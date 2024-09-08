DROP TABLE IF EXISTS "Clip";
DROP TABLE IF EXISTS "Video";
DROP TABLE IF EXISTS "Affluenza";
DROP TABLE IF EXISTS "Presenza";
DROP TABLE IF EXISTS "Emoji";
DROP TABLE IF EXISTS "Interazione";
DROP TABLE IF EXISTS "Live";
DROP TABLE IF EXISTS "Voto";
DROP TABLE IF EXISTS "Visita";
DROP TABLE IF EXISTS "Associazione";
DROP TABLE IF EXISTS "ContenutoMultimediale";
DROP TABLE IF EXISTS "Categoria";
DROP TABLE IF EXISTS "Hashtag";
DROP TABLE IF EXISTS "Subscription";
DROP TABLE IF EXISTS "Follower";
DROP TABLE IF EXISTS "Donazione";
DROP TABLE IF EXISTS "LinkSocial";
DROP TABLE IF EXISTS "Programmazione";
DROP TABLE IF EXISTS "Canale";
DROP TABLE IF EXISTS "Rinnovo";
DROP TABLE IF EXISTS "Amministratore";
DROP TABLE IF EXISTS "Provider";
DROP TABLE IF EXISTS "Portafoglio";
DROP TABLE IF EXISTS "Messaggio";
DROP TABLE IF EXISTS "Registrato";
DROP TABLE IF EXISTS "Utente";
DROP SEQUENCE IF EXISTS guest_sequence;
DROP SEQUENCE IF EXISTS url_sequence;
DROP DOMAIN IF EXISTS LikertDomain;
DROP DOMAIN IF EXISTS InterazioneDomain;

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

-- Table: "Utente"

CREATE TABLE IF NOT EXISTS "Utente"
(
    "NomeUtente" text PRIMARY KEY DEFAULT ('guest_' || nextval('guest_sequence'))
);

ALTER TABLE IF EXISTS "Utente"
	ADD CHECK ("NomeUtente" <> '' AND length("NomeUtente") > 3 AND length("NomeUtente") < 20);

COMMENT ON TABLE "Utente"
	IS 'Lista username degli utenti guest e registrati';

-- Table: "Registrato"

CREATE TABLE IF NOT EXISTS "Registrato"
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

ALTER TABLE IF EXISTS "Registrato"
	ADD CONSTRAINT "Registrato_fkey" FOREIGN KEY ("Username")
        REFERENCES "Utente" ("NomeUtente")
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

COMMENT ON TABLE "Registrato"
    IS 'Tabella contenente gli utenti registrato, sia spettatori e streamer';

-- Table: "Messaggio"

CREATE TABLE IF NOT EXISTS "Messaggio"
(
	"Mittente" text NOT NULL,
	"TimestampMessaggio" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
	"Destinatario" text NOT NULL,
	"Testo" text NOT NULL,
	PRIMARY KEY ("Mittente", "TimestampMessaggio")
);

ALTER TABLE IF EXISTS "Messaggio"
	ADD FOREIGN KEY ("Mittente")
		REFERENCES "Registrato" ("Username")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD FOREIGN KEY ("Destinatario")
		REFERENCES "Registrato" ("Username")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	-- Check per garantire che il testo del messaggio inviato non sia vuoto
	ADD CHECK ("Testo" <> '' AND length("Testo") < 200),
	-- Check per garantire che il mittente e destinatario del messaggio inviato non sia lo stesso
	ADD CHECK ("Mittente" <> "Destinatario");

COMMENT ON TABLE "Messaggio"
	IS 'Tabella contenente i messaggi privati inviati tra utenti registrati';

-- Table: "Portafoglio"

CREATE TABLE IF NOT EXISTS "Portafoglio"
(
	"UtenteProprietario" text PRIMARY KEY,
	"TotaleBits" integer NOT NULL DEFAULT 0
);

ALTER TABLE IF EXISTS "Portafoglio"
	ADD FOREIGN KEY ("UtenteProprietario")
		REFERENCES "Registrato" ("Username")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	-- Vincolo per garantire che il totale dei bits (il bilancio) non sia negativo
	ADD CHECK ("TotaleBits" >= 0);

COMMENT ON TABLE "Portafoglio"
	IS 'Tabella contenente i portafogli privati degli utenti registrati';

-- Table: "Provider"

