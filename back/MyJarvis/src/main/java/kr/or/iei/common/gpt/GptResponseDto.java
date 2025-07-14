package kr.or.iei.common.gpt;

import kr.or.iei.meeting.model.dto.Meeting;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data

public class GptResponseDto {
    private String summary;

<<<<<<< HEAD

    public GptResponseDto(String summary) {
        this.summary = summary;
    }
    public String getSummary() {
        return summary;
    }
    public void setSummary(String summary) {
        this.summary = summary;
    }
