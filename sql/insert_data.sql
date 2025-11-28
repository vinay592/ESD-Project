-- ============================================
-- INSERT DATA FOR ACADEMIC ERP PROJECT
-- ============================================

-- ===========================
-- 1. EMPLOYEES (FACULTY)
-- Password hash = bcrypt("pass")
-- ===========================

INSERT INTO employee (first_name, last_name, email, password) VALUES
('John', 'Doe', 'john@uni.edu', '$2a$10$jdbgfTCBHuu2B8V4.Hc8/Oexo9yEY0N6hJJ6XAAAXo8A9R9Aic4Ki'),
('Meera', 'Sharma', 'meera@uni.edu', '$2a$10$jdbgfTCBHuu2B8V4.Hc8/Oexo9yEY0N6hJJ6XAAAXo8A9R9Aic4Ki'),
('Jimmy', 'Carter', 'jimmy@uni.edu', '$2a$10$jdbgfTCBHuu2B8V4.Hc8/Oexo9yEY0N6hJJ6XAAAXo8A9R9Aic4Ki'),
('Vinay', 'Bhandare', 'vinayvb592@gmail.com', '$2a$10$jdbgfTCBHuu2B8V4.Hc8/Oexo9yEY0N6hJJ6XAAAXo8A9R9Aic4Ki');


-- ===========================
-- 2. COURSES
-- ===========================

INSERT INTO course (course_code, name, credits) VALUES
('CS101','Data Structures',4),
('CS201','Database Systems',4),
('CS301','Machine Learning',4),
('CS401','Operating Systems',4),
('CS501','Computer Networks',4),
('CS601','Artificial Intelligence',4),
('CS701','Cloud Computing',4),
('CS801','Cyber Security',4);


-- ===========================
-- 3. SPECIALISATIONS
-- ===========================

INSERT INTO specialisation (name) VALUES
('Software Engineering'),
('Data Science');


-- ===========================
-- 4. SPECIALISATION → COURSE MAPPING
-- ===========================

INSERT INTO specialisation_course (specialisation_id, course_id) VALUES
(1, 1), (1, 4),     -- Software Engineering → DS + OS
(2, 3), (2, 6);     -- Data Science → ML + AI


-- ===========================
-- 5. FACULTY → COURSE MAPPING
-- ===========================
-- 4 teachers → each teaches 2 subjects

INSERT INTO faculty_course (faculty, course_id) VALUES
(1,1),(1,2),     -- John: DS, DB
(2,3),(2,4),     -- Meera: ML, OS
(3,5),(3,6),     -- Jimmy: CN, AI
(4,7),(4,8);     -- Vinay: Cloud, Cyber


-- ===========================
-- 6. WEEKLY TIMETABLE (REAL, SCATTERED)
-- ===========================

DELETE FROM course_schedule;

INSERT INTO course_schedule (course_id, day, time_slot, building, room_number) VALUES

-- MONDAY
(1,'Monday','9-10 AM','Block A','101'),
(3,'Monday','10-11 AM','Block A','102'),
(5,'Monday','11-12 PM','Block B','201'),
(7,'Monday','1-2 PM','Block C','301'),
(2,'Monday','2-3 PM','Block A','103'),
(4,'Monday','3-4 PM','Block B','202'),

-- TUESDAY
(2,'Tuesday','9-10 AM','Block A','101'),
(4,'Tuesday','10-11 AM','Block A','102'),
(6,'Tuesday','11-12 PM','Block B','201'),
(8,'Tuesday','1-2 PM','Block D','401'),
(1,'Tuesday','2-3 PM','Block C','301'),
(3,'Tuesday','3-4 PM','Block B','202'),

-- WEDNESDAY
(5,'Wednesday','9-10 AM','Block C','303'),
(7,'Wednesday','10-11 AM','Block D','402'),
(1,'Wednesday','11-12 PM','Block A','101'),
(3,'Wednesday','1-2 PM','Block A','102'),
(4,'Wednesday','2-3 PM','Block B','202'),
(2,'Wednesday','3-4 PM','Block C','301'),

-- THURSDAY
(3,'Thursday','9-10 AM','Block A','101'),
(1,'Thursday','10-11 AM','Block A','102'),
(8,'Thursday','11-12 PM','Block D','401'),
(6,'Thursday','1-2 PM','Block C','302'),
(7,'Thursday','2-3 PM','Block D','402'),
(5,'Thursday','3-4 PM','Block B','201'),

