-- We can create database through script
-- CREATE DATABASE mycounter;
-- It's already done when running container

-- We specify the database to use
USE mariadocker;

-- We create counters table
CREATE TABLE counters
( 
  id INT(11) NOT NULL AUTO_INCREMENT,
  value INT NOT NULL,
  PRIMARY KEY (id)
);

-- We insert values
INSERT INTO counters
(value)
VALUES
(1);
