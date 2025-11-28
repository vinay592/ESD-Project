package com.example.erp_backend.dto;

import lombok.Data;

@Data
public class TimetableEntryDto
{
    private Integer courseId;
    private String courseName;
    private String specializationName;
    private String day;
    private String time_slot;
    private String building;
    private String roomNumber;
}
