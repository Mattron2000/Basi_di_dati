-- Op3 Per ogni streamer, calcola la media dei voti per ogni contenuto multimediale

DROP VIEW IF EXISTS "MediaLikertPerCanaleVista";

CREATE VIEW "MediaLikertPerCanaleVista" AS
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
    CM."Canale",
    CM."IdURL"
ORDER BY
    "Canale",
	CAST(REGEXP_REPLACE("IdURL", '\D', '', 'g') AS INTEGER),
	"MediaLikert" DESC;

SELECT *
FROM "MediaLikertPerCanaleVista";
