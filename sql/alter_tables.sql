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

DELIMITER $$

CREATE TRIGGER prevent_student_clash
BEFORE INSERT ON student_course
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM student_course sc
        JOIN course_schedule cs1 ON sc.course_id = cs1.course_id
        JOIN course_schedule cs2 ON NEW.course_id = cs2.course_id
        WHERE sc.student_id = NEW.student_id
          AND cs1.day = cs2.day
          AND cs1.time_slot = cs2.time_slot
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Time clash: student already has a class at this time!';
    END IF;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER prevent_faculty_clash
BEFORE INSERT ON faculty_course
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM faculty_course fc
        JOIN course_schedule cs1 ON fc.course_id = cs1.course_id
        JOIN course_schedule cs2 ON NEW.course_id = cs2.course_id
        WHERE fc.faculty = NEW.faculty
          AND cs1.day = cs2.day
          AND cs1.time_slot = cs2.time_slot
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Time clash: faculty already teaching a course at this time!';
    END IF;
END$$

DELIMITER ;


DELIMITER $$

CREATE TRIGGER prevent_room_clash
BEFORE INSERT ON course_schedule
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM course_schedule cs
        WHERE cs.day = NEW.day
          AND cs.time_slot = NEW.time_slot
          AND cs.building = NEW.building
          AND cs.room_number = NEW.room_number
    ) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Time clash: Another class is already in this room at this time!';
    END IF;
END$$

DELIMITER ;

