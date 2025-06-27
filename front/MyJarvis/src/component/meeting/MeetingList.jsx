import React, { useState } from 'react';
import SumAndMakeTag from './SumAndMakeTag';

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

function MeetingList() {
  const [meetings, setMeetings] = useState(initialMeetings);
  const [selected, setSelected] = useState(null);
  const [showGpt, setShowGpt] = useState(false);
  const [editMode, setEditMode] = useState(false);
  const [editData, setEditData] = useState({ title: '', date: '', tags: '', content: '' });

  const filtered = meetings;
  // const filtered = meetings.filter(m => filter ? m.tags.includes(filter) : true);

  const handleEdit = () => {
    setEditData({
      title: selected.title,
      date: selected.date,
      tags: selected.tags.join(', '),
      content: selected.content,
    });
    setEditMode(true);
  };

  const handleEditSave = () => {
    setMeetings(meetings.map(m =>
      m.id === selected.id ? {
        ...m,
        title: editData.title,
        date: editData.date,
        tags: editData.tags.split(',').map(t => t.trim()),
        content: editData.content,
      } : m
    ));
    setSelected({
      ...selected,
      title: editData.title,
      date: editData.date,
      tags: editData.tags.split(',').map(t => t.trim()),
      content: editData.content,
    });
    setEditMode(false);
  };

  return (
    <div>
      <h3>회의록 목록</h3>
      {/* 버튼 그룹 완전 제거 */}
      <ul>
        {filtered.map(m => (
          <li key={m.id} style={{ display: 'flex', alignItems: 'center' }}>
            {/* deleteMode 체크박스 완전 제거 */}
            <span style={{ flex: 1, cursor: 'pointer', fontWeight: selected && selected.id === m.id ? 'bold' : 'normal' }} onClick={() => { setSelected(m); setShowGpt(false); setEditMode(false); }}>
              {m.title} ({m.date}) - 태그: {m.tags.join(', ')}
            </span>
          </li>
        ))}
      </ul>
      {selected && (
        <div className="meeting-detail" style={{ display: 'flex', flexDirection: 'row', gap: '2.5rem', alignItems: 'flex-start', width: '100%' }}>
          <div style={{ flex: 2, minWidth: 320, maxWidth: 700 }}>
            <h4>회의 내용</h4>
            {editMode ? (
              <div className="meeting-edit-form">
                <div><b>제목:</b> <input value={editData.title} onChange={e => setEditData({ ...editData, title: e.target.value })} /></div>
                <div><b>일자:</b> <input type="date" value={editData.date} onChange={e => setEditData({ ...editData, date: e.target.value })} /></div>
                <div><b>태그:</b> <input value={editData.tags} onChange={e => setEditData({ ...editData, tags: e.target.value })} placeholder=",로 구분" /></div>
                <div style={{ marginTop: 8 }}><textarea value={editData.content} onChange={e => setEditData({ ...editData, content: e.target.value })} rows={3} style={{ width: '100%' }} /></div>
                <button onClick={handleEditSave} style={{ marginTop: 8 }}>저장</button>
                <button onClick={() => setEditMode(false)} style={{ marginLeft: 8 }}>취소</button>
              </div>
            ) : (
              <>
                <div><b>제목:</b> {selected.title}</div>
                <div><b>일자:</b> {selected.date}</div>
                <div><b>태그:</b> {selected.tags.join(', ')}</div>
                <div style={{ marginTop: 8 }}>{selected.content}</div>
                <button style={{ marginTop: 16 }} onClick={handleEdit}>수정</button>
                <button style={{ marginTop: 16, marginLeft: 8 }} onClick={() => setShowGpt(!showGpt)}>
                  {showGpt ? '요약/태그 닫기' : 'GPT 요약/태그'}
                </button>
                {/* 상세보기 내 삭제 버튼 */}
                <button style={{ marginTop: 16, marginLeft: 8, background: '#e11d48', color: '#fff', border: 'none', borderRadius: 8, padding: '8px 24px', fontWeight: 600, fontSize: '1rem', cursor: 'pointer' }}
                  onClick={() => {
                    setMeetings(meetings.filter(m => m.id !== selected.id));
                    setSelected(null);
                    setShowGpt(false);
                    setEditMode(false);
                  }}
                >삭제</button>
              </>
            )}
          </div>
          {showGpt && (
            <div style={{ flex: 3, minWidth: 400, maxWidth: 900 }}>
              <SumAndMakeTag initialContent={selected.content} />
            </div>
          )}
        </div>
      )}
    </div>
  );
}

export default MeetingList;