-- FRIDAY
(6,'Friday','9-10 AM','Block B','201'),
(2,'Friday','10-11 AM','Block A','103'),
(4,'Friday','11-12 PM','Block B','202'),
(7,'Friday','1-2 PM','Block D','401'),
(8,'Friday','2-3 PM','Block D','402'),
(3,'Friday','3-4 PM','Block A','101');


-- ===========================
-- 7. STUDENTS (100 STUDENTS)
-- ===========================

INSERT INTO student (roll_number, first_name, last_name, email) VALUES
-- 16 original students
('21CS01','Alice','Rao','alice@stud.edu'),
('21CS02','Bob','Patel','bob@stud.edu'),
('21CS03','Cara','Nair','cara@stud.edu'),
('21CS04','Dev','Deshpande','dev@stud.edu'),
('21CS05','Sara','Khan','sara@stud.edu'),
('21CS06','Yash','Shah','yash@stud.edu'),
('21CS07','Tara','Gowda','tara@stud.edu'),
('21CS08','Kabir','Mehta','kabir@stud.edu'),
('21CS09','Pooja','Naik','pooja@stud.edu'),
('21CS10','Mihir','Bose','mihir@stud.edu'),
('21CS11','Neha','Sharma','neha@stud.edu'),
('21CS12','Rishi','Pandey','rishi@stud.edu'),
('21CS13','Nikita','Reddy','nikita@stud.edu'),
('21CS14','Rohan','Kulkarni','rohan@stud.edu'),
('21CS15','Megha','Shetty','megha@stud.edu'),
('21CS16','Karthik','Patel','karthik@stud.edu'),

-- 84 NEW auto-generated
('21CS17','Aarav','Shetty','aarav17@stud.edu'),
('21CS18','Isha','Rao','isha18@stud.edu'),
('21CS19','Rehan','Ali','rehan19@stud.edu'),
('21CS20','Maya','Kulkarni','maya20@stud.edu'),
('21CS21','Advait','Sharma','advait21@stud.edu'),
('21CS22','Vani','Reddy','vani22@stud.edu'),
('21CS23','Vivaan','Mehta','vivaan23@stud.edu'),
('21CS24','Diya','Joshi','diya24@stud.edu'),
('21CS25','Arjun','Rao','arjun25@stud.edu'),
('21CS26','Prisha','Gupta','prisha26@stud.edu'),
('21CS27','Kabir','Naik','kabir27@stud.edu'),
('21CS28','Aanya','Shah','aanya28@stud.edu'),
('21CS29','Anvi','Patel','anvi29@stud.edu'),
('21CS30','Krish','Menon','krish30@stud.edu'),
('21CS31','Saanvi','Iyer','saanvi31@stud.edu'),
('21CS32','Aditi','Bhat','aditi32@stud.edu'),
('21CS33','Aryan','Shetty','aryan33@stud.edu'),
('21CS34','Tanvi','Kale','tanvi34@stud.edu'),
('21CS35','Om','Kulkarni','om35@stud.edu'),
('21CS36','Zoya','Pathan','zoya36@stud.edu'),
('21CS37','Ritvik','Desai','ritvik37@stud.edu'),
('21CS38','Nisha','Kamath','nisha38@stud.edu'),
('21CS39','Jay','Pai','jay39@stud.edu'),
('21CS40','Sneha','Rao','sneha40@stud.edu'),
('21CS41','Ravi','Shinde','ravi41@stud.edu'),
('21CS42','Sam','Fernandes','sam42@stud.edu'),
('21CS43','Ira','Shetty','ira43@stud.edu'),
('21CS44','Ved','Pai','ved44@stud.edu'),
('21CS45','Anya','Deshpande','anya45@stud.edu'),
('21CS46','Rohan','Mali','rohan46@stud.edu'),
('21CS47','Neel','Shah','neel47@stud.edu'),
('21CS48','Sia','Kulkarni','sia48@stud.edu'),
('21CS49','Reva','Kamath','reva49@stud.edu'),
('21CS50','Dev','Kale','dev50@stud.edu'),

