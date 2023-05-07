drop table Museums
drop table Artists
Drop table Paintings
drop table Statues
drop table Types
drop table MuseumTypes
drop table Directors
drop table HistoryDirectors
drop table Collections
drop table MuseumCollections

DELETE FROM Paintings

SELECT * FROM Museums
SELECT * FROM Paintings

CREATE TABLE Museums(	
	museum_id INT PRIMARY KEY,
	museum_name VARCHAR(50),
	ticket_price INT,
	museum_year_establishment INT,
	museum_director VARCHAR(50),
	museum_country VARCHAR(50),
	museum_city VARCHAR(50)
);

CREATE TABLE Artists(
	artist_id INT PRIMARY KEY,
	artist_name VARCHAR(50),
	birth_date DATE,
	artist_movement VARCHAR(50)
);

CREATE TABLE Paintings(
	painting_id INT PRIMARY KEY,
	painting_name VARCHAR(50),
	painting_artist_id INT FOREIGN KEY REFERENCES Artists(artist_id) ON DELETE CASCADE,
	painting_museum_id INT FOREIGN KEY REFERENCES Museums(museum_id) ON DELETE CASCADE,
	painting_century VARCHAR(10),
	paint_type VARCHAR(20)
	UNIQUE(painting_artist_id, painting_id, painting_museum_id)
);

CREATE TABLE Statues(	
	statue_name VARCHAR(50),
	statue_artist_id INT FOREIGN KEY REFERENCES Artists(artist_id) ON DELETE CASCADE,
	statue_museum_id INT FOREIGN KEY REFERENCES Museums(museum_id),
	statue_century VARCHAR(10),
	statue_material VARCHAR(20)
	UNIQUE(statue_artist_id, statue_name, statue_museum_id)
);

CREATE TABLE Types(
	museum_type_id INT PRIMARY KEY,
	museum_type_name VARCHAR(50)
);

CREATE TABLE MuseumTypes(		
	museum_id INT FOREIGN KEY REFERENCES Museums(museum_id),
	museum_type_id INT FOREIGN KEY REFERENCES Types(museum_type_id),
	UNIQUE(museum_id, museum_type_id)
);

CREATE TABLE Directors(
	director_id INT PRIMARY KEY,
	director_name VARCHAR(50)
);

CREATE TABLE HistoryDirectors(
	director_id INT FOREIGN KEY REFERENCES Directors(director_id),
	museum_id INT FOREIGN KEY REFERENCES Museums(museum_id),
	director_start_date DATE,
	director_end_date DATE
)

CREATE TABLE Collections(
	collection_id INT PRIMARY KEY,
	collection_name VARCHAR(50)
)

CREATE TABLE MuseumCollections(
	museum_id INT FOREIGN KEY REFERENCES Museums(museum_id),
	collection_id INT FOREIGN KEY REFERENCES Collections(collection_id)
)

ALTER TABLE MuseumCollections
ADD UNIQUE(museum_id, collection_id)

--------------------------------------------------LAB 2 ------------------------------------------------------------

