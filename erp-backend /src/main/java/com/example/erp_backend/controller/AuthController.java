package com.example.erp_backend.controller;

import com.example.erp_backend.dto.LoginRequest;
import com.example.erp_backend.dto.LoginResponse;
import com.example.erp_backend.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.example.erp_backend.dto.GoogleAuthRequest;
@RestController
@RequestMapping("/auth")
@CrossOrigin("*")
public class AuthController {

    @Autowired
    private AuthService authService;

    @PostMapping("/login")
    public LoginResponse login(@RequestBody LoginRequest request) {
        return authService.login(request);
    }

    @PostMapping("/google")
    public LoginResponse googleLogin(@RequestBody GoogleAuthRequest request) {
        return authService.googleLogin(request.getToken());
    }

}
