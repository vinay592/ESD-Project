package com.example.erp_backend.repository;

import com.example.erp_backend.entity.Course;
import com.example.erp_backend.entity.CourseSchedule;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CourseScheduleRepository extends JpaRepository<CourseSchedule, Integer> {

    List<CourseSchedule> findByCourseIn(Iterable<Course> courses);
}
