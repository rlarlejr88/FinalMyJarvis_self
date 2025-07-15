package kr.or.iei.schedule.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import kr.or.iei.schedule.model.dto.Schedule;
import kr.or.iei.schedule.model.service.ScheduleService;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/schedule")
public class ScheduleController {
    @Autowired
    private ScheduleService service;

    @PostMapping
    public int insertSchedule(@RequestBody Schedule schedule) {
    	
        schedule.setMemberNo(1); // 테스트를 위해 기본값 설정. 추후 삭제 필요
        
        return service.insertSchedule(schedule);
    }

    @GetMapping("/{memberNo}")
    public List<Schedule> selectScheduleList(@PathVariable String memberNo) {
        return service.selectScheduleList(memberNo);
    }

    @PutMapping
    public int updateSchedule(@RequestBody Schedule schedule) {
        return service.updateSchedule(schedule);
    }

    @DeleteMapping("/{scheduleNo}")
    public int deleteSchedule(@PathVariable String scheduleNo) {
        return service.deleteSchedule(scheduleNo);
    }
}