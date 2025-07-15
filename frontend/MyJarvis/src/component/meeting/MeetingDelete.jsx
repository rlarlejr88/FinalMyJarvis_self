import React from "react";

// props: id(삭제할 회의 id), onDelete(삭제 함수), onCancel(취소 함수)
function MeetingDelete({ id, onDelete, onCancel }) {
  const handleDelete = async () => {
    try {
      const res = await fetch(`/api/meetings/${id}`, {
        method: 'DELETE',
      });
      if (res.ok) {
        onDelete(id);
        alert('회의가 삭제되었습니다.');
      } else {
        alert('삭제 실패 (서버 오류)');
      }
    } catch {
      alert('삭제 실패 (네트워크 오류)');
    }
  };

  return (
    <div className="meeting-delete-modal">
      <div className="meeting-delete-content">
        <h4>회의록 삭제</h4>
        <p>정말 삭제하시겠습니까?</p>
        <div className="meeting-delete-btns">
          <button className="meeting-delete-confirm" onClick={handleDelete}>삭제</button>
          <button className="meeting-delete-cancel" onClick={onCancel}>취소</button>
        </div>
      </div>
    </div>
  );
}

export default MeetingDelete;
