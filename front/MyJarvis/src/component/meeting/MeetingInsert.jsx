import React, { useState } from 'react';

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
function MeetingInsert() {
  const [title, setTitle] = useState('');
  const [date, setDate] = useState('');
  const [content, setContent] = useState('');
  const [file, setFile] = useState(null);
  const [participants, setParticipants] = useState('');

  const handleSubmit = (e) => {
    e.preventDefault();
    alert('회의록이 등록되었습니다! (실제 저장 로직 필요)');
  };

  return (
    <form onSubmit={handleSubmit} style={{ maxWidth: 400 }}>
      <h3>회의록 등록</h3>
      <input placeholder="회의 제목" value={title} onChange={e => setTitle(e.target.value)} required /><br />
      <input type="date" value={date} onChange={e => setDate(e.target.value)} required /><br />
      <textarea placeholder="회의 내용" value={content} onChange={e => setContent(e.target.value)} rows={4} required /><br />
      <input placeholder="참여자(,로 구분)" value={participants} onChange={e => setParticipants(e.target.value)} /><br />
      <input type="file" onChange={e => setFile(e.target.files[0])} /><br />
      {file && <div>업로드 파일: {file.name}</div>}
      <button type="submit">등록</button>
    </form>
  );
}

export default MeetingInsert;