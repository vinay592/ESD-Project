package com.example.erp_backend.repository;

import com.example.erp_backend.entity.Course;
import com.example.erp_backend.entity.StudentCourse;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface StudentCourseRepository extends JpaRepository<StudentCourse, Integer> {

    List<StudentCourse> findByCourse(Course course);
}
