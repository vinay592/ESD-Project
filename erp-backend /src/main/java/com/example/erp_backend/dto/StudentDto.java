package com.example.erp_backend.dto;

public class StudentDto
{
    private Integer studentId;
    private String firstName;
    private String lastName;
    private String rollNumber;
    private String email;

    public StudentDto(Integer studentId, String firstName, String lastName, String rollNumber, String email)
    {
        this.studentId = studentId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.rollNumber = rollNumber;
        this.email = email;
    }

    public Integer getStudentId()
    {
        return studentId;
    }

    public String getFirstName()
    {
        return firstName;
    }

    public String getLastName()
    {
        return lastName;
    }

    public String getRollNumber()
    {
        return rollNumber;
    }

    public String getEmail()
    {
        return email;
    }
}
