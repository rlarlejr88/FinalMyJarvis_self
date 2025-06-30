package kr.or.iei.meeting.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Meeting {
	
	private String meetingNo;
	private String memberNo;
	private String clientNo;
	private String compCd;
	private String meetTitle;
	private String meetContent;
	private String meetingDate;
	private String gptSummary;

}
