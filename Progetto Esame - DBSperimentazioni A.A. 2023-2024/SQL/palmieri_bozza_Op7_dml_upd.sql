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
