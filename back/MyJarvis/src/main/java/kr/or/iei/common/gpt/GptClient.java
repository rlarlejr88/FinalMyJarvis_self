package kr.or.iei.common.gpt;

import org.springframework.stereotype.Component;

@Component
public class GptClient {
    public GptResponseDto requestSummary(String prompt) {
        // TODO: Replace with actual API call logic
        String dummySummary = "지피티 테스트 테스트.";
        return new GptResponseDto(dummySummary);
    }
}