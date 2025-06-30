package kr.or.iei.meeting.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.iei.meeting.model.dao.MeetingDao;

@Service
public class MeetingService {
	
     @Autowired
     private MeetingDao dao;
     
     
     
}