-- Continue similarly up to 100...
('21CS51','Ayra','Patil','ayra51@stud.edu'),
('21CS52','Aarush','More','aarush52@stud.edu'),
('21CS53','Ishan','Gupta','ishan53@stud.edu'),
('21CS54','Atharv','Shetty','atharv54@stud.edu'),
('21CS55','Nikita','Bhat','nikita55@stud.edu'),
('21CS56','Nirav','Aggarwal','nirav56@stud.edu'),
('21CS57','Keya','Dave','keya57@stud.edu'),
('21CS58','Omkar','Shetty','omkar58@stud.edu'),
('21CS59','Navya','Joshi','navya59@stud.edu'),
('21CS60','Hriday','Rao','hriday60@stud.edu'),
('21CS61','Nidhi','Sharma','nidhi61@stud.edu'),
('21CS62','Parth','Patel','parth62@stud.edu'),
('21CS63','Yuvraj','Singh','yuvraj63@stud.edu'),
('21CS64','Minal','Thakur','minal64@stud.edu'),
('21CS65','Aayush','Desai','aayush65@stud.edu'),
('21CS66','Mahika','Naik','mahika66@stud.edu'),
('21CS67','Harsh','Gupta','harsh67@stud.edu'),
('21CS68','Ayesha','Pathan','ayesha68@stud.edu'),
('21CS69','Samar','Shetty','samar69@stud.edu'),
('21CS70','Naina','Rao','naina70@stud.edu'),
('21CS71','Devansh','Patel','devansh71@stud.edu'),
('21CS72','Sitara','Shetty','sitara72@stud.edu'),
('21CS73','Ansh','Menon','ansh73@stud.edu'),
('21CS74','Tia','Kulkarni','tia74@stud.edu'),
('21CS75','Sahil','Kadam','sahil75@stud.edu'),
('21CS76','Divya','Shah','divya76@stud.edu'),
('21CS77','Rhea','Mehta','rhea77@stud.edu'),
('21CS78','Aarav','Nair','aarav78@stud.edu'),
('21CS79','Kavya','Shetty','kavya79@stud.edu'),
('21CS80','Ishant','Bose','ishant80@stud.edu'),
('21CS81','Sanaya','Khan','sanaya81@stud.edu'),
('21CS82','Shiv','Reddy','shiv82@stud.edu'),
('21CS83','Kruti','Patel','kruti83@stud.edu'),
('21CS84','Aditya','Pai','aditya84@stud.edu'),
('21CS85','Jiya','Kamath','jiya85@stud.edu'),
('21CS86','Arnav','Shetty','arnav86@stud.edu'),
('21CS87','Kabir','Shah','kabir87@stud.edu'),
('21CS88','Ananya','Rao','ananya88@stud.edu'),
('21CS89','Samarth','Patil','samarth89@stud.edu'),
('21CS90','Rehan','Deshmukh','rehan90@stud.edu'),
('21CS91','Trisha','Gowda','trisha91@stud.edu'),
('21CS92','Athira','Menon','athira92@stud.edu'),
('21CS93','Rahil','Shetty','rahil93@stud.edu'),
('21CS94','Hridaan','Rao','hridaan94@stud.edu'),
('21CS95','Sara','Mehta','sara95@stud.edu'),
('21CS96','Pranav','Patel','pranav96@stud.edu'),
('21CS97','Diya','Mali','diya97@stud.edu'),
('21CS98','Zain','Pathan','zain98@stud.edu'),
('21CS99','Aadhya','Naik','aadhya99@stud.edu'),
('21CS100','Ranveer','Shetty','ranveer100@stud.edu');


-- ===========================
-- 8. STUDENT → COURSE (3 COURSES EACH)
-- Using specialisation preference
-- ===========================

INSERT INTO student_course (student_id, course_id) VALUES
-- Software Engineering (odd IDs)
(1,1),(1,4),(1,2),
(3,1),(3,4),(3,2),
(5,1),(5,4),(5,2),
(7,1),(7,4),(7,2),
(9,1),(9,4),(9,2),

-- Data Science (even IDs)
(2,3),(2,6),(2,1),
(4,3),(4,6),(4,2),
(6,3),(6,6),(6,1),
(8,3),(8,6),(8,2),
(10,3),(10,6),(10,1),

-- Continue similarly:
(11,1),(11,4),(11,2),
(12,3),(12,6),(12,1),
(13,1),(13,4),(13,2),
(14,3),(14,6),(14,1),
(15,1),(15,4),(15,2),
(16,3),(16,6),(16,1);

-- For students 17–100:
-- Odd → SE (C1, C4, C2)
-- Even → DS (C3, C6, C1)

INSERT INTO student_course (student_id, course_id)
SELECT student_id,
       CASE WHEN student_id % 2 = 1 THEN 1 ELSE 3 END
FROM student WHERE student_id >= 17;

INSERT INTO student_course (student_id, course_id)
SELECT student_id,
       CASE WHEN student_id % 2 = 1 THEN 4 ELSE 6 END
FROM student WHERE student_id >= 17;

INSERT INTO student_course (student_id, course_id)
SELECT student_id,
       CASE WHEN student_id % 2 = 1 THEN 2 ELSE 1 END
FROM student WHERE student_id >= 17;


