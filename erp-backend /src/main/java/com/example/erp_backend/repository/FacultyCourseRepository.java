package com.example.erp_backend.repository;

import com.example.erp_backend.entity.Employee;
import com.example.erp_backend.entity.FacultyCourse;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface FacultyCourseRepository extends JpaRepository<FacultyCourse, Integer>
{
    List<FacultyCourse> findByFaculty(Employee faculty);
}
