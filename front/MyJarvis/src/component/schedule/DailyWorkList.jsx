import React, { useState } from 'react';

/*
  오늘 할 일, 완료/미완료 분류

  - To-do 리스트 등록
  - 체크박스로 완료 상태 표시
  - 작업 중요도 선택(Low/Medium/High)
  - 작업 정렬(기한순, 중요도순 등)
  - 완료 항목 숨기기 옵션
 */

// 오늘 할 일, To-do 등록/완료 체크, 중요도/정렬 샘플
const initialTodos = [
  { id: 1, text: '보고서 작성', done: false, priority: 'High' },
  { id: 2, text: '미팅 준비', done: true, priority: 'Low' },
];

function DailyWorkList() {
  const [todos, setTodos] = useState(initialTodos);
  const [input, setInput] = useState('');
  const [priority, setPriority] = useState('Medium');
  const [deleteMode, setDeleteMode] = useState(false);
  const [checked, setChecked] = useState([]);

  const addTodo = () => {
    if (!input) return;
    setTodos([...todos, { id: Date.now(), text: input, done: false, priority }]);
    setInput('');
  };
  const toggleDone = id => {
    setTodos(todos.map(t => t.id === id ? { ...t, done: !t.done } : t));
  };
  const handleCheck = id => {
    setChecked(checked.includes(id) ? checked.filter(cid => cid !== id) : [...checked, id]);
  };
  const handleDelete = () => {
    setTodos(todos.filter(t => !checked.includes(t.id)));
    setChecked([]);
    setDeleteMode(false);
  };
  const handleCancel = () => {
    setChecked([]);
    setDeleteMode(false);
  };

  return (
    <div>
      <h3>오늘 할 일</h3>
      <div className="button-row" style={{ marginBottom: 12 }}>
        <input value={input} onChange={e => setInput(e.target.value)} placeholder="할 일 입력" />
        <select value={priority} onChange={e => setPriority(e.target.value)}>
          <option>Low</option><option>Medium</option><option>High</option>
        </select>
        <button onClick={addTodo}>추가</button>
        {deleteMode ? (
          <>
            <button onClick={handleDelete} disabled={checked.length === 0}>선택 삭제</button>
            <button onClick={handleCancel}>취소</button>
          </>
        ) : (
          <button onClick={() => setDeleteMode(true)}>삭제</button>
        )}
      </div>
      <ul>
        {todos.map(t => (
          <li key={t.id} style={{ textDecoration: t.done ? 'line-through' : 'none', display: 'flex', alignItems: 'center' }}>
            {deleteMode && (
              <input type="checkbox" checked={checked.includes(t.id)} onChange={() => handleCheck(t.id)} style={{ marginRight: 8 }} />
            )}
            <span style={{ flex: 1 }}>
              <input type="checkbox" checked={t.done} onChange={() => toggleDone(t.id)} disabled={deleteMode} style={{ marginRight: 8 }} />
              {t.text} ({t.priority})
            </span>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default DailyWorkList;