DROP TABLE IF EXISTS fincato_palmieri."Clip";
DROP TABLE IF EXISTS fincato_palmieri."Video";
DROP TABLE IF EXISTS fincato_palmieri."Affluenza";
DROP TABLE IF EXISTS fincato_palmieri."Presenza";
DROP TABLE IF EXISTS fincato_palmieri."Emoji";
DROP TABLE IF EXISTS fincato_palmieri."Interazione";
DROP TABLE IF EXISTS fincato_palmieri."Live";
DROP TABLE IF EXISTS fincato_palmieri."Voto";
DROP TABLE IF EXISTS fincato_palmieri."Visita";
DROP TABLE IF EXISTS fincato_palmieri."Associazione";
DROP TABLE IF EXISTS fincato_palmieri."ContenutoMultimediale";
DROP TABLE IF EXISTS fincato_palmieri."Categoria";
DROP TABLE IF EXISTS fincato_palmieri."Hashtag";
DROP TABLE IF EXISTS fincato_palmieri."Subscription";
DROP TABLE IF EXISTS fincato_palmieri."Follower";
DROP TABLE IF EXISTS fincato_palmieri."Donazione";
DROP TABLE IF EXISTS fincato_palmieri."LinkSocial";
DROP TABLE IF EXISTS fincato_palmieri."Programmazione";
DROP TABLE IF EXISTS fincato_palmieri."Canale";
DROP TABLE IF EXISTS fincato_palmieri."Rinnovo";
DROP TABLE IF EXISTS fincato_palmieri."Amministratore";
DROP TABLE IF EXISTS fincato_palmieri."Provider";
DROP TABLE IF EXISTS fincato_palmieri."Portafoglio";
DROP TABLE IF EXISTS fincato_palmieri."Messaggio";
DROP TABLE IF EXISTS fincato_palmieri."Registrato";
DROP TABLE IF EXISTS fincato_palmieri."Utente";
DROP SCHEMA IF EXISTS "fincato_palmieri";
DROP SEQUENCE IF EXISTS guest_sequence;
DROP SEQUENCE IF EXISTS url_sequence;
DROP DOMAIN IF EXISTS LikertDomain;
DROP DOMAIN IF EXISTS InterazioneDomain;

CREATE SCHEMA "fincato_palmieri";

-- Sequenza che incrementa di 1 il numero intero associato ad un guest
CREATE SEQUENCE IF NOT EXISTS guest_sequence;

-- Sequenza che incrementa di 1 il numero associato ad un url, per creare un url simbolico univoco
CREATE SEQUENCE IF NOT EXISTS url_sequence;

-- Dominio applicato all'attributo "Likert" per garantire il corretto valore del voto
CREATE DOMAIN LikertDomain
AS integer
CHECK (value >= 1 AND value <= 10);

-- Dominio applicato all'attributo "Tipologia" per garantire il corretto valore del tipo di interazione
CREATE DOMAIN InterazioneDomain
AS text
CHECK (value = 'commento' OR value = 'reazione');

-- Table: fincato_palmieri."Utente"

CREATE TABLE IF NOT EXISTS fincato_palmieri."Utente"
(
    "NomeUtente" text PRIMARY KEY DEFAULT ('guest_' || nextval('guest_sequence'))
);

ALTER TABLE IF EXISTS fincato_palmieri."Utente"
	ADD CHECK ("NomeUtente" <> '' AND length("NomeUtente") > 3 AND length("NomeUtente") < 20);

COMMENT ON TABLE fincato_palmieri."Utente"
	IS 'Lista username degli utenti guest e registrati';

-- Table: fincato_palmieri."Registrato"

CREATE TABLE IF NOT EXISTS fincato_palmieri."Registrato"
(
    "Username" text PRIMARY KEY,
    "UserPassword" text NOT NULL,
    "DataDiNascita" date NOT NULL,
    "DataRegistrazione" date NOT NULL DEFAULT CURRENT_DATE,
    "NumeroDiTelefono" text,
    "IndirizzoMail" text,
    "Affiliate" boolean,
    "Premium" boolean NOT NULL DEFAULT false,
    "LIS" boolean NOT NULL DEFAULT false
);

