CREATE TABLE employee (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    active_token TEXT
);

CREATE TABLE course (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_code VARCHAR(20) UNIQUE NOT NULL,
    name VARCHAR(100) NOT NULL,
    credits INT
);

CREATE TABLE student (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    roll_number VARCHAR(50) UNIQUE NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE faculty_course (
    id INT PRIMARY KEY AUTO_INCREMENT,
    faculty INT,
    course_id INT
);

CREATE TABLE course_schedule (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_id INT,
    day VARCHAR(20),
    time_slot VARCHAR(20),
    building VARCHAR(50),
    room_number VARCHAR(20)
);

CREATE TABLE student_course (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT
);
CREATE TABLE specialisation (
    specialisation_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE specialisation_course (
    id INT PRIMARY KEY AUTO_INCREMENT,
    specialisation_id INT NOT NULL,
    course_id INT NOT NULL
);
