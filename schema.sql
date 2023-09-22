CREATE TABLE animals(
    id INT NOT NULL PRIMARY KEY,
    name VARCHAR(255), 
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg FLOAT
);

-- Create a table named `owners` with the following columns:
  -- `id`: integer (set it as autoincremented PRIMARY KEY)
  -- `full_name`: string
  -- `age`: integer
  CREATE TABLE owners(
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(255),
    age INT, PRIMARY KEY(id)
  );

-- Create a table named `species` with the following columns:
  -- `id`: integer (set it as autoincremented PRIMARY KEY)
  -- `name`: string
  CREATE TABLE species(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    PRIMARY KEY(id)
);

-- Modify `animals` table:
  -- Make sure that id is set as autoincremented PRIMARY KEY
    ALTER TABLE animals DROP id;
    ALTER TABLE animals ADD id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY;

  -- Remove column `species`
  ALTER TABLE animals DROP COLUMN species;

  -- Add column `species_id` which is a foreign key referencing `species` table
  ALTER TABLE animals ADD COLUMN species_id INT, ADD CONSTRAINT fk FOREIGN KEY(species_id) REFERENCES species(id);

  -- Add column `owner_id` which is a foreign key referencing the `owners` table
  ALTER TABLE animals ADD COLUMN owner_id INT, ADD CONSTRAINT ownerfk FOREIGN KEY(owner_id) REFERENCES owners(id);  

-- Create a table named `vets` with the following columns:
    -- `id`: integer (set it as autoincremented PRIMARY KEY)
    -- `name`: string
    -- `age`: integer
    -- `date_of_graduation`: date
CREATE TABLE vets(
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(255),
    age INT,
    date_of_graduation date
);

-- There is a **many-to-many** relationship between the tables `species` and `vets`: a vet can specialize in multiple species, and a species can have multiple vets specialized in it. Create a "join table" called `specializations` to handle this relationship.
CREATE TABLE specializations(
    species_id INT,
    vet_id INT,
    CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id),
    CONSTRAINT fk_vets FOREIGN KEY(vet_id) REFERENCES vets(id)
);

-- There is a **many-to-many** relationship between the tables `animals` and `vets`: an animal can visit multiple vets and one vet can be visited by multiple animals. Create a "join table" called `visits` to handle this relationship, it should also keep track of the date of the visit.
CREATE TABLE visits(
    animal_id INT,
    vet_id INT,
    date_of_visit date,
    CONSTRAINT fk_animal FOREIGN KEY(animal_id) REFERENCES animals(id),
    CONSTRAINT fk_vet FOREIGN KEY(vet_id) REFERENCES vets(id)
);
