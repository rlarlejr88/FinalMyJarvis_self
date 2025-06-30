import React, { useState } from 'react';
import './MeetingInsert.css';

/*
  수동 작성, 회의 파일 업로드

  - 회의 제목 입력
  - 회의 일시 선택
  - 회의 내용 작성 에디터
  - 참여자 추가(이메일 자동완성)
  - 파일 선택 버튼
  - 파일 목록 표시
  - 미리보기 또는 삭제 기능
*/

// 회의록 등록/수정, 파일 업로드 폼
function MeetingInsert({ setMeetings, setTab }) {
  const [title, setTitle] = useState('');
  const [date, setDate] = useState('');
  const [content, setContent] = useState('');
  const [file, setFile] = useState(null);
  const [participants, setParticipants] = useState('');

  const handleSubmit = (e) => {
    e.preventDefault();
    // 새 회의록 추가
    setMeetings(prev => [
      ...prev,
      {
        id: Date.now(),
        title,
        date,
        content,
        tags: [],
        participants,
        file,
      },
    ]);
    setTitle('');
    setDate('');
    setContent('');
    setParticipants('');
    setFile(null);
    alert('회의록이 등록되었습니다!');
    if (setTab) setTab('list'); // 등록 후 목록 탭으로 자동 전환
  };

  return (
    <form onSubmit={handleSubmit} className="meeting-insert-form">
      <h3>회의록 등록</h3>
      <input placeholder="회의 제목" value={title} onChange={e => setTitle(e.target.value)} required />
      <input type="date" value={date} onChange={e => setDate(e.target.value)} required />
      <textarea placeholder="회의 내용" value={content} onChange={e => setContent(e.target.value)} rows={4} required />
      <input placeholder="참여자(,로 구분)" value={participants} onChange={e => setParticipants(e.target.value)} />
      <input type="file" onChange={e => setFile(e.target.files[0])} />
      {file && <div>업로드 파일: {file.name}</div>}
      <button type="submit">등록</button>
    </form>
  );
}

export default MeetingInsert;