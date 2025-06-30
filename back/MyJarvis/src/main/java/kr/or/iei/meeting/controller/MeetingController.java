package kr.or.iei.meeting.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.or.iei.meeting.model.service.MeetingService;

@RestController
@CrossOrigin("*")
@RequestMapping("/member")
public class MeetingController {
	
     @Autowired
     private MeetingService service;
     
     
     
     
}