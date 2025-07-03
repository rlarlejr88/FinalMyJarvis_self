package kr.or.iei.common.gpt;

import org.springframework.stereotype.Component;

@Component
public class GptClient {
    public GptResponseDto requestSummary(String prompt) {
        String dummySummary = "테스트 gpt 확인 테스트.";
        return new GptResponseDto(dummySummary);
    }
}
