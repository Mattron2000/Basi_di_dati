-- Vista dove elenca gli utenti streamer

-- DROP VIEW "UtenteStreamerView";

CREATE VIEW "UtenteStreamerView" AS
SELECT
    R.*
FROM
    "Registrato" AS R JOIN
    "Canale" AS C ON
    R."Username" = C."StreamerProprietario";

-- SELECT * FROM "UtenteStreamerView";

-- Vista di nome streamer e il relativo numero di follower

-- DROP VIEW "NumeroFollowerView";

CREATE VIEW "NumeroFollowerView" AS
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

-- SELECT *
-- FROM "NumeroFollowerView"
-- WHERE "NumeroFollower" >= 50;

-- Vista per Affluenza media per ogni Live

-- DROP VIEW "AffluenzaMediaPerCanaleVista";
-- DROP VIEW "AffluenzaMediaLiveVista";

CREATE VIEW "AffluenzaMediaLiveVista" AS
SELECT
    A."Live",
    SUM("NumeroSpettatori") / COUNT("Live") AS "AffluenzaMedia"
FROM
    "Affluenza" AS A
GROUP BY
    A."Live"
ORDER BY
    "AffluenzaMedia" DESC;

-- Vista per la media della affluenza per ogni Canale

CREATE VIEW "AffluenzaMediaPerCanaleVista" AS
SELECT
    C."Canale",
    FLOOR(AVG(A."AffluenzaMedia")) AS "AffluenzaMediaPerCanale"
FROM
    "AffluenzaMediaLiveVista" AS A
JOIN
    "Live" AS L
    ON A."Live" = L."IdLive"
JOIN
    "ContenutoMultimediale" AS C
    ON L."IdLive" = C."IdURL"
GROUP BY
    C."Canale"
ORDER BY
    "AffluenzaMediaPerCanale" DESC;

-- SELECT *
-- FROM "AffluenzaMediaPerCanaleVista"
-- WHERE "AffluenzaMediaPerCanale" >= 3;

-- Vista per minuti trasmessi per ogni canale

-- DROP VIEW "MinutiTotaliTrasmesseVista";

CREATE VIEW "MinutiTotaliTrasmesseVista" AS
SELECT
    C."Canale",
    FLOOR(SUM(
        EXTRACT(EPOCH FROM (L."DataFine" - L."DataInizio")) / 60
    )) AS "MinutiTotaliTrasmesse"
FROM
    "Live" AS L
JOIN
    "ContenutoMultimediale" AS C
    ON L."IdLive" = C."IdURL"
GROUP BY
    C."Canale"
ORDER BY
    "MinutiTotaliTrasmesse" DESC;

-- SELECT *
-- FROM "MinutiTotaliTrasmesseVista"
-- WHERE "MinutiTotaliTrasmesse" >= 500;

-- FINALE Op1

UPDATE "Registrato"
SET "Affiliate" = true
WHERE "Username" IN (
    SELECT
        R."Username"
    FROM
        "Registrato" AS R
    JOIN
        "Canale" AS C
        ON R."Username" = C."StreamerProprietario"
    JOIN
        "MinutiTotaliTrasmesseVista" AS M
        ON C."StreamerProprietario" = M."Canale"
    JOIN
        "AffluenzaMediaPerCanaleVista" AS A
        ON C."StreamerProprietario" = A."Canale"
    JOIN
        "NumeroFollowerView" AS N
        ON C."StreamerProprietario" = N."Streamer"
    WHERE
        M."MinutiTotaliTrasmesse" >= 500
        AND A."AffluenzaMediaPerCanale" >= 3
        AND N."NumeroFollower" >= 50
);