ALTER TABLE IF EXISTS fincato_palmieri."Registrato"
	ADD CONSTRAINT "Registrato_fkey" FOREIGN KEY ("Username")
        REFERENCES fincato_palmieri."Utente" ("NomeUtente")
        ON UPDATE CASCADE
        ON DELETE CASCADE,
	-- Vincolo per garantire che l'etá minima imposta dalla UE sia rispettata
	ADD CHECK ("DataDiNascita" <= (CURRENT_DATE - INTERVAL '13 years')),
	-- Validazione tramite regex della email (supporta gli alias)
	-- 		ex.		john.doe@gmail.com, alice+newsletter@domain.co.uk, foo.bar+baz@domain123.co
	--				user_name123@example.com, test.email+alias@sub.domain.org
    ADD CHECK ("IndirizzoMail" IS NULL OR "IndirizzoMail" ~* '^\w+(\.\w+)*(\+\w+)?@\w{2,}(\.\w{2,})*$'),
    -- lunghezza minima richiesta per una password forte
	ADD CHECK (length("UserPassword") >= 8),
	-- validazione tramite regex dei numeri di telefono con prefisso internazionale
	-- 		ex.		1234567890, 123 456 7890, 123-456-7890,
	-- 				+441234567890, +44 1234567890, +44 123 456 7890, +44-123-456-7890
    ADD CHECK ("NumeroDiTelefono" IS NULL OR "NumeroDiTelefono" ~ '^(\+\d{1,3}( |-)?)?(\d{10}|(\d{3} \d{3} \d{4})|(\d{3}-\d{3}-\d{4}))$');

COMMENT ON TABLE fincato_palmieri."Registrato"
    IS 'Tabella contenente gli utenti registrato, sia spettatori e streamer';

-- Table: fincato_palmieri."Messaggio"

CREATE TABLE IF NOT EXISTS fincato_palmieri."Messaggio"
(
	"Mittente" text NOT NULL,
	"TimestampMessaggio" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
	"Destinatario" text NOT NULL,
	"Testo" text NOT NULL,
	PRIMARY KEY ("Mittente", "TimestampMessaggio")
);

ALTER TABLE IF EXISTS fincato_palmieri."Messaggio"
	ADD FOREIGN KEY ("Mittente")
		REFERENCES fincato_palmieri."Registrato" ("Username")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD FOREIGN KEY ("Destinatario")
		REFERENCES fincato_palmieri."Registrato" ("Username")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	-- Check per garantire che il testo del messaggio inviato non sia vuoto
	ADD CHECK ("Testo" <> '' AND length("Testo") < 200),
	-- Check per garantire che il mittente e destinatario del messaggio inviato non sia lo stesso
	ADD CHECK ("Mittente" <> "Destinatario");

COMMENT ON TABLE fincato_palmieri."Messaggio"
	IS 'Tabella contenente i messaggi privati inviati tra utenti registrati';

-- Table: fincato_palmieri."Portafoglio"

CREATE TABLE IF NOT EXISTS fincato_palmieri."Portafoglio"
(
	"UtenteProprietario" text PRIMARY KEY,
	"TotaleBits" integer NOT NULL DEFAULT 0
);

ALTER TABLE IF EXISTS fincato_palmieri."Portafoglio"
	ADD FOREIGN KEY ("UtenteProprietario")
		REFERENCES fincato_palmieri."Registrato" ("Username")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	-- Vincolo per garantire che il totale dei bits (il bilancio) non sia negativo
	ADD CHECK ("TotaleBits" >= 0);

COMMENT ON TABLE fincato_palmieri."Portafoglio"
	IS 'Tabella contenente i portafogli privati degli utenti registrati';

-- Table: fincato_palmieri."Provider"

CREATE TABLE IF NOT EXISTS fincato_palmieri."Provider"
(
	"NomeProvider" text PRIMARY KEY
);

ALTER TABLE IF EXISTS fincato_palmieri."Provider"
	-- Vincolo per garantire che il nome del provider non sia vuoto
	ADD CHECK ("NomeProvider" <> '' AND length("NomeProvider") < 15);

