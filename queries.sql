-- Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name='Pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * FROM animals WHERE neutered = TRUE;

-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE name NOT LIKE 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg >=10.4 AND weight_kg <=17.3;

--Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction.
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;

--Inside a transaction:
  BEGIN;
  -- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
  UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

  -- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
  UPDATE animals SET species = 'pokemon' WHERE name NOT LIKE '%mon';

  -- Verify that changes were made.
  SELECT * FROM animals;
  -- Commit the transaction.
  COMMIT;
  -- Verify that changes persist after commit.
  SELECT * FROM animals;


-- Now, take a deep breath and... Inside a transaction delete all records in the animals table, then roll back the transaction.
  BEGIN;
  DELETE FROM animals;
  ROLLBACK;
-- After the rollback verify if all records in the animals table still exists. After that, you can start breathing as usual ;)
  SELECT * FROM animals;

-- Inside a transaction:
  BEGIN;

  -- Delete all animals born after Jan 1st, 2022.
  DELETE FROM animals WHERE date_of_birth > '2022/01/01';

  -- Create a savepoint for the transaction.
  SAVEPOINT animal;

  -- Update all animals' weight to be their weight multiplied by -1.
  UPDATE animals SET weight_kg = weight_kg * -1;

  -- Rollback to the savepoint
  ROLLBACK;

  BEGIN;

  -- Update all animals' weights that are negative to be their weight multiplied by -1.
  UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

  -- Commit transaction
  COMMIT;

-- Write queries to answer the following questions:
  -- How many animals are there?
  SELECT COUNT(name) FROM animals;

  -- How many animals have never tried to escape?
  SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

  -- What is the average weight of animals?
  SELECT AVG(weight_kg) FROM animals;

  -- Who escapes the most, neutered or not neutered animals?
  SELECT neutered, SUM(escape_attempts) FROM animals  GROUP BY neutered;

  -- What is the minimum and maximum weight of each type of animal?
  SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;

  -- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
  SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990/01/01' AND '2000/12/31' GROUP BY species;


--Write queries (using `JOIN`) to answer the following questions:
  -- What animals belong to Melody Pond?
  SELECT name FROM animals A JOIN owners O ON O.id = A.owner_id WHERE owner_id = 4;

  -- List of all animals that are pokemon (their type is Pokemon).
  SELECT * FROM animals A JOIN species s ON s.id = A.species_id WHERE species_id = 1;

  -- List all owners and their animals, remember to include those that don't own any animal.
  SELECT owners.full_name, animals.name FROM owners LEFT JOIN animals ON owners.id = animals.owner_id;

  -- How many animals are there per species?
  SELECT species.name, COUNT(*) FROM species LEFT JOIN animals ON species.id = animals.species_id GROUP BY species.name;

  -- List all Digimon owned by Jennifer Orwell.
  SELECT animals.name, owners.full_name FROM animals JOIN species ON animals.species_id = species.id JOIN owners ON animals.owner_id = owners.id WHERE species.id = 2 AND owners.id = 2;

  -- List all animals owned by Dean Winchester that haven't tried to escape.
  SELECT animals.name, owners.full_name FROM animals JOIN owners ON animals.owner_id = owners.id WHERE escape_attempts = 0 AND owners.id = 5;

  -- Who owns the most animals?
  SELECT owners.full_name, COUNT(*) FROM owners LEFT JOIN animals ON owners.id = animals.owner_id GROUP BY owners.full_name ORDER BY count DESC;

-- Write queries to answer the following:
  -- Who was the last animal seen by William Tatcher?
  SELECT animals.name, visits.date_of_visit FROM animals JOIN visits ON animals.id = visits.animal_id WHERE vet_id = 1 ORDER BY date_of_visit DESC;

  -- How many different animals did Stephanie Mendez see?
  SELECT COUNT(*) FROM animals JOIN visits ON animals.id = visits.animal_id WHERE vet_id = 3;

  -- List all vets and their specialties, including vets with no specialties.
  SELECT vets.name, species.name AS specialized_in FROM vets LEFT JOIN specializations ON specializations.vet_id = vets.id LEFT JOIN  species ON specializations.species_id = species.id;

  -- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
  SELECT name FROM animals JOIN visits ON animals.id = visits.animal_id WHERE vet_id = 3 AND date_of_visit BETWEEN '2020/04/01' AND '2020/08/30';

  -- What animal has the most visits to vets?
  SELECT animals.name, COUNT(*) FROM animals JOIN visits ON animals.id = visits.animal_id GROUP BY animals.name ORDER BY count DESC LIMIT 1;

  -- Who was Maisy Smith's first visit?
  SELECT animals.name, visits.date_of_visit FROM animals JOIN visits ON animals.id = visits.animal_id WHERE vet_id = 2 GROUP BY animals.name, date_of_visit ORDER BY date_of_visit LIMIT 1;

  -- Details for most recent visit: animal information, vet information, and date of visit.
  SELECT animals.name, animals.date_of_birth, animals.escape_attempts, animals.neutered, animals.weight_kg, vets.name, vets.age, vets.date_of_graduation, visits.date_of_visit FROM animals JOIN visits ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vet_id ORDER BY date_of_visit DESC;

  -- How many visits were with a vet that did not specialize in that animal's species?
  SELECT COUNT(*) FROM visits JOIN animals ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vet_id JOIN specializations on specializations.vet_id = visits.vet_id WHERE animals.species_id != specializations.species_id;

  -- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
  SELECT species.name as species, COUNT(*) from visits JOIN vets ON vets.id = visits.vet_id JOIN animals ON animals.id = visits.animal_id JOIN species ON species.id = animals.species_id WHERE vets.id = 2 GROUP BY species.name;
  
