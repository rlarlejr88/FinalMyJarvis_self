/**
 * MeetingList.jsx
 * - 회의 목록을 불러오고, 상세/수정/태그/삭제 등 회의 관리 기능 제공
 * - meetings: 회의 데이터 배열
 * - setMeetings: 회의 데이터 상태 변경 함수
 * - setTab: 상위 탭 전환 함수
 * - selected: 선택된 회의
 * - setSelected: 선택 회의 변경 함수
 * - scrollToId: 특정 회의로 스크롤 이동
 */
import React, { useEffect, useRef, useState } from "react";
import SumAndMakeTag from "./SumAndMakeTag";
import "./MeetingList.css";

/*
  태그 기반 필터, 고객사별 보기

  - 태그 다중 선택  
  - 태그 자동 완성 입력
  - 필터 초기화 버튼
  - 고객사 선택 드롭 다운
  - 고객사별 회의 리스트 출력
  - 회의 요약 / 태그 미리보기

*/

function MeetingList({
  meetings = [
    {
      id: 1,
      title: "주간 회의",
      date: "2025-06-20",
      content: "주간 업무 공유 및 진행 상황 논의.",
    },
    {
      id: 2,
      title: "기획 회의",
      date: "2025-06-21",
      content: "신규 프로젝트 기획 및 역할 분담.",
    },
  ],
  setMeetings,
  setTab,
  selected,
  setSelected,
  scrollToId,
}) {
  // 각 회의 li에 ref를 연결하여 DOM 조작 가능
  const itemRefs = useRef({});

  // DB에서 회의록 불러오기 (최초 1회 실행)
  useEffect(() => {
    async function fetchMeetings() {
      try {
        console.log("회의 목록을 불러오는 중...");

        const token = localStorage.getItem("accessToken");
        const res = await fetch("/api/meetings", {
          headers: {
            Authorization: `Bearer ${token}`, 
            "Content-Type": "application/json",
          },
        });
        if (!res.ok) {
          const errorText = await res.text();
          console.error("서버 오류:", res.status, errorText);
          alert(
            `회의 목록을 불러오는 중 서버 오류가 발생했습니다. (상태 코드: ${res.status})`
          );
          return;
        }

        const result = await res.json();
        if (!result || !result.resData) {
          console.error("응답 데이터가 올바르지 않습니다:", result);
          alert("회의 목록을 불러오는 중 데이터 오류가 발생했습니다.");
          return;
        }

        const rawMeetings = result.resData;
        const data = Array.isArray(rawMeetings)
          ? rawMeetings
              .filter((m) => m)
              .map((m) => ({
                id: m.meetingNo,
                memberNo: m.memberNo,
                title: m.meetTitle,
                content: m.meetContent,
                date: m.meetDate,
                summary: m.gptSummary,
                tags: [],
              }))
          : [];

        console.log("불러온 회의 목록:", data);
        if (setMeetings) setMeetings(data);
      } catch {
        alert(
          "회의 목록을 불러오는 중 네트워크 오류가 발생했습니다.\n자세한 내용은 콘솔을 확인하세요."
        );
      }
    }

    fetchMeetings();
  }, [setMeetings]);

  // 외부에서 selected가 바뀌면 상세 포커스 및 스크롤 이동
  useEffect(() => {
    if (selected && itemRefs.current[selected.id]) {
      itemRefs.current[selected.id].scrollIntoView({
        behavior: "smooth",
        block: "center",
      });
    }
    if (selected && !meetings.find((m) => m.id === selected.id)) {
      console.warn("선택된 회의가 목록에 없습니다.");
    }
  }, [selected, meetings]);

  // 외부에서 scrollToId가 들어오면 해당 회의로 이동 및 상세 오픈
  useEffect(() => {
    if (scrollToId && itemRefs.current[scrollToId]) {
      setSelected(meetings.find((m) => m.id === scrollToId));
      setTimeout(() => {
        if (itemRefs.current[scrollToId]) {
          itemRefs.current[scrollToId].scrollIntoView({
            behavior: "smooth",
            block: "center",
          });
        }
      }, 100);
    }
  }, [scrollToId, meetings, setSelected]);

  const handleTagClick = () => {
    if (setTab) {
      setTab("tag");
    }
  };

  const handleSaveTags = (meetingId, newTags) => {
    setMeetings((prev) =>
      prev.map((m) =>
        m.id === meetingId
          ? { ...m, tags: Array.from(new Set([...(m.tags || []), ...newTags])) }
          : m
      )
    );
  };

  // 태그 삭제 핸들러
  const handleRemoveTag = (meetingId, tag) => {
    setMeetings((prev) =>
      prev.map((m) =>
        m.id === meetingId
          ? { ...m, tags: (m.tags || []).filter((t) => t !== tag) }
          : m
      )
    );
  };

  const [editId, setEditId] = useState(null);
  const [editContent, setEditContent] = useState("");

  /**
   * handleEdit
   * - 특정 회의를 수정 모드로 전환
   * @param {Object} meeting - 수정할 회의 객체
   */
  const handleEdit = (meeting) => {
    setEditContent(meeting.content); // 수정할 회의 내용을 상태에 저장
  };

  /**
   * handleSaveEdit
   * - 수정된 회의 내용을 저장
   * @param {number} id - 수정할 회의 ID
   */
  const handleSaveEdit = async (id) => {
    const targetMeeting = meetings.find((m) => m.id === id); // 수정 대상 회의 찾기
    const updatedMeeting = {
      meetingNo: targetMeeting.id, // DB PK와 일치
      meetTitle: targetMeeting.title, // 기존 제목 유지
      meetContent: editContent, // 수정된 내용 반영
      meetDate: targetMeeting.date, // 기존 날짜 유지
      gptSummary: targetMeeting.summary, // 기존 요약 유지
      memberNo: targetMeeting.memberNo, // 기존 멤버 유지
    };

    try {
      const res = await fetch("/api/meetings", {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(updatedMeeting),
      });
      if (res.ok) {
        // 성공적으로 저장되면 상태 업데이트
        setMeetings((prev) =>
          prev.map((m) => (m.id === id ? { ...m, content: editContent } : m))
        );
        alert("수정 완료!");
      } else {
        alert("수정 실패(서버 오류)");
      }
    } catch (e) {
      alert("수정 실패(네트워크 오류)");
    }
  };

  /**
   * handleSummarize
   * - AI를 활용하여 회의 내용을 요약
   * @param {number} meetingId - 요약할 회의 ID
   */
  const handleSummarize = async (meetingId) => {
    try {
      const res = await fetch(`/api/meetings/${meetingId}/summary`, {
        method: "POST",
      });
      if (res.ok) {
        const data = await res.json();
        // 요약 결과를 상태에 반영
        setMeetings((prev) =>
          prev.map((m) =>
            m.id === meetingId ? { ...m, summary: data.summary } : m
          )
        );
      } else {
        alert("요약 실패(서버 오류)");
      }
    } catch {
      alert("요약 실패(네트워크 오류)");
    }
  };

  const handleTagExtract = async (meetingId) => {
    try {
      const res = await fetch(`/api/meetings/${meetingId}/tags`, {
        method: "POST",
      });
      if (res.ok) {
        const data = await res.json();
        setMeetings((prev) =>
          prev.map((m) => (m.id === meetingId ? { ...m, tags: data.tags } : m))
        );
      } else {
        alert("태그 추출 실패 (서버 오류)");
      }
    } catch {
      alert("태그 추출 실패 (네트워크 오류)");
    }
  };

  const myMemberNo = null; // TODO: 실제 로그인 사용자 번호로 대체

  // 내가 등록한 회의록만 필터링
  // const filtered = meetings.filter(m => m.memberNo === myMemberNo);
  const filtered = Array.isArray(meetings)
    ? meetings.filter((m) => m.memberNo === myMemberNo)
    : [];

  return (
    <div>
      <h3>회의록 목록</h3>
      <ul className="meeting-list">
        {filtered.map((m) => (
          <li
            key={m.id}
            ref={(el) => (itemRefs.current[m.id] = el)}
            className={`meeting-list-item${
              selected && selected.id === m.id ? " selected" : ""
            }`}
            onClick={() => setSelected(m)}
          >
            <b className="meeting-title">{m.title}</b>{" "}
            <span className="meeting-date">({m.date})</span>
            <br />
            <span>
              태그:{" "}
              {m.tags && m.tags.length > 0
                ? m.tags.map((tag, idx) => (
                    <React.Fragment key={tag}>
                      <span
                        className="meeting-tag"
                        onClick={(e) => {
                          e.stopPropagation();
                          handleTagClick(tag);
                        }}
                      >
                        {tag}
                        {selected && selected.id === m.id && (
                          <button
                            className="meeting-tag-remove"
                            onClick={(e) => {
                              e.stopPropagation();
                              handleRemoveTag(m.id, tag);
                            }}
                            title="태그 삭제"
                          >
                            ×
                          </button>
                        )}
                      </span>
                      {idx < m.tags.length - 1 && (
                        <span className="meeting-tag-comma">, </span>
                      )}
                    </React.Fragment>
                  ))
                : "없음"}
            </span>
            {selected && selected.id === m.id && (
              <div className="meeting-detail">
                <div className="meeting-detail-section">
                  <b>회의 내용:</b>
                  <div>
                    {editId === m.id ? (
                      <textarea
                        className="meeting-edit-textarea"
                        value={editContent}
                        onChange={(e) => setEditContent(e.target.value)}
                        rows={4}
                      />
                    ) : (
                      selected.content
                    )}
                    <div className="meeting-detail-btns-bottom">
                      {editId === m.id ? (
                        <>
                          <button
                            className="meeting-detail-save-btn"
                            onClick={(e) => {
                              e.stopPropagation();
                              handleSaveEdit(m.id);
                            }}
                          >
                            저장
                          </button>
                          <button
                            className="meeting-detail-cancel-btn"
                            onClick={(e) => {
                              e.stopPropagation();
                              setEditId(null);
                            }}
                          >
                            취소
                          </button>
                        </>
                      ) : (
                        <>
                          <button
                            className="meeting-detail-edit-btn"
                            onClick={(e) => {
                              e.stopPropagation();
                              handleEdit(m);
                            }}
                          >
                            수정
                          </button>
                          <button
                            className="meeting-detail-delete-btn meeting-detail-delete-btn-margin"
                            onClick={async (e) => {
                              e.stopPropagation();
                              if (window.confirm("정말 삭제하시겠습니까?")) {
                                try {
                                  const res = await fetch(
                                    `/api/meetings/${m.id}`,
                                    { method: "DELETE" }
                                  );
                                  if (res.ok) {
                                    setMeetings((prev) =>
                                      prev.filter((mm) => mm.id !== m.id)
                                    );
                                    alert("Delete!!");
                                  } else {
                                    alert("삭제 실패(서버)");
                                  }
                                } catch (e) {
                                  alert("삭제 실패(네트워크)");
                                }
                              }
                            }}
                          >
                            삭제
                          </button>
                        </>
                      )}
                    </div>
                  </div>
                </div>
                <div className="meeting-detail-section">
                  <SumAndMakeTag
                    initialContent={selected.content}
                    onSaveTags={(tags) => handleSaveTags(selected.id, tags)}
                  />
                </div>
                <div className="meeting-gpt-summary">
                  <b>GPT 요약:</b>
                  <div>
                    {selected.summary || "요약 없음"}
                    <button
                      className="meeting-gpt-button"
                      onClick={(e) => {
                        e.stopPropagation();
                        handleSummarize(selected.id);
                      }}
                    >
                      GPT 요약 실행
                    </button>
                  </div>
                </div>
                <div className="meeting-gpt-tags">
                  <b>GPT 태그:</b>
                  <div>
                    {selected.tags && selected.tags.length > 0
                      ? selected.tags.map((tag) => (
                          <span key={tag} className="tag">
                            {tag}
                          </span>
                        ))
                      : "태그 없음"}
                    <button
                      className="meeting-gpt-button"
                      onClick={(e) => {
                        e.stopPropagation();
                        handleTagExtract(selected.id);
                      }}
                    >
                      GPT 태그 추출
                    </button>
                  </div>
                </div>
              </div>
            )}
          </li>
        ))}
      </ul>
    </div>
  );
}

export default MeetingList;
