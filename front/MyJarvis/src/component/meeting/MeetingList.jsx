import React, { useState } from 'react';
import SumAndMakeTag from './SumAndMakeTag';
import './MeetingList.css';

/*
  태그 기반 필터, 고객사별 보기

  - 태그 다중 선택  
  - 태그 자동 완성 입력
  - 필터 초기화 버튼
  - 고객사 선택 드롭 다운
  - 고객사별 회의 리스트 출력
  - 회의 요약 / 태그 미리보기

*/

// 회의록 리스트, 태그/필터 기능 샘플 + 회의 내용 보기
const initialMeetings = [
  { id: 1, title: '주간 회의', date: '2025-06-20', tags: ['업무', '주간'], content: '주간 업무 공유 및 진행 상황 논의.' },
  { id: 2, title: '기획 회의', date: '2025-06-21', tags: ['기획'], content: '신규 프로젝트 기획 및 역할 분담.' },
];

function MeetingList({ meetings, setMeetings, setTab, setSelectedTag }) {
  const [selected, setSelected] = useState(null);

  const handleTagClick = (tag) => {
    if (setSelectedTag && setTab) {
      setSelectedTag(tag);
      setTab('tag');
    }
  };

  const handleSaveTags = (meetingId, newTags) => {
    setMeetings(prev => prev.map(m => m.id === meetingId ? { ...m, tags: Array.from(new Set([...(m.tags || []), ...newTags])) } : m));
    // 태그 저장 후 바로 상세에 반영됨
  };

  const filtered = meetings;
  return (
    <div>
      <h3>회의록 목록</h3>
      <ul className="meeting-list">
        {filtered.map(m => (
          <li
            key={m.id}
            className={`meeting-list-item${selected && selected.id === m.id ? ' selected' : ''}`}
            onClick={() => setSelected(m)}
          >
            <b>{m.title}</b> <span style={{ color: '#888', fontSize: '0.95em' }}>({m.date})</span><br />
            <span>
              태그: {m.tags && m.tags.length > 0 ? m.tags.map((tag, idx) => (
                <span key={tag} className="meeting-tag" onClick={e => { e.stopPropagation(); handleTagClick(tag); }}>
                  {tag}{idx < m.tags.length - 1 ? ', ' : ''}
                </span>
              )) : '없음'}
            </span>
            {selected && selected.id === m.id && (
              <div className="meeting-detail">
                <div className="meeting-detail-section">
                  <b>회의 내용:</b>
                  <div>{selected.content}</div>
                </div>
                <div className="meeting-detail-section">
                  <SumAndMakeTag
                    initialContent={selected.content}
                    onSaveTags={tags => handleSaveTags(selected.id, tags)}
                  />
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