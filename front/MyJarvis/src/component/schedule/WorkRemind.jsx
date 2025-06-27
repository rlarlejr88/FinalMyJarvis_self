import React, { useState } from 'react';

// 샘플 데이터: 실제로는 props 또는 context로 회의/일정 목록을 받아올 수 있음
const sampleItems = [
  { id: 1, type: '회의', title: '주간 회의', date: '2024-06-10', time: '10:00' },
  { id: 2, type: '일정', title: '계약서 제출', date: '2024-06-12', time: '15:00' },
  { id: 3, type: '일정', title: '팀 워크샵', date: '2024-06-15', time: '09:30' },
];

function WorkRemind() {
  const [remindSettings, setRemindSettings] = useState({}); // { [id]: { ...설정 } }
  const [editingId, setEditingId] = useState(null);
  const [form, setForm] = useState({ repeat: '없음', email: false, banner: true });

  // 리마인드 설정 폼 열기
  const openEdit = (item) => {
    setEditingId(item.id);
    setForm(remindSettings[item.id] || {
      repeat: '없음',
      email: false,
      banner: true,
      date: item.date,
      time: item.time,
    });
  };

  // 리마인드 설정 저장
  const saveRemind = (item) => {
    setRemindSettings({
      ...remindSettings,
      [item.id]: { ...form },
    });
    setEditingId(null);
  };

  return (
    <div style={{ width: '100%', display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
      <h3>내 회의/일정 리마인더</h3>
      <div style={{ color: '#888', fontSize: '0.95rem', marginBottom: 12, textAlign: 'center' }}>
        각 회의/일정별로 리마인드 알림을 설정할 수 있습니다.<br />
        ※ 실제 알림은 연동 필요, 현재는 설정 UI만 제공됩니다.
      </div>
      <div style={{ background: '#f8fafc', padding: 16, borderRadius: 10, boxShadow: '0 1px 4px #e0e7ef33', maxWidth: 500, width: '100%', display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
        {sampleItems.map(item => (
          <div key={item.id} style={{ marginBottom: 18, borderBottom: '1px solid #e5e7eb', paddingBottom: 10, width: '100%', maxWidth: 420, textAlign: 'center', display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
            <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', width: '100%', gap: 12 }}>
              <div style={{ flex: 1, textAlign: 'center' }}>
                <span style={{ fontWeight: 600, color: '#2563eb' }}>{item.type}</span> · {item.title}
                <span style={{ marginLeft: 12, color: '#555' }}>{item.date} {item.time}</span>
                {remindSettings[item.id] && <span style={{ marginLeft: 10, color: '#22c55e', fontWeight: 500, fontSize: '0.95em' }}>리마인드 설정됨</span>}
              </div>
              <button className="remind-btn" style={{ background: '#fff', border: '1px solid #2563eb', color: '#2563eb', borderRadius: 6, padding: '4px 12px', cursor: 'pointer' }} onClick={() => openEdit(item)}>
                {remindSettings[item.id] ? '수정' : '설정'}
              </button>
            </div>
            {editingId === item.id && (
              <div style={{ marginTop: 10, background: '#f1f5f9', padding: 12, borderRadius: 8, width: '100%', display: 'flex', flexDirection: 'column', alignItems: 'center' }}>
                <div style={{ marginBottom: 8 }}>
                  <label>날짜:
                    <input type="date" value={form.date} onChange={e => setForm(f => ({ ...f, date: e.target.value }))} style={{ marginLeft: 8 }} />
                  </label>
                  <label style={{ marginLeft: 16 }}>시간:
                    <input type="time" value={form.time} onChange={e => setForm(f => ({ ...f, time: e.target.value }))} style={{ marginLeft: 8 }} />
                  </label>
                </div>
                <div style={{ marginBottom: 8 }}>
                  <label>반복:
                    <select value={form.repeat} onChange={e => setForm(f => ({ ...f, repeat: e.target.value }))} style={{ marginLeft: 8 }}>
                      <option>없음</option>
                      <option>매일</option>
                      <option>매주</option>
                      <option>매월</option>
                    </select>
                  </label>
                </div>
                <div style={{ marginBottom: 8 }}>
                  <label>
                    <input type="checkbox" checked={form.email} onChange={e => setForm(f => ({ ...f, email: e.target.checked }))} /> 이메일 알림
                  </label>
                  <label style={{ marginLeft: 16 }}>
                    <input type="checkbox" checked={form.banner} onChange={e => setForm(f => ({ ...f, banner: e.target.checked }))} /> 화면 배너 알림
                  </label>
                </div>
                <div style={{ display: 'flex', gap: 8, justifyContent: 'center' }}>
                  <button className="remind-btn" style={{ background: '#2563eb', color: '#fff', border: 'none', borderRadius: 6, padding: '4px 16px', cursor: 'pointer' }} onClick={() => saveRemind(item)}>저장</button>
                  <button className="remind-btn" style={{ background: '#fff', color: '#2563eb', border: '1px solid #2563eb', borderRadius: 6, padding: '4px 16px', cursor: 'pointer' }} onClick={() => setEditingId(null)}>취소</button>
                </div>
              </div>
            )}
          </div>
        ))}
      </div>
    </div>
  );
}

export default WorkRemind;