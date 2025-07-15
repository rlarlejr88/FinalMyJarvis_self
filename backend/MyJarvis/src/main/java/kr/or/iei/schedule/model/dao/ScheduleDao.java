package kr.or.iei.schedule.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.or.iei.schedule.model.dto.Schedule;

@Mapper
public interface ScheduleDao {
    int insertSchedule(Schedule schedule);
    List<Schedule> selectScheduleList(String memberNo);
    int updateSchedule(Schedule schedule);
    int deleteSchedule(String scheduleNo);
}