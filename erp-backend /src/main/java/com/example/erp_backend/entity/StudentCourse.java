package com.example.erp_backend.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "student_course")
@Data
public class StudentCourse {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "student_id")   // ✔ FIXED
    private Student student;

    @ManyToOne
    @JoinColumn(name = "course_id")    // already correct
    private Course course;
}