COMMENT ON TABLE fincato_palmieri."Provider"
	IS 'Tabella contenente i provider disponibili per ospitare i contenuti multimediali creati dagli streamer sotto gestione degli amministratori';

-- Table: fincato_palmieri."Amministratore"

CREATE TABLE IF NOT EXISTS fincato_palmieri."Amministratore"
(
	"CodiceAdmin" integer PRIMARY KEY,
	"Nome" text NOT NULL,
	"Cognome" text NOT NULL,
	UNIQUE ("Nome", "Cognome")
);

ALTER TABLE IF EXISTS fincato_palmieri."Amministratore"
	ADD CHECK ("Cognome" <> '' AND length("Cognome") > 3 AND length("Cognome") < 20),
	ADD CHECK ("Nome" <> '' AND length("Nome") > 3 AND length("Nome") < 20);

COMMENT ON TABLE fincato_palmieri."Amministratore"
	IS 'Tabella contenente gli amministratori delle pagine che hanno il ruolo di gestire i contenuti multimediali dei canali assegnati nei server del provider a cui ha pagato';

-- Table: fincato_palmieri."Rinnovo"

CREATE TABLE IF NOT EXISTS fincato_palmieri."Rinnovo"
(
	"Amministratore" integer,
	"Provider" text,
	"DataScadenza" date NOT NULL,
	PRIMARY KEY ("Amministratore", "Provider")
);

ALTER TABLE IF EXISTS fincato_palmieri."Rinnovo"
	ADD FOREIGN KEY ("Amministratore")
		REFERENCES fincato_palmieri."Amministratore" ("CodiceAdmin")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD FOREIGN KEY ("Provider")
		REFERENCES fincato_palmieri."Provider" ("NomeProvider")
		ON UPDATE CASCADE
		ON DELETE CASCADE;

COMMENT ON TABLE fincato_palmieri."Rinnovo"
	IS 'Tabella che contiene i rinnovi effettuati dagli amministratori per poter continuare a gestire i contenuti multimediali con il provider';

-- Table: fincato_palmieri."Canale"

CREATE TABLE IF NOT EXISTS fincato_palmieri."Canale"
(
	"StreamerProprietario" text PRIMARY KEY,
	"AdminCanale" integer NOT NULL,
	"HostingProvider" text NOT NULL,
	"Descrizione" text,
	"ImmagineProfilo" text,
	"Trailer" text
);

ALTER TABLE IF EXISTS fincato_palmieri."Canale"
	ADD FOREIGN KEY ("StreamerProprietario")
		REFERENCES fincato_palmieri."Registrato" ("Username")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD FOREIGN KEY ("AdminCanale")
		REFERENCES fincato_palmieri."Amministratore" ("CodiceAdmin")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD FOREIGN KEY ("HostingProvider")
		REFERENCES fincato_palmieri."Provider" ("NomeProvider")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD CHECK ("Descrizione" IS NULL OR "Descrizione" <> ''),
	ADD CHECK ("ImmagineProfilo" IS NULL OR "ImmagineProfilo" <> ''),
	ADD CHECK ("Trailer" IS NULL OR "Trailer"  <> '');

COMMENT ON TABLE fincato_palmieri."Canale"
	IS 'Tabella contenenti i canali creati e gestiti dagli utenti registrati che vogliono pubblicare contenuti multimediali';

-- Table: fincato_palmieri."Programmazione"

CREATE TABLE IF NOT EXISTS fincato_palmieri."Programmazione"
(
	"Streamer" text NOT NULL,
	"ProgTimestamp" timestamp with time zone NOT NULL,
	"Titolo" text NOT NULL,
	"LIS" boolean NOT NULL DEFAULT false,
	"Premium" boolean NOT NULL DEFAULT false,
	PRIMARY KEY ("Streamer", "ProgTimestamp")
);

ALTER TABLE IF EXISTS fincato_palmieri."Programmazione"
	ADD FOREIGN KEY ("Streamer")
		REFERENCES fincato_palmieri."Canale" ("StreamerProprietario")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD CHECK ("Titolo" <> '');

