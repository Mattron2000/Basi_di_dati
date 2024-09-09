-- Op4 Gli amministratori delle pagine, per ogni contenuto multimediale di ogni streamer, stilano il rating dei video più votati

DROP VIEW IF EXISTS "RatingContenutiMultimedialiVista";

CREATE VIEW "RatingContenutiMultimedialiVista" AS
SELECT
    CM."Canale",
    CM."IdURL" AS "ContenutoMultimediale",
    CM."Titolo",
    COUNT(V."UtenteRegistrato") AS "NumeroVoti"
FROM
    "ContenutoMultimediale" AS CM
LEFT JOIN
    "Voto" AS V
    ON CM."IdURL" = V."ContenutoMultimediale"
GROUP BY
    CM."Canale",
    CM."IdURL",
    CM."Titolo"
ORDER BY
    "NumeroVoti" DESC;

SELECT *
FROM "RatingContenutiMultimedialiVista";
