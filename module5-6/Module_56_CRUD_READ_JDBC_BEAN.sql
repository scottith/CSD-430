-- Author: Scott Macioce
-- Course: CSD430 – Server-Side Development
-- Modules 5–6: Initial DB + table setup
-- Purpose: Create CSD430 DB, user, and scott_movies_data table with sample data

-- 1) Create database
DROP DATABASE IF EXISTS CSD430;
CREATE DATABASE CSD430
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_0900_ai_ci;

USE CSD430;

-- 2) Create project user
DROP USER IF EXISTS 'student1'@'localhost';
CREATE USER 'student1'@'localhost' IDENTIFIED BY 'pass';
GRANT ALL PRIVILEGES ON CSD430.* TO 'student1'@'localhost';
FLUSH PRIVILEGES;

-- 3) Create table: scott_movies_data
DROP TABLE IF EXISTS scott_movies_data;
CREATE TABLE scott_movies_data (
    id INT AUTO_INCREMENT PRIMARY KEY,        -- PK
    title VARCHAR(200) NOT NULL,              -- movie title
    genre VARCHAR(60) NOT NULL,               -- genre
    release_year INT NOT NULL,                -- year released
    rating DECIMAL(3,1) NULL,                 -- e.g. 8.7
    duration_min INT NULL,                    -- length in minutes
    director VARCHAR(120) NULL,               -- director name
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4) Insert records
INSERT INTO scott_movies_data
(title, genre, release_year, rating, duration_min, director) VALUES
('The Fellowship of the Ring', 'Fantasy', 2001, 8.8, 178, 'Peter Jackson'),
('The Two Towers',              'Fantasy', 2002, 8.7, 179, 'Peter Jackson'),
('The Return of the King',      'Fantasy', 2003, 9.0, 201, 'Peter Jackson'),
('The Hobbit: An Unexpected Journey', 'Fantasy', 2012, 7.8, 169, 'Peter Jackson'),
('The Hobbit: The Desolation of Smaug', 'Fantasy', 2013, 7.8, 161, 'Peter Jackson'),
('The Hobbit: The Battle of the Five Armies', 'Fantasy', 2014, 7.4, 164, 'Peter Jackson'),
('John Wick',                 'Action', 2014, 7.4, 101, 'Chad Stahelski'),
('John Wick: Chapter 2',      'Action', 2017, 7.5, 122, 'Chad Stahelski'),
('John Wick: Chapter 3 – Parabellum', 'Action', 2019, 7.4, 131, 'Chad Stahelski'),
('John Wick: Chapter 4',      'Action', 2023, 7.8, 169, 'Chad Stahelski');