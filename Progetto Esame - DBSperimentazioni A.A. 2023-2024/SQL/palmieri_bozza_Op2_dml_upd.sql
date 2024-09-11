-- Op2 Calcola la classifica degli streamer più seguiti

DROP VIEW IF EXISTS "NumeroFollowerVista";

CREATE VIEW "NumeroFollowerVista" AS
SELECT
    C."StreamerProprietario" AS "Streamer",
    COUNT(F."UtenteFollower") AS "NumeroFollower"
FROM
    "Canale" AS C
LEFT JOIN
    "Follower" AS F
ON
    C."StreamerProprietario" = F."StreamerSeguito"
GROUP BY
    C."StreamerProprietario"
ORDER BY
    "NumeroFollower" DESC;

SELECT *
FROM "NumeroFollowerVista";
