/*
  계약별 일정 보기, 상태에 따른 일정 표시

  - 계약명 기준으로 일정 그룹핑
  - 계약상태(진행,완료 등) 필터 제공
  - 상태별 일정 강조 표시(색상 또는 뱃지)
  - 검색 기능(계약명, 날짜 기준)
*/

import React, { useState } from 'react';

const initialContracts = [
  {
    id: 1,
    name: 'A사 공급계약',
    status: '진행중',
    progress: 60,
    schedules: [
      { id: 101, title: '계약서 작성', date: '2025-06-28', done: true },
      { id: 102, title: '1차 납품', date: '2025-07-05', done: false },
    ],
  },
  {
    id: 2,
    name: 'B사 유지보수',
    status: '대기',
    progress: 0,
    schedules: [
      { id: 201, title: 'Kick-off 미팅', date: '2025-07-01', done: false },
    ],
  },
];

function ContractList() {
  const [contracts, setContracts] = useState(initialContracts);
  const [selected, setSelected] = useState(null);
  const [filterStatus, setFilterStatus] = useState('all');
  const [searchTerm, setSearchTerm] = useState('');

  const filteredContracts = contracts.filter(contract => {
    const matchesStatus = filterStatus === 'all' || contract.status === filterStatus;
    const matchesSearch =
      contract.name.includes(searchTerm) ||
      contract.schedules.some(schedule => schedule.date.includes(searchTerm));
    return matchesStatus && matchesSearch;
  });

  const getProgress = (schedules) =>
    schedules.length
      ? Math.round((schedules.filter(s => s.done).length / schedules.length) * 100)
      : 0;

  return (
    <div className="contractlist-container">
      <div className="contractlist-header" style={{ textAlign: 'center' }}>
        <h2>계약 일정 관리</h2>
        <div className="contractlist-filters" style={{ display: 'flex', justifyContent: 'center', gap: '10px', marginBottom: '20px' }}>
          <select onChange={e => setFilterStatus(e.target.value)} value={filterStatus} style={{ padding: '10px', fontSize: '16px' }}>
            <option value="all">전체</option>
            <option value="진행중">진행중</option>
            <option value="대기">대기</option>
            <option value="완료">완료</option>
          </select>
          <input
            type="text"
            placeholder="계약명 또는 날짜 검색"
            value={searchTerm}
            onChange={e => setSearchTerm(e.target.value)}
            style={{ padding: '10px', fontSize: '16px', width: '300px' }}
          />
        </div>
      </div>
      <ul className="contractlist-list" style={{ listStyle: 'none', padding: 0, width: '80%', margin: '0 auto' }}>
        {filteredContracts.map(contract => (
          <li key={contract.id} className={`contractlist-item status-${contract.status}`} style={{ marginBottom: '20px', border: '1px solid #ccc', borderRadius: '8px', padding: '15px' }}>
            <div className="contractlist-summary" onClick={() => setSelected(contract)}>
              <div className="contractlist-summary-header" style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                <b style={{ fontSize: '18px' }}>{contract.name}</b>
                <span className={`contractlist-status badge-${contract.status}`} style={{ padding: '5px 10px', borderRadius: '5px', backgroundColor: contract.status === '진행중' ? '#4caf50' : contract.status === '대기' ? '#ff9800' : '#2196f3', color: '#fff' }}>{contract.status}</span>
              </div>
              <div className="contractlist-progress-bar" style={{ background: '#f0f0f0', height: '10px', borderRadius: '5px', marginTop: '10px' }}>
                <div
                  className="contractlist-progress"
                  style={{ width: `${getProgress(contract.schedules)}%`, background: '#4caf50', height: '100%', borderRadius: '5px' }}
                ></div>
              </div>
            </div>
            {selected && selected.id === contract.id && (
              <div className="contractlist-detail-popup" style={{ marginTop: '15px' }}>
                <h4 style={{ textAlign: 'center' }}>{contract.name} 상세</h4>
                <ul className="contractlist-schedule-list" style={{ listStyle: 'none', padding: 0 }}>
                  {contract.schedules.map(s => (
                    <li key={s.id} className="contractlist-schedule-item" style={{ display: 'flex', justifyContent: 'space-between', padding: '10px 0', borderBottom: '1px solid #ddd' }}>
                      <span className="schedule-title" style={{ flex: 1 }}>{s.title}</span>
                      <span className="schedule-date" style={{ flex: 1, textAlign: 'center' }}>{s.date}</span>
                      <span className={`schedule-status ${s.done ? 'done' : 'in-progress'}`} style={{ flex: 1, textAlign: 'right', color: s.done ? '#4caf50' : '#ff9800' }}>
                        {s.done ? '완료' : '진행중'}
                      </span>
                    </li>
                  ))}
                </ul>
                <button className="close-detail-btn" onClick={() => setSelected(null)} style={{ display: 'block', margin: '10px auto', padding: '10px 20px', background: '#f44336', color: '#fff', border: 'none', borderRadius: '5px', cursor: 'pointer' }}>닫기</button>
              </div>
            )}
          </li>
        ))}
      </ul>
    </div>
  );
}

export default ContractList;