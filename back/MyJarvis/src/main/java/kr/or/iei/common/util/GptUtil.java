package kr.or.iei.common.util;

import org.springframework.http.*;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;
import java.util.*;

@Component
public class GptUtil {
    private static final String API_URL = "https://api.openai.com/v1/chat/completions";
    private static final String API_KEY = "YOUR_OPENAI_API_KEY"; // 실제 키로 교체 필요

    public String summarize(String content) {
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setBearerAuth(API_KEY);

        Map<String, Object> message = new HashMap<>();
        message.put("role", "user");
        message.put("content", "다음 회의록을 5줄 이내로 요약해줘: " + content);

        Map<String, Object> body = new HashMap<>();
        body.put("model", "gpt-3.5-turbo");
        body.put("messages", Collections.singletonList(message));
        body.put("max_tokens", 500);
        body.put("temperature", 0.7);

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(body, headers);
        ResponseEntity<Map> response = restTemplate.postForEntity(API_URL, entity, Map.class);

        if (response.getStatusCode() == HttpStatus.OK) {
            List<Map<String, Object>> choices = (List<Map<String, Object>>) response.getBody().get("choices");
            if (choices != null && !choices.isEmpty()) {
                Map<String, Object> messageObj = (Map<String, Object>) choices.get(0).get("message");
                return (String) messageObj.get("content");
            }
        }
        return "요약 실패";
    }
    
}