-- insert data – for at least 4 tables; at least one statement must violate referential integrity constraints;
INSERT INTO Museums VALUES(1, 'Louvre', 20, 1793, 'Laurence des Cars', 'France', 'Paris')
INSERT INTO Museums VALUES(2, 'Anne Frank House', 20, 1960, 'Ronald Leopold', 'Netherlands', 'Amsterdam')
INSERT INTO Museums VALUES(3, 'The British Museum', 200, 1753, 'Hartwig Fischer', 'United Kingdom', 'London')
INSERT INTO Museums VALUES(4, 'Solomon R. Guggenheim Museum', 25, 1937, '	Richard Armstrong', 'USA', 'New York City')
INSERT INTO Museums VALUES(5, 'Musée d’Orsay', 15, 1986, 'Guy Cogeval', 'France', 'Paris')
INSERT INTO Museums VALUES(6, 'Uffizi Gallery', 40, 1581, '	Eike Schmidt', 'Italy', 'Florence')
INSERT INTO Types VALUES(1, 'natural history')
INSERT INTO Types VALUES(2, 'natural science')
INSERT INTO Types VALUES(3, 'science and technology')
INSERT INTO Types VALUES(4, 'art')
INSERT INTO Types VALUES(5, 'historic site')
INSERT INTO MuseumTypes VALUES(1, 4)
INSERT INTO MuseumTypes VALUES(1, 5)
INSERT INTO MuseumTypes VALUES(4, 4)
INSERT INTO MuseumTypes VALUES(5, 4)
INSERT INTO MuseumTypes VALUES(5, 5)
INSERT INTO MuseumTypes VALUES(5, 6) -- error. There is no key 6 in Types
INSERT INTO Artists VALUES (1, 'Michelangelo Buonarroti', '1475-04-06', 'High Renaissance')
INSERT INTO Artists VALUES (2, 'Vincent van Gogh', '1853-03-30', '	Post-Impressionism')
INSERT INTO Artists VALUES (3, 'Leonardo da Vinci', '1452-04-15', 'High Renaissance')
INSERT INTO Artists VALUES (4, 'Raphael', '1483-04-06', 'High Renaissance')
INSERT INTO Artists VALUES (5, 'Frédéric Bazille', '1841-12-06', 'Impressionism')
INSERT INTO Artists VALUES (6, 'Gustave Courbet', '1819-06-10', 'Realism')
INSERT INTO Artists VALUES (7, 'Auguste Rodin', '1840-11-12', 'Impressionism')
INSERT INTO Artists VALUES (8, 'Wassily Kandinsky', '1866-12-16', '	Expressionism')
INSERT INTO Paintings VALUES(1,'Landscape with Factory Chimney', 8, 4, '20th', 'oil')
INSERT INTO Paintings VALUES(2,'La Belle Jardinière', 4, 1, '16th', 'oil') 
INSERT INTO Paintings VALUES(3,'St. Michael Vanquishing Satan', 4, 1, '26th', 'oil')
INSERT INTO Paintings VALUES(4,'The Annunciation', 3, 6, '15th', 'oil and tempera') 
INSERT INTO Paintings VALUES(5,'The Holy Family', 1, 6, '16th', 'oil and tempera') 


-- update data – for at least 3 tables

UPDATE Museums SET ticket_price = 30 WHERE museum_city = 'Paris' -- used =
UPDATE Paintings SET paint_type = NULL WHERE paint_type NOT IN ('oil', 'tempera', 'acrylic', 'pencil')
UPDATE Paintings SET painting_century = NULL WHERE painting_century NOT IN ('13th', '14th', '15th', '16th', '17th', '18th', '19th', '20th', '21st') -- used [NOT] IN
UPDATE Museums SET ticket_price = 25 WHERE ticket_price IS NULL -- used IS NULL
UPDATE Artists SET birth_date = '1475-03-06' WHERE artist_id = 1

-- delete data – for at least 2 tables
DELETE Artists WHERE birth_date BETWEEN '1400-01-01' AND '1500-01-01' -- used BETWEEN
DELETE Paintings WHERE painting_century LIKE '15%' OR painting_century LIKE '16%' -- used LIKE and OR
DELETE MuseumTypes WHERE museum_type_id = 4

