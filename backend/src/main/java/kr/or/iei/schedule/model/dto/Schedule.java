package kr.or.iei.schedule.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Schedule {
	private String scheduleNo;
	private int memberNo = 1; // 테스트를 위해 기본값 설정. 추후 삭제 필요
	private int contractNo;
	private String statusCode;
	private String scheduleTitle;
	private String regDate;
	private String scheduleContent;
	private String scheduleProgress;
	private String scheduleColor;
}
