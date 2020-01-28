CREATE TABLE clients
(
    id          INT          NOT NULL PRIMARY KEY AUTO_INCREMENT,
    client_name VARCHAR(100) NOT NULL,
    project_id  INT          NOT NULL
);

CREATE TABLE projects
(
    id              INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    client_id       INT NOT NULL,
    project_lead_id INT NOT NULL
);

CREATE TABLE employees
(
    id         INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(30),
    last_name  VARCHAR(30),
    project_id INT NOT NULL
);

ALTER TABLE clients
    ADD CONSTRAINT fk_clients_projects
        FOREIGN KEY clients (project_id)
            REFERENCES projects (id);

ALTER TABLE projects
    ADD CONSTRAINT fk_projects_clients
        FOREIGN KEY projects (client_id)
            REFERENCES clients (id),
    ADD CONSTRAINT fk_projects_employees
        FOREIGN KEY projects (project_lead_id)
            REFERENCES employees (id);


ALTER TABLE employees
    ADD CONSTRAINT fk_employees_projects
        FOREIGN KEY employees (project_id)
            REFERENCES projects (id);

CREATE DATABASE pass_info;
USE pass_info;

#Exercise 1 - One-To-One Relationship
CREATE TABLE persons
(
    person_id   INT         NOT NULL,
    first_name  VARCHAR(30) NOT NULL,
    salary      DECIMAL(10, 2),
    passport_id INT         NOT NULL UNIQUE
);

CREATE TABLE passports
(
    passport_id     INT        NOT NULL PRIMARY KEY AUTO_INCREMENT,
    passport_number VARCHAR(8) NOT NULL UNIQUE
);

INSERT INTO persons
VALUES (1, 'Roberto', 43300.00, 102),
       (2, 'Tom', 56100.00, 103),
       (3, 'Yana', 60200.00, 101);

INSERT INTO passports
VALUES (101, 'N34FG21B'),
       (102, 'K65LO4R7'),
       (103, 'ZE657QP2');

ALTER TABLE persons
    MODIFY person_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT;

ALTER TABLE persons
    ADD CONSTRAINT fk_persons_passports
        FOREIGN KEY persons (passport_id)
            REFERENCES passports (passport_id);


#Exercise 2 - One-To-Many Relationship
CREATE DATABASE auto_house;
USE auto_house;

CREATE TABLE manufacturers
(
    manufacturer_id INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(20) NOT NULL,
    established_on  DATE
);

CREATE TABLE models
(
    model_id        INT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name            VARCHAR(20) NOT NULL,
    manufacturer_id INT         NOT NULL,
    CONSTRAINT fk_models_manufacturers
        FOREIGN KEY models (manufacturer_id)
            REFERENCES manufacturers (manufacturer_id)
);


INSERT INTO manufacturers(name, established_on)
VALUES ('BMW', '1916-03-01'),
       ('Tesla', '2003-01-01'),
       ('Lada', '1966-05-01');

INSERT INTO models
VALUES (101, 'X1', 1),
       (102, 'i6', 1),
       (103, 'Model S', 2),
       (104, 'Model X', 2),
       (105, 'Model 3', 2),
       (106, 'Nova', 3);


#Exercise 3 - Many-To-Many Relationship
CREATE DATABASE exam_results;
USE exam_results;

CREATE TABLE students
(
    student_id INT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name       VARCHAR(50) NOT NULL
);

CREATE TABLE exams
(
    exam_id INT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name    VARCHAR(50) NOT NULL
);

CREATE TABLE students_exams
(
    student_id INT NOT NULL,
    exam_id    INT NOT NULL,
    PRIMARY KEY (student_id, exam_id),
    CONSTRAINT fk_students_exam_students
        FOREIGN KEY students_exams (student_id)
            REFERENCES students (student_id),
    CONSTRAINT fk_students_exams_exams
        FOREIGN KEY students_exams (exam_id)
            REFERENCES exams (exam_id)
);

INSERT INTO students
VALUES (1, 'Mila'),
       (2, 'Toni'),
       (3, 'Ron');

INSERT INTO exams
VALUES (101, 'Spring MVC'),
       (102, 'Neo4j'),
       (103, 'Oracle 11g');

