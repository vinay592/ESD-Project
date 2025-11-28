package com.example.erp_backend.entity;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "student")
public class Student {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer student_id;

    private String first_name;
    private String last_name;
    private String roll_number;
    private String email;
}
