package kr.or.iei.common.gpt;

import org.springframework.http.*;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;
import java.util.*;

@Component
public class GptClient {

	// 추후 URL 변경으로 영어가 아닌 한글 요약을 요청할 수 있도록 변경 예정
	private static final String HUGGINGFACE_URL =
		    "https://api-inference.huggingface.co/models/psyche/KoT5-summarization";
	private static final String HUGGINGFACE_TOKEN = "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";

	public GptResponseDto requestSummary(String content) {
		RestTemplate restTemplate = new RestTemplate();

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.setAccept(Collections.singletonList(MediaType.APPLICATION_JSON));
		headers.set("Authorization", "Bearer " + HUGGINGFACE_TOKEN);

		Map<String, Object> body = new HashMap<>();
		body.put("inputs", content);

		HttpEntity<Map<String, Object>> entity = new HttpEntity<>(body, headers);

		try {

			ResponseEntity<List> response = restTemplate.postForEntity(HUGGINGFACE_URL, entity, List.class);
			if (response.getStatusCode() == HttpStatus.OK && response.getBody() != null) {
				Object summaryText = ((Map) response.getBody().get(0)).get("summary_text");
				return new GptResponseDto(summaryText != null ? summaryText.toString() : "요약 실패(응답 이상)");
			}

			return new GptResponseDto("요약 실패(HuggingFace 응답 오류)");
		} catch (Exception e) {
			e.printStackTrace();
			return new GptResponseDto("요약 실패(HuggingFace 서버/네트워크 오류)");
		}
	}

}
