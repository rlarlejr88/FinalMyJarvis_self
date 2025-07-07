package kr.or.iei.meeting.model.service;

import java.util.Collections;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

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

	// 코드 확인을 위해 주석 처리
//    public String summarizeMeeting(String content) {
//        return gptService.summarize(content);
//    }

	// 코드 확인 후 주석 해제 및 삭제.
	private static final String HUGGINGFACE_URL = "https://api-inference.huggingface.co/models/psyche/KoT5-summarization";
	private static final String API_KEY = "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";

	public String summarizeMeeting(Meeting meeting) {
		RestTemplate restTemplate = new RestTemplate();

		// Meeting 클래스의 실제 텍스트 필드명 맞춰주세요!
		// 예시: meeting.getMeetingContent()
		String body = "{\"inputs\": \"" + meeting.getMeetContent() + "\"}";

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.setBearerAuth(API_KEY);
		headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));

		HttpEntity<String> entity = new HttpEntity<>(body, headers);

		String result = null;
		try {
			ResponseEntity<String> response = restTemplate.postForEntity(HUGGINGFACE_URL, entity, String.class);
			result = response.getBody();
			System.out.println("요약 결과: " + result); // 자바에서는 이게 콘솔에 찍힘
		} catch (Exception e) {
			System.out.println("요약 API 호출 실패: " + e.getMessage());
		}
		return result;
	}

}