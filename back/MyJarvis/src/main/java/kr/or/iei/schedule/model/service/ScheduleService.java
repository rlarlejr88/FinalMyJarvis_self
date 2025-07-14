package kr.or.iei.schedule.model.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.or.iei.schedule.model.dao.ScheduleDao;
import kr.or.iei.schedule.model.dto.Schedule;

@Service
public class ScheduleService {
    @Autowired
    private ScheduleDao dao;

    public int insertSchedule(Schedule schedule) {
        return dao.insertSchedule(schedule);
    }

    public List<Schedule> selectScheduleList(String memberNo) {
        return dao.selectScheduleList(memberNo);
    }

    public int updateSchedule(Schedule schedule) {
        return dao.updateSchedule(schedule);
    }

    public int deleteSchedule(String scheduleNo) {
        return dao.deleteSchedule(scheduleNo);
    }
}