CREATE TABLE IF NOT EXISTS "Provider"
(
	"NomeProvider" text PRIMARY KEY
);

ALTER TABLE IF EXISTS "Provider"
	-- Vincolo per garantire che il nome del provider non sia vuoto
	ADD CHECK ("NomeProvider" <> '' AND length("NomeProvider") < 15);

COMMENT ON TABLE "Provider"
	IS 'Tabella contenente i provider disponibili per ospitare i contenuti multimediali creati dagli streamer sotto gestione degli amministratori';

-- Table: "Amministratore"

CREATE TABLE IF NOT EXISTS "Amministratore"
(
	"CodiceAdmin" integer PRIMARY KEY,
	"Nome" text NOT NULL,
	"Cognome" text NOT NULL,
	UNIQUE ("Nome", "Cognome")
);

ALTER TABLE IF EXISTS "Amministratore"
	ADD CHECK ("Cognome" <> '' AND length("Cognome") > 3 AND length("Cognome") < 20),
	ADD CHECK ("Nome" <> '' AND length("Nome") > 3 AND length("Nome") < 20);

COMMENT ON TABLE "Amministratore"
	IS 'Tabella contenente gli amministratori delle pagine che hanno il ruolo di gestire i contenuti multimediali dei canali assegnati nei server del provider a cui ha pagato';

-- Table: "Rinnovo"

CREATE TABLE IF NOT EXISTS "Rinnovo"
(
	"Amministratore" integer,
	"Provider" text,
	"DataScadenza" date NOT NULL,
	PRIMARY KEY ("Amministratore", "Provider")
);

ALTER TABLE IF EXISTS "Rinnovo"
	ADD FOREIGN KEY ("Amministratore")
		REFERENCES "Amministratore" ("CodiceAdmin")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD FOREIGN KEY ("Provider")
		REFERENCES "Provider" ("NomeProvider")
		ON UPDATE CASCADE
		ON DELETE CASCADE;

COMMENT ON TABLE "Rinnovo"
	IS 'Tabella che contiene i rinnovi effettuati dagli amministratori per poter continuare a gestire i contenuti multimediali con il provider';

-- Table: "Canale"

CREATE TABLE IF NOT EXISTS "Canale"
(
	"StreamerProprietario" text PRIMARY KEY,
	"AdminCanale" integer NOT NULL,
	"HostingProvider" text NOT NULL,
	"Descrizione" text,
	"ImmagineProfilo" text,
	"Trailer" text
);

ALTER TABLE IF EXISTS "Canale"
	ADD FOREIGN KEY ("StreamerProprietario")
		REFERENCES "Registrato" ("Username")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD FOREIGN KEY ("AdminCanale")
		REFERENCES "Amministratore" ("CodiceAdmin")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD FOREIGN KEY ("HostingProvider")
		REFERENCES "Provider" ("NomeProvider")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD CHECK ("Descrizione" IS NULL OR "Descrizione" <> ''),
	ADD CHECK ("ImmagineProfilo" IS NULL OR "ImmagineProfilo" <> ''),
	ADD CHECK ("Trailer" IS NULL OR "Trailer"  <> '');

COMMENT ON TABLE "Canale"
	IS 'Tabella contenenti i canali creati e gestiti dagli utenti registrati che vogliono pubblicare contenuti multimediali';

-- Table: "Programmazione"

CREATE TABLE IF NOT EXISTS "Programmazione"
(
	"Streamer" text NOT NULL,
	"ProgTimestamp" timestamp with time zone NOT NULL,
	"Titolo" text NOT NULL,
	"LIS" boolean NOT NULL DEFAULT false,
	"Premium" boolean NOT NULL DEFAULT false,
	PRIMARY KEY ("Streamer", "ProgTimestamp")
);

ALTER TABLE IF EXISTS "Programmazione"
	ADD FOREIGN KEY ("Streamer")
		REFERENCES "Canale" ("StreamerProprietario")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD CHECK ("Titolo" <> '');

COMMENT ON TABLE "Programmazione"
	IS 'Tabelle contenenti le programmazioni di live prefissate dallo streamer';

-- Table: "LinkSocial";

CREATE TABLE IF NOT EXISTS "LinkSocial"
(
	"CanaleAssociato" text NOT NULL,
	"Social" text NOT NULL,
	"LinkProfilo" text NOT NULL,
	PRIMARY KEY ("CanaleAssociato", "Social")
);

