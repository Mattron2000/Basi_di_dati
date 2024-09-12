-- Vista dove elenca gli utenti streamer

DROP VIEW IF EXISTS "UtenteStreamerVista";

CREATE VIEW "UtenteStreamerVista" AS
SELECT
    R.*
FROM
    "Registrato" AS R JOIN
    "Canale" AS C ON
    R."Username" = C."StreamerProprietario";

-- SELECT * FROM "UtenteStreamerVista";

-- Vista di nome streamer e il relativo numero di follower

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

-- SELECT *
-- FROM "NumeroFollowerVista"
-- WHERE "NumeroFollower" >= 50;

-- Vista per Affluenza media per ogni Live

DROP VIEW IF EXISTS "AffluenzaMediaPerCanaleVista";
DROP VIEW IF EXISTS "AffluenzaMediaLiveVista";

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

DROP VIEW IF EXISTS "MinutiTotaliTrasmesseVista";

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

-- Op1 Controlla le condizioni per la qualifica di affiliate

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
        "NumeroFollowerVista" AS N
        ON C."StreamerProprietario" = N."Streamer"
    WHERE
        M."MinutiTotaliTrasmesse" >= 500
        AND A."AffluenzaMediaPerCanale" >= 3
        AND N."NumeroFollower" >= 50
);

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

-- Op5 Controlla ed elimina tutti i commenti offensivi per ogni contenuto multimediale, nelle categorie, nei canali e durante le live

DROP VIEW IF EXISTS "CommentiOffensiviVista";

CREATE VIEW "CommentiOffensiviVista" AS
SELECT
    I."Spettatore",
    I."LiveCorrente",
    I."IntTimestamp"
FROM
    "Interazione" I
JOIN
    "Live" L ON I."LiveCorrente" = L."IdLive"
JOIN
    "ContenutoMultimediale" C ON L."IdLive" = C."IdURL"
WHERE
    I."Tipologia" = 'commento'
AND
    I."Messaggio" LIKE '%offensiva%';

-- DELETE FROM "Interazione"
-- WHERE ("Spettatore", "LiveCorrente", "IntTimestamp") IN (
--     SELECT *
--     FROM "CommentiOffensiviVista"
-- );

-- DEBUG
SELECT * FROM "Interazione"
WHERE ("Spettatore", "LiveCorrente", "IntTimestamp") IN (
    SELECT *
    FROM "CommentiOffensiviVista"
);

-- Op6 Controlla i nuovi utenti registrati

SELECT
    R.*
FROM
    "Registrato" AS R
WHERE
    R."DataRegistrazione" >= (CURRENT_DATE - INTERVAL '5 year')    -- possiamo cambiare interval in '1 year', '1 week', ...
ORDER BY
    R."DataRegistrazione" DESC;

-- Op7 Gli amministratori del DB controllano le segnalazioni inviate dagli streamer di profili fake che li seguono

DROP VIEW IF EXISTS "UtentiSegnalatiVista";

CREATE VIEW "UtentiSegnalatiVista" AS
SELECT
    R.*
FROM
    "Utente" AS U
LEFT JOIN
    "Registrato" AS R
ON
    U."NomeUtente" = R."Username"
WHERE
    U."Segnalato" = true;

SELECT *
FROM "UtentiSegnalatiVista";

-- Op8 Visualizzare agli amministratori delle pagine lo storico degli utenti premium, sia quelli storici (dato un range di date) che quelli dell’ultimo mese

DROP VIEW IF EXISTS "StoricoUtentiPremiumVista";

CREATE VIEW "StoricoUtentiPremiumVista" AS
SELECT
    R.*
FROM
    "Registrato" R
WHERE
    R."Premium" = true
    AND (
        -- Filtra gli utenti premium registrati in un range di date specifico
        (R."DataRegistrazione" BETWEEN '2019-01-01' AND '2020-12-31')
        OR
        -- Filtra gli utenti premium registrati nell'ultimo mese
        (R."DataRegistrazione" >= (CURRENT_DATE - INTERVAL '1 month'))
    )
ORDER BY
    R."DataRegistrazione" DESC;

SELECT *
FROM "StoricoUtentiPremiumVista";

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
