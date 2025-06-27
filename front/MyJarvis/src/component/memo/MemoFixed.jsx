import React, { useState, useEffect } from 'react';

/*
  고정 등록/해제, 우선순위 설정

  - 메모 상단 고정 버튼
  - 고정 해제 시 자동 정렬
  - 우선 순위(상/중/하) 설정 드롭다운
  - 우선순위별 색상 구분
*/

// 고정/해제, 우선순위 설정, 색상 구분 샘플
const initialMemos = [
  { id: 1, text: '중요 메모', fixed: true, priority: '상', color: 'yellow' },
  { id: 2, text: '일반 메모', fixed: false, priority: '하', color: 'white' },
];

function MemoFixed({ onAddMemo }) {
  // 전역 메모 상태: localStorage 사용
  const [memo, setMemo] = useState(() => localStorage.getItem('globalMemo') || '');
  const [saved, setSaved] = useState(false);
  const [folded, setFolded] = useState(false);

  useEffect(() => {
    const savedMemo = localStorage.getItem('globalMemo');
    if (savedMemo !== null) setMemo(savedMemo);
  }, []);

  const handleChange = e => {
    setMemo(e.target.value);
    setSaved(false);
  };
  const handleSave = () => {
    localStorage.setItem('globalMemo', memo);
    setSaved(true);
    if (onAddMemo && memo.trim()) {
      onAddMemo(memo);
      setMemo('');
    }
  };

  if (folded) {
    return (
      <div style={{
        position: 'fixed',
        right: 32,
        bottom: 32,
        zIndex: 9999,
        background: '#fffbe6',
        border: '1.5px solid #ffe066',
        borderRadius: 14,
        boxShadow: '0 2px 12px #e0e7ef55',
        padding: '0.7rem 1.2rem',
        minWidth: 120,
        maxWidth: 180,
        minHeight: 0,
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        fontSize: '1rem',
      }}>
        <button onClick={() => setFolded(false)} style={{
          background: '#ffe066',
          color: '#fab005',
          fontWeight: 700,
          border: 'none',
          borderRadius: 8,
          padding: '0.5rem 1.2rem',
          cursor: 'pointer',
        }}>열기</button>
      </div>
    );
  }
  return (
    <div style={{
      position: 'fixed',
      right: 32,
      bottom: 32,
      zIndex: 9999,
      background: '#fffbe6',
      border: '1.5px solid #ffe066',
      borderRadius: 14,
      boxShadow: '0 2px 12px #e0e7ef55',
      padding: '1.2rem 1.2rem 1.6rem 1.2rem',
      minWidth: 260,
      maxWidth: 340,
      minHeight: 120,
      display: 'flex',
      flexDirection: 'column',
      alignItems: 'stretch',
      fontSize: '1rem',
    }}>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: 8 }}>
        <span style={{ fontWeight: 700, color: '#fab005', fontSize: '1.1rem' }}>포스트잇</span>
        <button onClick={() => setFolded(true)} style={{
          background: '#ffe066',
          color: '#fab005',
          fontWeight: 700,
          border: 'none',
          borderRadius: 8,
          padding: '0.2rem 0.8rem',
          cursor: 'pointer',
          fontSize: '1rem',
        }}>접기</button>
      </div>
      <textarea
        value={memo}
        onChange={handleChange}
        placeholder="여기에 메모를 남기세요..."
        style={{
          width: '100%',
          minHeight: 70,
          border: '1px solid #ffe066',
          borderRadius: 8,
          padding: 8,
          fontSize: '1rem',
          background: '#fffde4',
          resize: 'vertical',
        }}
      />
      <button onClick={handleSave} style={{
        marginTop: 10,
        background: saved ? '#fab005' : '#ffe066',
        color: saved ? '#fff' : '#fab005',
        fontWeight: 600,
        border: 'none',
        borderRadius: 8,
        padding: '0.5rem 1.2rem',
        cursor: 'pointer',
        transition: 'background 0.2s, color 0.2s',
      }}>저장</button>
      {saved && <div style={{ color: '#228be6', fontSize: '0.95rem', marginTop: 4 }}>저장됨</div>}
    </div>
  );
}

export default MemoFixed;