INSERT INTO MuseumTypes VALUES(1, 4)
INSERT INTO MuseumTypes VALUES(4, 4)
INSERT INTO MuseumTypes VALUES(5, 4)
INSERT INTO Artists VALUES (3, 'Leonardo da Vinci', '1452-04-15', 'High Renaissance')
INSERT INTO Artists VALUES (4, 'Raphael', '1483-04-06', 'High Renaissance')
INSERT INTO Artists VALUES (1, 'Michelangelo Buonarroti', '1475-04-06', 'High Renaissance')
INSERT INTO Paintings VALUES('La Belle Jardinière', 4, 1, '16th', 'oil') 
INSERT INTO Paintings VALUES('St. Michael Vanquishing Satan', 4, 1, '26th', 'oil')
INSERT INTO Paintings VALUES('The Annunciation', 3, 6, '15th', 'oil and tempera') 
INSERT INTO Paintings VALUES('The Holy Family', 1, 6, '16th', 'oil and tempera')
UPDATE Paintings SET paint_type = NULL WHERE paint_type NOT IN ('oil', 'tempera', 'acrylic', 'pencil')
UPDATE Paintings SET painting_century = NULL WHERE painting_century NOT IN ('13th', '14th', '15th', '16th', '17th', '18th', '19th', '20th', '21st')
INSERT INTO Artists VALUES (9, 'Denis Foyatier', '1793-09-17', 'Neoclassicism')
INSERT INTO Artists VALUES (10, 'Pierre Puget', '1620-10-16', 'Baroque')
INSERT INTO Artists VALUES (11, 'Louis-Ernest Barrias', '1841-04-13', 'Romantic')
INSERT INTO Statues VALUES('Milo Of Croton', 10, 1, '17th', 'marble')
INSERT INTO Statues VALUES('Spartacus', 9, 1, '19th', 'marble')
INSERT INTO Statues VALUES('Nature Unveiling Herself Before Science', 11, 5, '19th', 'marble')
INSERT INTO Statues	VALUES ('Dying Slave', 1, 1, '16th', 'marble')
UPDATE Paintings SET painting_century = '19th' WHERE painting_century = '16th'
INSERT INTO Collections VALUES(1, 'paintings')
INSERT INTO Collections VALUES(2, 'drawings and prints')
INSERT INTO Collections VALUES(3, 'sculptures')
INSERT INTO Collections VALUES(4, 'furniture')
INSERT INTO Collections VALUES(5, 'textiles')
INSERT INTO Collections VALUES(6, 'jewellery and finery')
INSERT INTO Collections VALUES(7, 'writing and inscriptions')
INSERT INTO Collections VALUES(8, 'objects')
INSERT INTO Collections VALUES(9, 'photography')
INSERT INTO Collections VALUES(10, 'architecture')
INSERT INTO MuseumCollections VALUES(1, 1)
INSERT INTO MuseumCollections VALUES(1, 2)
INSERT INTO MuseumCollections VALUES(1, 3)
INSERT INTO MuseumCollections VALUES(1, 4)
INSERT INTO MuseumCollections VALUES(1, 5)
INSERT INTO MuseumCollections VALUES(1, 6)
INSERT INTO MuseumCollections VALUES(1, 7)
INSERT INTO MuseumCollections VALUES(1, 8)
INSERT INTO MuseumCollections VALUES(2, 2)
INSERT INTO MuseumCollections VALUES(2, 4)
INSERT INTO MuseumCollections VALUES(2, 5)
INSERT INTO MuseumCollections VALUES(2, 7)
INSERT INTO MuseumCollections VALUES(2, 9)
INSERT INTO MuseumCollections VALUES(2, 10)
INSERT INTO MuseumCollections VALUES(3, 1)
INSERT INTO MuseumCollections VALUES(3, 2)
INSERT INTO MuseumCollections VALUES(3, 3)
INSERT INTO MuseumCollections VALUES(3, 4)
INSERT INTO MuseumCollections VALUES(3, 5)
INSERT INTO MuseumCollections VALUES(3, 6)
INSERT INTO MuseumCollections VALUES(3, 8)
INSERT INTO MuseumCollections VALUES(4, 1)
INSERT INTO MuseumCollections VALUES(4, 3)
INSERT INTO MuseumCollections VALUES(4, 10)
INSERT INTO MuseumCollections VALUES(5, 1)
INSERT INTO MuseumCollections VALUES(5, 3)
INSERT INTO MuseumCollections VALUES(5, 8)
INSERT INTO MuseumCollections VALUES(5, 9)
INSERT INTO MuseumCollections VALUES(5, 10)
INSERT INTO MuseumCollections VALUES(5, 2)
INSERT INTO MuseumCollections VALUES(6, 1)
INSERT INTO MuseumCollections VALUES(6, 3)


--a. 2 queries with the union operation; use UNION [ALL] and OR
SELECT painting_name AS art_name, painting_museum_id AS museum_id-- select paintings name and statues name from museum_id = 1 or museum_id = 4
FROM Paintings
WHERE painting_museum_id = 1 or painting_museum_id = 4
UNION
SELECT statue_name, statue_museum_id
FROM Statues
WHERE statue_museum_id = 1 or statue_museum_id = 4

SELECT painting_name as art_name, painting_century as century -- select paintings and statues from 19th and 20th century
FROM Paintings
WHERE painting_century = '19th' or painting_century = '20th'
UNION 
SELECT statue_name, statue_century
FROM Statues
WHERE statue_century = '19th' or statue_century = '20th'

-- b. 2 queries with the intersection operation; use INTERSECT and IN;
SELECT museum_id -- select museum id of staues from paris and made of marble or stone
FROM Museums
WHERE museum_city = 'Paris'
INTERSECT
SELECT statue_museum_id
FROM Statues
WHERE statue_material IN ('marble', 'stone')

SELECT museum_id -- select museum id that has the ticket price = 30 and it has the type natural history, science and technology and historic site 
FROM Museums
WHERE ticket_price = 30
INTERSECT
SELECT museum_id
FROM MuseumTypes
WHERE museum_type_id IN (1, 3, 5)

