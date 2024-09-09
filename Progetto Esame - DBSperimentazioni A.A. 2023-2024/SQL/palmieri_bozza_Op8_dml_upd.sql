-- Op8 Visualizzare agli amministratori delle pagine lo storico degli utenti premium, sia quelli storici (dato un range di date) che quelli dell’ultimo mese

DROP VIEW IF EXISTS "StoricoUtentiPremium";

CREATE VIEW "StoricoUtentiPremium" AS
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
FROM "StoricoUtentiPremium";
