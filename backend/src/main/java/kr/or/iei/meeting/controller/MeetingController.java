package kr.or.iei.meeting.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletRequest;
import kr.or.iei.common.model.dto.ResponseDTO;
import kr.or.iei.meeting.model.dto.Meeting;
import kr.or.iei.meeting.model.service.MeetingService;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/meetings")
public class MeetingController {
	@Autowired
	private MeetingService service;

	// 회의록 등록
//	@PostMapping
//	public ResponseEntity<ResponseDTO> insertMeeting(@ModelAttribute Meeting meeting,
//			@RequestParam(value = "file", required = false) MultipartFile file, HttpServletRequest req) {
//
//		String memberNo = (String) req.getAttribute("memberNo");
//
//		// 디버깅용: 받은 meeting 객체를 콘솔에 출력 // 확인 후, 삭제 코드
//		System.out.println("🔥 memberNo: " + memberNo);
//		System.out.println("🔥 meeting: " + meeting);
//
//		meeting.setMemberNo(memberNo); // memberNo 설정
//
//		try {
//			int result = service.insertMeeting(meeting);
//			return ResponseEntity.ok(new ResponseDTO(HttpStatus.OK, "회의록 등록 완료", true, null));
//		} catch (Exception e) {
//			e.printStackTrace(); // 💥 여기가 실제 콘솔에 진짜 예외 로그 남김
//			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
//					.body(new ResponseDTO(HttpStatus.INTERNAL_SERVER_ERROR, "서버 예외 발생", false, null));
//		}
//	}
	
	
	// 회의록 등록 디버깅용 코드 //  확인 후 수정 및 삭제
	@PostMapping
	public ResponseEntity<ResponseDTO> insertMeeting(
	        @ModelAttribute Meeting meeting,
	        @RequestParam(value = "file", required = false) MultipartFile file,
	        HttpServletRequest req) {

	    String memberNo = (String) req.getAttribute("memberNo");

	    System.out.println("🔥 [insertMeeting] memberNo: " + memberNo);
	    System.out.println("🔥 [insertMeeting] meeting: " + meeting);

	    meeting.setMemberNo(memberNo);

	    try {
	        int result = service.insertMeeting(meeting);
	        System.out.println("🔥 [insertMeeting] DB Insert result: " + result);

	        if (result > 0) {
	            return ResponseEntity.ok(new ResponseDTO(HttpStatus.OK, "회의록 등록 완료", true, null));
	        } else {
	            System.out.println("⚠️ [insertMeeting] DB Insert 실패: result == 0");
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	                    .body(new ResponseDTO(HttpStatus.INTERNAL_SERVER_ERROR, "등록 실패(DB 영향 없음)", false, null));
	        }

	    } catch (Exception e) {
	        System.out.println("💥 [insertMeeting] 예외 발생");
	        e.printStackTrace(); // 진짜 에러 로그 찍기
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	                .body(new ResponseDTO(HttpStatus.INTERNAL_SERVER_ERROR, "서버 예외 발생", false, null));
	    }
	}

	// 회의록 전체 조회
	@GetMapping
	public ResponseEntity<ResponseDTO> getAllMeetings() {
		List<Meeting> meetings = service.getAllMeetings();
		return ResponseEntity.ok(new ResponseDTO(HttpStatus.OK, "회의록 목록 조회", meetings, "success"));
	}

	// 회의록 수정
	@PutMapping
	public ResponseEntity<ResponseDTO> updateMeeting(@RequestBody Meeting meeting) {

		// 디버깅용: 받은 meeting 객체를 콘솔에 출력 // 확인 후, 삭제 코드
		System.out.println(">> 받은 meeting = " + meeting); // 값 찍어보기!

		int result = service.updateMeeting(meeting);
		if (result > 0) {
			return ResponseEntity.ok(new ResponseDTO(HttpStatus.OK, "회의록 수정 완료", true, null));
		} else {
			return ResponseEntity.ok(new ResponseDTO(HttpStatus.INTERNAL_SERVER_ERROR, "수정 실패", false, null));
		}
	}

	// 회의록 삭제
	@DeleteMapping("/{meetingNo}")
	public ResponseEntity<ResponseDTO> deleteMeeting(@PathVariable String meetingNo) {
		int result = service.deleteMeeting(meetingNo);
		if (result > 0) {
			return ResponseEntity.ok(new ResponseDTO(HttpStatus.OK, "회의록 삭제 완료", true, null));
		} else {
			return ResponseEntity.ok(new ResponseDTO(HttpStatus.INTERNAL_SERVER_ERROR, "삭제 실패", false, null));
		}
	}

//	// 회의록 요약
//	@PostMapping("/summary")
//	public ResponseEntity<ResponseDTO> summarizeMeeting(@RequestBody Meeting meeting) {
//		try {
//			String summary = service.summarizeMeeting(meeting.getMeetContent());
//			return ResponseEntity.ok(new ResponseDTO(HttpStatus.OK, "회의록 요약 성공", summary, "success"));
//		} catch (Exception e) {
//			return ResponseEntity.ok(new ResponseDTO(HttpStatus.INTERNAL_SERVER_ERROR, "요약 실패", null, "fail"));
//		}
//	}

	@PostMapping("/summary")
	public ResponseEntity<ResponseDTO> summarizeMeeting(@RequestBody Meeting meeting,
			@RequestHeader Map<String, Object> headers) {
		System.out.println("Incoming headers: " + headers);
		try {

			String summary = service.summarizeMeeting(meeting); // 전체 meeting 전달!
			return ResponseEntity.ok(new ResponseDTO(HttpStatus.OK, "회의록 요약 성공", summary, "success"));
		} catch (Exception e) {
			return ResponseEntity.ok(new ResponseDTO(HttpStatus.INTERNAL_SERVER_ERROR, "요약 실패", null, "fail"));
		}
	}
}