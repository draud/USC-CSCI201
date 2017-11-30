-- 
-- Disable foreign keys
-- 
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-- 
-- Set SQL mode
-- 
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 
-- Set character set the client will use to send SQL statements to the server
--
SET NAMES 'utf8';

-- 
-- Set default database
--
USE site201;

--
-- Definition for table schedules
--
DROP TABLE IF EXISTS schedules;
CREATE TABLE schedules (
  id INT(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 2
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table schools
--
DROP TABLE IF EXISTS schools;
CREATE TABLE schools (
  id INT(11) NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  image VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (id)
)
ENGINE = INNODB
AUTO_INCREMENT = 2
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table departments
--
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
  id INT(11) NOT NULL AUTO_INCREMENT,
  long_name VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  prefix VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  school_id INT(11) DEFAULT NULL,
  PRIMARY KEY (id),
  INDEX IX_Schools_id (school_id),
  CONSTRAINT `FK_dbo.Departments_dbo.Schools_Schools_id` FOREIGN KEY (school_id)
    REFERENCES schools(id) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 2
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table textbooks
--
DROP TABLE IF EXISTS textbooks;
CREATE TABLE textbooks (
  id INT(11) NOT NULL AUTO_INCREMENT,
  number VARCHAR(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  author VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  title VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  publisher VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  year VARCHAR(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  isbn VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  schedule_id INT(11) DEFAULT NULL,
  PRIMARY KEY (id),
  INDEX IX_Schedule_ID (schedule_id),
  CONSTRAINT `FK_dbo.Textbooks_dbo.Schedules_Schedule_ID` FOREIGN KEY (schedule_id)
    REFERENCES schedules(ID) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 2
AVG_ROW_LENGTH = 16384
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table weeks
--
DROP TABLE IF EXISTS weeks;
CREATE TABLE weeks (
  id INT(11) NOT NULL AUTO_INCREMENT,
  schedule_id INT(11) NOT NULL,
  week INT(11) DEFAULT NULL,
  PRIMARY KEY (id),
  INDEX IX_scheduleID (schedule_id),
  CONSTRAINT `FK_dbo.Weeks_dbo.Schedules_scheduleID` FOREIGN KEY (schedule_id)
    REFERENCES schedules(ID) ON DELETE CASCADE ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 7
AVG_ROW_LENGTH = 2730
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table courses
--
DROP TABLE IF EXISTS courses;
CREATE TABLE courses (
  id INT(11) NOT NULL AUTO_INCREMENT,
  number VARCHAR(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  title VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  units VARCHAR(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  term VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  year VARCHAR(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  syllabus_url VARBINARY(255) DEFAULT NULL,
  schedule_id INT(11) DEFAULT NULL,
  department_id INT(11) DEFAULT NULL,
  PRIMARY KEY (id),
  INDEX IX_Departments_id (department_id),
  INDEX IX_schedule_ID (schedule_id),
  CONSTRAINT `FK_dbo.Courses_dbo.Departments_Departments_id` FOREIGN KEY (department_id)
    REFERENCES departments(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_dbo.Courses_dbo.Schedules_schedule_ID` FOREIGN KEY (schedule_id)
    REFERENCES schedules(ID) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 2
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table labs
--
DROP TABLE IF EXISTS labs;
CREATE TABLE labs (
  id INT(11) NOT NULL AUTO_INCREMENT,
  number VARCHAR(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  title VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  url VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  week_id INT(11) DEFAULT NULL,
  PRIMARY KEY (id),
  INDEX IX_Weeks_id (week_id),
  CONSTRAINT `FK_dbo.Labs_dbo.Weeks_Weeks_id` FOREIGN KEY (week_id)
    REFERENCES weeks(id) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 8
AVG_ROW_LENGTH = 2340
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table lectures
--
DROP TABLE IF EXISTS lectures;
CREATE TABLE lectures (
  id INT(11) NOT NULL AUTO_INCREMENT,
  number VARCHAR(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  date VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  day VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  week_id INT(11) DEFAULT NULL,
  PRIMARY KEY (id),
  INDEX IX_Weeks_id (week_id),
  CONSTRAINT `FK_dbo.Lectures_dbo.Weeks_Weeks_id` FOREIGN KEY (week_id)
    REFERENCES weeks(id) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 13
AVG_ROW_LENGTH = 1365
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table assignments
--
DROP TABLE IF EXISTS assignments;
CREATE TABLE assignments (
  id INT(11) NOT NULL AUTO_INCREMENT,
  number VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  assigned_date VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  due_date VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  title VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  url VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  grade_percentage VARCHAR(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  course_id INT(11) DEFAULT NULL,
  PRIMARY KEY (id),
  INDEX IX_Courses_id (course_id),
  CONSTRAINT `FK_dbo.Assignments_dbo.Courses_Courses_id` FOREIGN KEY (course_id)
    REFERENCES courses(id) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 7
AVG_ROW_LENGTH = 2730
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table exams
--
DROP TABLE IF EXISTS exams;
CREATE TABLE exams (
  id INT(11) NOT NULL AUTO_INCREMENT,
  semester VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  year VARBINARY(5) DEFAULT NULL,
  course_id INT(11) DEFAULT NULL,
  PRIMARY KEY (id),
  INDEX IX_Courses_id (course_id),
  CONSTRAINT `FK_dbo.Exams_dbo.Courses_Courses_id` FOREIGN KEY (course_id)
    REFERENCES courses(id) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 4
AVG_ROW_LENGTH = 5461
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table meetings
--
DROP TABLE IF EXISTS meetings;
CREATE TABLE meetings (
  id INT(11) NOT NULL AUTO_INCREMENT,
  type VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  section VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  course_id INT(11) DEFAULT NULL,
  PRIMARY KEY (id),
  INDEX IX_Courses_id (course_id),
  CONSTRAINT `FK_dbo.Meetings_dbo.Courses_Courses_id` FOREIGN KEY (course_id)
    REFERENCES courses(id) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 9
AVG_ROW_LENGTH = 2340
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table staff_members
--
DROP TABLE IF EXISTS staff_members;
CREATE TABLE staff_members (
  id INT(11) NOT NULL AUTO_INCREMENT,
  type VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  first_name VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  last_name VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  email VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  image VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  phone VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  office VARCHAR(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  course_id INT(11) DEFAULT NULL,
  PRIMARY KEY (id),
  INDEX IX_Courses_id (course_id),
  CONSTRAINT `FK_dbo.StaffMembers_dbo.Courses_Courses_id` FOREIGN KEY (course_id)
    REFERENCES courses(id) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 12
AVG_ROW_LENGTH = 4096
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table topics
--
DROP TABLE IF EXISTS topics;
CREATE TABLE topics (
  id INT(11) NOT NULL AUTO_INCREMENT,
  number VARCHAR(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  title VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  url VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  chapter VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  lecture_id INT(11) DEFAULT NULL,
  PRIMARY KEY (id),
  INDEX IX_Lectures_id (lecture_id),
  CONSTRAINT `FK_dbo.Topics_dbo.Lectures_Lectures_id` FOREIGN KEY (lecture_id)
    REFERENCES lectures(id) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 32
AVG_ROW_LENGTH = 528
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table assignment_files
--
DROP TABLE IF EXISTS assignment_files;
CREATE TABLE assignment_files (
  id INT(11) NOT NULL AUTO_INCREMENT,
  number INT(11) DEFAULT NULL,
  title VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  url VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  assignment_id INT(11) DEFAULT NULL,
  PRIMARY KEY (id),
  INDEX IX_Assignments_id (assignment_id),
  CONSTRAINT `FK_dbo.AssignmentFiles_dbo.Assignments_Assignments_id` FOREIGN KEY (assignment_id)
    REFERENCES assignments(id) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 4
AVG_ROW_LENGTH = 5461
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table assistants
--
DROP TABLE IF EXISTS assistants;
CREATE TABLE assistants (
  id INT(11) NOT NULL AUTO_INCREMENT,
  staff_member_id INT(11) DEFAULT NULL,
  meeting_id INT(11) DEFAULT NULL,
  PRIMARY KEY (id),
  CONSTRAINT FK_Assistants_Meetings_id FOREIGN KEY (meeting_id)
    REFERENCES meetings(id) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 16
AVG_ROW_LENGTH = 1092
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table deliverables
--
DROP TABLE IF EXISTS deliverables;
CREATE TABLE deliverables (
  id INT(11) NOT NULL AUTO_INCREMENT,
  number VARCHAR(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  due_date VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  title VARBINARY(100) DEFAULT NULL,
  grade_percentage VARBINARY(255) DEFAULT NULL,
  assignment_id INT(11) DEFAULT NULL,
  PRIMARY KEY (id),
  INDEX IX_Assignments_id (assignment_id),
  CONSTRAINT `FK_dbo.Deliverables_dbo.Assignments_Assignments_id` FOREIGN KEY (assignment_id)
    REFERENCES assignments(id) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 9
AVG_ROW_LENGTH = 2048
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table grading_criteria_files
--
DROP TABLE IF EXISTS grading_criteria_files;
CREATE TABLE grading_criteria_files (
  id INT(11) NOT NULL AUTO_INCREMENT,
  number VARCHAR(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  title VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  url VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  assignment_id INT(11) DEFAULT NULL,
  PRIMARY KEY (id),
  INDEX IX_Assignments_id (assignment_id),
  CONSTRAINT `FK_dbo.GradingCriteriaFiles_dbo.Assignments_Assignments_id` FOREIGN KEY (assignment_id)
    REFERENCES assignments(id) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 7
AVG_ROW_LENGTH = 2730
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table meeting_periods
--
DROP TABLE IF EXISTS meeting_periods;
CREATE TABLE meeting_periods (
  id INT(11) NOT NULL AUTO_INCREMENT,
  day VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  time_start VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  time_end VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  meeting_id INT(11) DEFAULT NULL,
  PRIMARY KEY (id),
  INDEX IX_Meetings_id (meeting_id),
  CONSTRAINT `FK_dbo.MeetingPeriods_dbo.Meetings_Meetings_id` FOREIGN KEY (meeting_id)
    REFERENCES meetings(id) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 12
AVG_ROW_LENGTH = 1489
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table office_hours
--
DROP TABLE IF EXISTS office_hours;
CREATE TABLE office_hours (
  id INT(11) NOT NULL AUTO_INCREMENT,
  day VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  time_start VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  time_end VARCHAR(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  staff_member_id INT(11) DEFAULT NULL,
  PRIMARY KEY (id),
  INDEX IX_StaffMembers_id (staff_member_id),
  CONSTRAINT `FK_dbo.OfficeHours_dbo.StaffMembers_StaffMembers_id` FOREIGN KEY (staff_member_id)
    REFERENCES staff_members(id) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 33
AVG_ROW_LENGTH = 512
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table programs
--
DROP TABLE IF EXISTS programs;
CREATE TABLE programs (
  id INT(11) NOT NULL AUTO_INCREMENT,
  topic_id INT(11) DEFAULT NULL,
  PRIMARY KEY (id),
  INDEX IX_Topics_id (topic_id),
  CONSTRAINT `FK_dbo.Programs_dbo.Topics_Topics_id` FOREIGN KEY (topic_id)
    REFERENCES topics(id) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 12
AVG_ROW_LENGTH = 1489
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table solution_files
--
DROP TABLE IF EXISTS solution_files;
CREATE TABLE solution_files (
  id INT(11) NOT NULL AUTO_INCREMENT,
  number VARCHAR(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  title VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  url VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  assignment_id INT(11) DEFAULT NULL,
  PRIMARY KEY (id),
  INDEX IX_Assignments_id (assignment_id),
  CONSTRAINT `FK_dbo.SolutionFiles_dbo.Assignments_Assignments_id` FOREIGN KEY (assignment_id)
    REFERENCES assignments(id) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 2
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table tests
--
DROP TABLE IF EXISTS tests;
CREATE TABLE tests (
  id INT(11) NOT NULL AUTO_INCREMENT,
  title VARCHAR(100) DEFAULT NULL,
  url VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  exam_id INT(11) DEFAULT NULL,
  PRIMARY KEY (id),
  INDEX IX_Exams_id (exam_id),
  CONSTRAINT `FK_dbo.Tests_dbo.Exams_Exams_id` FOREIGN KEY (exam_id)
    REFERENCES exams(id) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 13
AVG_ROW_LENGTH = 1365
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table program_files
--
DROP TABLE IF EXISTS program_files;
CREATE TABLE program_files (
  id INT(11) NOT NULL AUTO_INCREMENT,
  number VARCHAR(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  title VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  url VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  program_id INT(11) DEFAULT NULL,
  PRIMARY KEY (id),
  INDEX IX_Programs_ID (program_id),
  CONSTRAINT `FK_dbo.ProgramFiles_dbo.Programs_Programs_ID` FOREIGN KEY (program_id)
    REFERENCES programs(ID) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 23
AVG_ROW_LENGTH = 744
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

--
-- Definition for table test_files
--
DROP TABLE IF EXISTS test_files;
CREATE TABLE test_files (
  id INT(11) NOT NULL AUTO_INCREMENT,
  number VARCHAR(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  title VARCHAR(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  url VARCHAR(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  test_id INT(11) DEFAULT NULL,
  PRIMARY KEY (id),
  INDEX IX_Tests_id (test_id),
  CONSTRAINT `FK_dbo.TestFiles_dbo.Tests_Tests_id` FOREIGN KEY (test_id)
    REFERENCES tests(id) ON DELETE NO ACTION ON UPDATE NO ACTION
)
ENGINE = INNODB
AUTO_INCREMENT = 20
AVG_ROW_LENGTH = 862
CHARACTER SET latin1
COLLATE latin1_swedish_ci;

-- 
-- Dumping data for table schedules
--
INSERT INTO schedules VALUES
(1);

-- 
-- Dumping data for table schools
--
INSERT INTO schools VALUES
(1, 'USC', 'http://www-scf.usc.edu/~csci201/images/USC_seal.gif');

-- 
-- Dumping data for table departments
--
INSERT INTO departments VALUES
(1, 'Computer Science', 'CSCI', 1);

-- 
-- Dumping data for table textbooks
--
INSERT INTO textbooks VALUES
(1, '1', 'Y. Daniel Liang', 'Introduction to Java Programming, Comprehensive Version, 10th Edition', 'Prentice Hall, Inc.', '2014', '978-0133761313', 1);

-- 
-- Dumping data for table weeks
--
INSERT INTO weeks VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 1, 6);

-- 
-- Dumping data for table courses
--
INSERT INTO courses VALUES
(1, '201L', 'Principles of Software Development', '4', 'Fall', '2017', 'http://www-scf.usc.edu/~csci201/syllabus.pdf', 1, 1);

-- 
-- Dumping data for table labs
--
INSERT INTO labs VALUES
(1, '1', 'Github Tutorial', 'http://www-scf.usc.edu/~csci201/labs/Lab0.pdf', 1),
(2, '2', 'Environment Setup', 'http://www-scf.usc.edu/~csci201/labs/Lab1.pdf', 1),
(3, '1', 'File I/O', 'http://www-scf.usc.edu/~csci201/labs/Lab2.pdf', 2),
(4, '1', 'HTML/CSS', 'http://www-scf.usc.edu/~csci201/lectures/Lecture4/Generics.pdf', 3),
(5, '1', 'Inheritance', 'http://www-scf.usc.edu/~csci201/labs/Lab3.pdf', 4),
(6, '1', 'JavaScript and AJAX', 'http://www-scf.usc.edu/~csci201/labs/Lab6.pdf', 5),
(7, '1', 'JDBC', 'http://www-scf.usc.edu/~csci201/labs/Lab12.pdf', 6);

-- 
-- Dumping data for table lectures
--
INSERT INTO lectures VALUES
(1, '1', '8-24-2017', 'Tuesday', 1),
(2, '2', '8-28-2017', 'Thursday', 1),
(3, '1', '8-29-2017', 'Tuesday', 2),
(4, '2', '8-31-2017', 'Thursday', 2),
(5, '1', '9-12-2017', 'Tuesday', 3),
(6, '2', '9-14-2017', 'Thursday', 3),
(7, '1', '9-19-2017', 'Tuesday', 4),
(8, '2', '9-21-2017', 'Thursday', 4),
(9, '1', '10-3-2017', 'Tuesday', 5),
(10, '2', '10-5-2017', 'Thursday', 5),
(11, '1', '10-24-2017', 'Tuesday', 6),
(12, '2', '10-26-2017', 'Thursday', 6);

-- 
-- Dumping data for table assignments
--
INSERT INTO assignments VALUES
(1, '1', '8-15-2017', '8-24-2017', 'PDF', 'http://www-scf.usc.edu/~csci201/assignments/Assignment1-1.pdf', '3.5%', 1),
(2, '2', '8-17-2017', '8-28-2017', 'PDF', 'http://www-scf.usc.edu/~csci201/assignments/Assignment2.pdf', '3.5%', 1),
(3, '3', '8-20-2017', '8-29-2017', NULL, NULL, '4.5%', 1),
(4, '4', '8-27-2017', '8-31-2017', NULL, NULL, '3.5%', 1),
(5, '5', '9-7-2017', '9-12-2017', NULL, NULL, '5.0%', 1),
(6, 'Final Project', '9-24-2017', NULL, 'Final Project Description', 'http://www-scf.usc.edu/~csci201/assignments/FinalProject.pdf', NULL, 1);

-- 
-- Dumping data for table exams
--
INSERT INTO exams VALUES
(1, 'Spring', x'2014', 1),
(2, 'Spring', x'2010', 1),
(3, 'Summer', x'2011', 1);

-- 
-- Dumping data for table meetings
--
INSERT INTO meetings VALUES
(1, 'lecture', '30303R', 1),
(2, 'lecture', '29909R', 1),
(3, 'lecture', '30389R', 1),
(4, 'lab', '30237R', 1),
(5, 'lab', '30385R', 1),
(6, 'lab', '29904R', 1),
(7, 'lab', '30238R', 1),
(8, 'quiz', '30028R', 1);

-- 
-- Dumping data for table staff_members
--
INSERT INTO staff_members VALUES
(1, 'instructor', NULL, NULL, 'jeffrey.miller@usc.edu', 'http://www-scf.usc.edu/~csci201/images/jeffrey_miller.jpg', '213-740-7129', 'SAL 342', 1),
(2, 'ta', NULL, NULL, 'arikgha@usc.edu', 'http://www-scf.usc.edu/~csci201/images/USC_seal.gif', NULL, NULL, 1),
(3, 'cp', NULL, NULL, 'ninareh@usc.edu', 'http://www-scf.usc.edu/~csci201/images/ninareh_mehrabi.jpg', NULL, NULL, 1),
(4, 'cp', NULL, NULL, 'chaimelo@usc.edu', 'http://www-scf.usc.edu/~csci201/images/melody_chai.jpg', NULL, NULL, 1),
(5, 'grader', NULL, NULL, 'libowsky@usc.edu', 'http://www-scf.usc.edu/~csci201/images/ruth_libowsky.jpg', NULL, NULL, 1),
(6, 'cp', NULL, NULL, 'elautz@usc.edu', 'http://www-scf.usc.edu/~csci201/images/emma_lautz.jpg', NULL, NULL, 1),
(7, 'cp', NULL, NULL, 'jiwerner@usc.edu', 'http://www-scf.usc.edu/~csci201/images/jesse_werner.jpg', NULL, NULL, 1),
(8, 'cp', NULL, NULL, 'helenarh@usc.edu', 'http://www-scf.usc.edu/~csci201/images/helena_rhee.jpg', NULL, NULL, 1),
(9, 'cp', NULL, NULL, 'joglekar@usc.edu', 'http://www-scf.usc.edu/~csci201/images/uddhav_joglekar.jpg', NULL, NULL, 1),
(10, 'cp', NULL, NULL, 'elautz@usc.edu', 'http://www-scf.usc.edu/~csci201/images/emma_lautz.jpg', NULL, NULL, 1),
(11, 'cp', NULL, NULL, 'jansonla@usc.edu', 'http://www-scf.usc.edu/~csci201/images/janson_lau.jpg', NULL, NULL, 1);

-- 
-- Dumping data for table topics
--
INSERT INTO topics VALUES
(1, '1', 'Introduction', 'http://www-scf.usc.edu/~csci201/lectures/Lecture1/Introduction.pdf', NULL, 1),
(2, '2', 'Environment', 'http://www-scf.usc.edu/~csci201/lectures/Lecture1/Environment.pdf', NULL, 1),
(3, '3', 'Reading Parameters', 'http://www-scf.usc.edu/~csci201/lectures/Lecture1/ReadingParameters.pdf', '2', 1),
(4, '4', 'Conditions', 'http://www-scf.usc.edu/~csci201/lectures/Lecture1/Conditions.pdf', '3', 1),
(5, '5', 'Loops', 'http://www-scf.usc.edu/~csci201/lectures/Lecture1/Loops.pdf', '4', 1),
(6, '6', 'Methods', 'http://www-scf.usc.edu/~csci201/lectures/Lecture1/Methods.pdf', '5', 1),
(7, '7', 'Arrays', 'http://www-scf.usc.edu/~csci201/lectures/Lecture1/Arrays.pdf', '6-7', 1),
(8, '8', 'Strings', 'http://www-scf.usc.edu/~csci201/lectures/Lecture1/Strings.pdf', '9', 1),
(9, '1', 'Classes', 'http://www-scf.usc.edu/~csci201/lectures/Lecture2/Classes.pdf', '8,10', 2),
(10, '2', 'Packages', 'http://www-scf.usc.edu/~csci201/lectures/Lecture2/Packages.pdf', '8', 2),
(11, '3', 'File I/O', 'http://www-scf.usc.edu/~csci201/lectures/Lecture4/FileIO.pdf', '9', 2),
(12, '1', 'Abstract Classes and Interfaces', 'http://www-scf.usc.edu/~csci201/lectures/Lecture2/AbstractClassesInterfaces.pdf', '11', 3),
(13, '2', 'Polymorphism', 'http://www-scf.usc.edu/~csci201/lectures/Lecture2/Polymorphism.pdf', '11', 3),
(14, '1', 'Garbage Collection', 'http://www-scf.usc.edu/~csci201/lectures/Lecture3/GarbageCollection.pdf', '6,8', 4),
(15, '2', 'Exception Handling', 'http://www-scf.usc.edu/~csci201/lectures/Lecture3/ExceptionHandling.pdf', '13', 4),
(16, '3', 'Serialization', 'http://www-scf.usc.edu/~csci201/lectures/Lecture4/Serialization.pdf', '19', 4),
(17, '4', 'Generics', 'http://www-scf.usc.edu/~csci201/lectures/Lecture4/Generics.pdf', '21', 4),
(18, '1', 'JavaScript', 'http://www-scf.usc.edu/~csci201/lectures/Lecture7/JavaScript.pdf', '1', 5),
(19, '1', 'AJAX', 'http://www-scf.usc.edu/~csci201/lectures/Lecture7/AJAX.pdf', '3', 6),
(20, '1', 'HTML', 'http://www-scf.usc.edu/~csci201/lectures/Lecture5/HTML.pdf', NULL, 7),
(21, '2', 'CSS', 'http://www-scf.usc.edu/~csci201/lectures/Lecture5/CSS.pdf', '2', 7),
(22, '1', 'Java Servlets', 'http://www-scf.usc.edu/~csci201/lectures/Lecture6/Servlets.pdf', NULL, 8),
(23, '2', 'JSP', 'http://www-scf.usc.edu/~csci201/lectures/Lecture6/JSP.pdf', '8', 8),
(24, '1', 'Software Engineering', 'http://www-scf.usc.edu/~csci201/lectures/Lecture11/SoftwareEngineering.pdf', NULL, 9),
(25, '2', 'Methodologies', 'http://www-scf.usc.edu/~csci201/lectures/Lecture11/Methodologies.pdf', NULL, 9),
(26, '3', 'Testing', 'http://www-scf.usc.edu/~csci201/lectures/Lecture11/Testing.pdf', '7', 9),
(27, '1', 'Project Discussion', 'http://www-scf.usc.edu/~csci201/assignments/FinalProject.pdf', NULL, 10),
(28, '2', 'Review for Exam', 'http://www-scf.usc.edu/~csci201/lectures/Lecture6/JSP.pdf', '4', 10),
(29, '1', 'SQL', 'http://www-scf.usc.edu/~csci201/lectures/Lecture16/SQL.pdf', '2', 11),
(30, '1', 'JDBC', 'http://www-scf.usc.edu/~csci201/lectures/Lecture16/JDBC.pdf', NULL, 12),
(31, '2', 'JDBC Tutorial', 'http://www-scf.usc.edu/~csci201/lectures/Lecture16/JDBCTutorial.pdf', '5', 12);

-- 
-- Dumping data for table assignment_files
--
INSERT INTO assignment_files VALUES
(1, 1, 'Sample JSON', 'http://www-scf.usc.edu/~csci201/assignments/Assignment1-1.json', 1),
(2, 1, 'Sample JSON', 'http://www-scf.usc.edu/~csci201/assignments/Assignment2.json', 2),
(3, 1, 'Final Project Ideas from Previous CPs', 'http://www-scf.usc.edu/~csci201/assignments/FinalProjectIdeas.pdf', 6);

-- 
-- Dumping data for table assistants
--
INSERT INTO assistants VALUES
(1, 8, 1),
(2, 7, 2),
(3, 3, 3),
(4, 6, 4),
(5, 4, 4),
(6, 2, 4),
(7, 7, 5),
(8, 2, 5),
(9, 3, 5),
(10, 4, 6),
(11, 7, 6),
(12, 6, 6),
(13, 3, 7),
(14, 8, 7),
(15, 2, 7);

-- 
-- Dumping data for table deliverables
--
INSERT INTO deliverables VALUES
(1, '1', '9-19-2017', 'Twice/Week Meeting with Assigned CP', '4.0% (0.5%/week)', 6),
(2, '2', '9-12-2017', 'Team Members, Meeting Times, Project Proposal', '1.0%', 6),
(3, '3', '9-21-2017', 'High-Level Requirements', '2.0%', 6),
(4, '4', '10-3-2017', 'Technical Specifications', '2.0%', 6),
(5, '5', '10-5-2017', 'Peer Review #1', '1.0%', 6),
(6, '6', '10-24-2017', 'Detailed Design', '3.0%', 6),
(7, '7', '10-26-2017', 'Testing Document', '2.0%', 6),
(8, '8', '11-30-2017', 'Demonstration', '10.0%', 6);

-- 
-- Dumping data for table grading_criteria_files
--
INSERT INTO grading_criteria_files VALUES
(1, '1', 'PDF', 'http://www-scf.usc.edu/~csci201/assignments/assignment1gradingcriteria/Assignment1GradingCriteria-1.pdf', 1),
(2, '2', 'valid.json', 'http://www-scf.usc.edu/~csci201/assignments/assignment1gradingcriteria/valid.json', 1),
(3, '3', 'InvalidMissingTag.json', 'http://www-scf.usc.edu/~csci201/assignments/assignment1gradingcriteria/InvalidMissingTag.json', 1),
(4, '4', 'InvalidMissingClosingTag.json', 'http://www-scf.usc.edu/~csci201/assignments/assignment1gradingcriteria/InvalidMissingClosingTag.json', 1),
(5, '5', 'InvalidExtraDepartmentNoCourses.json', 'http://www-scf.usc.edu/~csci201/assignments/assignment1gradingcriteria/InvalidExtraDepartmentNoCourses.json', 1),
(6, '6', 'NoLastNamesError.json', 'http://www-scf.usc.edu/~csci201/assignments/assignment1gradingcriteria/NoLastNamesError.json', 1);

-- 
-- Dumping data for table meeting_periods
--
INSERT INTO meeting_periods VALUES
(1, 'Tuesday', NULL, NULL, 1),
(2, 'Thursday', NULL, NULL, 1),
(3, 'Tuesday', NULL, NULL, 2),
(4, 'Thursday', NULL, NULL, 2),
(5, 'Tuesday', NULL, NULL, 3),
(6, 'Thursday', NULL, NULL, 3),
(7, 'Tuesday', NULL, NULL, 4),
(8, 'Wednesday', NULL, NULL, 5),
(9, 'Wednesday', NULL, NULL, 6),
(10, 'Wednesday', NULL, NULL, 7),
(11, 'Thursday', NULL, NULL, 8);

-- 
-- Dumping data for table office_hours
--
INSERT INTO office_hours VALUES
(1, 'Tuesday', NULL, NULL, 1),
(2, 'Thursday', NULL, NULL, 1),
(3, 'Monday', NULL, NULL, 2),
(4, 'Tuesday', NULL, NULL, 2),
(5, 'Friday', NULL, NULL, 2),
(6, 'Monday', NULL, NULL, 2),
(7, 'Monday', NULL, NULL, 3),
(8, 'Monday', NULL, NULL, 3),
(9, 'Monday', NULL, NULL, 3),
(10, 'Thursday', NULL, NULL, 4),
(11, 'Friday', NULL, NULL, 4),
(12, 'Friday', NULL, NULL, 4),
(13, 'Thursday', NULL, NULL, 4),
(14, 'Tuesday', NULL, NULL, 4),
(15, 'Saturday', NULL, NULL, 4),
(16, 'Thursday', NULL, NULL, 4),
(17, 'Thursday', NULL, NULL, 6),
(18, 'Thursday', NULL, NULL, 6),
(19, 'Friday', NULL, NULL, 6),
(20, 'Wednesday', NULL, NULL, 6),
(21, 'Wednesday', NULL, NULL, 6),
(22, 'Friday', NULL, NULL, 6),
(23, 'Tuesday', NULL, NULL, 7),
(24, 'Wednesday', NULL, NULL, 7),
(25, 'Saturday', NULL, NULL, 7),
(26, 'Saturday', NULL, NULL, 7),
(27, 'Tuesday', NULL, NULL, 8),
(28, 'Wednesday', NULL, NULL, 8),
(29, 'Tuesday', NULL, NULL, 9),
(30, 'Saturday', NULL, NULL, 9),
(31, 'Wednesday', NULL, NULL, 10),
(32, 'Saturday', NULL, NULL, 11);

-- 
-- Dumping data for table programs
--
INSERT INTO programs VALUES
(1, 4),
(2, 5),
(3, 6),
(4, 7),
(5, 9),
(6, 11),
(7, 12),
(8, 15),
(9, 17),
(10, 19),
(11, 22);

-- 
-- Dumping data for table solution_files
--
INSERT INTO solution_files VALUES
(1, '1', 'Zip', 'http://www-scf.usc.edu/~csci201/assignments/Assignment1Solution.zip', 1);

-- 
-- Dumping data for table tests
--
INSERT INTO tests VALUES
(1, 'Written Exam #1', NULL, 1),
(2, 'Programming Exam #1', NULL, 1),
(3, 'Written Exam #2', NULL, 1),
(4, 'Programming Exam #2', NULL, 1),
(5, 'Written Exam #1', NULL, 2),
(6, 'Programming Exam #1', NULL, 2),
(7, 'Written Exam #2', NULL, 2),
(8, 'Programming Exam #2', NULL, 2),
(9, 'Written Exam #1', NULL, 3),
(10, 'Programming Exam #1', NULL, 3),
(11, 'Written Exam #2', NULL, 3),
(12, 'Programming Exam #2', NULL, 3);

-- 
-- Dumping data for table program_files
--
INSERT INTO program_files VALUES
(1, '1', 'Operation.java', 'http://www-scf.usc.edu/~csci201/Lecture1/Operation.java', 1),
(2, '1', 'Dice.java', 'http://www-scf.usc.edu/~csci201/Lecture1/Dice.java', 2),
(3, '1', 'Fibonacci.java', 'http://www-scf.usc.edu/~csci201/Lecture1/Fibonacci.java', 3),
(4, '1', 'Dice.java', 'http://www-scf.usc.edu/~csci201/Lecture1/Dice.java', 4),
(5, '1', 'Salary.java', 'http://www-scf.usc.edu/~csci201/Lecture2/Salary.java', 5),
(6, '1', 'FileCopy.java', 'http://www-scf.usc.edu/~csci201/lectures/Lecture4/FileCopy.java', 6),
(7, '2', 'FileCopier.java', 'http://www-scf.usc.edu/~csci201/lectures/Lecture4/FileCopier.java', 6),
(8, '1', 'TestShape.java', 'http://www-scf.usc.edu/~csci201/Lecture2/TestShape.java', 7),
(9, '2', 'Shape.java', 'http://www-scf.usc.edu/~csci201/Lecture2/Shape.java', 7),
(10, '3', 'Rectangle.java', 'http://www-scf.usc.edu/~csci201/Lecture2/Rectangle.java', 7),
(11, '4', 'Square.java', 'http://www-scf.usc.edu/~csci201/Lecture2/Square.java', 7),
(12, '5', 'Triangle.java', 'http://www-scf.usc.edu/~csci201/Lecture2/Triangle.java', 7),
(13, '1', 'NumberExceptions.java', 'http://www-scf.usc.edu/~csci201/lectures/Lecture3/NumberExceptions.java', 8),
(14, '2', 'NumberGreaterException.java', 'http://www-scf.usc.edu/~csci201/letures/Lecture3/NumberGreaterException.java', 8),
(15, '1', 'Employee.java', 'http://www-scf.usc.edu/~csci201/lectures/Lecture4/Employee.java', 9),
(16, '2', 'EmployeeMain.java', 'http://www-scf.usc.edu/~csci201/letures/Lecture4/EmployeeMain.java', 9),
(17, '3', 'GenericArray.java', 'http://www-scf.usc.edu/~csci201/letures/Lecture4/GenericArray.java', 9),
(18, '1', 'ajaxform.html', 'http://www-scf.usc.edu/~csci201/lectures/Lecture7/ajaxform.html', 10),
(19, '2', 'validate.jsp', 'http://www-scf.usc.edu/~csci201/lectures/Lecture7/validate.jsp', 10),
(20, '1', 'schoolform.html', 'http://www-scf.usc.edu/~csci201/lectures/Lecture6/schoolform.html', 11),
(21, '2', 'SchoolFormServlet.java', 'http://www-scf.usc.edu/~csci201/lectures/Lecture6/SchoolFormServlet.java', 11),
(22, '3', 'SchoolForm.jsp', 'http://www-scf.usc.edu/~csci201/lectures/Lecture6/SchoolForm.jsp', 11);

-- 
-- Dumping data for table test_files
--
INSERT INTO test_files VALUES
(1, '1', 'PDF 2014', 'http://www-scf.usc.edu/~csci201/exams/midterm-written-spring2014.pdf', 1),
(2, '1', 'Section 1 PDF 2014', 'http://www-scf.usc.edu/~csci201/exams/midterm-programming-section1-spring2014.pdf', 2),
(3, '2', 'Section 2 PDF 2014', 'http://www-scf.usc.edu/~csci201/exams/midterm-programming-section2-spring2014.pdf', 2),
(4, '1', 'PDF 2014', 'http://www-scf.usc.edu/~csci201/exams/final-written-spring2014.pdf', 3),
(5, '1', 'Section 1 PDF 2014', 'http://www-scf.usc.edu/~csci201/exams/final-programming-section1-spring2014.pdf', 4),
(6, '2', 'Section 2 PDF 2014', 'http://www-scf.usc.edu/~csci201/exams/final-programming-section2-spring2014.pdf', 4),
(7, '3', 'zip file', 'http://www-scf.usc.edu/~csci201/exams/finalexam_spring2014.zip', 4),
(8, '1', 'PDF 2010', 'http://www-scf.usc.edu/~csci201/exams/midterm-written-spring2014.pdf', 5),
(9, '1', 'Section 1 PDF 2010', 'http://www-scf.usc.edu/~csci201/exams/midterm-programming-section1-spring2014.pdf', 6),
(10, '2', 'Section 2 PDF 2010', 'http://www-scf.usc.edu/~csci201/exams/midterm-programming-section2-spring2014.pdf', 6),
(11, '1', 'PDF 2010', 'http://www-scf.usc.edu/~csci201/exams/final-written-spring2014.pdf', 7),
(12, '1', 'Section 1 PDF 2010', 'http://www-scf.usc.edu/~csci201/exams/final-programming-section1-spring2014.pdf', 8),
(13, '2', 'Section 2 PDF 2010', 'http://www-scf.usc.edu/~csci201/exams/final-programming-section2-spring2014.pdf', 8),
(14, '3', 'zip file', 'http://www-scf.usc.edu/~csci201/exams/finalexam_spring2014.zip', 8),
(15, '1', 'PDF 2011', 'http://www-scf.usc.edu/~csci201/exams/midterm-written-summer2014.pdf', 9),
(16, '1', 'PDF 2011', 'http://www-scf.usc.edu/~csci201/exams/midterm-programming-summer2014.pdf', 10),
(17, '1', 'PDF 2011', 'http://www-scf.usc.edu/~csci201/exams/final-written-summer2014.pdf', 11),
(18, '1', 'PDF 2011', 'http://www-scf.usc.edu/~csci201/exams/final-programming-summer2014.pdf', 12),
(19, '3', 'zip file', 'http://www-scf.usc.edu/~csci201/exams/finalexam_summer2014.zip', 12);

-- 
-- Restore previous SQL mode
-- 
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

-- 
-- Enable foreign keys
-- 
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;