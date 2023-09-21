CREATE TABLE animals(
    id INT NOT NULL PRIMARY KEY,
    name VARCHAR(255), 
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg FLOAT
);
