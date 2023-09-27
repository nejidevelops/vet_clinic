INSERT INTO animals VALUES (1, 'Agumon', '2020-02-03', 0, TRUE, 10.23);
INSERT INTO animals VALUES (2, 'Gabumon', '2018-11-15', 2, TRUE, 8);
INSERT INTO animals VALUES (3, 'Pikachu', '2021-01-07', 1, FALSE, 15.04);
INSERT INTO animals VALUES (4, 'Devimon', '2017-05-12', 5, TRUE, 11);

INSERT INTO animals VALUES (5,'Charmander','2020/02/08',0,FALSE,-11);
INSERT INTO animals VALUES (6,'Plantmon','2021/11/15',2,TRUE,-5.7);
INSERT INTO animals VALUES (7,'Squirtle','1993/04/02',3,FALSE,-12.13);
INSERT INTO animals VALUES (8,'Angemon','2005/06/12',1,TRUE,-45);
INSERT INTO animals VALUES (9,'Boarmon','2005/06/07',7,TRUE,20.4);
INSERT INTO animals VALUES (10,'Blossom','1998/10/13',3,TRUE,17);
INSERT INTO animals VALUES (11,'Ditto','2022/05/14',4,TRUE,22);

-- Insert the following data into the `owners` table:
  -- Sam Smith 34 years old.
  -- Jennifer Orwell 19 years old.
  -- Bob 45 years old.
  -- Melody Pond 77 years old.
  -- Dean Winchester 14 years old.
  -- Jodie Whittaker 38 years old.
INSERT INTO owners
  (full_name,age)
    VALUES
      ('Sam Smith', 34),
      ('Jennifer Orwell', 19),
      ('Bob', 45),
      ('Melody Pond', 77),
      ('Dean Winchester', 14),
      ('Jodie Whittaker', 38);

-- Insert the following data into the `species` table:
  -- Pokemon
  -- Digimon
  INSERT INTO species
    (name) 
      VALUES
        ('Pokemon'),
        ('Digimon');

-- Modify your inserted animals so it includes the species_id value:
  -- If the name ends in "mon" it will be Digimon
  UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';

  -- All other animals are Pokemon
  UPDATE animals SET species_id = 1 WHERE name NOT LIKE '%mon';

-- Modify your inserted animals to include owner information (owner_id):
  -- Sam Smith owns Agumon.
  -- Jennifer Orwell owns Gabumon and Pikachu.
  -- Bob owns Devimon and Plantmon.
  -- Melody Pond owns Charmander, Squirtle, and Blossom.
  -- Dean Winchester owns Angemon and Boarmon.  
  UPDATE animals 
    SET owner_id = CASE 
      WHEN name = 'Agumon' THEN 1 
      WHEN name = 'Gabumon' OR name = 'Pikachu' THEN 2 
      WHEN name = 'Devimon' OR name = 'Plantmon' THEN 3 
      WHEN name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom' THEN 4 
      WHEN name = 'Angemon' OR name = 'Boarmon' THEN 5 
    END;

-- Insert the following data for vets:
  -- Vet William Tatcher is 45 years old and graduated Apr 23rd, 2000.
  -- Vet Maisy Smith is 26 years old and graduated Jan 17th, 2019.
  -- Vet Stephanie Mendez is 64 years old and graduated May 4th, 1981.
  -- Vet Jack Harkness is 38 years old and graduated Jun 8th, 2008.
    INSERT INTO vets(
        name,
        age,
        date_of_graduation
      )
        VALUES
          ('Vet William Tatcher', 45, '2000/04/23'),
          ('Vet Maisy Smith', 26, '2019/01/17'),
          ('Vet Stephanie Mendez', 64, '1981/05/04'),
          ('Vet Jack Harkness', 38, '2008/06/08')
    ;

-- Insert the following data for specializations:
  -- Vet William Tatcher is specialized in Pokemon.
  -- Vet Stephanie Mendez is specialized in Digimon and Pokemon.
  -- Vet Jack Harkness is specialized in Digimon.
  INSERT INTO specializations
    VALUES
      (1,1),
      (1,3),
      (2,3), 
      (2,4)
  ;

-- Insert the following data for visits:
  -- Agumon visited William Tatcher on May 24th, 2020.
  -- Agumon visited Stephanie Mendez on Jul 22th, 2020.
  -- Gabumon visited Jack Harkness on Feb 2nd, 2021.
  -- Pikachu visited Maisy Smith on Jan 5th, 2020.
  -- Pikachu visited Maisy Smith on Mar 8th, 2020.
  -- Pikachu visited Maisy Smith on May 14th, 2020.
  -- Devimon visited Stephanie Mendez on May 4th, 2021.
  -- Charmander visited Jack Harkness on Feb 24th, 2021.
  -- Plantmon visited Maisy Smith on Dec 21st, 2019.
  -- Plantmon visited William Tatcher on Aug 10th, 2020.
  -- Plantmon visited Maisy Smith on Apr 7th, 2021.
  -- Squirtle visited Stephanie Mendez on Sep 29th, 2019.
  -- Angemon visited Jack Harkness on Oct 3rd, 2020.
  -- Angemon visited Jack Harkness on Nov 4th, 2020.
  -- Boarmon visited Maisy Smith on Jan 24th, 2019.
  -- Boarmon visited Maisy Smith on May 15th, 2019.
  -- Boarmon visited Maisy Smith on Feb 27th, 2020.
  -- Boarmon visited Maisy Smith on Aug 3rd, 2020.
  -- Blossom visited Stephanie Mendez on May 24th, 2020.
  -- Blossom visited William Tatcher on Jan 11th, 2021.
  INSERT INTO visits
    VALUES
      (6, 1, '2020-05-24'),
      (6, 3, '2020-07-22'),
      (3, 4, '2021-02-02'),
      (9, 2, '2020-01-05'),
      (9, 2, '2020-03-08'),
      (9, 2, '2020-05-14'),
      (4, 3, '2021-05-04'),
      (7, 4, '2021-02-24'),
      (1, 2, '2019-12-21'),
      (1, 1, '2020-08-10'),
      (1, 2, '2021-04-07'),
      (8, 3, '2019-09-29'),
      (2, 4, '2020-10-03'),
      (2, 4, '2020-11-04'),
      (5, 2, '2019-01-24'),
      (5, 2, '2019-05-15'),
      (5, 2, '2020-02-27'),
      (5, 2, '2020-08-03'),
      (10, 3, '2020-05-24'),
      (10, 1, '2021-01-11')
  ;

  -- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
INSERT into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';