package com.example.erp_backend.service;

import com.example.erp_backend.dto.LoginRequest;
import com.example.erp_backend.dto.LoginResponse;
import com.example.erp_backend.entity.Employee;
import com.example.erp_backend.repository.EmployeeRepository;
import com.example.erp_backend.security.GoogleValidator;
import com.example.erp_backend.security.JwtService;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.http.HttpStatus;

import java.util.Set;

@Service
public class AuthService {

    private final EmployeeRepository employeeRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final GoogleValidator googleValidator;

    // ALLOWED GOOGLE EMAILS (example)
    private final Set<String> allowedEmails = Set.of(
            "vinayvb592@gmail.com"
    );

    public AuthService(EmployeeRepository employeeRepository,
                       PasswordEncoder passwordEncoder,
                       JwtService jwtService,
                       GoogleValidator googleValidator) {
        this.employeeRepository = employeeRepository;
        this.passwordEncoder = passwordEncoder;
        this.jwtService = jwtService;
        this.googleValidator = googleValidator;
    }

    public LoginResponse login(LoginRequest request) {
        Employee employee = employeeRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Invalid email"));

        if (!passwordEncoder.matches(request.getPassword(), employee.getPassword())) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "Wrong password");
        }

        // generate raw token (no "Bearer " prefix)
        String rawToken = jwtService.generateToken(employee.getEmail());

        // save raw token to DB as activeToken -> enforces single session
        employee.setActiveToken(rawToken);
        employeeRepository.save(employee);

        LoginResponse response = new LoginResponse();
        response.setFacultyName(employee.getFirst_name() + " " + employee.getLast_name());
        response.setToken("Bearer " + rawToken); // send with Bearer for frontend
        return response;
    }

    public LoginResponse googleLogin(String googleToken) {
        GoogleIdToken.Payload payload = googleValidator.verifyToken(googleToken);

        String email = payload.getEmail();
        String firstName = (String) payload.get("given_name");
        String lastName = (String) payload.get("family_name");

        if (!allowedEmails.contains(email)) {
            throw new ResponseStatusException(HttpStatus.FORBIDDEN, "Unauthorized Google Account");
        }

        Employee employee = employeeRepository.findByEmail(email)
                .orElseGet(() -> {
                    Employee e = new Employee();
                    e.setEmail(email);
                    e.setFirst_name(firstName);
                    e.setLast_name(lastName);
                    e.setPassword("");
                    return employeeRepository.save(e);
                });

        String rawToken = jwtService.generateToken(email);

        // save raw token
        employee.setActiveToken(rawToken);
        employeeRepository.save(employee);

        LoginResponse response = new LoginResponse();
        response.setFacultyName(employee.getFirst_name() + " " + employee.getLast_name());
        response.setToken("Bearer " + rawToken);
        return response;
    }
}