COMMENT ON TABLE fincato_palmieri."Programmazione"
	IS 'Tabelle contenenti le programmazioni di live prefissate dallo streamer';

-- Table: fincato_palmieri."LinkSocial";

CREATE TABLE IF NOT EXISTS fincato_palmieri."LinkSocial"
(
	"CanaleAssociato" text NOT NULL,
	"Social" text NOT NULL,
	"LinkProfilo" text NOT NULL,
	PRIMARY KEY ("CanaleAssociato", "Social")
);

ALTER TABLE IF EXISTS fincato_palmieri."LinkSocial"
	ADD FOREIGN KEY ("CanaleAssociato")
		REFERENCES fincato_palmieri."Canale" ("StreamerProprietario")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	-- Validazione tramite regex il link URL del social
	-- 		ex.		https://www.asd.google.com/search?q=some+text&param=3#dfsd,
	-- 				https://www.google.com
	-- 				http://google.com/?q=some+text&param=3#dfsdf
	-- 				https://www.google.com/api/?
	-- 				https://www.google.com/api/login.php
	ADD CHECK ("LinkProfilo" ~ '^https?:\/\/(www\.)?([-\w@:%._\+~#=]{2,}\.[a-z]{2,6})+(\/[\/\w\.-]*)*(\?\w+=.+)*$');

COMMENT ON TABLE fincato_palmieri."LinkSocial"
	IS 'Tabella contenenti i link social del canale';

-- Table: fincato_palmieri."Donazione"

CREATE TABLE IF NOT EXISTS fincato_palmieri."Donazione"
(
	"ProprietarioPortafoglio" text NOT NULL,
	"CanaleStreamer" text NOT NULL,
	"Timestamp" timestamp with time zone NOT NULL,
	"Bits" integer NOT NULL DEFAULT 1,
	PRIMARY KEY ("ProprietarioPortafoglio", "Timestamp")
);

ALTER TABLE IF EXISTS fincato_palmieri."Donazione"
	ADD FOREIGN KEY ("ProprietarioPortafoglio")
		REFERENCES fincato_palmieri."Portafoglio" ("UtenteProprietario")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD FOREIGN KEY ("CanaleStreamer")
		REFERENCES fincato_palmieri."Canale" ("StreamerProprietario")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	-- Vincolo per garantire che il numero di bits da donare non sia negativo o zero
	ADD CHECK ("Bits" > 0);

COMMENT ON TABLE fincato_palmieri."Donazione"
	IS 'Tabella che contiene le donazioni effettuate da utente registrato a utente streamer (utente registrato che gestisce un canale)';

-- Table: fincato_palmieri."Follower"

CREATE TABLE IF NOT EXISTS fincato_palmieri."Follower"
(
	"UtenteFollower" text NOT NULL,
	"StreamerSeguito" text NOT NULL,
	PRIMARY KEY ("UtenteFollower", "StreamerSeguito")
);

ALTER TABLE IF EXISTS fincato_palmieri."Follower"
	ADD FOREIGN KEY ("StreamerSeguito")
		REFERENCES fincato_palmieri."Canale" ("StreamerProprietario")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD FOREIGN KEY ("UtenteFollower")
		REFERENCES fincato_palmieri."Registrato" ("Username")
		ON UPDATE CASCADE
		ON DELETE CASCADE;

COMMENT ON TABLE fincato_palmieri."Follower"
	IS 'Tabella che contiene le iscrizioni degli utenti registrati ai canali per avere le notifiche delle programmazioni delle live';

-- Table: fincato_palmieri."Subscription"

CREATE TABLE IF NOT EXISTS fincato_palmieri."Subscription"
(
	"UtenteAbbonato" text NOT NULL,
	"Streamer" text NOT NULL,
	PRIMARY KEY ("UtenteAbbonato", "Streamer")
);

