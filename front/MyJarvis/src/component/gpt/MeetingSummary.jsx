import React, { useState } from "react";
import "./MeetingSummary.css";

function MeetingSummary({ content }) {
  const [summary, setSummary] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  const handleSummarize = async () => {
    setLoading(true);
    setError("");
    setSummary("");
    try {
      const res = await fetch("/api/gpt/summary", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ content }),
      });
      if (res.ok) {
        const data = await res.json();
        setSummary(data.summary || "");
      } else {
        setError("요약 실패 (서버 오류)");
      }
    } catch (e) {
      setError("요약 실패 (네트워크 오류)");
    }
    setLoading(false);
  };

  return (
    <div className="meeting-summary-container">
      <button className="meeting-summary-btn" onClick={handleSummarize} disabled={loading}>
        {loading ? "요약 중..." : "요약 실행"}
      </button>
      <div className="meeting-summary-title">
        회의 내용 GPT 요약
        <div className="meeting-summary-box">
          {error ? <span className="meeting-summary-error">{error}</span> : summary}
        </div>
      </div>
    </div>
  );
}

export default MeetingSummary;
