package com.example.erp_backend.dto;

import lombok.Data;

@Data
public class LoginResponse {
    private String token;
    private String facultyName;
}
