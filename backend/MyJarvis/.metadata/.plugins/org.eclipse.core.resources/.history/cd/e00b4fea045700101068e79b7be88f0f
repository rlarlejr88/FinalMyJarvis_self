package kr.or.iei.meeting.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.iei.meeting.model.dao.MeetingDao;
import kr.or.iei.meeting.model.dto.Meeting;

@Service
public class MeetingService {
	
     @Autowired
     private MeetingDao dao;

     @Transactional
	public int insertMeeting(Meeting meeting) {
    	  
		return dao.insertMeeting(meeting);
	}
     
     
     
}