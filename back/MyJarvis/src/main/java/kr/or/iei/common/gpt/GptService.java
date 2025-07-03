package kr.or.iei.common.gpt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class GptService {
    @Autowired
    private GptClient gptClient;

    public String summarize(String content) {
        String prompt = "다음 회의록을 5줄 이내로 요약해줘: " + content;
        GptResponseDto response = gptClient.requestSummary(prompt);
        return response != null ? response.getSummary() : "요약 실패";
    }
}