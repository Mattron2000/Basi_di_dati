-- Op6 Controlla i nuovi utenti registrati

SELECT
    R.*,
    CASE
        WHEN C."StreamerProprietario" IS NOT NULL THEN true
        ELSE false
    END AS "HaCanale"
FROM
    "Registrato" AS R
LEFT JOIN
    "Canale" AS C ON R."Username" = C."StreamerProprietario"
WHERE
    R."DataRegistrazione" >= (CURRENT_DATE - INTERVAL '5 year')    -- possiamo cambiare interval in '1 year', '1 week', ...
ORDER BY
    R."DataRegistrazione" DESC;
