import React, { useState } from 'react';

/*
  캘린더 뷰, 주간일정

  - 월간/주간/일간 보기 전환
  - 일정 항목 드래그 이동
  - 일정 제목, 시작시간, 상태 표시
  - 오늘 날짜 강조 표시
  - 일정 등록 버튼 제공
 */

// 캘린더 뷰, 주간/월간/일간 전환, 일정 등록 샘플
const dummySchedules = [
  { id: 1, title: '팀 미팅', date: '2025-06-28', status: '예정', desc: '주간 팀 업무 공유 및 이슈 논의.' },
  { id: 2, title: '계약 마감', date: '2025-07-01', status: '중요', desc: 'A사와의 계약 마감일. 서류 제출 필수.' },
];

function MySchedule() {
  const [selected, setSelected] = useState(null);
  const [schedules, setSchedules] = useState(dummySchedules);
  const [editMode, setEditMode] = useState(false);
  const [editData, setEditData] = useState({ title: '', date: '', status: '', desc: '' });
  // view에 따라 일정 필터링(샘플)
  const filtered = schedules;

  const handleDelete = (id) => {
    setSchedules(schedules.filter(s => s.id !== id));
    setSelected(null);
  };
  const handleEditClick = (s) => {
    setSelected(s);
    setEditData({ title: s.title, date: s.date, status: s.status, desc: s.desc });
    setEditMode(true);
  };
  const handleEditChange = (e) => {
    const { name, value } = e.target;
    setEditData(prev => ({ ...prev, [name]: value }));
  };
  const handleEditSave = () => {
    setSchedules(schedules.map(s => s.id === selected.id ? { ...s, ...editData } : s));
    setEditMode(false);
    setSelected(null);
  };
  const handleEditCancel = () => {
    setEditMode(false);
    setSelected(null);
  };
  return (
    <div>
      <h3>내 일정</h3>
      <ul>
        {filtered.map(s => (
          <li key={s.id} style={{ cursor: 'pointer', fontWeight: selected && selected.id === s.id ? 'bold' : 'normal', display: 'flex', alignItems: 'center' }}>
            <span
              style={{ flex: 1, display: selected && selected.id === s.id && !editMode ? 'none' : 'block' }}
              onClick={() => { setSelected(s); setEditMode(false); }}
            >
              {s.title} ({s.date}) - {s.status}
            </span>
            {selected && selected.id === s.id && !editMode && (
              <>
                <div className="schedule-detail" style={{
                  marginTop: 10,
                  background: '#f4f8fb',
                  padding: '16px 20px',
                  borderRadius: 10,
                  minWidth: 260,
                  boxShadow: '0 2px 8px #e0e7ef33',
                  color: '#234',
                  lineHeight: 1.7,
                  display: 'flex',
                  flexDirection: 'row',
                  alignItems: 'flex-start',
                  gap: 24
                }}>
                  <div style={{ fontSize: '1.1rem', fontWeight: 600, minWidth: 110 }}>{selected.title}</div>
                  <div>
                    <div><b>날짜:</b> {selected.date}</div>
                    <div><b>상태:</b> <span style={{ color: selected.status === '완료' ? '#228be6' : '#fab005', fontWeight: 500 }}>{selected.status}</span></div>
                    <div style={{ marginTop: 8 }}><b>설명:</b> <span style={{ color: '#444' }}>{selected.desc}</span></div>
                  </div>
                  <div style={{ display: 'flex', flexDirection: 'row', gap: 12, marginLeft: 18 }}>
                    <button style={{ background: '#fff', color: '#2563eb', border: '1px solid #2563eb', borderRadius: 8, padding: '8px 24px', fontWeight: 500, fontSize: '1rem', cursor: 'pointer' }}
                      onClick={() => { setEditData({ title: selected.title, date: selected.date, status: selected.status, desc: selected.desc }); setEditMode(true); }}
                    >수정</button>
                    <button style={{ background: '#e11d48', color: '#fff', border: 'none', borderRadius: 8, padding: '8px 24px', fontWeight: 600, fontSize: '1rem', cursor: 'pointer' }}
                      onClick={() => handleDelete(selected.id)}
                    >삭제</button>
                  </div>
                </div>
              </>
            )}
            {selected && selected.id === s.id && editMode && (
              <div className="schedule-detail" style={{
                marginTop: 10,
                background: '#f4f8fb',
                padding: 16,
                borderRadius: 10,
                minWidth: 260,
                maxWidth: 400,
                boxShadow: '0 2px 8px #e0e7ef33',
                color: '#234',
                lineHeight: 1.7,
                display: 'flex',
                flexDirection: 'column',
                alignItems: 'flex-start',
                gap: 10
              }}>
                <div style={{ marginBottom: 8 }}>
                  <label style={{ display: 'block', fontWeight: 600 }}>제목:
                    <input name="title" value={editData.title} onChange={handleEditChange} style={{ marginLeft: 8, width: 220 }} />
                  </label>
                </div>
                <div style={{ marginBottom: 8 }}>
                  <label style={{ display: 'block', fontWeight: 600 }}>날짜:
                    <input name="date" value={editData.date} onChange={handleEditChange} style={{ marginLeft: 8, width: 220 }} />
                  </label>
                </div>
                <div style={{ marginBottom: 8 }}>
                  <label style={{ display: 'block', fontWeight: 600 }}>상태:
                    <input name="status" value={editData.status} onChange={handleEditChange} style={{ marginLeft: 8, width: 220 }} />
                  </label>
                </div>
                <div style={{ marginBottom: 8 }}>
                  <label style={{ display: 'block', fontWeight: 600 }}>설명:
                    <input name="desc" value={editData.desc} onChange={handleEditChange} style={{ marginLeft: 8, width: 220 }} />
                  </label>
                </div>
                <div>
                  <button onClick={handleEditSave} style={{ marginTop: 8 }}>저장</button>
                  <button onClick={handleEditCancel} style={{ marginLeft: 8 }}>취소</button>
                </div>
              </div>
            )}
          </li>
        ))}
      </ul>
      <div>※ 실제 캘린더/드래그 UI는 추후 연동</div>
    </div>
  );
}

export default MySchedule;