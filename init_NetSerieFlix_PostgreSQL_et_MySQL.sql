-- Script d'initialisation de la base NetSerieFlix
-- (Script fonctionnant pour une base MySQL, comme une base PostgreSQL)

/*** CREATE TABLE ***/
CREATE TABLE serie (
	id_serie INTEGER PRIMARY KEY,
	nom_serie VARCHAR(100) UNIQUE,
	note INTEGER CHECK (note BETWEEN 0 AND 100),
	synopsis VARCHAR(200)
);

CREATE TABLE saison (
	id_serie INTEGER REFERENCES serie(id_serie),
	num_saison INTEGER,
	annee INTEGER,
	PRIMARY KEY (id_serie, num_saison)
);

CREATE TABLE episode (
	id_serie INTEGER,
	num_saison INTEGER,
	num_ep INTEGER CHECK (num_ep BETWEEN 0 AND 100),
	nom_ep VARCHAR(100),
	duree_en_min INTEGER CHECK (duree_en_min > 0),
	PRIMARY KEY (id_serie, num_saison, num_ep),
	FOREIGN KEY (id_serie, num_saison) REFERENCES saison(id_serie, num_saison)
);

CREATE TABLE genre (
	id_genre INTEGER PRIMARY KEY,
	nom_genre VARCHAR(100)
);

CREATE TABLE appartenir (
	id_serie INTEGER REFERENCES serie(id_serie),
	id_genre INTEGER REFERENCES genre(id_genre),
	PRIMARY KEY (id_serie, id_genre)
);


/*** INSERT INTO ***/
INSERT INTO serie (id_serie, nom_serie, note, synopsis)
VALUES
(1, 'Black Mirror', 98, 'Cette anthologie de science-fiction explore un futur...'),
(2, 'Hero Corp', 90, 'Suite à la guerre qui fit rage jusque dans les années 80...'),
(3, 'Stranger Things', 96, 'Quand un jeune garçon disparaît, une petite ville découvre...'),
(4, 'The IT Crowd', 92, 'Aidés par une chef ignare en technologie, 2 geeks...'),
(5, 'Lupin', 88, 'Il y a 25 ans, la vie du jeune Assane Diop est bouleversée...');
/* (La série Lupin n'a pas de saison, ni d'épisode, ni de genre associé) */

INSERT INTO saison (id_serie, num_saison, annee)
VALUES
-- Black Mirror
(1, 1, 2011),
(1, 2, 2013),
(1, 3, 2016),
(1, 4, 2017),
-- Hero Corp
(2, 1, 2008),
(2, 2, 2010),
-- Stranger Things
(3, 1, 2016),
(3, 2, 2017),
(3, 3, 2019),
-- The IT Crowd
(4, 1, 2006),
(4, 2, 2007),
(4, 3, 2008),
(4, 4, 2010);