ALTER TABLE IF EXISTS fincato_palmieri."Subscription"
	ADD FOREIGN KEY ("Streamer")
		REFERENCES fincato_palmieri."Canale" ("StreamerProprietario")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD FOREIGN KEY ("UtenteAbbonato")
		REFERENCES fincato_palmieri."Registrato" ("Username")
		ON UPDATE CASCADE
		ON DELETE CASCADE;

COMMENT ON TABLE fincato_palmieri."Subscription"
	IS 'Tabella che contiene gli abbonamenti degli utenti registrati ai canali per poter seguire anche i contenuti multimediali esclusivi ai soli abbonati';

-- Table: fincato_palmieri."Categoria"

CREATE TABLE IF NOT EXISTS fincato_palmieri."Categoria"
(
	"NomeCategoria" text PRIMARY KEY
);

ALTER TABLE IF EXISTS fincato_palmieri."Categoria"
	ADD CHECK ("NomeCategoria" <> '');

COMMENT ON TABLE fincato_palmieri."Categoria"
	IS 'Tabella contenente le categorie per poter filtrare i contenuti multimediale';

-- Table: fincato_palmieri."Hashtag"

CREATE TABLE IF NOT EXISTS fincato_palmieri."Hashtag"
(
	"NomeHashtag" text PRIMARY KEY
);

ALTER TABLE IF EXISTS fincato_palmieri."Hashtag"
	ADD CHECK ("NomeHashtag" <> '');

COMMENT ON TABLE fincato_palmieri."Hashtag"
	IS 'Tabella contenente gli hashtag per poter filtrare i contenuti multimediale';

-- Table: fincato_palmieri."ContenutoMultimediale"

CREATE TABLE IF NOT EXISTS fincato_palmieri."ContenutoMultimediale"
(
	"IdURL" text PRIMARY KEY DEFAULT ('url' || nextval('url_sequence')),
	"Canale" text NOT NULL,
	"Titolo" text NOT NULL,
	"Categoria" text NOT NULL,
	"LIS" boolean NOT NULL DEFAULT false,
	"Premium" boolean NOT NULL DEFAULT false
);

ALTER TABLE IF EXISTS fincato_palmieri."ContenutoMultimediale"
	ADD FOREIGN KEY ("Canale")
		REFERENCES fincato_palmieri."Canale" ("StreamerProprietario")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD FOREIGN KEY ("Categoria")
		REFERENCES fincato_palmieri."Categoria" ("NomeCategoria")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	-- Validazione tramite regex del link URL del contenuto mutimediale di qualsiasi tipo
	-- 		ex.		https://www.asd.google.com/search?q=some+text&param=3#dfsd,
	-- 				https://www.google.com
	-- 				http://google.com/?q=some+text&param=3#dfsdf
	-- 				https://www.google.com/api/?
	-- 				https://www.google.com/api/login.php
	-- ADD CHECK ("IdURL" ~* '^https?:\/\/(www\.)?([-\w@:%._\+~#=]{2,}\.[a-z]{2,6})+(\/[\/\w\.-]*)*(\?\w+=.+)*$'),
	ADD CHECK ("IdURL" ~ '^url\d+$'),
	-- Vincolo che impedisce di impostare il titolo del contenuto mutimediale di qualsiasi tipo in una stringa vuota
	ADD CHECK ("Titolo" <> '');

COMMENT ON TABLE fincato_palmieri."ContenutoMultimediale"
	IS 'Tabella che contiene i valori comuni di diversi tipi di contenuti multimediali (LIVE, VIDEO e CLIP)';

-- Table: fincato_palmieri."Associazione"

CREATE TABLE IF NOT EXISTS fincato_palmieri."Associazione"
(
	"Hashtag" text,
	"ContenutoMultimediale" text,
	PRIMARY KEY ("Hashtag", "ContenutoMultimediale")
);

ALTER TABLE IF EXISTS fincato_palmieri."Associazione"
	ADD FOREIGN KEY ("Hashtag")
		REFERENCES fincato_palmieri."Hashtag" ("NomeHashtag")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD FOREIGN KEY ("ContenutoMultimediale")
		REFERENCES fincato_palmieri."ContenutoMultimediale" ("IdURL")
		ON UPDATE CASCADE
		ON DELETE CASCADE;

