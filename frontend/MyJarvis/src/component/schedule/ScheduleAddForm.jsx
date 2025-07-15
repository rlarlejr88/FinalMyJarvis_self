import React from 'react';
import './ScheduleAddForm.css';

function ScheduleAddForm({
  addType,
  setAddType,
  addTitle,
  setAddTitle,
  addDate,
  setAddDate,
  addDesc,
  setAddDesc,
  addStatus,
  setAddStatus,
  addColor,
  setAddColor,
  handleAddSchedule
}) {
  return (
    <div className="schedulemain-addform">
      <h3 className="form-title">일정 등록</h3>
      <div className="form-group">
        <label>유형</label>
        <select value={addType} onChange={e => setAddType(e.target.value)}>
          <option value="contract">계약 일정</option>
          <option value="personal">개인 일정</option>
        </select>
      </div>
      <div className="form-group">
        <label>제목</label>
        <input value={addTitle} onChange={e => setAddTitle(e.target.value)} placeholder="일정 제목을 입력하세요" />
      </div>
      <div className="form-group">
        <label>날짜</label>
        <input type="date" value={addDate} onChange={e => setAddDate(e.target.value)} />
      </div>
      <div className="form-group">
        <label>일정 내용</label>
        <textarea
          className="schedulemain-detail-textarea"
          value={addDesc}
          onChange={e => setAddDesc(e.target.value)}
          placeholder="일정 내용을 입력하세요"
          rows={3}
        />
      </div>
      <div className="form-group">
        <label>상태</label>
        <select value={addStatus} onChange={e => setAddStatus(e.target.value)}>
          <option value="계획">계획</option>
          <option value="진행중">진행중</option>
          <option value="완료">완료</option>
        </select>
      </div>
      <div className="form-group">
        <label>색상</label>
        <input type="color" value={addColor} onChange={e => setAddColor(e.target.value)} />
      </div>
      <button className="form-submit-btn" onClick={handleAddSchedule}>등록</button>
    </div>
  );
}

export default ScheduleAddForm;
