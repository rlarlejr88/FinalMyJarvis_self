/*
  계약 연동 일정 표시, 개인 일정 포함

  - 계약별 일정 자동 생성
  - 개인 일정 수동 추가 기능
  - 계약 일정과 개인 일정 색상 구분
  - 진행퓰 표시(막대 또는 퍼센트로)
  - 일정 클릭 시, 상세 팝업 보기
*/

import React, { useState } from 'react';
import ContractList from './ContractList';
import DailyWorkList from './DailyWorkList';
import MySchedule from './MySchedule';
import WorkRemind from './WorkRemind';
import './Schedule.css';

// 일정/작업 관리 메인: 계약 연도 일정, To-do, 리마인더 등 탭 연결
function ScheduleMain() {
  const [tab, setTab] = useState('contract');
  return (
    <div className="schedule-main">
      <h2>일정/작업 관리</h2>
      <div className="button-row" style={{ marginBottom: 16 }}>
        <button onClick={() => setTab('contract')}>계약별 일정</button>
        <button onClick={() => setTab('todo')}>오늘 할 일</button>
        <button onClick={() => setTab('myschedule')}>내 일정</button>
        <button onClick={() => setTab('remind')}>리마인더</button>
      </div>
      {tab === 'contract' && <ContractList />}
      {tab === 'todo' && <DailyWorkList />}
      {tab === 'myschedule' && <MySchedule />}
      {tab === 'remind' && <WorkRemind />}
    </div>
  );
}

export default ScheduleMain;