INSERT INTO episode (id_serie, num_saison, num_ep, nom_ep, duree_en_min)
VALUES
-- Black Mirror
(1, 1, 1, 'L''Hymne national', 44),
(1, 1, 2, '15 millions de mérites', 61),
(1, 1, 3, 'Retour sur image', 49),
(1, 2, 1, 'Bientôt de retour', 48),
(1, 2, 2, 'La Chasse', 42),
(1, 2, 3, 'Le Show de Waldo', 43),
(1, 2, 4, 'Blanc comme neige', 73),
(1, 3, 1, 'Chute libre', 63),
(1, 3, 2, 'Phase d''essai', 57),
(1, 3, 3, 'Tais-toi et danse', 52),
(1, 3, 4, 'San Junipero', 61),
(1, 3, 5, 'Tuer sans état d''âme', 60),
(1, 3, 6, 'Haine virtuelle', 89),
(1, 4, 1, 'USS Callister ', 76),
(1, 4, 2, 'Archange', 52),
(1, 4, 3, 'Crocodile', 59),
(1, 4, 4, 'Pendez le DJ ', 51),
(1, 4, 5, 'Tête de Métal', 41),
(1, 4, 6, 'Black Museum ', 69),
-- Hero Corp
(2, 1, 1, 'Le Village', 25),
(2, 1, 2, 'Le Test', 24),
(2, 1, 3, 'Le Grand Départ', 24),
(2, 1, 4, 'Révélations', 24),
(2, 1, 5, 'Recherches', 23),
(2, 1, 6, 'Retour aux sources', 26),
(2, 1, 7, 'À l''intérieur', 26),
(2, 1, 8, 'Nouvelle donne', 25),
(2, 1, 9, 'Emplettes', 26),
(2, 1, 10, 'L''Alerte', 23),
(2, 1, 11, 'Chez l''habitant', 24),
(2, 1, 12, 'Nouvelle peau', 23),
(2, 1, 13, 'Die Hard', 26),
(2, 1, 14, 'Duel', 28),
(2, 1, 15, 'Après le calme', 29),
(2, 2, 1, 'La tempête', 22),
(2, 2, 2, 'La leçon', 20),
(2, 2, 3, 'Ex-æquo', 23),
(2, 2, 4, 'La mine', 20),
(2, 2, 5, 'Au pied des murs', 21),
(2, 2, 6, 'Nouveau toit', 19),
(2, 2, 7, 'Intrus', 20),
(2, 2, 8, 'Du bon côté', 20),
(2, 2, 9, 'Servir l''homme', 21),
(2, 2, 10, 'Dix-sept survivants', 20),
(2, 2, 11, 'Retrouvailles', 22),
(2, 2, 12, 'Stratèges', 20),
(2, 2, 13, 'Instructions', 24),
(2, 2, 14, 'Une nouvelle ère (1/2)', 26),
(2, 2, 15, 'Une nouvelle ère (2/2)', 29),
-- Stranger Things
(3, 1, 1, 'La Disparition de Will Byers', 47),
(3, 1, 2, 'La Barjot de Maple Street', 55),
(3, 1, 3, 'Petit papa Noël', 51),
(3, 1, 4, 'Le Corps', 49),
(3, 1, 5, 'La Puce et l''acrobate', 52),
(3, 1, 6, 'Le Monstre', 46),
(3, 1, 7, 'Le Bain', 41),
(3, 1, 8, 'Le Monde à l''envers', 54),
(3, 2, 1, 'MADMAX', 48),
(3, 2, 2, 'Des Bonbons ou un sort, espèce de taré', 56),
(3, 2, 3, 'Le Batracien', 51),
(3, 2, 4, 'Will le sage', 46),
(3, 2, 5, 'Dig Dug', 58),
(3, 2, 6, 'L''Espion', 51),
(3, 2, 7, 'La Sœur perdue', 45),
(3, 2, 8, 'Le Flagelleur mental', 47),
(3, 2, 9, 'Le Portail ', 62),
(3, 3, 1, 'Suzie, tu me reçois ?', 51),
(3, 3, 2, 'Comme des rats', 50),
(3, 3, 3, 'La maître-nageuse disparue', 50),
(3, 3, 4, 'Le Sauna', 53),
(3, 3, 5, 'L''Armada', 52),
(3, 3, 6, 'E Pluribus Unum', 60),
(3, 3, 7, 'La Morsure', 55),
(3, 3, 8, 'La Bataille de Starcourt', 78),
-- The IT Crowd
(4, 1, 1, 'Les givrés du sous-sol', 23),
(4, 1, 2, 'Aïe mes pieds !', 24),
(4, 1, 3, 'Le millionnaire', 24),
(4, 1, 4, 'La porte rouge', 23),
(4, 1, 5, 'Jen est morte', 23),
(4, 1, 6, 'Tante Irma est arrivée', 25),
(4, 2, 1, 'La soirée gay', 24),
(4, 2, 2, 'Le patron saute', 24),
(4, 2, 3, 'Cuisine à l''allemande', 23),
(4, 2, 4, 'Le dîner de Jen', 22),
(4, 2, 5, 'Ecran de fumée', 24),
(4, 2, 6, 'La potion magique', 23),
(4, 3, 1, 'Le maçon', 23),
(4, 3, 2, 'Les vrais mecs', 22),
(4, 3, 3, 'Ceinture de chasteté', 22),
(4, 3, 4, 'Le discours', 24),
(4, 3, 5, 'Friendface', 23),
(4, 3, 6, 'Le Calendrier des geeks', 23),
(4, 4, 1, 'Jen et les féministes', 25),
(4, 4, 2, 'Finale sanglante', 24),
(4, 4, 3, 'La Spaciologie', 23),
(4, 4, 4, 'Italian for Beginners', 24),
(4, 4, 5, 'Bad Boys', 24),
(4, 4, 6, 'Reynholm vs Reynholm', 24); /* INFO : UPDATE ensuite pour passer à 31 minutes */

/* Les genres des séries :
	(1, 'Black Mirror', ...)  => Science-Fiction(1), Fantastique(2)
	(2, 'Hero Corp', ...) => Fantastique(2), Comique(3)
	(3, 'Stranger Things', ...) => Fantastique(2), Thriller(4)
	(4, 'The IT Crowd', ...) => Comique(3)
*/
INSERT INTO genre (id_genre, nom_genre)
VALUES
(1, 'Science-Fiction'),
(2, 'Fantastique'),
(3, 'Comique'),
(4, 'Thriller');

INSERT INTO appartenir (id_serie, id_genre)
VALUES
(1, 1),
(1, 2),
(2, 2),
(2, 3),
(3, 2),
(3, 4),
(4, 3);

/* Mise à jour de la durée du dernier épisode de The IT Crowd
		pour avoir un épisode qui dépasse 30 minutes */
UPDATE episode SET duree_en_min=31
WHERE id_serie=4 AND num_saison=4 AND num_ep=6;
