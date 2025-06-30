/*
  계약별 일정 보기, 상태에 따른 일정 표시

  - 계약명 기준으로 일정 그룹핑
  - 계약상태(진행,완료 등) 필터 제공
  - 상태별 일정 강조 표시(색상 또는 뱃지)
  - 검색 기능(계약명, 날짜 기준)
*/

import React, { useState } from 'react';
import MemoFixed from '../memo/MemoFixed';

const initialContracts = [
  { id: 1, name: 'A사 계약', status: '진행', date: '2025-07-01', desc: 'A사와의 연간 유지보수 계약. 7월 1일 시작, 1년간 진행.' },
  { id: 2, name: 'B사 계약', status: '완료', date: '2025-06-15', desc: 'B사 신규 시스템 구축 계약. 6월 15일 완료.' },
];

function ContractList() {
  const [contracts, setContracts] = useState(initialContracts);
  const [selected, setSelected] = useState(null);
  const [editMode, setEditMode] = useState(false);
  const [editData, setEditData] = useState({ name: '', date: '', status: '', desc: '' });

  const handleDelete = (id) => {
    setContracts(contracts.filter(c => c.id !== id));
    setSelected(null);
  };

  const handleEditChange = (e) => {
    const { name, value } = e.target;
    setEditData(prev => ({ ...prev, [name]: value }));
  };
  const handleEditSave = () => {
    setContracts(contracts.map(c => c.id === selected.id ? { ...c, ...editData } : c));
    setEditMode(false);
    setSelected(null);
  };
  const handleEditCancel = () => {
    setEditMode(false);
    setSelected(null);
  };

  return (
    <div style={{ position: 'relative' }}>
      <h3>계약별 일정</h3>
      <ul>
        {contracts.map(c => (
          <li key={c.id} style={{ display: 'flex', alignItems: 'center' }}>
            <span
              style={{ flex: 1, cursor: 'pointer', fontWeight: selected && selected.id === c.id ? 'bold' : 'normal', display: selected && selected.id === c.id && !editMode ? 'none' : 'block' }}
              onClick={() => { setSelected(c); setEditMode(false); }}
            >
              {c.name} - 상태: {c.status}
            </span>
            {selected && selected.id === c.id && !editMode && (
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
                  <div style={{ fontSize: '1.1rem', fontWeight: 600, minWidth: 110 }}>{selected.name}</div>
                  <div>
                    <div><b>날짜:</b> {selected.date}</div>
                    <div><b>상태:</b> <span style={{ color: selected.status === '완료' ? '#228be6' : '#fab005', fontWeight: 500 }}>{selected.status}</span></div>
                    <div style={{ marginTop: 8 }}><b>설명:</b> <span style={{ color: '#444' }}>{selected.desc}</span></div>
                  </div>
                  <div style={{ display: 'flex', flexDirection: 'row', gap: 12, marginLeft: 18 }}>
                    <button style={{ background: '#fff', color: '#2563eb', border: '1px solid #2563eb', borderRadius: 8, padding: '8px 24px', fontWeight: 500, fontSize: '1rem', cursor: 'pointer' }}
                      onClick={() => { setEditData({ name: selected.name, date: selected.date, status: selected.status, desc: selected.desc }); setEditMode(true); }}
                    >수정</button>
                    <button style={{ background: '#e11d48', color: '#fff', border: 'none', borderRadius: 8, padding: '8px 24px', fontWeight: 600, fontSize: '1rem', cursor: 'pointer' }}
                      onClick={() => handleDelete(selected.id)}
                    >삭제</button>
                  </div>
                </div>
              </>
            )}
            {selected && selected.id === c.id && editMode && (
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
                  <label style={{ display: 'block', fontWeight: 600 }}>계약명:
                    <input name="name" value={editData.name} onChange={handleEditChange} style={{ marginLeft: 8, width: 220 }} />
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
      <MemoFixed globalMemo />
    </div>
  );
}

export default ContractList;