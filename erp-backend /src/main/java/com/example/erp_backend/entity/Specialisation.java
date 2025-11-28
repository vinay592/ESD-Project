package com.example.erp_backend.entity;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "specialisation")
public class Specialisation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer specialisation_id;

    private String name;
}
