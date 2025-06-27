import React, { useState } from 'react';
import MeetingInsert from './MeetingInsert';
import MeetingList from './MeetingList';
import TagList from './TagList';
import './Meet.css';

// 회의 관리 메인: 회의록 등록/수정, 파일 업로드, 태그별 보기만 탭으로 노출
function MeetingMain() {
  const [tab, setTab] = useState('list');
  return (
    <div className="meeting-main">
      <h2>회의 관리</h2>
      <div className="button-row">
        <button onClick={() => setTab('list')}>회의록 목록</button>
        <button onClick={() => setTab('insert')}>회의록 등록</button>
        <button onClick={() => setTab('tag')}>태그별 보기</button>
      </div>
      {tab === 'list' && <MeetingList />}
      {tab === 'insert' && <MeetingInsert />}
      {tab === 'tag' && <TagList />}
    </div>
  );
}

export default MeetingMain;