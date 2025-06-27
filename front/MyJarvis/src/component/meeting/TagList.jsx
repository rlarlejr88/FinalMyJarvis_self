import React, { useState } from 'react';
import SumAndMakeTag from './SumAndMakeTag';

const initialMeetings = [
  { id: 1, title: '주간 회의', date: '2025-06-20', tags: ['업무', 'AI'], participants: '홍길동, 김철수', content: '주간 업무 공유 및 진행 상황 논의.' },
  { id: 2, title: '기획 회의', date: '2025-06-21', tags: ['기획'], participants: '이영희', content: '신규 프로젝트 기획 및 역할 분담.' },
];

function TagList() {
  const [selectedMeeting, setSelectedMeeting] = useState(null);
  const [meetings, setMeetings] = useState(initialMeetings);
  const [checked, setChecked] = useState([]);
  const [deleteMode] = useState(false);

  const filtered = meetings;

  const handleCheck = (id) => {
    setChecked(prev => prev.includes(id) ? prev.filter(cid => cid !== id) : [...prev, id]);
  };

  return (
    <div>
      <h3>태그별 회의 목록</h3>
      <ul style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', padding: 0, listStyle: 'none' }}>
        {filtered.map(m => (
          <li key={m.id} style={{ width: '100%', maxWidth: 500, marginBottom: 16, textAlign: 'center', background: '#f8fafc', borderRadius: 10, boxShadow: '0 1px 4px #e0e7ef33', padding: 16 }}>
            {deleteMode && !selectedMeeting && (
              <input type="checkbox" checked={checked.includes(m.id)} onChange={() => handleCheck(m.id)} />
            )}
            <b>{m.title}</b> ({m.date})<br />
            <span>참여자: {m.participants || '-'} </span><br />
            <span>태그: {m.tags.join(', ')}</span>
            {!selectedMeeting && (
              <button style={{ marginLeft: 12 }} onClick={() => setSelectedMeeting(m)}>상세보기</button>
            )}
            {selectedMeeting && selectedMeeting.id === m.id && (
              <div className="meeting-detail" style={{ marginTop: 10, display: 'flex', flexDirection: 'column', alignItems: 'center', width: '100%' }}>
                <b style={{ textAlign: 'center', width: '100%' }}>회의 내용:</b>
                <div style={{ textAlign: 'center', maxWidth: 400, width: '100%' }}>{selectedMeeting.content}</div>
                <div style={{ width: '100%', display: 'flex', justifyContent: 'center', marginTop: 16 }}>
                  <SumAndMakeTag initialContent={selectedMeeting.content} />
                </div>
                {/* 상세보기 내 삭제 버튼 */}
                <button style={{ marginTop: 18, background: '#e11d48', color: '#fff', border: 'none', borderRadius: 8, padding: '8px 24px', fontWeight: 600, fontSize: '1rem', cursor: 'pointer' }}
                  onClick={() => {
                    setMeetings(meetings.filter(mm => mm.id !== m.id));
                    setSelectedMeeting(null);
                  }}
                >삭제</button>
                <button style={{ marginTop: 10, background: '#fff', color: '#2563eb', border: '1px solid #2563eb', borderRadius: 8, padding: '6px 18px', fontWeight: 500, fontSize: '1rem', cursor: 'pointer' }}
                  onClick={() => setSelectedMeeting(null)}
                >목록으로</button>
              </div>
            )}
          </li>
        ))}
      </ul>
    </div>
  );
}

export default TagList;