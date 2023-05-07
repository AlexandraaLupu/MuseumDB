DROP TABLE Tc
DROP TABLE Ta
DROP TABLE Tb

--create the tables
CREATE TABLE Ta (
	aid INT PRIMARY KEY,
	a2 INT UNIQUE,
	a3 INT
)

CREATE TABLE Tb (
	bid INT PRIMARY KEY,
	b2 INT,
	b3 INT
)

CREATE TABLE Tc (
	cid INT PRIMARY KEY,
	aid INT FOREIGN KEY REFERENCES Ta(aid),
	bid INT FOREIGN KEY REFERENCES Tb(bid)
)


--procedure to generate random values for Ta
CREATE OR ALTER PROCEDURE InsertDataTa(@rows INT) AS
	BEGIN
		DECLARE @random INT
		SET @random = @rows * 17 + 13
		WHILE @rows > 0
			BEGIN
				INSERT INTO Ta VALUES(@rows, @random, @random % 57)
				SET @rows = @rows - 1
				SET @random = @random + 1
			END
	END
GO

--procedure to generate random values for Tb
CREATE OR ALTER PROCEDURE InsertDataTb(@rows INT) AS
	BEGIN
		DECLARE @random INT
		SET @random = @rows * 8 + 5
		WHILE @rows > 0
			BEGIN
				INSERT INTO Tb VALUES(@rows, @random, @random % 33)
				SET @rows = @rows - 1
				SET @random = @random + 2
			END
	END
GO

--procedure to generate random values for Tc
CREATE OR ALTER PROCEDURE InsertDataTc(@rows INT) AS
	BEGIN
		DECLARE @aid INT
		DECLARE @bid INT
		WHILE @rows > 0
			BEGIN
				SET @aid = (SELECT TOP 1 aid FROM Ta ORDER BY NEWID())
				SET @bid = (SELECT TOP 1 bid FROM Tb ORDER BY NEWID())
				INSERT INTO Tc VALUES(@rows, @aid, @bid)
				SET @rows = @rows - 1
			END
	END
GO


EXEC InsertDataTa 10000
EXEC InsertDataTb 12000
EXEC InsertDataTc 9000

Select *
From Ta

Select *
From Tb

Select *
From Tc

--a. Write queries on Ta such that their execution plans contain the following operators:
--clustered index scan
--0.046

SELECT *
FROM Ta

--clustered index seek
--0.003
SELECT *
FROM Ta
WHERE aid < 50

--nonclustered index scan
--0.039
SELECT a2
FROM Ta
ORDER BY a2

--nonclustered index seek
--0.003
SELECT a2
FROM Ta
WHERE a2 < 170021
ORDER BY a2

--key lookup
--0.003
SELECT *
FROM Ta
WHERE a2 = 180000

--b. Write a query on table Tb with a WHERE clause of the form WHERE b2 = value and analyze its execution plan.
--Create a nonclustered index that can speed up the query
--0.054
SELECT *
FROM Tb
WHERE b2 = 119061

--0.003
DROP INDEX Tb_b2_index ON Tb

CREATE NONCLUSTERED INDEX Tb_b2_index ON Tb(b2)

SELECT *
FROM Tb
WHERE b2 = 119061

--Create a view that joins at least 2 tables. 
--Check whether existing indexes are helpful; if not, reassess existing indexes / examine the cardinality of the tables.

CREATE OR ALTER VIEW View1 AS
	SELECT Tc.cid, Ta.aid, Ta.a3, Tb.bid, Tb.b3
	FROM Tc 
	INNER JOIN Ta ON Tc.aid = Ta.aid 
	INNER JOIN Tb ON Tc.bid = Tb.bid
	WHERE Tb.b3 > 17 AND Ta.a3 < 30

SELECT *
FROM View1

--0.447 without indexes

DROP INDEX Ta_a3_index ON Ta

CREATE NONCLUSTERED INDEX Ta_a3_index ON Ta(a3)

--0.411 nonclustered index on a3

DROP INDEX Tb_b3_index ON Tb

CREATE NONCLUSTERED INDEX Tb_b3_index ON Tb(b3)

--0.411 nonclustered index on b3

DROP INDEX Tc_index ON Tc

CREATE NONCLUSTERED INDEX Tc_index ON Tc(aid, bid)

--0.398 nonclustered index on (aid, bid) from Tc