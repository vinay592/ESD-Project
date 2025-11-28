ALTER TABLE faculty_course
    ADD FOREIGN KEY (faculty) REFERENCES employee(employee_id),
    ADD FOREIGN KEY (course_id) REFERENCES course(course_id);

ALTER TABLE course_schedule
    ADD FOREIGN KEY (course_id) REFERENCES course(course_id);

ALTER TABLE student_course
    ADD FOREIGN KEY (student_id) REFERENCES student(student_id),
    ADD FOREIGN KEY (course_id) REFERENCES course(course_id);

ALTER TABLE course_schedule
ADD CONSTRAINT unique_time UNIQUE (day, time_slot);


INSERT INTO student_course (student_id, course_id)
SELECT student_id, 
       CASE 
           WHEN student_id % 2 = 1 THEN 1
           ELSE 4
       END AS course_id
FROM student;

INSERT INTO student_course (student_id, course_id)
SELECT student_id, 
       CASE 
           WHEN student_id % 2 = 1 THEN 2
           ELSE 5
       END AS course_id
FROM student;

INSERT INTO student_course (student_id, course_id)
SELECT student_id, 
       CASE 
           WHEN student_id % 2 = 1 THEN 3
           ELSE 6
       END AS course_id
FROM student;
