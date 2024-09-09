-- Op7 Gli amministratori del DB controllano le segnalazioni inviate dagli streamer di profili fake che li seguono

DROP VIEW IF EXISTS "UtentiSegnalatiVista";

CREATE VIEW "UtentiSegnalatiVista" AS
SELECT
    U."NomeUtente",
    R."UserPassword",
    R."DataDiNascita",
    R."DataRegistrazione",
    R."NumeroDiTelefono",
    R."IndirizzoMail",
    R."Affiliate",
    R."Premium",
    R."LIS"
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
