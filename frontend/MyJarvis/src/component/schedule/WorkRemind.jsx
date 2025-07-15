import React, { useState } from 'react';
import './WorkRemind.css';

function WorkRemind({ tab }) {
  const [reminders, setReminders] = useState([
    { id: 1, text: 'A사 1차 납품 3일 전', type: '계약', date: '2025-07-02', read: false },
    { id: 2, text: 'To-do: 회의록 정리 마감', type: 'To-do', date: '2025-06-30', read: false },
  ]);
  const [showAll, setShowAll] = useState(true);
  const [emailNotifications, setEmailNotifications] = useState(false);
  const [bannerNotifications, setBannerNotifications] = useState(true);
  const [notificationTiming, setNotificationTiming] = useState('1일 전');

  const handleRead = (id) => {
    setReminders(reminders.map(r => r.id === id ? { ...r, read: true } : r));
  };

  let title = '알림';
  if (tab === 'week') title = '주간 일정';
  if (tab === 'day') title = '일간 일정';

  return (
    <div className="workremind-container" style={{ textAlign: 'center' }}>
      <h3>{title}</h3>
      <div className="workremind-settings" style={{ marginBottom: '20px' }}>
        <div style={{ display: 'flex', justifyContent: 'center', gap: '10px', marginBottom: '10px' }}>
          <label>
            알림 시점:
            <select value={notificationTiming} onChange={e => setNotificationTiming(e.target.value)} style={{ marginLeft: '10px', padding: '5px' }}>
              <option value="1일 전">1일 전</option>
              <option value="1시간 전">1시간 전</option>
              <option value="30분 전">30분 전</option>
            </select>
          </label>
        </div>
        <div style={{ display: 'flex', justifyContent: 'center', gap: '20px' }}>
          <label>
            <input
              type="checkbox"
              checked={emailNotifications}
              onChange={e => setEmailNotifications(e.target.checked)}
            /> 이메일 알림
          </label>
          <label>
            <input
              type="checkbox"
              checked={bannerNotifications}
              onChange={e => setBannerNotifications(e.target.checked)}
            /> 배너 알림
          </label>
        </div>
      </div>
      <label style={{ display: 'block', marginBottom: '10px' }}>
        <input type="checkbox" checked={showAll} onChange={e => setShowAll(e.target.checked)} /> 전체 알림 보기
      </label>
      <ul className="workremind-list" style={{ listStyle: 'none', padding: 0, width: '80%', margin: '0 auto' }}>
        {reminders
          .filter(r => showAll || !r.read)
          .map(r => (
            <li key={r.id} className={`workremind-item${r.read ? ' read' : ''}`} style={{ marginBottom: '10px', border: '1px solid #ccc', borderRadius: '8px', padding: '10px' }}>
              <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <span className="workremind-type" style={{ fontWeight: 'bold' }}>{r.type}</span>
                <span className="workremind-text" style={{ flex: 1, textAlign: 'center' }}>{r.text}</span>
                <span className="workremind-date" style={{ marginRight: '10px' }}>{r.date}</span>
                {!r.read && (
                  <button
                    className="workremind-read-btn"
                    onClick={() => handleRead(r.id)}
                    style={{ background: '#4caf50', color: '#fff', border: 'none', borderRadius: '5px', padding: '5px 10px', cursor: 'pointer' }}
                  >
                    확인
                  </button>
                )}
              </div>
            </li>
          ))}
      </ul>
    </div>
  );
}

export default WorkRemind;