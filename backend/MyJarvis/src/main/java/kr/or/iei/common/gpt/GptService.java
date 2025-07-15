package kr.or.iei.common.gpt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class GptService {
    @Autowired
    private GptClient gptClient;

    public String summarize(String content) {
    	
        String prompt = content; // HuggingFace 프롬프트 없이 텍스트만 전달
        GptResponseDto response = gptClient.requestSummary(prompt);
        return response != null ? response.getSummary() : "요약 실패";
    }
}
