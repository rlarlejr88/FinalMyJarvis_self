import React, { useState, useEffect } from 'react';

/*
  AI 요약 실행, 자동 태그 추출

  - 회의 내용 요약 실행 버튼
  - 요약 결과 텍스트 표시
  - 요약문 직접 수정 가능
  - GPT기반 태그 추출 버튼
  - 추출된 태그 리스트 선택 적용
  - 불필요한 태그 삭제 기능
*/

// AI 요약 실행, GPT 태그 추출 샘플 (회의 내용 입력 → 요약/태그)
function SumAndMakeTag({ initialContent = '' }) {
  const [content, setContent] = useState(initialContent);
  const [summary, setSummary] = useState('');
  const [tags, setTags] = useState([]);
  const [editSummary, setEditSummary] = useState(false);

  useEffect(() => {
    setContent(initialContent);
    setSummary('');
    setTags([]);
    setEditSummary(false);
  }, [initialContent]);

  const handleSummarize = () => {
    setSummary(content ? `${content.slice(0, 20)}... (AI 요약 예시)` : '회의 내용을 입력하세요.');
    setEditSummary(false);
  };
  const handleTag = () => {
    setTags(content ? ['업무', '회의', 'AI'] : []);
  };
  const handleTagRemove = (tag) => {
    setTags(tags.filter(t => t !== tag));
  };

  return (
    <div className="gpt-summary-tag">
      <div style={{ flex: 1, minWidth: 220, maxWidth: 340, display: 'flex', flexDirection: 'column', alignItems: 'flex-start' }}>
        <h3 style={{ marginBottom: 8 }}>회의 내용 GPT 요약 및 태그</h3>
        <textarea
          placeholder="회의 내용을 입력하세요"
          value={content}
          onChange={e => setContent(e.target.value)}
          rows={5}
          className="gpt-content-input"
          style={{ width: '100%', minWidth: 180, maxWidth: 340, marginBottom: 12 }}
        />
        <div className="gpt-btns" style={{ display: 'flex', flexDirection: 'column', gap: 8, alignItems: 'flex-start', width: '100%' }}>
          <button onClick={handleSummarize}>요약 실행</button>
          <button onClick={handleTag}>GPT 태그 추출</button>
        </div>
      </div>
      <div style={{ flex: 2, minWidth: 260, maxWidth: 900, display: 'flex', flexDirection: 'row', gap: '2rem', alignItems: 'flex-start', transition: 'none' }}>
        <div className="gpt-summary-area" style={{ flex: 1, minWidth: 180 }}>
          <strong>요약:</strong>
          {editSummary ? (
            <textarea
              value={summary}
              onChange={e => setSummary(e.target.value)}
              rows={2}
              className="gpt-summary-edit"
              style={{ width: '100%', minWidth: 120, marginTop: 6 }}
            />
          ) : (
            <div style={{ marginTop: 6, marginBottom: 6 }}>{summary}</div>
          )}
          <button onClick={() => setEditSummary(!editSummary)} style={{ marginTop: 4 }}>{editSummary ? '수정 완료' : '요약 직접 수정'}</button>
        </div>
        <div className="gpt-tag-area" style={{ flex: 1, minWidth: 120 }}>
          <strong>태그:</strong>
          <div style={{ display: 'flex', flexWrap: 'wrap', gap: 6, marginTop: 6 }}>
            {tags.map(tag => (
              <span key={tag} style={{ background: '#e7f0fa', color: '#2563eb', borderRadius: 6, padding: '2px 10px', marginRight: 4, display: 'inline-flex', alignItems: 'center' }}>
                {tag}
                <button onClick={() => handleTagRemove(tag)} style={{ marginLeft: 4, background: 'none', border: 'none', color: '#e11d48', fontWeight: 700, cursor: 'pointer', fontSize: 14 }}>×</button>
              </span>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}

export default SumAndMakeTag;