INSERT INTO students_exams
VALUES (1, 101),
       (1, 102),
       (2, 101),
       (3, 103),
       (2, 102),
       (2, 103);


#Exercise 4 - Self-Referencing
CREATE TABLE teachers
(
    teacher_id INT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name       VARCHAR(20) NOT NULL,
    manager_id INT
);

INSERT INTO teachers
VALUES (101, 'John', NULL),
       (102, 'Maya', 106),
       (103, 'Silvia', 106),
       (104, 'Ted', 105),
       (105, 'Mark', 101),
       (106, 'Greta', 101);

ALTER TABLE teachers
    ADD CONSTRAINT fk_teachers
        FOREIGN KEY (manager_id)
            REFERENCES teachers (teacher_id);


#Exercise 5 - Online Store Database
CREATE DATABASE online_store;
USE online_store;

CREATE TABLE items
(
    item_id      INT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name         VARCHAR(50) NOT NULL,
    item_type_id INT         NOT NULL
);

CREATE TABLE item_types
(
    item_type_id INT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name         VARCHAR(50) NOT NULL
);

CREATE TABLE order_items
(
    order_id INT NOT NULL AUTO_INCREMENT,
    item_id  INT NOT NULL,
    PRIMARY KEY (order_id, item_id)
);

CREATE TABLE customers
(
    customer_id INT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name        VARCHAR(50) NOT NULL,
    birthday    DATE,
    city_id     INT         NOT NULL
);

CREATE TABLE cities
(
    city_id INT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name    VARCHAR(50) NOT NULL
);

CREATE TABLE orders
(
    order_id    INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL
);

ALTER TABLE order_items
    ADD CONSTRAINT fk_order_items_items
        FOREIGN KEY (item_id)
            REFERENCES items (item_id),
    ADD CONSTRAINT fk_order_items_orders
        FOREIGN KEY (order_id)
            REFERENCES orders (order_id);

ALTER TABLE items
    ADD CONSTRAINT fk_items_item_types
        FOREIGN KEY (item_type_id)
            REFERENCES item_types (item_type_id);

ALTER TABLE customers
    ADD CONSTRAINT fk_customers_cities
        FOREIGN KEY (city_id)
            REFERENCES cities (city_id);

ALTER TABLE orders
    ADD CONSTRAINT fk_orders_customers
        FOREIGN KEY (customer_id)
            REFERENCES customers (customer_id);


#Exercise 6 - University Database
CREATE DATABASE university;
USE university;

CREATE TABLE subjects
(
    subject_id   INT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    subject_name VARCHAR(50) NOT NULL
);

CREATE TABLE agenda
(
    student_id INT NOT NULL AUTO_INCREMENT,
    subject_id INT NOT NULL,
    PRIMARY KEY (student_id, subject_id)
);

CREATE TABLE majors
(
    major_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name     VARCHAR(50)
);

CREATE TABLE students
(
    student_id     INT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    student_number VARCHAR(12) NOT NULL UNIQUE,
    student_name   VARCHAR(50) NOT NULL,
    major_id       INT         NOT NULL
);

CREATE TABLE payments
(
    payment_id     INT           NOT NULL PRIMARY KEY AUTO_INCREMENT,
    payment_date   DATE,
    payment_amount DECIMAL(8, 2) NOT NULL,
    student_id     INT           NOT NULL
);

ALTER TABLE agenda
    ADD CONSTRAINT fk_agenda_subjects
        FOREIGN KEY (subject_id)
            REFERENCES subjects (subject_id),
    ADD CONSTRAINT fk_agenda_students
        FOREIGN KEY (student_id)
            REFERENCES students (student_id);

ALTER TABLE students
    ADD CONSTRAINT fk_students_majors
        FOREIGN KEY (major_id)
            REFERENCES majors (major_id);

ALTER TABLE payments
    ADD CONSTRAINT fk_payments_students
        FOREIGN KEY (student_id)
            REFERENCES students (student_id);


#Exercise 9 - Peaks in Rila
USE geography;

SELECT m.mountain_range, p.peak_name, p.elevation AS peak_elevation
FROM mountains AS m
JOIN peaks p on m.id = p.mountain_id
WHERE m.id = 17 AND p.mountain_id = 17
ORDER BY p.elevation DESC;