-- c. 2 queries with the difference operation; use EXCEPT and NOT IN
SELECT painting_name, painting_century -- find paintings except those that are not from 19th and 20th
FROM Paintings -- 
WHERE painting_century IS NOT NULL
EXCEPT
SELECT painting_name, painting_century
FROM Paintings
WHERE painting_century NOT IN ('19th', '20th')


SELECT * -- find all the museum except the ones that are not in paris or london
FROM Museums
EXCEPT
SELECT *
FROM Museums
WHERE museum_city NOT IN ('Paris', 'London')

--d. 4 queries with INNER JOIN, LEFT JOIN, RIGHT JOIN, and FULL JOIN (one query per operator); one query will join at least 3 tables,
--while another one will join at least two many-to-many relationships;

-- INNER JOIN with 3 tables
SELECT A.artist_name, P.painting_name, M.museum_name -- find the artists that have paintings in the museums
FROM Artists A
INNER JOIN Paintings P ON A.artist_id = P.painting_artist_id
INNER JOIN Museums M ON P.painting_museum_id = M.museum_id

--LEFT JOIN
SELECT A.artist_name, A.artist_movement, S.statue_name -- find the artists and if they have sculptures
FROM Artists A
LEFT JOIN Statues S ON S.statue_artist_id = A.artist_id

-- RIGHT JOIN with 2 many-to-many relationships - museum types collections
SELECT DISTINCT * -- find museums and show if the ones of type HISTORIC SITE have a collection of type PAINTINGS
FROM  MuseumCollections MC
RIGHT JOIN MuseumTypes MT ON MC.museum_id = MT.museum_id AND MC.collection_id = 1 AND MT.museum_type_id = 5

-- FULL JOIN
SELECT A.artist_name, P.painting_name -- find the artists and their paintings if they have
FROM Artists A
FULL JOIN Paintings P ON A.artist_id = P.painting_artist_id

-- e. 2 queries with the IN operator and a subquery in the WHERE clause; in at least one case, the subquery must include a subquery in its own WHERE clause
SELECT *	-- find artists that have paintings in the museums from data base
FROM Artists A
WHERE A.artist_id IN (
	SELECT P.painting_artist_id
	FROM Paintings P
	WHERE P.painting_museum_id IN (
		SELECT M.museum_id
		FROM Museums M 
		)
    )

SELECT P.painting_name -- select paintings from museums in Paris
FROM Paintings P
WHERE P.painting_museum_id IN (
	SELECT M.museum_id
	FROM Museums M
	WHERE M.museum_city = 'Paris'
	)

-- f. 2 queries with the EXISTS operator and a subquery in the WHERE clause
SELECT P.painting_name -- paintings from the museum in the data base where the ticket price is less than 30
FROM Paintings P
WHERE EXISTS ( 
	SELECT M.museum_name
	FROM Museums M
	WHERE P.painting_museum_id = M.museum_id AND M.ticket_price < 30
	)

SELECT DISTINCT M.museum_name -- museums where there are collections of type PAINTINGS
FROM Museums M
WHERE EXISTS (
	SELECT *
	FROM MuseumCollections MC, Collections C
	WHERE MC.museum_id = M.museum_id AND MC.collection_id = C.collection_id AND C.collection_name = 'paintings'
	)
ORDER BY M.museum_name

-- g. 2 queries with a subquery in the FROM clause;   
SELECT AR.artist_name	-- select artists from the movement HIGH RENAISSANCE that have statues
FROM (
	SELECT A.artist_name, A.artist_id
	FROM Artists A
	WHERE A.artist_movement = 'High Renaissance'
	)AR
WHERE AR.artist_id IN (
	SELECT S.statue_artist_id
	FROM Statues S
	)

SELECT PA.painting_name -- select paintings from the 19th century from Louvre(id = 1)
FROM (
	SELECT P.painting_name, P.painting_museum_id
	FROM Paintings P
	WHERE P.painting_century = '19th'
	) PA
WHERE PA.painting_museum_id = 1

-- h. 4 queries with the GROUP BY clause, 3 of which also contain the HAVING clause; 2 of the latter will also have a subquery in the HAVING clause 
-- use the aggregation operators: COUNT, SUM, AVG, MIN, MAX


SELECT TOP 2 COUNT(*) AS number_of_paintings, m.museum_id, m.museum_name -- show museums and their number of paintings
FROM Museums m, Paintings P
where m.museum_id = p.painting_museum_id
GROUP BY m.museum_id, m.museum_name
HAVING COUNT(*) = ( -- HAVING and SUBQUERY
	SELECT COUNT(*) C
	FROM Paintings P
	WHERE P.painting_museum_id = M.museum_id
	)
