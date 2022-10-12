DROP TABLE roles;
DROP TABLE film;
DROP TABLE acteur;

CREATE TABLE film (
    id_film INTEGER,
    titre VARCHAR(16) NOT NULL,
    annee INTEGER NOT NULL,
    PRIMARY KEY (id_film)
);

CREATE TABLE acteur (
    id_acteur INTEGER,
    nom VARCHAR(2048) NOT NULL,
    PRIMARY KEY (id_acteur)
);

CREATE TABLE roles (
    id_film INTEGER,
    id_acteur INTEGER,
    PRIMARY KEY (id_film, id_acteur),
    FOREIGN KEY (id_acteur) REFERENCES acteur(id_acteur),
    FOREIGN KEY (id_film) REFERENCES film(id_film)
);