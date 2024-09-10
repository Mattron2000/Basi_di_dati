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
