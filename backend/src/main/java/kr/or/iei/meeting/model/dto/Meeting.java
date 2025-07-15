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
	private String meetTitle;
	private String meetContent;
	private String meetDate;
	private String gptSummary;

	
	//  디버깅 확인용 코드. 확인 후 삭제
	@Override
	public String toString() {
		return "Meeting{" + "meetingNo='" + meetingNo + '\'' + ", memberNo='" + memberNo + '\'' + ", meetTitle='"
				+ meetTitle + '\'' + ", meetContent='" + meetContent + '\'' + ", meetDate='" + meetDate + '\''
				+ ", gptSummary='" + gptSummary + '\'' + '}';
	}
}
