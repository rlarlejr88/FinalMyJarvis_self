import React, { useState, useEffect } from 'react';
import './TagList.css';

// TagList 컴포넌트: 태그를 기반으로 회의 목록을 필터링하고 표시하는 역할
function TagList({ meetings, setMeetings, setTab, setScrollToId }) {
  // 선택된 회의 상태 관리
  const [selectedMeeting, setLocalSelectedMeeting] = useState(null);
  // 선택된 태그 상태 관리 (다중 선택 가능)
  const [selectedTags, setLocalSelectedTags] = useState([]);

  // 전체 태그 목록 추출: 모든 회의 데이터에서 태그를 중복 없이 수집
  const allTags = Array.from(new Set(meetings.flatMap(m => m.tags || [])));

  // 태그 클릭 핸들러: 태그를 선택하거나 선택 해제하고, 해당 태그로 회의 목록 필터링
  const handleTagClick = (tag) => {
    // 선택된 회의 초기화
    setLocalSelectedMeeting(null);
    // 선택된 태그 업데이트 (이미 선택된 태그는 제거, 그렇지 않으면 추가)
    setLocalSelectedTags(prev => prev.includes(tag) ? prev.filter(t => t !== tag) : [...prev, tag]);

    // 선택된 태그를 기준으로 회의 목록 필터링
    const filteredMeetings = meetings.filter(m => m.tags && m.tags.includes(tag));
    setMeetings(filteredMeetings);
  };

  // 선택된 태그를 기준으로 회의 목록 필터링
  const filtered = selectedTags.length > 0
    ? meetings.filter(m => selectedTags.every(tag => (m.tags || []).includes(tag)))
    : meetings;

  // 선택된 태그가 변경될 때마다 선택된 회의 초기화
  useEffect(() => {
    setLocalSelectedMeeting(null);
  }, [selectedTags]);

  // 본문으로 이동 버튼 클릭 핸들러: 특정 회의로 이동하고 회의록 목록 탭으로 전환
  const handleGoToMainList = (meeting) => {
    if (setTab && setScrollToId) {
      setTab('list'); // 탭을 회의록 목록으로 전환
      setScrollToId(meeting.id); // 특정 회의로 스크롤 이동
    }
  };

  return (
    <div>
      {/* 태그별 회의 목록 제목 */}
      <h3>태그별 회의 목록</h3>
      {/* 태그 선택 바 */}
      <div className="taglist-tagbar">
        {allTags.length > 0 ? allTags.map(tag => (
          <span
            key={tag} // 태그 고유 키
            className={`meeting-tag${selectedTags.includes(tag) ? ' selected' : ''}`} // 선택된 태그 스타일 적용
            onClick={() => handleTagClick(tag)} // 태그 클릭 시 핸들러 호출
          >
            {tag}
          </span>
        )) : <span className="no-tags">등록된 태그 없음</span>}
      </div>
      {/* 필터링된 회의 목록 */}
      <ul className="taglist-list">
        {filtered.map(m => (
          <li
            key={m.id} // 회의 고유 키
            className="taglist-item" // 회의 항목 스타일 클래스
          >
            <div>
              {/* 회의 제목과 날짜 표시 */}
              <b>{m.title}</b> <span className="meeting-date">{m.date}</span>
            </div>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default TagList;