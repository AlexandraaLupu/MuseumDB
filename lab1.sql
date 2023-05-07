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
	painting_name VARCHAR(50),
	painting_artist_id INT FOREIGN KEY REFERENCES Artists(artist_id),
	museum_id INT FOREIGN KEY REFERENCES Museums(museum_id),
	painting_style VARCHAR(50),
	painting_century VARCHAR(10),
	paint_type VARCHAR(20)
);

CREATE TABLE Statues(	
	statue_name VARCHAR(50),
	statue_artist_id INT FOREIGN KEY REFERENCES Artists(artist_id),
	museum_id INT FOREIGN KEY REFERENCES Museums(museum_id),
	statue_century VARCHAR(10),
	statue_style VARCHAR(20),
	statue_material VARCHAR(20)
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