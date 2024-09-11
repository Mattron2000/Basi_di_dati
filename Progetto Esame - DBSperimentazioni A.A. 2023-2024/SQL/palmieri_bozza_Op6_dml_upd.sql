-- Op6 Controlla i nuovi utenti registrati

SELECT
    R.*
FROM
    "Registrato" AS R
WHERE
    R."DataRegistrazione" >= (CURRENT_DATE - INTERVAL '5 year')    -- possiamo cambiare interval in '1 year', '1 week', ...
ORDER BY
    R."DataRegistrazione" DESC;
