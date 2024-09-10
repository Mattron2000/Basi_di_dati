-- Op9 Per ogni streamer, stilare la media degli spettatori per ogni live uscita in quel mese

DROP VIEW IF EXISTS "LiveTrasmesseNelMeseSceltoVista";

CREATE VIEW "LiveTrasmesseNelMeseSceltoVista" AS
SELECT
	CM.*,
	L."DataInizio",
	L."DataFine",
	COALESCE(FLOOR(AVG(A."NumeroSpettatori")), 0) AS "MediaSpettatori"
FROM
    "Live" AS L
LEFT JOIN
    "Affluenza" AS A ON L."IdLive" = A."Live"
JOIN
    "ContenutoMultimediale" AS CM ON CM."IdURL" = L."IdLive"
WHERE
    EXTRACT(YEAR FROM L."DataInizio") = EXTRACT(YEAR FROM CURRENT_DATE)
AND
	EXTRACT(MONTH FROM L."DataInizio") = EXTRACT(MONTH FROM CURRENT_DATE)
GROUP BY
    CM."IdURL", L."IdLive", CM."Canale";

SELECT * FROM "LiveTrasmesseNelMeseSceltoVista";
