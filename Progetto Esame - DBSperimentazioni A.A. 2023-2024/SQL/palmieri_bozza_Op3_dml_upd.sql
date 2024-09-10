-- Op3 Per ogni streamer, calcola la media dei voti per ogni contenuto multimediale

DROP VIEW IF EXISTS "MediaLikertPerContenutoVista";

CREATE VIEW "MediaLikertPerContenutoVista" AS
SELECT
    CM."Canale",
    CM."IdURL" AS "ContenutoMultimediale",
    COALESCE(FLOOR(AVG(V."Likert")), 0) AS "MediaLikert"
FROM
    "ContenutoMultimediale" AS CM
LEFT JOIN
    "Voto" AS V
    ON CM."IdURL" = V."ContenutoMultimediale"
GROUP BY
    CM."IdURL"
ORDER BY
	"MediaLikert" DESC;

SELECT *
FROM "MediaLikertPerContenutoVista";
