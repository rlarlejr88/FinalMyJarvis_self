import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';
import MeetingMain from './component/meeting/MeetingMain';
import ScheduleMain from './component/schedule/ScheduleMain';
import MemoMain from './component/memo/MemoMain';
import MemoFixed from './component/memo/MemoFixed';
import './App.css';

function App() {
 {/*
    기능 : 사용자의 일상 업무 효율과 기록, 협업을 지원하는 기능을 개발. 사용자의 직접적인 사용 경험(UX)에 집중

    기능 그룹 : 회의 관리, 일정/작업 관리, 메모/포스트잇

    상세 기능 : - 회의록 등록/수정, 파일 업로드
               - GPT 요약/태그 기능 연동
               - 계약 연도 일정 자동 생성
               - To-do 및 리마인더 기능
               - 페이지별 메모 관리
            
    특징 : A 개발자가 만든 핵심 데이터를 활용하여 연동. 사용자 인터페이스의 편의성이 중요. 개발자의 API에 대한 의존성 가짐
  */}

  return (
    <Router>
      <div className="app-layout">
        <aside className="sidebar">
          <h2 className="sidebar-title">My Jarvis</h2>
          <nav className="sidebar-nav">
            <Link to="/meeting">회의 관리</Link>
            <Link to="/schedule">일정/작업 관리</Link>
            <Link to="/memo">메모/포스트잇</Link>
          </nav>
        </aside>
        <main className="main-content">
          <Routes>
            <Route path="/meeting/*" element={<MeetingMain />} />
            <Route path="/schedule/*" element={<ScheduleMain />} />
            <Route path="/memo/*" element={<MemoMain />} />
            <Route path="*" element={<div>환영합니다! 좌측 메뉴에서 기능을 선택하세요.</div>} />
          </Routes>
        </main>
        <MemoFixed globalMemo />
      </div>
    </Router>
  )
}

export default App
