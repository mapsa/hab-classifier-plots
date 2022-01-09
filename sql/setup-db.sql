-- CREATE EXTENSION postgis;
DROP TABLE Bin;
DROP TABLE Dataset;

CREATE TABLE Dataset (
    id INTEGER NOT NULL PRIMARY KEY,
    name CHARACTER varying(100) NOT NULL,
    location CHARACTER varying(100) NOT NULL,
    latitude NUMERIC(20,18) NOT NULL,
    longitude NUMERIC(20,18) NOT NULL,
    geom GEOMETRY(Point, 4326),
    dashboard_id_name CHARACTER varying(100) NOT NULL
);

CREATE TABLE Bin (
    pid CHARACTER varying(24) NOT NULL PRIMARY KEY,
    dataset_id INTEGER REFERENCES Dataset(id),
    sample_time TIMESTAMP,
    exclude BOOLEAN,
    ifcb INTEGER,
    ml_analyzed FLOAT,
    depth FLOAT,
    n_images INTEGER,
    cell_concentration FLOAT -- 1000 * n_images/ml_analyzed (cells/L)
);

CREATE TABLE SPECIES (
    id INTEGER NOT NULL PRIMARY KEY,
    name CHARACTER VARYING(200),
    class CHARACTER VARYING(200)
);

CREATE TABLE IMAGES (
    image_id INTEGER NOT NULL PRIMARY KEY,
    classification INTEGER REFERENCES SPECIES(id),
    probability FLOAT
);