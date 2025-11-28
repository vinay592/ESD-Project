package com.example.erp_backend.service;

import com.example.erp_backend.dto.StudentDto;
import com.example.erp_backend.dto.TimetableEntryDto;
import com.example.erp_backend.entity.*;
import com.example.erp_backend.repository.*;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class FacultyService
{
    private final EmployeeRepository employeeRepository;
    private final FacultyCourseRepository facultyCourseRepository;
    private final CourseScheduleRepository courseScheduleRepository;
    private final CourseRepository courseRepository;
    private final StudentCourseRepository studentCourseRepository;
    private final SpecialisationCourseRepository specialisationCourseRepository;



    public FacultyService(EmployeeRepository employeeRepository,
                          FacultyCourseRepository facultyCourseRepository,
                          CourseScheduleRepository courseScheduleRepository,
                          CourseRepository courseRepository,
                          StudentCourseRepository studentCourseRepository,
                          SpecialisationCourseRepository specialisationCourseRepository)
    {

        this.employeeRepository = employeeRepository;
        this.facultyCourseRepository = facultyCourseRepository;
        this.courseScheduleRepository = courseScheduleRepository;
        this.courseRepository = courseRepository;
        this.studentCourseRepository = studentCourseRepository;
        this.specialisationCourseRepository = specialisationCourseRepository;
    }

    public List<TimetableEntryDto> getTimetableDto(String email)
    {
        List<CourseSchedule> schedules = getTimetable(email);
        return schedules.stream().map(schedule ->
        {
            TimetableEntryDto dto = new TimetableEntryDto();
            dto.setCourseId(schedule.getCourse().getCourse_id());
            dto.setCourseName(schedule.getCourse().getName());
            dto.setDay(schedule.getDay());


            dto.setTime_slot(schedule.getTime_slot()); // or schedule.getTimeSlot()

            dto.setBuilding(schedule.getBuilding());
            dto.setRoomNumber(schedule.getRoom_number());

            List<SpecialisationCourse> sc = specialisationCourseRepository.findAll().stream()
                    .filter(x -> x.getCourse().getCourse_id().equals(schedule.getCourse().getCourse_id()))
                    .toList();
            if (!sc.isEmpty())
                dto.setSpecializationName(sc.get(0).getSpecialisation().getName());
            else
                dto.setSpecializationName("");

            return dto;
        }).toList();
    }


    public List<StudentDto> getStudentsByCourseDto(Integer courseId)
    {
        Course course = courseRepository.findById(courseId)
                .orElseThrow(() -> new RuntimeException("Course not found"));

        List<StudentCourse> studentCourses = studentCourseRepository.findByCourse(course);
        return studentCourses.stream().map(sc ->
                new StudentDto(
                        sc.getStudent().getStudent_id(),
                        sc.getStudent().getFirst_name(),
                        sc.getStudent().getLast_name(),
                        sc.getStudent().getRoll_number(),
                        sc.getStudent().getEmail()
                )
        ).toList();
    }

    public List<Course> getAssignedCourses(String email)
    {
        Employee faculty = employeeRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Faculty not found"));
        List<FacultyCourse> facultyCourses = facultyCourseRepository.findByFaculty(faculty);
        return facultyCourses.stream().map(FacultyCourse::getCourse).collect(Collectors.toList());
    }

    public List<CourseSchedule> getTimetable(String email)
    {
        Employee faculty = employeeRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Faculty not found"));
        List<FacultyCourse> facultyCourses = facultyCourseRepository.findByFaculty(faculty);
        List<Course> courses = facultyCourses.stream().map(FacultyCourse::getCourse).collect(Collectors.toList());
        return courseScheduleRepository.findByCourseIn(courses);
    }
}
