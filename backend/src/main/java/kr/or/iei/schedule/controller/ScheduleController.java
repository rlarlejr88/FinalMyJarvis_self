package kr.or.iei.schedule.controller;

import java.util.List;
import java.util.Map;

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
    public Map<String, Object> insertSchedule(@RequestBody Schedule schedule) {
        schedule.setMemberNo(1); // 추후 로그인 연동 시 제거
        int result = service.insertSchedule(schedule);

        return Map.of("scheduleNo", result);
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