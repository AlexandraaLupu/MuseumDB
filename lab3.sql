-- a. modify the type of a column;
-- changing the ticket price from int to decimal
CREATE OR ALTER PROCEDURE setTicketPriceFromMuseumsDecimal
AS 
	ALTER TABLE Museums ALTER COLUMN ticket_price DECIMAL(4, 2)
GO

CREATE OR ALTER PROCEDURE setTicketPriceFromMuseumsInt
AS
	ALTER TABLE Museums ALTER COLUMN ticket_price INT
GO

-- b. add / remove a column;
-- add and remove nationality from artists
CREATE OR ALTER PROCEDURE addNationalityFromArtists
AS 
	ALTER TABLE Artists ADD artist_nationality VARCHAR(50)
GO

CREATE OR ALTER PROCEDURE removeNationalityFromArtists
AS 
	ALTER TABLE Artists DROP COLUMN artist_nationality
GO

-- c. add / remove a DEFAULT constraint;
CREATE OR ALTER PROCEDURE addDefaultCenturyFromPaintings
AS 
	ALTER TABLE Paintings ADD CONSTRAINT default_century DEFAULT 'unknown' FOR painting_century
GO

CREATE OR ALTER PROCEDURE removeDefaultCenturyFromPaintings
AS
	ALTER TABLE Paintings DROP CONSTRAINT default_century
GO

-- g. create / drop a table.

CREATE OR ALTER PROCEDURE addStaff
AS
	CREATE TABLE Staff (
		staff_name VARCHAR(50) NOT NULL,
		staff_id_number VARCHAR(20) NOT NULL,
		staff_role VARCHAR(50),
		staff_salary INT,
		staff_museum_id INT
	)
GO

CREATE OR ALTER PROCEDURE dropStaff
AS
	DROP TABLE Staff
GO

-- d. add / remove a primary key;
CREATE OR ALTER PROCEDURE addPrimaryKeyStaff
AS
	ALTER TABLE Staff ADD CONSTRAINT pk_staff PRIMARY KEY(staff_name, staff_id_number)
GO


CREATE OR ALTER PROCEDURE removePrimaryKeyStaff
AS
	ALTER TABLE Staff DROP CONSTRAINT pk_staff
GO

-- e. add / remove a candidate key;
CREATE OR ALTER PROCEDURE addCandidateKeyMuseums
AS
	ALTER TABLE Museums ADD CONSTRAINT candidate_key_museum UNIQUE(museum_name, museum_city)
GO 

CREATE OR ALTER PROCEDURE removeCandidateKeyMuseums
AS
	ALTER TABLE Museums DROP CONSTRAINT candidate_key_museum
GO

-- f. add / remove a foreign key;
CREATE OR ALTER PROCEDURE addForeignKeyStaff
AS
	ALTER TABLE Staff
	ADD CONSTRAINT foreign_key_staff FOREIGN KEY(staff_museum_id) REFERENCES Museums(museum_id)
GO

CREATE OR ALTER PROCEDURE removeForeignKeyStaff
AS
	ALTER TABLE Staff
	DROP CONSTRAINT foreign_key_staff
GO

CREATE TABLE versionTable (
	version INT
)

INSERT INTO versionTable VALUES(1)

CREATE TABLE proceduresTable (
	from_version INT,
	to_version INT,
	PRIMARY KEY(from_version, to_version),
	procedure_name VARCHAR(100)
)

INSERT INTO proceduresTable values(1, 2, 'setTicketPriceFromMuseumsDecimal')
INSERT INTO proceduresTable values(2, 1, 'setTicketPriceFromMuseumsInt')
INSERT INTO proceduresTable values(2, 3, 'addNationalityFromArtists')
INSERT INTO proceduresTable values(3, 2, 'removeNationalityFromArtists')
INSERT INTO proceduresTable values(3, 4, 'addDefaultCenturyFromPaintings')
INSERT INTO proceduresTable values(4, 3, 'removeDefaultCenturyFromPaintings')
INSERT INTO proceduresTable values(4, 5, 'addStaff')
INSERT INTO proceduresTable values(5, 4, 'dropStaff')
INSERT INTO proceduresTable values(5, 6, 'addPrimaryKeyStaff')
INSERT INTO proceduresTable values(6, 5, 'removePrimaryKeyStaff')
INSERT INTO proceduresTable values(6, 7, 'addCandidateKeyMuseums')
INSERT INTO proceduresTable values(7, 6, 'removeCandidateKeyMuseums')
INSERT INTO proceduresTable values(7, 8, 'addForeignKeyStaff')
INSERT INTO proceduresTable values(8, 7, 'removeForeignKeyStaff')

-- Write a stored procedure that receives as a parameter a version number and brings the database to that version.

CREATE OR ALTER PROCEDURE goToVersion(@new_version INT)
AS
	DECLARE @current_version INT
	DECLARE @procedure_name VARCHAR(100)
	
	SELECT @current_version = version FROM versionTable

	IF @new_version > (SELECT MAX(to_version) FROM proceduresTable) OR @new_version < 1
		RAISERROR ('Incorect version', 10, 1)

	WHILE @current_version > @new_version 
	BEGIN
		SELECT @procedure_name = procedure_name
		FROM proceduresTable 
		WHERE from_version = @current_version AND to_version = @current_version - 1
		EXEC(@procedure_name)
		SET @current_version = @current_version - 1
	END

	WHILE @current_version < @new_version 
	BEGIN
		SELECT @procedure_name = procedure_name
		FROM proceduresTable
		WHERE from_version = @current_version AND to_version = @current_version + 1
		EXEC(@procedure_name)
		SET @current_version = @current_version + 1
	END

	UPDATE versionTable SET version = @new_version

GO

EXEC goToVersion 1

SELECT *
FROM Museums

SELECT *
FROM Staff

SELECT *
FROM versionTable

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