COMMENT ON TABLE fincato_palmieri."Associazione"
	IS 'Tabella che contiene le associazioni create dagli utenti streamer ai propri contenuti multimediali';

-- Table: fincato_palmieri."Visita"

CREATE TABLE IF NOT EXISTS fincato_palmieri."Visita"
(
	"Utente" text,
	"ContenutoMultimediale" text,
	PRIMARY KEY ("Utente", "ContenutoMultimediale")
);

ALTER TABLE IF EXISTS fincato_palmieri."Visita"
	ADD FOREIGN KEY ("Utente")
		REFERENCES fincato_palmieri."Utente" ("NomeUtente")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD FOREIGN KEY ("ContenutoMultimediale")
		REFERENCES fincato_palmieri."ContenutoMultimediale" ("IdURL")
		ON UPDATE CASCADE
		ON DELETE CASCADE;

COMMENT ON TABLE fincato_palmieri."Visita"
	IS 'Tabella che contiene le visite effettuate dagli utenti guest e registrati ai contenuti multimediali';

-- Table: fincato_palmieri."Voto"

CREATE TABLE IF NOT EXISTS fincato_palmieri."Voto"
(
	"UtenteRegistrato" text,
	"ContenutoMultimediale" text,
	"Likert" LikertDomain NOT NULL,
	PRIMARY KEY ("UtenteRegistrato", "ContenutoMultimediale")
);

ALTER TABLE IF EXISTS fincato_palmieri."Voto"
	ADD FOREIGN KEY ("UtenteRegistrato")
		REFERENCES fincato_palmieri."Registrato" ("Username")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD FOREIGN KEY ("ContenutoMultimediale")
		REFERENCES fincato_palmieri."ContenutoMultimediale" ("IdURL")
		ON UPDATE CASCADE
		ON DELETE CASCADE;

COMMENT ON TABLE fincato_palmieri."Voto"
	IS 'Tabella che contiene i voti lasciati dagli utenti registrati ai contenuti multimediali';

-- Table: fincato_palmieri."Live"

CREATE TABLE IF NOT EXISTS fincato_palmieri."Live"
(
	"IdLive" text PRIMARY KEY,
	"DataInizio" timestamp with time zone NOT NULL,
	"DataFine" timestamp with time zone NOT NULL,
	"Premium" boolean NOT NULL
);

ALTER TABLE IF EXISTS fincato_palmieri."Live"
	ADD FOREIGN KEY ("IdLive")
		REFERENCES fincato_palmieri."ContenutoMultimediale" ("IdURL")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD CHECK ("DataFine" > "DataInizio") ;

COMMENT ON TABLE fincato_palmieri."Live"
	IS 'Tabella contenenti le informazioni dedicate ai contenuti multimediali di tipo live';

-- Table: fincato_palmieri."Live"

CREATE TABLE IF NOT EXISTS fincato_palmieri."Emoji"
(
	"Codice" text PRIMARY KEY,
	"Personalizzato" text DEFAULT NULL
);

ALTER TABLE IF EXISTS fincato_palmieri."Emoji"
	ADD FOREIGN KEY ("Personalizzato")
		REFERENCES fincato_palmieri."Canale" ("StreamerProprietario")
		ON UPDATE CASCADE
		ON DELETE CASCADE
	ADD CHECK ("Codice" <> '');

COMMENT ON TABLE fincato_palmieri."Emoji"
	IS 'Tabella contenente le emoji consentite nei commenti delle live';

-- Table: fincato_palmieri."Interazione"

CREATE TABLE IF NOT EXISTS fincato_palmieri."Interazione"
(
	"Spettatore" text,
	"LiveCorrente" text,
	"IntTimestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
	"Tipologia" InterazioneDomain NOT NULL,
	"Messaggio" text,
	PRIMARY KEY ("Spettatore", "LiveCorrente", "IntTimestamp")
);

