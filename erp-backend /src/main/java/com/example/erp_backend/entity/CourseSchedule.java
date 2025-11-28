package com.example.erp_backend.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "course_schedule")
@Data
public class CourseSchedule {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "course_id")
    private Course course;

    private String day;
    private String building;
    private String room_number;

    @Column(name = "time_slot")
    private String time_slot;
}
