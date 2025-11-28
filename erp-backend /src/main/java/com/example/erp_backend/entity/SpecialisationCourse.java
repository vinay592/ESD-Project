package com.example.erp_backend.entity;

import jakarta.persistence.*;
import lombok.Data;
@Entity
@Table(name = "specialisation_course")   // match MySQL table name exactly
@Data
public class SpecialisationCourse {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;   // real DB column name

    @ManyToOne
    @JoinColumn(name = "specialisation_id")   // exact column name from DB
    private Specialisation specialisation;

    @ManyToOne
    @JoinColumn(name = "course_id")   // existing column matches
    private Course course;
}

