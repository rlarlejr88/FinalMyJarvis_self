package kr.or.iei.meeting.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.or.iei.common.model.dto.ResponseDTO;
import kr.or.iei.meeting.model.dto.Meeting;
import kr.or.iei.meeting.model.service.MeetingService;

@RestController
@CrossOrigin("*")
@RequestMapping("/member")
public class MeetingController {
	
     @Autowired
     private MeetingService service;
     
     // 회의록 등록
     @PostMapping
     public ResponseEntity<ResponseDTO> insertMeeting(@ModelAttribute Meeting meeting){
    	 ResponseDTO res = new ResponseDTO(HttpStatus.INTERNAL_SERVER_ERROR, "등록 중, 에러가 발생했습니다.!!", false, "error");
    	 
    	 
    	 return null;
     }
     
     // 회의록 수정
     
     // 회의 내용 요약 저장
     
     // 회의 태그 저장
     
     
}