import React, { useState, useEffect } from 'react';
import SumAndMakeTag from './SumAndMakeTag';
import './TagList.css';

function TagList({ meetings, setMeetings, selectedTag, setSelectedTag }) {
  const [selectedMeeting, setSelectedMeeting] = useState(null);
  const [checked, setChecked] = useState([]);
  const [deleteMode] = useState(false);

  // 태그별 필터링
  const filtered = selectedTag
    ? meetings.filter(m => (m.tags || []).includes(selectedTag))
    : meetings;

  const handleCheck = (id) => {
    setChecked(prev => prev.includes(id) ? prev.filter(cid => cid !== id) : [...prev, id]);
  };

  // 태그 클릭 시 해당 태그로 필터링
  const handleTagClick = (tag) => {
    if (setSelectedTag) setSelectedTag(tag);
  };

  useEffect(() => {
    // selectedTag가 바뀌면 상세보기 닫기
    setSelectedMeeting(null);
  }, [selectedTag]);

  return (
    <div>
      <h3>태그별 회의 목록{selectedTag ? `: ${selectedTag}` : ''}</h3>
      <ul className="taglist-list">
        {filtered.map(m => (
          <li
            key={m.id}
            className={`taglist-item${selectedMeeting && selectedMeeting.id === m.id ? ' selected' : ''}`}
            onClick={() => {
              if (!selectedMeeting || selectedMeeting.id !== m.id) setSelectedMeeting(m);
            }}
          >
            {deleteMode && !selectedMeeting && (
              <input type="checkbox" checked={checked.includes(m.id)} onChange={e => { e.stopPropagation(); handleCheck(m.id); }} />
            )}
            <b>{m.title}</b> ({m.date})<br />
            <span>참여자: {m.participants || '-'} </span><br />
            <span>
              태그: {m.tags && m.tags.length > 0 ? m.tags.map(tag => (
                <span key={tag} className="meeting-tag" onClick={e => { e.stopPropagation(); handleTagClick(tag); }}>{tag}</span>
              )) : '없음'}
            </span>
            {(selectedMeeting && selectedMeeting.id === m.id) ? (
              <div className="meeting-detail">
                <div className="meeting-detail-section">
                  <b style={{ textAlign: 'center', width: '100%' }}>회의 내용:</b>
                  <div style={{ textAlign: 'center', maxWidth: 400, width: '100%' }}>{selectedMeeting.content}</div>
                </div>
                <div className="meeting-detail-section">
                  <SumAndMakeTag initialContent={selectedMeeting.content} />
                  <div className="meeting-detail-btns">
                    <button className="delete-btn"
                      onClick={e => {
                        e.stopPropagation();
                        setMeetings(meetings.filter(mm => mm.id !== m.id));
                        setSelectedMeeting(null);
                      }}
                    >삭제</button>
                    <button className="back-btn"
                      onClick={e => {
                        e.stopPropagation();
                        setSelectedMeeting(null);
                      }}
                    >목록으로</button>
                  </div>
                </div>
              </div>
            ) : null}
          </li>
        ))}
      </ul>
    </div>
  );
}

export default TagList;