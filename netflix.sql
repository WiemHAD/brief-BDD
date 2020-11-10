--1/Créer une base de données ‘netflix’:

CREATE database netflix; --create DATABASE
USE netflix;
SHOW tables; --Show empty tables

-- 2/ Créer une table appelée ‘netflix_title’:
CREATE TABLE `netflix_title`
(
    `show_id` INT,
    `type` VARCHAR(7),
    `title` VARCHAR(104),
    `director` VARCHAR(208),
    `cast` VARCHAR(771),
    `country` VARCHAR(123),
    `date_added` VARCHAR(19),
    `release_year` INT,
    `rating` VARCHAR(8),
    `duration` VARCHAR(10),
    `listed_in` VARCHAR(79),
    `description` VARCHAR (248)
);
--load table:
LOAD DATA LOCAL INFILE '/home/wiem/Document/Git/brief BDD/netflix_titles.csv' 
INTO TABLE netflix.netflix_title
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Créer une table appelée ‘netflix_shows’:
CREATE TABLE `netflix_shows`
(
   `title` VARCHAR(63),
   `rating` VARCHAR(8),
   `ratingLevel` VARCHAR(125),
   `release_year` INT,
   `user_rating_score` FLOAT(5),
   `user_rating_size` INT

); 
-- load table:
LOAD DATA LOCAL INFILE '/home/wiem/Document/Git/brief BDD/netflix_titles.csv' 
INTO TABLE netflix.netflix_title
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Afficher tous les titres de films de la table netflix_titles dont l’ID est inférieur strict à 80000000
SELECT title FROM netflix_title 
WHERE show_id < 80000000;

-- Afficher toutes les durée des TV Show (colonne duration)
SELECT type, duration FROM netflix_title
WHERE type='TV Show';

--Afficher tous les noms de films communs aux 2 tables (netflix_titles et netflix_shows) 
SELECT netflix_title.title FROM netflix_title
INNER JOIN netflix_shows ON netflix_title.title = netflix_shows.title;

-- Calculer la durée totale de tous les films (Movie)S de votre table netflix_titles
SELECT SUM(duration) FROM netflix_title
WHERE type='Movie';

--Compter le nombre de TV Shows de votre table ‘netflix_shows’ dont le ‘ratingLevel’ est renseigné. 
SELECT COUNT(title) FROM netflix_shows
WHERE ratingLevel <> '';

-- Compter les films et TV Shows pour lesquels les noms (title) sont les mêmes 
--sur les 2 tables et dont le ‘release year’ est supérieur à 2016. 
SELECT COUNT(netflix_title.title) FROM netflix_title
INNER JOIN netflix_shows on netflix_title.title = netflix_shows.title
WHERE netflix_title.title = netflix_shows.title
AND netflix_title.release_year > 2016 AND netflix_shows.release_year > 2016);

--Supprimer la colonne ‘rating’ de votre table ‘netflix_shows’ 
ALTER TABLE netflix_shows
DROP rating;

--Supprimer les 100 dernières lignes de la table ‘netflix_shows’
ALTER TABLE netflix_shows --create collumn id 
ADD id_shows INT PRIMARY KEY NOT NULL AUTO_INCREMENT;

SELECT *  -- afficher les 100 dernières lignes
FROM netflix_shows ORDER BY id_shows DESC LIMIT 100;
DELETE FROM netflix_shows ORDER BY id_shows DESC LIMIT 100;

-- Le champs “ratingLevel” pour le TV show “Marvel's Iron Fist”
-- de la table ‘netflix_shows’ est vide, pouvez-vous ajouter un commentaire
UPDATE netflix_shows
SET netflix_shows.ratingLevel= 'Marvel'
WHERE netflix_shows.title = "Marvel's Iron Fist";
SELECT * FROM netflix_shows WHERE netflix_shows.title = "Marvel's Iron Fist"; --show updates


