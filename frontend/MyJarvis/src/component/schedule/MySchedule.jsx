// 필요한 라이브러리와 컴포넌트 가져오기
import React, { useState, useEffect } from 'react';
import './Schedule.css';
import ContractList from './SchduleContractList';
import DailyWorkList from './DailyWorkList';
import WorkRemind from './WorkRemind';
import { Calendar, momentLocalizer } from 'react-big-calendar';
import moment from 'moment';
import 'react-big-calendar/lib/css/react-big-calendar.css';
import ScheduleAddForm from './ScheduleAddForm';

// moment를 사용하여 캘린더 로컬라이저 초기화
const localizer = momentLocalizer(moment);

function MySchedule() {
  // 상태 변수 정의
  const [viewState, setView] = useState('grid'); // 현재 탭 보기 상태 (grid, personal, contract 등)
  const [schedules, setSchedules] = useState([]); // 일정 목록을 저장하는 상태
  const [tasks, setTasks] = useState([]); // 작업 리스트 데이터를 저장하는 상태
  const [reminders, setReminders] = useState([]); // 리마인더 데이터를 저장하는 상태
  const [personalTitle, setPersonalTitle] = useState(''); // 개인 일정 제목 입력값
  const [personalDate, setPersonalDate] = useState(''); // 개인 일정 날짜 입력값
  const [personalStart, setPersonalStart] = useState(''); // 개인 일정 시작 시간 입력값
  const [selectedSchedule, setSelectedSchedule] = useState(null); // 선택된 일정 데이터
  const [addType, setAddType] = useState('personal'); // 일정 추가 유형 (personal, contract 등)
  const [addTitle, setAddTitle] = useState(''); // 추가할 일정 제목 입력값
  const [addDate, setAddDate] = useState(''); // 추가할 일정 날짜 입력값
  const [addDesc, setAddDesc] = useState(''); // 추가할 일정 설명 입력값
  const [addStatus, setAddStatus] = useState(false); // 추가할 일정 상태 (완료 여부)
  const [addColor, setAddColor] = useState('#4caf50'); // 추가할 일정 색상
  const [editMode, setEditMode] = useState(false); // 수정 모드 활성화 여부

  // 컴포넌트가 마운트될 때 서버에서 일정 데이터를 가져오는 함수
  useEffect(() => {
    async function fetchSchedules() {
      try {
        // 서버에서 일정 데이터를 가져옴
        const res = await fetch('/api/schedule');
        if (res.ok) {
          const result = await res.json();
          // 서버에서 받은 데이터를 일정 형식에 맞게 변환
          const data = Array.isArray(result.resData)
            ? result.resData.filter(s => s).map(s => ({
                id: s.scheduleNo, // 일정 ID
                title: s.title, // 일정 제목
                date: s.date, // 일정 날짜
                color: s.color || '#4caf50', // 일정 색상 (기본값: 초록색)
                detail: s.detail || '', // 일정 상세 내용
                done: s.done || false, // 완료 여부
                start: s.start || '09:00', // 시작 시간 (기본값: 오전 9시)
                type: s.type || 'personal', // 일정 유형 (기본값: 개인 일정)
                progress: s.progress || 0, // 진행률 (기본값: 0%)
              }))
            : [];
          setSchedules(data); // 변환된 데이터를 상태에 저장
        } else {
          const errorText = await res.text();
          console.error('서버 오류:', res.status, errorText); // 서버 오류 처리
        }
      } catch (e) {
        console.error('네트워크 오류:', e); // 네트워크 오류 처리
      }
    }
    fetchSchedules(); // 함수 호출
  }, []);

  // 작업 완료 상태를 토글하는 함수
  const handleToggle = (id) => {
    setTasks(tasks.map(task => task.id === id ? { ...task, done: !task.done } : task));
  };

  // 작업 중요 상태를 토글하는 함수
  const handleImportant = (id) => {
    setTasks(tasks.map(task => task.id === id ? { ...task, important: !task.important } : task));
  };

  // 작업을 삭제하는 함수
  const handleDelete = (id) => {
    setTasks(tasks.filter(task => task.id !== id));
  };

  // 리마인더를 읽음 처리하는 함수
  const handleRead = (id) => {
    setReminders(reminders.map(reminder => reminder.id === id ? { ...reminder, read: true } : reminder));
  };

  // 개인 일정을 추가하는 함수
  const handleAddPersonal = async () => {
    // 제목과 날짜가 입력되지 않은 경우 경고 메시지 표시
    if (!personalTitle || !personalDate) {
      alert('일정 제목과 날짜를 입력하세요.');
      return;
    }
    // 새로운 일정 데이터 생성
    const newSchedule = {
      title: personalTitle, // 일정 제목
      date: personalDate, // 일정 날짜
      start: personalStart || '09:00', // 시작 시간 (기본값: 오전 9시)
      detail: '', // 상세 내용 (기본값: 빈 문자열)
      done: false, // 완료 여부 (기본값: 미완료)
      type: 'personal', // 일정 유형 (기본값: 개인 일정)
      progress: 0, // 진행률 (기본값: 0%)
    };
    try {
      // 서버에 새로운 일정 데이터를 POST 요청으로 전송
      const res = await fetch('/api/schedule', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(newSchedule),
      });
      if (res.ok) {
        const savedSchedule = await res.json(); // 서버에서 저장된 일정 데이터 응답 받음
        setSchedules([...schedules, { ...newSchedule, id: savedSchedule.id }]); // 새로운 일정 추가
        setPersonalTitle(''); // 제목 입력값 초기화
        setPersonalDate(''); // 날짜 입력값 초기화
        setPersonalStart(''); // 시작 시간 입력값 초기화
        setView('personal'); // 개인 일정 보기로 전환
      } else {
        const errorText = await res.text();
        console.error('일정 추가 오류:', res.status, errorText); // 서버 오류 처리
      }
    } catch (e) {
      console.error('네트워크 오류:', e); // 네트워크 오류 처리
    }
  };

  return (
    <div className="myschedule-container">
      {/* 상단 탭: 전체 일정, 개인 일정, 계약 일정, 작업 리스트, 리마인더 */}
      <div className="myschedule-tabs">
        <button onClick={() => setView('grid')} className={`folder-tab ${viewState === 'grid' ? 'active' : ''}`}>전체 일정 보기</button>
        <button onClick={() => setView('personal')} className={`folder-tab ${viewState === 'personal' ? 'active' : ''}`}>내 일정 보기</button>
        <button onClick={() => setView('contract')} className={`folder-tab ${viewState === 'contract' ? 'active' : ''}`}>계약 연동 일정</button>
        <button onClick={() => setView('tasks')} className={`folder-tab ${viewState === 'tasks' ? 'active' : ''}`}>작업 리스트</button>
        <button onClick={() => setView('reminders')} className={`folder-tab ${viewState === 'reminders' ? 'active' : ''}`}>미완료 작업 리마인더</button>
      </div>

      {/* 전체 일정 보기 */}
      {viewState === 'grid' && (
        <div className="myschedule-grid">
          <h3>전체 일정 보기</h3>
          <ul className="schedule-list">
            {schedules.map(schedule => (
              <li
                key={schedule.id}
                className={`schedule-item ${schedule.type === 'contract' ? 'contract-schedule' : 'personal-schedule'}`}
                onClick={() => setSelectedSchedule(schedule)}
              >
                <div className="schedule-summary">
                  <h4>{schedule.title}</h4>
                  <p>날짜: {schedule.date}</p>
                  <p>진행률: {schedule.progress}%</p>
                  <div className="progress-bar" style={{ width: `${schedule.progress}%` }}></div>
                </div>
              </li>
            ))}
          </ul>
          {selectedSchedule && (
            <div className="schedule-detail-popup">
              <h4>{selectedSchedule.title}</h4>
              <p>날짜: {selectedSchedule.date}</p>
              <p>상세: {selectedSchedule.detail || '상세 없음'}</p>
              <p>상태: {selectedSchedule.done ? '완료' : '진행중'}</p>
              <button onClick={() => setEditMode(true)}>수정</button>
              <button onClick={() => setSelectedSchedule(null)}>닫기</button>
              {editMode && (
                <div className="edit-schedule-form">
                  <label>
                    제목
                    <input
                      type="text"
                      value={selectedSchedule.title}
                      onChange={e => setSelectedSchedule({ ...selectedSchedule, title: e.target.value })}
                    />
                  </label>
                  <label>
                    날짜
                    <input
                      type="date"
                      value={selectedSchedule.date}
                      onChange={e => setSelectedSchedule({ ...selectedSchedule, date: e.target.value })}
                    />
                  </label>
                  <label>
                    상세
                    <textarea
                      value={selectedSchedule.detail}
                      onChange={e => setSelectedSchedule({ ...selectedSchedule, detail: e.target.value })}
                    />
                  </label>
                  <button onClick={() => {
                    const updatedSchedules = schedules.map(s =>
                      s.id === selectedSchedule.id ? selectedSchedule : s
                    );
                    setSchedules(updatedSchedules);
                    setEditMode(false);
                  }}>저장</button>
                  <button onClick={() => setEditMode(false)}>취소</button>
                </div>
              )}
            </div>
          )}
        </div>
      )}

      {/* 개인 일정 보기 */}
      {viewState === 'personal' && (
        <div className="myschedule-personal">
          {/* 수정된 '일정 등록' 버튼: 등록 화면으로 전환 */}
          <button
            className="add-schedule-btn"
            onClick={() => setView('addSchedule')}
          >
            일정 등록
          </button>
          <Calendar
            localizer={localizer}
            events={schedules.map(s => ({
              id: s.id,
              title: `${s.title} (${s.done ? '완료' : '진행중'})`,
              start: new Date(s.date + 'T' + s.start),
              end: new Date(s.date + 'T' + s.start),
              allDay: false,
              resource: s,
            }))}
            defaultView={'month'}
            views={['month', 'week', 'day']}
            onSelectEvent={event => setSelectedSchedule(event.resource)}
            onEventDrop={({ event, start }) => {
              const updatedSchedules = schedules.map(s =>
                s.id === event.id ? { ...s, date: moment(start).format('YYYY-MM-DD'), start: moment(start).format('HH:mm') } : s
              );
              setSchedules(updatedSchedules);
            }}
            style={{ height: 500 }}
            selectable
            popup
            dayPropGetter={date => {
              const today = new Date();
              if (date.toDateString() === today.toDateString()) {
                return { className: 'today-cell' };
              }
              return null;
            }}
          />
        </div>
      )}

      {/* 일정 등록 화면 */}
      {viewState === 'addSchedule' && (
        <div className="add-schedule-view">
          <ScheduleAddForm
            addType={addType}
            setAddType={setAddType}
            addTitle={addTitle}
            setAddTitle={setAddTitle}
            addDate={addDate}
            setAddDate={setAddDate}
            addDesc={addDesc}
            setAddDesc={setAddDesc}
            addStatus={addStatus}
            setAddStatus={setAddStatus}
            addColor={addColor}
            setAddColor={setAddColor}
            handleAddSchedule={handleAddPersonal}
          />
          <button
            onClick={() => setView('personal')}
            className="cancel-btn"
          >
            취소
          </button>
        </div>
      )}

      {/* 계약 일정 보기 */}
      {viewState === 'contract' && (
        <ContractList />
      )}

      {/* 작업 리스트 보기 */}
      {viewState === 'tasks' && (
        <DailyWorkList
          tasks={tasks}
          handleToggle={handleToggle}
          handleImportant={handleImportant}
          handleDelete={handleDelete}
        />
      )}

      {/* 리마인더 보기 */}
      {viewState === 'reminders' && (
        <WorkRemind
          tab={viewState}
          reminders={reminders}
          handleRead={handleRead}
        />
      )}
    </div>
  );
}

export default MySchedule;