ALTER TABLE IF EXISTS "LinkSocial"
	ADD FOREIGN KEY ("CanaleAssociato")
		REFERENCES "Canale" ("StreamerProprietario")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	-- Validazione tramite regex il link URL del social
	-- 		ex.		https://www.asd.google.com/search?q=some+text&param=3#dfsd,
	-- 				https://www.google.com
	-- 				http://google.com/?q=some+text&param=3#dfsdf
	-- 				https://www.google.com/api/?
	-- 				https://www.google.com/api/login.php
	ADD CHECK ("LinkProfilo" ~ '^https?:\/\/(www\.)?([-\w@:%._\+~#=]{2,}\.[a-z]{2,6})+(\/[\/\w\.-]*)*(\?\w+=.+)*$');

COMMENT ON TABLE "LinkSocial"
	IS 'Tabella contenenti i link social del canale';

-- Table: "Donazione"

CREATE TABLE IF NOT EXISTS "Donazione"
(
	"ProprietarioPortafoglio" text NOT NULL,
	"CanaleStreamer" text NOT NULL,
	"Timestamp" timestamp with time zone NOT NULL,
	"Bits" integer NOT NULL DEFAULT 1,
	PRIMARY KEY ("ProprietarioPortafoglio", "Timestamp")
);

ALTER TABLE IF EXISTS "Donazione"
	ADD FOREIGN KEY ("ProprietarioPortafoglio")
		REFERENCES "Portafoglio" ("UtenteProprietario")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD FOREIGN KEY ("CanaleStreamer")
		REFERENCES "Canale" ("StreamerProprietario")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	-- Vincolo per garantire che il numero di bits da donare non sia negativo o zero
	ADD CHECK ("Bits" > 0);

COMMENT ON TABLE "Donazione"
	IS 'Tabella che contiene le donazioni effettuate da utente registrato a utente streamer (utente registrato che gestisce un canale)';

-- Table: "Follower"

CREATE TABLE IF NOT EXISTS "Follower"
(
	"UtenteFollower" text NOT NULL,
	"StreamerSeguito" text NOT NULL,
	PRIMARY KEY ("UtenteFollower", "StreamerSeguito")
);

ALTER TABLE IF EXISTS "Follower"
	ADD FOREIGN KEY ("StreamerSeguito")
		REFERENCES "Canale" ("StreamerProprietario")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD FOREIGN KEY ("UtenteFollower")
		REFERENCES "Registrato" ("Username")
		ON UPDATE CASCADE
		ON DELETE CASCADE;

COMMENT ON TABLE "Follower"
	IS 'Tabella che contiene le iscrizioni degli utenti registrati ai canali per avere le notifiche delle programmazioni delle live';

-- Table: "Subscription"

CREATE TABLE IF NOT EXISTS "Subscription"
(
	"UtenteAbbonato" text NOT NULL,
	"Streamer" text NOT NULL,
	PRIMARY KEY ("UtenteAbbonato", "Streamer")
);

ALTER TABLE IF EXISTS "Subscription"
	ADD FOREIGN KEY ("Streamer")
		REFERENCES "Canale" ("StreamerProprietario")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD FOREIGN KEY ("UtenteAbbonato")
		REFERENCES "Registrato" ("Username")
		ON UPDATE CASCADE
		ON DELETE CASCADE;

COMMENT ON TABLE "Subscription"
	IS 'Tabella che contiene gli abbonamenti degli utenti registrati ai canali per poter seguire anche i contenuti multimediali esclusivi ai soli abbonati';

-- Table: "Categoria"

CREATE TABLE IF NOT EXISTS "Categoria"
(
	"NomeCategoria" text PRIMARY KEY
);

ALTER TABLE IF EXISTS "Categoria"
	ADD CHECK ("NomeCategoria" <> '');

COMMENT ON TABLE "Categoria"
	IS 'Tabella contenente le categorie per poter filtrare i contenuti multimediale';

-- Table: "Hashtag"

CREATE TABLE IF NOT EXISTS "Hashtag"
(
	"NomeHashtag" text PRIMARY KEY
);

ALTER TABLE IF EXISTS "Hashtag"
	ADD CHECK ("NomeHashtag" <> '');

COMMENT ON TABLE "Hashtag"
	IS 'Tabella contenente gli hashtag per poter filtrare i contenuti multimediale';

-- Table: "ContenutoMultimediale"

