package kr.or.iei.meeting.model.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import kr.or.iei.meeting.model.dao.MeetingDao;
import kr.or.iei.meeting.model.dto.Meeting;
import kr.or.iei.common.gpt.GptService;

@Service
public class MeetingService {
    @Autowired
    private MeetingDao dao;
    
    @Autowired
    private GptService gptService;

    @Transactional
    public int insertMeeting(Meeting meeting) {
        return dao.insertMeeting(meeting);
    }

    @Transactional
    public int updateMeeting(Meeting meeting) {
        return dao.updateMeeting(meeting);
    }
    
    @Transactional
    public int deleteMeeting(String meetingNo) {
        return dao.deleteMeeting(meetingNo);
    }

    public Meeting getMeetingByNo(String meetingNo) {
        return dao.selectMeetingByNo(meetingNo);
    }

    public List<Meeting> getAllMeetings() {
        return dao.selectAllMeetings();
    }
    
    public String summarizeMeeting(String content) {
        return gptService.summarize(content);
    }
    
}