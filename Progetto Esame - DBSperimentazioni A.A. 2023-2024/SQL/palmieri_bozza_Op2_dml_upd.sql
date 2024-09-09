-- Op2 Calcola la classifica degli streamer più seguiti

DROP VIEW IF EXISTS "NumeroFollowerView";

CREATE VIEW IF EXISTS "NumeroFollowerView" AS
SELECT
    c."StreamerProprietario" AS "Streamer",
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
FROM "NumeroFollowerView";
