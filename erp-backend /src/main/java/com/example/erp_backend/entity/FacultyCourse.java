package com.example.erp_backend.entity;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "faculty_course")
public class FacultyCourse {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "faculty")   // column in DB = faculty
    private Employee faculty;

    @ManyToOne
    @JoinColumn(name = "course_id") // this is correct
    private Course course;
}

