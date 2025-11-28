package com.example.erp_backend.controller;

import com.example.erp_backend.dto.StudentDto;
import com.example.erp_backend.dto.TimetableEntryDto;
import com.example.erp_backend.service.FacultyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/faculty")
@CrossOrigin("*")
public class FacultyController
{
    @Autowired
    private FacultyService facultyService;

    @GetMapping("/timetable")
    public List<TimetableEntryDto> getTimetable(Authentication authentication)
    {
        String email = authentication.getName();
        return facultyService.getTimetableDto(email);
    }

    @GetMapping("/course/{courseId}/students")
    public List<StudentDto> getStudents(@PathVariable Integer courseId)
    {
        return facultyService.getStudentsByCourseDto(courseId);
    }
}