CREATE TABLE IF NOT EXISTS "ContenutoMultimediale"
(
	"IdURL" text PRIMARY KEY DEFAULT ('url' || nextval('url_sequence')),
	"Canale" text NOT NULL,
	"Titolo" text NOT NULL,
	"Categoria" text NOT NULL,
	"LIS" boolean NOT NULL DEFAULT false,
	"Premium" boolean NOT NULL DEFAULT false
);

ALTER TABLE IF EXISTS "ContenutoMultimediale"
	ADD FOREIGN KEY ("Canale")
		REFERENCES "Canale" ("StreamerProprietario")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD FOREIGN KEY ("Categoria")
		REFERENCES "Categoria" ("NomeCategoria")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD CHECK ("IdURL" ~ '^url\d+$'),
	-- Vincolo che impedisce di impostare il titolo del contenuto mutimediale di qualsiasi tipo in una stringa vuota
	ADD CHECK ("Titolo" <> '');

COMMENT ON TABLE "ContenutoMultimediale"
	IS 'Tabella che contiene i valori comuni di diversi tipi di contenuti multimediali (LIVE, VIDEO e CLIP)';

-- Table: "Associazione"

CREATE TABLE IF NOT EXISTS "Associazione"
(
	"Hashtag" text,
	"ContenutoMultimediale" text,
	PRIMARY KEY ("Hashtag", "ContenutoMultimediale")
);

ALTER TABLE IF EXISTS "Associazione"
	ADD FOREIGN KEY ("Hashtag")
		REFERENCES "Hashtag" ("NomeHashtag")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD FOREIGN KEY ("ContenutoMultimediale")
		REFERENCES "ContenutoMultimediale" ("IdURL")
		ON UPDATE CASCADE
		ON DELETE CASCADE;

COMMENT ON TABLE "Associazione"
	IS 'Tabella che contiene le associazioni create dagli utenti streamer ai propri contenuti multimediali';

-- Table: "Visita"

CREATE TABLE IF NOT EXISTS "Visita"
(
	"Utente" text,
	"ContenutoMultimediale" text,
	PRIMARY KEY ("Utente", "ContenutoMultimediale")
);

ALTER TABLE IF EXISTS "Visita"
	ADD FOREIGN KEY ("Utente")
		REFERENCES "Utente" ("NomeUtente")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD FOREIGN KEY ("ContenutoMultimediale")
		REFERENCES "ContenutoMultimediale" ("IdURL")
		ON UPDATE CASCADE
		ON DELETE CASCADE;

COMMENT ON TABLE "Visita"
	IS 'Tabella che contiene le visite effettuate dagli utenti guest e registrati ai contenuti multimediali';

-- Table: "Voto"

CREATE TABLE IF NOT EXISTS "Voto"
(
	"UtenteRegistrato" text,
	"ContenutoMultimediale" text,
	"Likert" LikertDomain NOT NULL,
	PRIMARY KEY ("UtenteRegistrato", "ContenutoMultimediale")
);

ALTER TABLE IF EXISTS "Voto"
	ADD FOREIGN KEY ("UtenteRegistrato")
		REFERENCES "Registrato" ("Username")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD FOREIGN KEY ("ContenutoMultimediale")
		REFERENCES "ContenutoMultimediale" ("IdURL")
		ON UPDATE CASCADE
		ON DELETE CASCADE;

COMMENT ON TABLE "Voto"
	IS 'Tabella che contiene i voti lasciati dagli utenti registrati ai contenuti multimediali';

-- Table: "Live"

CREATE TABLE IF NOT EXISTS "Live"
(
	"IdLive" text PRIMARY KEY,
	"DataInizio" timestamp with time zone NOT NULL,
	"DataFine" timestamp with time zone NOT NULL
);

ALTER TABLE IF EXISTS "Live"
	ADD FOREIGN KEY ("IdLive")
		REFERENCES "ContenutoMultimediale" ("IdURL")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD CHECK ("DataFine" > "DataInizio") ;

COMMENT ON TABLE "Live"
	IS 'Tabella contenenti le informazioni dedicate ai contenuti multimediali di tipo live';

-- Table: "Live"

CREATE TABLE IF NOT EXISTS "Emoji"
(
	"Codice" text PRIMARY KEY,
	"Personalizzato" text DEFAULT NULL
);

