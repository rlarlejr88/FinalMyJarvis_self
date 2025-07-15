package kr.or.iei.meeting.model.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import kr.or.iei.meeting.model.dto.Meeting;

@Mapper
public interface MeetingDao {
    int insertMeeting(Meeting meeting);
    int updateMeeting(Meeting meeting);

    int deleteMeeting(String meetingNo);
    
    Meeting selectMeetingByNo(String meetingNo);
    List<Meeting> selectAllMeetings();
}
