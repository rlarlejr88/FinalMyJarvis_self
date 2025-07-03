package kr.or.iei.common.gpt;

public class GptResponseDto {
    private String summary;

    public GptResponseDto(String summary) {
        this.summary = summary;
    }
    public String getSummary() {
        return summary;
    }
    public void setSummary(String summary) {
        this.summary = summary;
    }
}