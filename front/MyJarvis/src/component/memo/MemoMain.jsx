/*
  최근 메모 우선, 즐겨찾기 메모

  - 최신 작성 순 정렬
  - 중요 메모 즐겨찾기 등록
  - 즐겨찾기 필터 토글
  - 메모 제목/내용 요약 표시
  - 고정/비고정 상태 구분 아이콘
 */

import React, { useState } from 'react';
import MemoFixed from './MemoFixed';
import MemoSearch from './MemoSearch';

// 샘플 메모 데이터
const sampleMemos = [
  { id: 1, title: '회의 준비', content: '회의 자료 준비 및 참석자 확인', date: '2025-06-25', fixed: false },
  { id: 2, title: '계약 검토', content: '계약서 3차 검토 및 수정사항 정리', date: '2025-06-26', fixed: true },
  { id: 3, title: '개인 일정', content: '병원 예약(오전 10시)', date: '2025-06-27', fixed: false },
];

// 메모 메인: 최근 메모, 즐겨찾기, 중요 메모 등 탭 연결
function MemoMain() {
  const [tab, setTab] = useState('recent');
  const [selectedMemo, setSelectedMemo] = useState(null);
  const [memos, setMemos] = useState(sampleMemos);

  const handleDelete = (id) => {
    setMemos(memos.filter(m => m.id !== id));
    if (selectedMemo && selectedMemo.id === id) setSelectedMemo(null);
  };

  // 빠른 메모에서 저장 시 최근 메모에 추가
  const handleAddQuickMemo = (text) => {
    if (!text.trim()) return;
    const newMemo = {
      id: Date.now(),
      title: '빠른 메모',
      content: text,
      date: new Date().toISOString().slice(0, 10),
      fixed: false,
    };
    setMemos([newMemo, ...memos]);
  };

  return (
    <div>
      <h2>메모/포스트잇</h2>
      <div style={{ display: 'flex', gap: 8, marginBottom: 16, justifyContent: 'center' }}>
        <button onClick={() => setTab('recent')}>최근 메모</button>
        <button onClick={() => setTab('fixed')}>고정 메모</button>
        <button onClick={() => setTab('search')}>메모 검색</button>
      </div>
      {tab === 'recent' && (
        <div style={{ maxWidth: 500, margin: '0 auto' }}>
          <h4>최근 메모</h4>
          <ul style={{ padding: 0, listStyle: 'none' }}>
            {memos.map(m => (
              <li key={m.id} style={{ background: '#f8fafc', borderRadius: 8, marginBottom: 10, padding: 12, boxShadow: '0 1px 4px #e0e7ef33', cursor: 'pointer', position: 'relative' }} onClick={() => setSelectedMemo(m)}>
                <b>{m.title}</b> <span style={{ color: '#888', fontSize: '0.95em' }}>({m.date})</span><br />
                <span>{m.content}</span>
                {m.fixed && <span style={{ color: '#f59e42', marginLeft: 8 }}>[고정]</span>}
                <button
                  onClick={e => { e.stopPropagation(); handleDelete(m.id); }}
                  style={{ position: 'absolute', top: 8, right: 12, background: 'none', border: 'none', color: '#e11d48', fontSize: 18, cursor: 'pointer' }}
                  title="삭제"
                >
                  ×
                </button>
              </li>
            ))}
          </ul>
          {selectedMemo && (
            <div style={{ position: 'fixed', left: 0, top: 0, width: '100vw', height: '100vh', background: '#0008', zIndex: 10000, display: 'flex', alignItems: 'center', justifyContent: 'center' }} onClick={() => setSelectedMemo(null)}>
              <div style={{ background: '#fff', borderRadius: 12, padding: 32, minWidth: 320, maxWidth: 400, boxShadow: '0 2px 16px #0002', position: 'relative' }} onClick={e => e.stopPropagation()}>
                <button onClick={() => setSelectedMemo(null)} style={{ position: 'absolute', top: 12, right: 16, background: 'none', border: 'none', fontSize: 22, cursor: 'pointer', color: '#888' }}>&times;</button>
                <h3 style={{ marginTop: 0 }}>{selectedMemo.title}</h3>
                <div style={{ color: '#888', fontSize: '0.95em', marginBottom: 8 }}>{selectedMemo.date}</div>
                <div style={{ marginBottom: 12 }}>{selectedMemo.content}</div>
                {selectedMemo.fixed && <div style={{ color: '#f59e42', fontWeight: 600 }}>[고정 메모]</div>}
              </div>
            </div>
          )}
        </div>
      )}
      {tab === 'fixed' && (
        <div style={{ maxWidth: 500, margin: '0 auto' }}>
          <h4>고정 메모</h4>
          <ul style={{ padding: 0, listStyle: 'none' }}>
            {memos.filter(m => m.fixed).map(m => (
              <li key={m.id} style={{ background: '#fffbe6', borderRadius: 8, marginBottom: 10, padding: 12, boxShadow: '0 1px 4px #ffe06655', position: 'relative', cursor: 'pointer' }} onClick={() => setSelectedMemo(m)}>
                <b>{m.title}</b> <span style={{ color: '#888', fontSize: '0.95em' }}>({m.date})</span><br />
                <span>{m.content}</span>
                <button
                  onClick={e => { e.stopPropagation(); handleDelete(m.id); }}
                  style={{ position: 'absolute', top: 8, right: 12, background: 'none', border: 'none', color: '#e11d48', fontSize: 18, cursor: 'pointer' }}
                  title="삭제"
                >
                  ×
                </button>
              </li>
            ))}
          </ul>
          {selectedMemo && (
            <div style={{ position: 'fixed', left: 0, top: 0, width: '100vw', height: '100vh', background: '#0008', zIndex: 10000, display: 'flex', alignItems: 'center', justifyContent: 'center' }} onClick={() => setSelectedMemo(null)}>
              <div style={{ background: '#fff', borderRadius: 12, padding: 32, minWidth: 320, maxWidth: 400, boxShadow: '0 2px 16px #0002', position: 'relative' }} onClick={e => e.stopPropagation()}>
                <button onClick={() => setSelectedMemo(null)} style={{ position: 'absolute', top: 12, right: 16, background: 'none', border: 'none', fontSize: 22, cursor: 'pointer', color: '#888' }}>&times;</button>
                <h3 style={{ marginTop: 0 }}>{selectedMemo.title}</h3>
                <div style={{ color: '#888', fontSize: '0.95em', marginBottom: 8 }}>{selectedMemo.date}</div>
                <div style={{ marginBottom: 12 }}>{selectedMemo.content}</div>
                {selectedMemo.fixed && <div style={{ color: '#f59e42', fontWeight: 600 }}>[고정 메모]</div>}
              </div>
            </div>
          )}
          <MemoFixed onAddMemo={handleAddQuickMemo} />
        </div>
      )}
      {tab === 'search' && <MemoSearch />}
      {/* 포스트잇(빠른 메모) 항상 렌더링, onAddMemo 항상 전달 */}
      <MemoFixed onAddMemo={handleAddQuickMemo} />
    </div>
  );
}

export default MemoMain;