ALTER TABLE IF EXISTS "Emoji"
	ADD FOREIGN KEY ("Personalizzato")
		REFERENCES "Canale" ("StreamerProprietario")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD CHECK ("Codice" <> '');

COMMENT ON TABLE "Emoji"
	IS 'Tabella contenente le emoji consentite nei commenti delle live';

-- Table: "Interazione"

CREATE TABLE IF NOT EXISTS "Interazione"
(
	"Spettatore" text,
	"LiveCorrente" text,
	"IntTimestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
	"Tipologia" InterazioneDomain NOT NULL,
	"Messaggio" text,
	PRIMARY KEY ("Spettatore", "LiveCorrente", "IntTimestamp")
);

ALTER TABLE IF EXISTS "Interazione"
	ADD FOREIGN KEY ("LiveCorrente")
		REFERENCES "Live" ("IdLive")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD FOREIGN KEY ("Spettatore")
		REFERENCES "Registrato" ("Username")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	-- Vincolo che l'interazione debba rispettare il seguente check altrimenti si perde il senso
	ADD CHECK (("Tipologia" = 'commento' AND "Messaggio" IS NOT NULL AND "Messaggio" <> '') OR ("Tipologia" = 'reazione' AND "Messaggio" IS NULL));

COMMENT ON TABLE "Interazione"
	IS 'Tabella contenente le interazioni (commenti e reazioni) effettuate dagli utenti registrati verso le live';

-- Table: "Presenza"

CREATE TABLE IF NOT EXISTS "Presenza"
(
	"SpettatoreLive" text,
	"LiveAssociata" text,
	"TimestampInt" timestamp with time zone,
	"CodiceEmoji" text,
	PRIMARY KEY ("SpettatoreLive", "LiveAssociata", "TimestampInt", "CodiceEmoji")
);

ALTER TABLE IF EXISTS "Presenza"
	ADD FOREIGN KEY ("CodiceEmoji")
		REFERENCES "Emoji" ("Codice")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD FOREIGN KEY ("SpettatoreLive", "LiveAssociata", "TimestampInt")
		REFERENCES "Interazione" ("Spettatore", "LiveCorrente", "IntTimestamp")
		ON UPDATE CASCADE
		ON DELETE CASCADE;

COMMENT ON TABLE "Presenza"
	IS 'Tabella "ponte" per permettere ai commenti e reazioni di avere emoji';

-- Table: "Affluenza"

CREATE TABLE IF NOT EXISTS "Affluenza"
(
	"Live" text,
	"TimestampAffluenza" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
	"NumeroSpettatori" integer NOT NULL,
	PRIMARY KEY ("Live", "TimestampAffluenza")
);

ALTER TABLE IF EXISTS "Affluenza"
	ADD FOREIGN KEY ("Live")
		REFERENCES "Live" ("IdLive")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	-- Vincolo per garantire che il numero di spettatori di un certo momento della live sia un numero non negativo
	ADD CHECK ("NumeroSpettatori" >= 0);

COMMENT ON TABLE "Affluenza"
	IS 'Tabella contenente l''affluenza di una specifica istantanea della live';

-- Table: "Video"

CREATE TABLE IF NOT EXISTS "Video"
(
	"IdVideo" text PRIMARY KEY,
	"Durata" integer NOT NULL,
	"Live" text NOT NULL UNIQUE
);

ALTER TABLE IF EXISTS "Video"
	ADD FOREIGN KEY ("IdVideo")
		REFERENCES "ContenutoMultimediale" ("IdURL")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD FOREIGN KEY ("Live")
		REFERENCES "Live" ("IdLive")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD CHECK ("Durata" > 0);

COMMENT ON TABLE "Video"
	IS 'Tabella contenente le live passate sottoforma di video';

-- Table: "Clip"

CREATE TABLE IF NOT EXISTS "Clip"
(
	"IdClip" text PRIMARY KEY,
	"Durata" integer NOT NULL,
	"Minutaggio" integer NOT NULL,
	"Video" text NOT NULL
);

ALTER TABLE IF EXISTS "Clip"
	ADD FOREIGN KEY ("Video")
		REFERENCES "Video" ("IdVideo")
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	-- Vincolo per assicurare che il valore della durata della clip sia positiva
	ADD CHECK ("Durata" > 0),
	ADD CHECK ("Minutaggio" > 0);

COMMENT ON TABLE "Clip"
	IS 'Tabella che contiene le clip, ovvero estratti di durata inferiore al video originale';
