import React, { useState } from 'react';
import './DailyWorkList.css';

function DailyWorkList() {
  const [tasks, setTasks] = useState([
    { id: 1, text: '회의록 정리', done: false, priority: 'High', dueDate: '2025-07-15' },
    { id: 2, text: '계약 일정 확인', done: false, priority: 'Medium', dueDate: '2025-07-16' },
    { id: 3, text: 'To-do 기능 구현', done: true, priority: 'Low', dueDate: '2025-07-14' },
  ]);
  const [input, setInput] = useState('');
  const [priority, setPriority] = useState('Medium');
  const [hideDone, setHideDone] = useState(false);
  const [sortOption, setSortOption] = useState('dueDate'); // dueDate, priority

  const handleAdd = () => {
    if (input.trim()) {
      setTasks([
        ...tasks,
        { id: Date.now(), text: input, done: false, priority, dueDate: new Date().toISOString().split('T')[0] },
      ]);
      setInput('');
    }
  };

  const handleToggle = (id) => {
    setTasks(tasks.map(t => t.id === id ? { ...t, done: !t.done } : t));
  };

  const handleDelete = (id) => {
    setTasks(tasks.filter(t => t.id !== id));
  };

  const sortedTasks = [...tasks]
    .filter(t => !(hideDone && t.done))
    .sort((a, b) => {
      if (sortOption === 'dueDate') {
        return new Date(a.dueDate) - new Date(b.dueDate);
      } else if (sortOption === 'priority') {
        const priorityOrder = { High: 1, Medium: 2, Low: 3 };
        return priorityOrder[a.priority] - priorityOrder[b.priority];
      }
      return 0;
    });

  return (
    <div className="dailywork-container" style={{ textAlign: 'center' }}>
      <h3>오늘의 To-do</h3>
      <div className="dailywork-controls" style={{ display: 'flex', justifyContent: 'center', gap: '10px', marginBottom: '20px' }}>
        <input
          className="dailywork-input"
          value={input}
          onChange={e => setInput(e.target.value)}
          placeholder="할 일을 입력하세요"
          onKeyDown={e => e.key === 'Enter' && handleAdd()}
          style={{ padding: '10px', fontSize: '16px', width: '300px' }}
        />
        <select value={priority} onChange={e => setPriority(e.target.value)} style={{ padding: '10px', fontSize: '16px' }}>
          <option value="High">High</option>
          <option value="Medium">Medium</option>
          <option value="Low">Low</option>
        </select>
        <button className="dailywork-add-btn" onClick={handleAdd} style={{ padding: '10px 20px', fontSize: '16px' }}>추가</button>
      </div>
      <div className="dailywork-filters" style={{ display: 'flex', justifyContent: 'center', gap: '10px', marginBottom: '20px' }}>
        <select value={sortOption} onChange={e => setSortOption(e.target.value)} style={{ padding: '10px', fontSize: '16px' }}>
          <option value="dueDate">기한순</option>
          <option value="priority">중요도순</option>
        </select>
        <label style={{ display: 'flex', alignItems: 'center', gap: '5px' }}>
          <input type="checkbox" checked={hideDone} onChange={e => setHideDone(e.target.checked)} /> 완료 숨기기
        </label>
      </div>
      <ul className="dailywork-list" style={{ listStyle: 'none', padding: 0, width: '80%', margin: '0 auto' }}>
        {sortedTasks.length === 0 && <li className="dailywork-empty">할 일이 없습니다</li>}
        {sortedTasks.map(task => (
          <li key={task.id} className={`dailywork-item${task.done ? ' done' : ''}`} style={{ marginBottom: '10px', border: '1px solid #ccc', borderRadius: '8px', padding: '10px' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
              <span className="dailywork-check" onClick={() => handleToggle(task.id)} style={{ cursor: 'pointer' }}>
                {task.done ? '✔️' : '⬜'}
              </span>
              <span className="dailywork-text" style={{ flex: 1, textAlign: 'left', marginLeft: '10px' }}>{task.text}</span>
              <span className="dailywork-priority" style={{ marginRight: '10px', color: task.priority === 'High' ? '#f44336' : task.priority === 'Medium' ? '#ff9800' : '#4caf50' }}>
                {task.priority}
              </span>
              <span className="dailywork-dueDate" style={{ marginRight: '10px' }}>{task.dueDate}</span>
              <button className="dailywork-delete-btn" onClick={() => handleDelete(task.id)} style={{ background: '#f44336', color: '#fff', border: 'none', borderRadius: '5px', padding: '5px 10px', cursor: 'pointer' }}>삭제</button>
            </div>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default DailyWorkList;