ALTER TABLE IF EXISTS fincato_palmieri."Interazione"
	ADD FOREIGN KEY ("LiveCorrente")
		REFERENCES fincato_palmieri."Live" ("IdLive")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD FOREIGN KEY ("Spettatore")
		REFERENCES fincato_palmieri."Registrato" ("Username")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	-- Vincolo che l'interazione debba rispettare il seguente check altrimenti si perde il senso
	ADD CHECK (("Tipologia" = 'commento' AND "Messaggio" IS NOT NULL AND "Messaggio" <> '') OR ("Tipologia" = 'reazione' AND "Messaggio" IS NULL));

COMMENT ON TABLE fincato_palmieri."Interazione"
	IS 'Tabella contenente le interazioni (commenti e reazioni) effettuate dagli utenti registrati verso le live';

-- Table: fincato_palmieri."Presenza"

CREATE TABLE IF NOT EXISTS fincato_palmieri."Presenza"
(
	"SpettatoreLive" text,
	"LiveAssociata" text,
	"TimestampInt" timestamp with time zone,
	"CodiceEmoji" text,
	PRIMARY KEY ("SpettatoreLive", "LiveAssociata", "TimestampInt", "CodiceEmoji")
);

ALTER TABLE IF EXISTS fincato_palmieri."Presenza"
	ADD FOREIGN KEY ("CodiceEmoji")
		REFERENCES fincato_palmieri."Emoji" ("Codice")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD FOREIGN KEY ("SpettatoreLive", "LiveAssociata", "TimestampInt")
		REFERENCES fincato_palmieri."Interazione" ("Spettatore", "LiveCorrente", "IntTimestamp")
		ON UPDATE CASCADE
		ON DELETE CASCADE;

COMMENT ON TABLE fincato_palmieri."Presenza"
	IS 'Tabella "ponte" per permettere ai commenti e reazioni di avere emoji';

-- Table: fincato_palmieri."Affluenza"

CREATE TABLE IF NOT EXISTS fincato_palmieri."Affluenza"
(
	"Live" text,
	"TimestampAffluenza" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
	"NumeroSpettatori" integer NOT NULL,
	PRIMARY KEY ("Live", "TimestampAffluenza")
);

ALTER TABLE IF EXISTS fincato_palmieri."Affluenza"
	ADD FOREIGN KEY ("Live")
		REFERENCES fincato_palmieri."Live" ("IdLive")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	-- Vincolo per garantire che il numero di spettatori di un certo momento della live sia un numero non negativo
	ADD CHECK ("NumeroSpettatori" >= 0);

COMMENT ON TABLE fincato_palmieri."Affluenza"
	IS 'Tabella contenente l''affluenza di una specifica istantanea della live';

-- Table: fincato_palmieri."Video"

CREATE TABLE IF NOT EXISTS fincato_palmieri."Video"
(
	"IdVideo" text PRIMARY KEY,
	"Durata" integer NOT NULL,
	"Live" text NOT NULL UNIQUE
);

ALTER TABLE IF EXISTS fincato_palmieri."Video"
	ADD FOREIGN KEY ("IdVideo")
		REFERENCES fincato_palmieri."ContenutoMultimediale" ("IdURL")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD FOREIGN KEY ("Live")
		REFERENCES fincato_palmieri."Live" ("IdLive")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD CHECK ("Durata" > 0);

COMMENT ON TABLE fincato_palmieri."Video"
	IS 'Tabella contenente le live passate sottoforma di video';

-- Table: fincato_palmieri."Clip"

CREATE TABLE IF NOT EXISTS fincato_palmieri."Clip"
(
	"IdClip" text PRIMARY KEY,
	"Durata" integer NOT NULL,
	"Minutaggio" integer NOT NULL,
	"Video" text NOT NULL
);

ALTER TABLE IF EXISTS fincato_palmieri."Clip"
	ADD FOREIGN KEY ("Video")
		REFERENCES fincato_palmieri."Video" ("IdVideo")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	-- Vincolo per assicurare che il valore della durata della clip sia positiva
	ADD CHECK ("Durata" > 0),
	ADD CHECK ("Minutaggio" > 0);

COMMENT ON TABLE fincato_palmieri."Clip"
	IS 'Tabella che contiene le clip, ovvero estratti di durata inferiore al video originale';
