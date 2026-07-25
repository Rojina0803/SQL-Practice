CREATE TABLE IF NOT EXISTS person (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    date_of_birth DATE NOT NULL
   
);

INSERT INTO person (id, first_name, last_name, gender, date_of_birth)
VALUES (
    id:integer,
    'first_name:character varying',
    'last_name:character varying',
    'gender':'',
    'date_of_birth:date'
  );