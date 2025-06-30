import React, { useState } from 'react';
import './WorkRemind.css';

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
    <div className="workremind-root">
      <h3>내 회의/일정 리마인더</h3>
      <div className="workremind-desc">
        각 회의/일정별로 리마인드 알림을 설정할 수 있습니다.<br />
        ※ 실제 알림은 연동 필요, 현재는 설정 UI만 제공됩니다.
      </div>
      <div className="workremind-list">
        {sampleItems.map(item => (
          <div key={item.id} className="workremind-item">
            <div className="workremind-item-row">
              <div className="workremind-item-title">
                <span className="workremind-type">{item.type}</span> · {item.title}
                <span className="workremind-date">{item.date} {item.time}</span>
                {remindSettings[item.id] && <span className="workremind-set">리마인드 설정됨</span>}
              </div>
              <button className="remind-btn" onClick={() => openEdit(item)}>
                {remindSettings[item.id] ? '수정' : '설정'}
              </button>
            </div>
            {editingId === item.id && (
              <div className="workremind-edit">
                <div className="workremind-edit-row">
                  <label>
                    날짜:
                    <input type="date" value={form.date} onChange={e => setForm(f => ({ ...f, date: e.target.value }))} className="workremind-edit-input" />
                  </label>
                  <label className="workremind-edit-label">
                    시간:
                    <input type="time" value={form.time} onChange={e => setForm(f => ({ ...f, time: e.target.value }))} className="workremind-edit-input" />
                  </label>
                </div>
                <div className="workremind-edit-row">
                  <label>
                    반복:
                    <select value={form.repeat} onChange={e => setForm(f => ({ ...f, repeat: e.target.value }))} className="workremind-edit-input">
                      <option>없음</option>
                      <option>매일</option>
                      <option>매주</option>
                      <option>매월</option>
                    </select>
                  </label>
                </div>
                <div className="workremind-edit-row">
                  <label>
                    <input type="checkbox" checked={form.email} onChange={e => setForm(f => ({ ...f, email: e.target.checked }))} /> 이메일 알림
                  </label>
                  <label className="workremind-edit-label">
                    <input type="checkbox" checked={form.banner} onChange={e => setForm(f => ({ ...f, banner: e.target.checked }))} /> 화면 배너 알림
                  </label>
                </div>
                <div className="workremind-edit-btns">
                  <button className="remind-btn save" onClick={() => saveRemind(item)}>저장</button>
                  <button className="remind-btn cancel" onClick={() => setEditingId(null)}>취소</button>
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