ORDER BY number_of_paintings DESC

SELECT COUNT(*) AS number_collections, M.museum_id, M.museum_name -- show the museums with the smallest number of collections
FROM Museums M INNER JOIN MuseumCollections MC ON M.museum_id = MC.museum_id
GROUP BY M.museum_id, M.museum_name
HAVING COUNT(*) = (	-- HAVING and SUBQUERY
	SELECT MIN(MMC.C) -- used MIN
	FROM(
		SELECT count(*) c
		FROM Museums M1 inner join MuseumCollections MC1 on M1.museum_id = MC1.museum_id
		GROUP BY M1.museum_id, M1.museum_name
		)
	MMC)

SELECT DISTINCT COUNT(*) AS number_museums, m.museum_city, SUM(m.ticket_price) AS maximum_price -- show the number of museums from a city and the total price of
FROM Museums M INNER JOIN Museums M1 ON M.museum_city = M1.museum_city							-- the tickets for that city
GROUP BY M.museum_id, m.museum_city
HAVING SUM(M.ticket_price) = (
	SELECT MAX(MU.S)  -- used SUM and MAX
	FROM (
		SELECT SUM(M.ticket_price) S
		FROM Museums M2
		GROUP BY M2.museum_id
		)MU
	)

SELECT M.museum_name, ticket_price -- select the museums that have the ticket price greater than the average
FROM Museums M
GROUP BY M.museum_name, M.ticket_price
HAVING M.ticket_price > (
	SELECT AVG(MU.T) -- used AVG
	FROM(
		SELECT M1.ticket_price T
		FROM Museums M1
		)MU
	)

-- i. 4 queries using ANY and ALL to introduce a subquery in the WHERE clause (2 queries per operator)
-- rewrite 2 of them with aggregation operators, and the other 2 with IN / [NOT] IN

SELECT M.museum_name, M.ticket_price -- museums that have the ticket price greater than any other museum from France
FROM Museums M
WHERE M.ticket_price > ANY( -- used ANY
	SELECT M1.ticket_price
	FROM Museums M1
	WHERE M.museum_country = 'France'
	)

SELECT M.museum_name, M.ticket_price -- rewritten using aggregation
FROM Museums M
WHERE M.ticket_price > (
	SELECT MIN(M1.ticket_price)
	FROM Museums M1
	WHERE M.museum_country = 'France'
	)


SELECT TOP 5 M.museum_name, M.museum_year_establishment -- select museum that have been established later than any other one
FROM Museums M
WHERE M.museum_year_establishment = ANY ( -- used ANY
	SELECT M1.museum_year_establishment
	FROM Museums M1
	)
ORDER BY M.museum_year_establishment

SELECT TOP 5 M.museum_name, M.museum_year_establishment -- rewritten using IN
FROM Museums M
WHERE M.museum_year_establishment IN ( 
	SELECT M1.museum_year_establishment
	FROM Museums M1
	)
ORDER BY M.museum_year_establishment

SELECT P.painting_name, P.painting_century -- select all the paintings that are different from the ones made in the 19th century
FROM Paintings P
WHERE P.painting_name <> ALL ( -- used ALL
	SELECT P1.painting_name
	FROM Paintings P1
	WHERE P1.painting_century = '19th'
	)

SELECT P.painting_name, P.painting_century -- rewritten using NOT IN
FROM Paintings P
WHERE P.painting_name NOT IN (
	SELECT P1.painting_name
	FROM Paintings P1
	WHERE P1.painting_century = '19th'
	)

SELECT TOP 3 M.museum_name, M.ticket_price -- select all the museums that have the ticket price * 1.5 greater than any other one
FROM Museums M
WHERE 1.5 * M.ticket_price > ALL ( -- used ALL
	SELECT M1.ticket_price
	FROM Museums M1
	)
ORDER BY M.ticket_price

SELECT TOP 3 M.museum_name, M.ticket_price -- rewritten using aggregation
FROM Museums M
WHERE 1.5 * M.ticket_price > (
	SELECT MAX(M1.ticket_price)
	FROM Museums M1
	)
ORDER BY M.ticket_price

SELECT *
FROM Museums

SELECT * 
FROM Types

SELECT *
FROM MuseumTypes

SELECT * 
FROM Paintings

SELECT * 
FROM Artists

SELECT *
FROM Statues

SELECT * 
FROM Collections

SELECT * 
FROM MuseumCollections
