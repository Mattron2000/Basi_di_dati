# DDL

- [DDL](#ddl)
  - [Database](#database)
  - [Schema](#schema)
  - [Setup DDL](#setup-ddl)
  - [Tabelle](#tabelle)
	- [UTENTE](#utente)
	- [REGISTRATO](#registrato)
	- [MESSAGGIO](#messaggio)
	- [PORTAFOGLIO](#portafoglio)
	- [PROVIDER](#provider)
	- [ADMIN](#admin)
	- [RINNOVO](#rinnovo)
	- [CANALE](#canale)
	- [PROGRAMMAZIONE](#programmazione)
	- [LINK SOCIAL](#link-social)
	- [DONAZIONE](#donazione)
	- [FOLLOWER](#follower)
	- [ABBONAMENTO](#abbonamento)
	- [CATEGORIA](#categoria)
	- [HASHTAG](#hashtag)
	- [CONTENUTO MULTIMEDIALE](#contenuto-multimediale)
	- [VISITA](#visita)
	- [VOTO](#voto)
	- [LIVE](#live)
	- [EMOJI](#emoji)
	- [COMMENTO](#commento)
	- [REAZIONE](#reazione)
	- [AFFLUENZA](#affluenza)
	- [VIDEO](#video)
	- [CLIP](#clip)

## Database

```sql
-- Database: My Twitch

-- DROP DATABASE IF EXISTS "My Twitch";

CREATE DATABASE "My Twitch"
	WITH
	OWNER = postgres
	ENCODING = 'UTF8'
	LC_COLLATE = 'Italian_Italy.1252'
	LC_CTYPE = 'Italian_Italy.1252'
	LOCALE_PROVIDER = 'libc'
	TABLESPACE = pg_default
	CONNECTION LIMIT = -1
	IS_TEMPLATE = False;

COMMENT ON DATABASE "My Twitch"
	IS 'Progetto d''esame di Basi di Dati 2023-2024 di Fincato Andrea e Palmieri Matteo';
```

## Schema

```sql
CREATE SCHEMA "fincato_palmieri"
	AUTHORIZATION postgres;
```

## Setup DDL

Scrivo il codice DDL di PostgreSQL in 4 sezioni:

1. il `CREATE TABLE`, dove crei una struttura dei dati.
2. i vincoli `UNIQUE` (se richieste).
3. le `FOREIGN KEY` (se richieste).
4. i `CHECK` che assicurino l'integritá dei dati (se richieste).
5. i `TRIGGER` (se richieste).

## Tabelle

### UTENTE

```sql
-- Sezione 1: Creazione della Tabella UTENTE
CREATE TABLE IF NOT EXISTS fincato_palmieri."UTENTE"
(
	nome_utente text PRIMARY KEY
);

-- Sezione 2: Vincoli UNIQUE e FOREIGN KEY
-- Non sono necessari vincoli UNIQUE o FOREIGN KEY aggiuntivi per questa tabella
-- perché nome_utente è già una chiave primaria e unica.

-- Sezione 3: Aggiunta di vincoli CHECK
-- Vincolo per garantire che nome_utente non sia una stringa vuota
ALTER TABLE IF EXISTS fincato_palmieri."UTENTE"
	ADD CONSTRAINT check_nome_utente_non_vuoto CHECK (nome_utente <> '') NOT VALID,
	OWNER to postgres;

COMMENT ON TABLE fincato_palmieri."UTENTE"
	IS 'Lista username degli utenti guest e registrati';
```

### REGISTRATO

```sql
-- Sezione 1: Creazione della Tabella REGISTRATO
CREATE TABLE IF NOT EXISTS fincato_palmieri."REGISTRATO"
(
	nome_utente text PRIMARY KEY,
	numero_di_telefono text,
	data_di_nascita date NOT NULL,
	premium boolean NOT NULL DEFAULT false,
	indirizzo_email text,
	affiliato boolean,
	password text NOT NULL,
	lis boolean NOT NULL DEFAULT false,
	data_di_registrazione timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Sezione 2: Vincoli UNIQUE e FOREIGN KEY
-- é necessario il vincoli FOREIGN KEY per questa tabella perché nome_utente deve coincidere con nome_utente della tabella UTENTE.
ALTER TABLE IF EXISTS fincato_palmieri."REGISTRATO"
	ADD CONSTRAINT "REGISTRATO_nome_utente_fkey" FOREIGN KEY (nome_utente)
		REFERENCES fincato_palmieri."UTENTE" (nome_utente) MATCH SIMPLE
		ON UPDATE CASCADE
		ON DELETE CASCADE;

-- Sezione 3: Aggiunta di vincoli CHECK
ALTER TABLE IF EXISTS fincato_palmieri."REGISTRATO"
	ADD CONSTRAINT check_eta_minima CHECK (data_di_nascita <= (CURRENT_DATE - '13 years'::interval)) NOT VALID, -- Vincolo per garantire che l'etá minima imposta dalla UE sia rispettata
	ADD CONSTRAINT check_indirizzo_email CHECK (indirizzo_email IS NULL OR indirizzo_email ~* '^\w+(\.\w+)*(\+\w+)?@\w{2,}(\.\w{2,})*$'::text) NOT VALID, -- validazione tramite regex della email (supporta gli alias)
	ADD CONSTRAINT check_lunghezza_password_minima CHECK (length(password) >= 8) NOT VALID, -- lunghezza minima richiesta per una password forte un minimo sindacale
	ADD CONSTRAINT check_numero_di_telefono CHECK (numero_di_telefono IS NULL OR numero_di_telefono ~ '^(\+\d{1,3}( |-)?)?(\d{10}|(\d{3} \d{3} \d{4})|(\d{3}-\d{3}-\d{4}))$'::text) NOT VALID; -- validazione tramite regex dei numeri di telefono con prefisso internazionale (1234567890, 123 456 7890, 123-456-7890, +441234567890, +44 1234567890, +44 123 456 7890, +44-123-456-7890)

ALTER TABLE IF EXISTS fincato_palmieri."REGISTRATO"
	OWNER to postgres;

COMMENT ON TABLE fincato_palmieri."REGISTRATO"
	IS 'Tabella contenente gli utenti registrato, sia spettatori e streamer';
```

### MESSAGGIO

```sql
-- Sezione 1: Creazione della Tabella REGISTRATO
CREATE TABLE fincato_palmieri."MESSAGGIO"
(
	mittente text NOT NULL,
	"timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
	testo text NOT NULL,
	destinatario text NOT NULL,
	PRIMARY KEY (mittente, "timestamp")
);

-- Sezione 2: Vincoli UNIQUE e FOREIGN KEY
-- sono necessari i vincoli FOREIGN KEY per questa tabella per mittente e destinatario del messaggio da coincidere con nome_utente della tabella REGISTRATO.
ALTER TABLE IF EXISTS fincato_palmieri."MESSAGGIO"
	ADD CONSTRAINT "MESSAGGIO_mittente_fkey"FOREIGN KEY (mittente)
		REFERENCES fincato_palmieri."REGISTRATO" (nome_utente) MATCH SIMPLE
		ON UPDATE CASCADE
		ON DELETE CASCADE
		NOT VALID,
	ADD CONSTRAINT "MESSAGGIO_destinatario_fkey" FOREIGN KEY (destinatario)
		REFERENCES fincato_palmieri."REGISTRATO" (nome_utente) MATCH SIMPLE
		ON UPDATE CASCADE
		ON DELETE CASCADE
		NOT VALID;

-- Sezione 3: Aggiunta di vincoli CHECK
-- Vincolo per garantire che il contenuto del testo del messaggio inviato non sia vuoto
ALTER TABLE IF EXISTS fincato_palmieri."REGISTRATO"
	ADD CONSTRAINT check_testo_non_vuoto CHECK (testo <> '') NOT VALID;

ALTER TABLE IF EXISTS fincato_palmieri."MESSAGGIO"
	OWNER to postgres;

COMMENT ON TABLE fincato_palmieri."MESSAGGIO"
	IS 'Tabella contenente i messaggi privati inviati tra utenti registrati';
```

### PORTAFOGLIO

```sql
-- Table: fincato_palmieri.PORTAFOGLIO

-- DROP TABLE IF EXISTS fincato_palmieri."PORTAFOGLIO";

-- Sezione 1: Creazione della Tabella PORTAFOGLIO
CREATE TABLE fincato_palmieri."PORTAFOGLIO"
(
	utente text PRIMARY KEY,
	totale_bits integer NOT NULL DEFAULT 0
);

-- Sezione 2: Vincoli UNIQUE e FOREIGN KEY
-- é necessario il vincolo FOREIGN KEY per questa tabella per utente del portafoglio da coincidere con nome_utente della tabella REGISTRATO.
ALTER TABLE IF EXISTS fincato_palmieri."PORTAFOGLIO"
	ADD CONSTRAINT "PORTAFOGLIO_utente_fkey" FOREIGN KEY (utente)
		REFERENCES fincato_palmieri."REGISTRATO" (nome_utente) MATCH SIMPLE
		ON UPDATE CASCADE
		ON DELETE CASCADE;

-- Sezione 3: Aggiunta di vincoli CHECK
-- Vincolo per garantire che il totale dei bits (il bilancio) non sia negativo
ALTER TABLE IF EXISTS fincato_palmieri."PORTAFOGLIO"
	ADD CONSTRAINT check_totale_bits_mai_negativo CHECK (totale_bits >= 0) NOT VALID;

ALTER TABLE IF EXISTS fincato_palmieri."PORTAFOGLIO"
	OWNER to postgres;

COMMENT ON TABLE fincato_palmieri."PORTAFOGLIO"
	IS 'Tabella contenente i portafogli privati degli utenti registrati';
```

### PROVIDER

```sql
-- Sezione 1: Creazione della Tabella PROVIDER
CREATE TABLE IF NOT EXISTS fincato_palmieri."PROVIDER"
(
	nome_provider text,
	CONSTRAINT "PROVIDER_pkey" PRIMARY KEY (nome_provider)
);

-- Sezione 2: Vincoli UNIQUE e FOREIGN KEY

-- Sezione 3: Aggiunta di vincoli CHECK
ALTER TABLE IF EXISTS fincato_palmieri."PROVIDER"
	ADD CONSTRAINT check_nome_provider CHECK (nome_provider <> ''::text) NOT VALID;

ALTER TABLE IF EXISTS fincato_palmieri."PROVIDER"
	OWNER to postgres;

COMMENT ON TABLE fincato_palmieri."PROVIDER"
	IS 'Tabella contenente i provider disponibili per ospitare i contenuti multimediali creati dagli streamer sotto gestione degli amministratori';
```

### ADMIN

```sql
-- Table: fincato_palmieri.ADMIN

-- DROP TABLE IF EXISTS fincato_palmieri."ADMIN";

-- Sezione 1: Creazione della Tabella ADMIN
CREATE TABLE IF NOT EXISTS fincato_palmieri."ADMIN"
(
	nome text NOT NULL,
	cognome text NOT NULL,
	codice integer NOT NULL,
	CONSTRAINT "ADMIN_pkey" PRIMARY KEY (codice)
);

-- Sezione 2: Vincoli UNIQUE e FOREIGN KEY
ALTER TABLE IF EXISTS fincato_palmieri."ADMIN"
	ADD CONSTRAINT "ADMIN_nome_cognome_key" UNIQUE (nome, cognome);

-- Sezione 3: Aggiunta di vincoli CHECK
ALTER TABLE IF EXISTS fincato_palmieri."ADMIN"
	ADD CONSTRAINT check_cognome CHECK (cognome <> ''::text AND length(cognome) > 3 AND length(cognome) < 20),
	ADD CONSTRAINT check_nome CHECK (nome <> ''::text AND length(nome) > 3 AND length(nome) < 20);

ALTER TABLE IF EXISTS fincato_palmieri."ADMIN"
	OWNER to postgres;

COMMENT ON TABLE fincato_palmieri."ADMIN"
	IS 'Tabella contenente gli amministratori delle pagine che hanno il ruolo di gestire i contenuti multimediali dei canali assegnati nei server del provider a cui ha pagato';
```

### RINNOVO

```sql
-- Sezione 1: Creazione della Tabella RINNOVO
CREATE TABLE IF NOT EXISTS fincato_palmieri."RINNOVO"
(
	provider text,
	admin integer,
	pagato boolean NOT NULL,
	scadenza date NOT NULL,
	CONSTRAINT "RINNOVO_pkey" PRIMARY KEY (provider, admin),
);

-- Sezione 2: Vincoli UNIQUE e FOREIGN KEY
ALTER TABLE IF EXISTS fincato_palmieri."RINNOVO"
	ADD CONSTRAINT "RINNOVO_provider_fkey" FOREIGN KEY (provider)
		REFERENCES fincato_palmieri."PROVIDER" (nome_provider) MATCH SIMPLE
		ON UPDATE CASCADE
		ON DELETE CASCADE
		NOT VALID,
	ADD CONSTRAINT "RINNOVO_admin_fkey" FOREIGN KEY (admin)
		REFERENCES fincato_palmieri."ADMIN" (codice) MATCH SIMPLE
		ON UPDATE CASCADE
		ON DELETE CASCADE
		NOT VALID;

-- Sezione 3: Aggiunta di vincoli CHECK

ALTER TABLE IF EXISTS fincato_palmieri."RINNOVO"
	OWNER to postgres;

COMMENT ON TABLE fincato_palmieri."RINNOVO"
	IS 'Tabella che contiene i rinnovi effettuati dagli amministratori per poter continuare a gestire i contenuti multimediali con il provider';
```

### CANALE

```sql
-- Sezione 1: Creazione della Tabella CANALE
CREATE TABLE fincato_palmieri."CANALE"
(
	streamer text PRIMARY KEY,
	descrizione text,
	immagine_profilo text,
	trailer text
	-- admin
	-- provider
);

-- Sezione 2: Vincoli UNIQUE e FOREIGN KEY
-- é necessario il vincolo FOREIGN KEY per questa tabella per streamer del canale da coincidere con nome_utente della tabella REGISTRATO.
ALTER TABLE IF EXISTS fincato_palmieri."CANALE"
	ADD CONSTRAINT "PORTAFOGLIO_utente_fkey" FOREIGN KEY (streamer)
		REFERENCES fincato_palmieri."REGISTRATO" (nome_utente) MATCH SIMPLE
		ON UPDATE CASCADE
		ON DELETE CASCADE
		NOT VALID;

-- Sezione 3: Aggiunta di vincoli CHECK
-- Vincolo per garantire che il totale dei bits (il bilancio) non sia negativo
ALTER TABLE IF EXISTS fincato_palmieri."CANALE"
	ADD CONSTRAINT check_descrizione_null_o_non_vuoto CHECK (descrizione IS NULL OR descrizione <> '') NOT VALID,
	ADD CONSTRAINT check_immagine_profilo_null_o_non_vuoto CHECK (immagine_profilo IS NULL OR immagine_profilo <> '') NOT VALID,
	ADD CONSTRAINT check_trailer_null_o_non_vuoto CHECK (trailer IS NULL OR trailer  <> '') NOT VALID;

ALTER TABLE IF EXISTS fincato_palmieri."CANALE"
	OWNER to postgres;

COMMENT ON TABLE fincato_palmieri."CANALE"
	IS 'Tabella contenenti i Canali creati e gestiti dagli utenti registrati che vogliono pubblicare contenuti multimediali';

--

-- Sezione 1: Creazione della Tabella CANALE
CREATE TABLE IF NOT EXISTS fincato_palmieri."CANALE"
(
	streamer text PRIMARY KEY,
	descrizione text,
	immagine_profilo text,
	trailer text,
	admin integer NOT NULL,
	provider text NOT NULL
);

-- Sezione 2: Vincoli UNIQUE e FOREIGN KEY
ALTER TABLE IF EXISTS fincato_palmieri."CANALE"
	ADD CONSTRAINT "CANALE_admin_fkey" FOREIGN KEY (admin)
		REFERENCES fincato_palmieri."ADMIN" (codice) MATCH SIMPLE
		ON UPDATE CASCADE
		ON DELETE CASCADE
		NOT VALID,
	ADD CONSTRAINT "CANALE_provider_fkey" FOREIGN KEY (provider)
		REFERENCES fincato_palmieri."PROVIDER" (nome_provider) MATCH SIMPLE
		ON UPDATE CASCADE
		ON DELETE CASCADE
		NOT VALID,
	ADD CONSTRAINT "CANALE_streamer_fkey" FOREIGN KEY (streamer)
		REFERENCES fincato_palmieri."REGISTRATO" (nome_utente) MATCH SIMPLE
		ON UPDATE CASCADE
		ON DELETE CASCADE
		NOT VALID;

-- Sezione 3: Aggiunta di vincoli CHECK
ALTER TABLE IF EXISTS fincato_palmieri."CANALE"
	ADD CONSTRAINT check_descrizione_null_o_non_vuoto CHECK (descrizione IS NULL OR descrizione <> '') NOT VALID,
	ADD CONSTRAINT check_immagine_profilo_null_o_non_vuoto CHECK (immagine_profilo IS NULL OR immagine_profilo <> '') NOT VALID,
	ADD CONSTRAINT check_trailer_null_o_non_vuoto CHECK (trailer IS NULL OR trailer  <> '') NOT VALID;

ALTER TABLE IF EXISTS fincato_palmieri."CANALE"
	OWNER to postgres;

COMMENT ON TABLE fincato_palmieri."CANALE"
	IS 'Tabella contenenti i canali creati e gestiti dagli utenti registrati che vogliono pubblicare contenuti multimediali';
```

### PROGRAMMAZIONE

```sql
-- Table: fincato_palmieri.PROGRAMMAZIONE

-- DROP TABLE IF EXISTS fincato_palmieri."PROGRAMMAZIONE";

-- Sezione 1: Creazione della Tabella PROGRAMMAZIONE
CREATE TABLE IF NOT EXISTS fincato_palmieri."PROGRAMMAZIONE"
(
	canale text NOT NULL,
	"timestamp" timestamp with time zone NOT NULL,
	titolo text NOT NULL,
	lis boolean NOT NULL DEFAULT false,
	premium boolean NOT NULL DEFAULT false,
	CONSTRAINT "PROGRAMMAZIONE_pkey" PRIMARY KEY (canale, "timestamp")
);

-- Sezione 2: Vincoli UNIQUE e FOREIGN KEY
ALTER TABLE IF EXISTS fincato_palmieri."PROGRAMMAZIONE"
	ADD CONSTRAINT "PROGRAMMAZIONE_canale_fkey" FOREIGN KEY (canale)
		REFERENCES fincato_palmieri."CANALE" (streamer) MATCH SIMPLE
		ON UPDATE CASCADE
		ON DELETE CASCADE;

-- Sezione 3: Aggiunta di vincoli CHECK
ALTER TABLE IF EXISTS fincato_palmieri."PROGRAMMAZIONE"
	ADD CONSTRAINT check_titolo_non_vuoto CHECK (titolo <> ''::text);

ALTER TABLE IF EXISTS fincato_palmieri."PROGRAMMAZIONE"
	OWNER to postgres;

COMMENT ON TABLE fincato_palmieri."PROGRAMMAZIONE"
	IS 'Tabelle contenenti le programmazioni di live prefissate dallo streamer';
```

### LINK SOCIAL

```sql
CREATE TABLE fincato_palmieri."LINK SOCIAL"
(
	canale text,
	social text,
	link text NOT NULL,
	PRIMARY KEY (canale, social),
	FOREIGN KEY (canale)
		REFERENCES fincato_palmieri."CANALE" (streamer) MATCH SIMPLE
		ON UPDATE CASCADE
		ON DELETE CASCADE
		NOT VALID,
	CONSTRAINT check_link_valido CHECK (link ~* '^https?:\/\/(www\.)?([-\w@:%._\+~#=]{2,256}\.[a-z]{2,6})+(\/[\/\w\.-]*)*(\?\w+=.+)*$') NOT VALID
);

ALTER TABLE IF EXISTS fincato_palmieri."LINK SOCIAL"
	OWNER to postgres;

COMMENT ON TABLE fincato_palmieri."LINK SOCIAL"
	IS 'Tabella contenenti i link social del canale';

-- Table: fincato_palmieri.LINK SOCIAL

-- DROP TABLE IF EXISTS fincato_palmieri."LINK SOCIAL";

-- Sezione 1: Creazione della Tabella LINK SOCIAL
CREATE TABLE IF NOT EXISTS fincato_palmieri."LINK SOCIAL"
(
	canale text COLLATE pg_catalog."default" NOT NULL,
	social text COLLATE pg_catalog."default" NOT NULL,
	link text COLLATE pg_catalog."default" NOT NULL,
	CONSTRAINT "LINK SOCIAL_pkey" PRIMARY KEY (canale, social)
);

-- Sezione 2: Vincoli UNIQUE e FOREIGN KEY
-- é necessario il vincolo FOREIGN KEY per questa tabella per canale del LINK SOCIAL da coincidere con streamer della tabella CANALE.
ALTER TABLE IF EXISTS fincato_palmieri."LINK SOCIAL"
	ADD CONSTRAINT "LINK SOCIAL_canale_fkey" FOREIGN KEY (canale)
		REFERENCES fincato_palmieri."CANALE" (streamer) MATCH SIMPLE
		ON UPDATE CASCADE
		ON DELETE CASCADE;

-- Sezione 3: Aggiunta di vincoli CHECK
-- Vincolo per validare il link del social tramite regex
ALTER TABLE IF EXISTS fincato_palmieri."LINK SOCIAL"
	ADD CONSTRAINT check_link_valido CHECK (link ~* '^https?:\/\/(www\.)?([-\w@:%._\+~#=]{2,256}\.[a-z]{2,6})+(\/[\/\w\.-]*)*(\?\w+=.+)*$'::text);

ALTER TABLE IF EXISTS fincato_palmieri."LINK SOCIAL"
	OWNER to postgres;

COMMENT ON TABLE fincato_palmieri."LINK SOCIAL"
	IS 'Tabella contenenti i link social del canale';
```

### DONAZIONE

```sql
-- Table: fincato_palmieri.DONAZIONE

-- DROP TABLE IF EXISTS fincato_palmieri."DONAZIONE";

-- Sezione 1: Creazione della Tabella DONAZIONE
CREATE TABLE IF NOT EXISTS fincato_palmieri."DONAZIONE"
(
	donatore text NOT NULL,
	"timestamp" timestamp with time zone NOT NULL,
	bits integer NOT NULL DEFAULT 1,
	streamer text NOT NULL,
	CONSTRAINT "DONAZIONE_pkey" PRIMARY KEY (donatore, "timestamp")
);

-- Sezione 2: Vincoli UNIQUE e FOREIGN KEY
-- é necessario il vincolo FOREIGN KEY per questa tabella per donatore e streamer della DONAZIONE da coincidere rispettivamente con nome_utente della tabella REGISTRATO e streamer di CANALE.
ALTER TABLE IF EXISTS fincato_palmieri."DONAZIONE"
	ADD CONSTRAINT "DONAZIONE_donatore_fkey" FOREIGN KEY (donatore)
		REFERENCES fincato_palmieri."PORTAFOGLIO" (utente) MATCH SIMPLE
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD CONSTRAINT "DONAZIONE_streamer_fkey" FOREIGN KEY (streamer)
		REFERENCES fincato_palmieri."CANALE" (streamer) MATCH SIMPLE
		ON UPDATE CASCADE
		ON DELETE CASCADE;

-- Sezione 3: Aggiunta di vincoli CHECK
-- Vincolo per garantire che bits (il bilancio) non sia negativo o zero
ALTER TABLE IF EXISTS fincato_palmieri."DONAZIONE"
	ADD CONSTRAINT check_valore_bits_strettamente_positivo CHECK (bits > 0);

ALTER TABLE IF EXISTS fincato_palmieri."DONAZIONE"
	OWNER to postgres;

COMMENT ON TABLE fincato_palmieri."DONAZIONE"
	IS 'Tabella che contiene le donazioni effettuate da utente registrato a utente streamer (utente registrato che gestisce un canale)';
```

### FOLLOWER

```sql
-- Table: fincato_palmieri.FOLLOWER

-- DROP TABLE IF EXISTS fincato_palmieri."FOLLOWER";

-- Sezione 1: Creazione della Tabella FOLLOWER
CREATE TABLE IF NOT EXISTS fincato_palmieri."FOLLOWER"
(
	iscritto text NOT NULL,
	canale text NOT NULL,
	CONSTRAINT "FOLLOWER_pkey" PRIMARY KEY (iscritto, canale)
);

-- Sezione 2: Vincoli UNIQUE e FOREIGN KEY
ALTER TABLE IF EXISTS fincato_palmieri."FOLLOWER"
	ADD CONSTRAINT "FOLLOWER_canale_fkey" FOREIGN KEY (canale)
		REFERENCES fincato_palmieri."CANALE" (streamer) MATCH SIMPLE
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD CONSTRAINT "FOLLOWER_iscritto_fkey" FOREIGN KEY (iscritto)
		REFERENCES fincato_palmieri."REGISTRATO" (nome_utente) MATCH SIMPLE
		ON UPDATE CASCADE
		ON DELETE CASCADE;

-- Sezione 3: Aggiunta di vincoli CHECK
-- non ce ne bisogno di check in quanto i possibili valori di tutti gli attributi sono ristretti ai valori presenti nelle tabelle REGISTRATO e CANALE 

ALTER TABLE IF EXISTS fincato_palmieri."FOLLOWER"
	OWNER to postgres;

COMMENT ON TABLE fincato_palmieri."FOLLOWER"
	IS 'Tabella che contiene le iscrizioni degli utenti registrati ai canali per avere le notifiche delle programmazioni delle live';
```

### ABBONAMENTO

```sql
-- Table: fincato_palmieri.ABBONAMENTO

-- DROP TABLE IF EXISTS fincato_palmieri."ABBONAMENTO";

-- Sezione 1: Creazione della Tabella ABBONAMENTO
CREATE TABLE IF NOT EXISTS fincato_palmieri."ABBONAMENTO"
(
	abbonato text NOT NULL,
	canale text NOT NULL,
	CONSTRAINT "ABBONAMENTO_pkey" PRIMARY KEY (abbonato, canale)
);

-- Sezione 2: Vincoli UNIQUE e FOREIGN KEY
ALTER TABLE IF EXISTS fincato_palmieri."ABBONAMENTO"
	ADD CONSTRAINT "ABBONAMENTO_canale_fkey" FOREIGN KEY (canale)
		REFERENCES fincato_palmieri."CANALE" (streamer) MATCH SIMPLE
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	ADD CONSTRAINT "ABBONAMENTO_abbonato_fkey" FOREIGN KEY (abbonato)
		REFERENCES fincato_palmieri."REGISTRATO" (nome_utente) MATCH SIMPLE
		ON UPDATE CASCADE
		ON DELETE CASCADE;

-- Sezione 3: Aggiunta di vincoli CHECK
-- non ce ne bisogno di check in quanto i possibili valori di tutti gli attributi sono ristretti ai valori presenti nelle tabelle REGISTRATO e CANALE 

ALTER TABLE IF EXISTS fincato_palmieri."ABBONAMENTO"
	OWNER to postgres;

COMMENT ON TABLE fincato_palmieri."ABBONAMENTO"
	IS 'Tabella che contiene gli abbonamenti degli utenti registrati ai canali per poter seguire anche i contenuti multimediali esclusivi ai soli abbonati';
```

### CATEGORIA

```sql
-- Sezione 1: Creazione della Tabella CATEGORIA
CREATE TABLE IF NOT EXISTS fincato_palmieri."CATEGORIA"
(
	nome text PRIMARY KEY
);

-- Sezione 2: Vincoli UNIQUE e FOREIGN KEY

-- Sezione 3: Aggiunta di vincoli CHECK
ALTER TABLE IF EXISTS fincato_palmieri."CATEGORIA"
	ADD CONSTRAINT check_nome_non_vuoto CHECK (nome <> ''::text) NOT VALID;

ALTER TABLE IF EXISTS fincato_palmieri."CATEGORIA"
	OWNER to postgres;

COMMENT ON TABLE fincato_palmieri."CATEGORIA"
	IS 'Tabella contenente le categorie per poter filtrare i contenuti multimediale';
```

### HASHTAG

```sql
-- Sezione 1: Creazione della Tabella HASHTAG
CREATE TABLE IF NOT EXISTS fincato_palmieri."HASHTAG"
(
	nome text PRIMARY KEY
);

-- Sezione 2: Vincoli UNIQUE e FOREIGN KEY

-- Sezione 3: Aggiunta di vincoli CHECK
ALTER TABLE IF EXISTS fincato_palmieri."HASHTAG"
	ADD CONSTRAINT check_nome_non_vuoto CHECK (nome <> ''::text) NOT VALID;

ALTER TABLE IF EXISTS fincato_palmieri."HASHTAG"
	OWNER to postgres;

COMMENT ON TABLE fincato_palmieri."HASHTAG"
	IS 'Tabella contenente gli hashtag per poter filtrare i contenuti multimediale';
```

### CONTENUTO MULTIMEDIALE

```sql
-- Sezione 1: Creazione della Tabella CONTENUTO MULTIMEDIALE
CREATE TABLE IF NOT EXISTS fincato_palmieri."CONTENUTO MULTIMEDIALE"
(
	canale text NOT NULL,
	url text PRIMARY KEY,
	categoria text NOT NULL,
	lis boolean NOT NULL DEFAULT false,
	titolo text NOT NULL,
);

-- Sezione 2: Vincoli UNIQUE e FOREIGN KEY
ALTER TABLE IF EXISTS fincato_palmieri."CONTENUTO MULTIMEDIALE"
	ADD CONSTRAINT "CONTENUTO MULTIMEDIALE_canale_fkey" FOREIGN KEY (canale)
		REFERENCES fincato_palmieri."CANALE" (streamer) MATCH SIMPLE
		ON UPDATE CASCADE
		ON DELETE CASCADE
		NOT VALID,
	ADD CONSTRAINT "CONTENUTO MULTIMEDIALE_categoria_fkey" FOREIGN KEY (categoria)
		REFERENCES fincato_palmieri."CATEGORIA" (nome) MATCH SIMPLE
		ON UPDATE CASCADE
		ON DELETE CASCADE
		NOT VALID;

-- Sezione 3: Aggiunta di vincoli CHECK
ALTER TABLE IF EXISTS fincato_palmieri."CONTENUTO MULTIMEDIALE"
	ADD CONSTRAINT check_url_non_vuoto CHECK (url <> '') NOT VALID,
	ADD CONSTRAINT check_titolo_non_vuoto CHECK (titolo <> '') NOT VALID

ALTER TABLE IF EXISTS fincato_palmieri."CONTENUTO MULTIMEDIALE"
	OWNER to postgres;

COMMENT ON TABLE fincato_palmieri."CONTENUTO MULTIMEDIALE"
	IS 'Tabella che contiene i valori comuni di diversi tipi di contenuti multimediali (LIVE, VIDEO e CLIP)';
```

### VISITA

```sql
-- Sezione 1: Creazione della Tabella VISITA
CREATE TABLE IF NOT EXISTS fincato_palmieri."VISITA"
(
	visitatore text,
	contenuto_multimediale text,
	PRIMARY KEY (visitatore, contenuto_multimediale)
);

-- Sezione 2: Vincoli UNIQUE e FOREIGN KEY
ALTER TABLE IF EXISTS fincato_palmieri."VISITA"
	ADD CONSTRAINT "VISITA_visitatore_fkey" FOREIGN KEY (visitatore)
		REFERENCES fincato_palmieri."UTENTE" (nome_utente) MATCH SIMPLE
		ON UPDATE CASCADE
		ON DELETE CASCADE
		NOT VALID,
	ADD CONSTRAINT "VISITA_contenuto_multimediale_fkey" FOREIGN KEY (contenuto_multimediale)
		REFERENCES fincato_palmieri."CONTENUTO MULTIMEDIALE" (url) MATCH SIMPLE
		ON UPDATE CASCADE
		ON DELETE CASCADE
		NOT VALID;

-- Sezione 3: Aggiunta di vincoli CHECK

ALTER TABLE IF EXISTS fincato_palmieri."VISITA"
	OWNER to postgres;

COMMENT ON TABLE fincato_palmieri."VISITA"
	IS 'Tabella che contiene le visite effettuate dagli utenti guest e registrati ai contenuti multimediali';
```

### VOTO

```sql
-- Sezione 1: Creazione della Tabella VOTO
CREATE TABLE IF NOT EXISTS fincato_palmieri."VOTO"
(
	utente text,
	contenuto_multimediale text,
	likert integer NOT NULL,
	PRIMARY KEY (utente, contenuto_multimediale)
);

-- Sezione 2: Vincoli UNIQUE e FOREIGN KEY
ALTER TABLE IF EXISTS fincato_palmieri."VOTO"
	ADD CONSTRAINT "VOTO_utente_fkey" FOREIGN KEY (utente)
		REFERENCES fincato_palmieri."REGISTRATO" (nome_utente) MATCH SIMPLE
		ON UPDATE CASCADE
		ON DELETE CASCADE
		NOT VALID,
	ADD CONSTRAINT "VOTO_contenuto_multimediale_fkey" FOREIGN KEY (contenuto_multimediale)
		REFERENCES fincato_palmieri."CONTENUTO MULTIMEDIALE" (url) MATCH SIMPLE
		ON UPDATE CASCADE
		ON DELETE CASCADE
		NOT VALID;

-- Sezione 3: Aggiunta di vincoli CHECK
ALTER TABLE IF EXISTS fincato_palmieri."VOTO"
	ADD CONSTRAINT check_likert CHECK (likert <= 1 AND likert <= 10) NOT VALID;

ALTER TABLE IF EXISTS fincato_palmieri."VOTO"
	OWNER to postgres;

COMMENT ON TABLE fincato_palmieri."VOTO"
	IS 'Tabella che contiene i voti lasciati dagli utenti registrati ai contenuti multimediali';
```

### LIVE

```sql
-- Sezione 1: Creazione della Tabella LIVE
CREATE TABLE IF NOT EXISTS fincato_palmieri."LIVE"
(
	url text PRIMARY KEY,
	premium boolean NOT NULL,
	data_fine timestamp with time zone NOT NULL,
	data_inizio timestamp with time zone NOT NULL
);

-- Sezione 2: Vincoli UNIQUE e FOREIGN KEY
ALTER TABLE IF EXISTS fincato_palmieri."LIVE"
	ADD CONSTRAINT "LIVE_url_fkey" FOREIGN KEY (url)
		REFERENCES fincato_palmieri."CONTENUTO MULTIMEDIALE" (url) MATCH SIMPLE
		ON UPDATE CASCADE
		ON DELETE CASCADE
		NOT VALID;

-- Sezione 3: Aggiunta di vincoli CHECK
ALTER TABLE IF EXISTS fincato_palmieri."LIVE"
	ADD CONSTRAINT check_date CHECK (data_fine > data_inizio) NOT VALID

ALTER TABLE IF EXISTS fincato_palmieri."LIVE"
	OWNER to postgres;

COMMENT ON TABLE fincato_palmieri."LIVE"
	IS 'Tabella contenenti le informazioni dedicate ai contenuti multimediali di tipo live';
```

### EMOJI

```sql
-- Sezione 1: Creazione della Tabella NOME
CREATE TABLE IF NOT EXISTS fincato_palmieri."EMOJI"
(
	codice text PRIMARY KEY
);

-- Sezione 2: Vincoli UNIQUE e FOREIGN KEY

-- Sezione 3: Aggiunta di vincoli CHECK
ALTER TABLE IF EXISTS fincato_palmieri."EMOJI"
	ADD CONSTRAINT check_codice CHECK (codice <> '') NOT VALID;

ALTER TABLE IF EXISTS fincato_palmieri."EMOJI"
	OWNER to postgres;

COMMENT ON TABLE fincato_palmieri."EMOJI"
	IS 'Tabella contenente le emoji consentite nei commenti delle live';
```

### INTERAZIONE

```sql
-- Table: fincato_palmieri.INTERAZIONE

-- DROP TABLE IF EXISTS fincato_palmieri."INTERAZIONE";

-- Sezione 1: Creazione della Tabella INTERAZIONE
CREATE TABLE IF NOT EXISTS fincato_palmieri."INTERAZIONE"
(
	utente text,
	"timestamp" timestamp with time zone,
	live text,
	tipologia text NOT NULL,
	messaggio text NOT NULL,
	PRIMARY KEY (utente, "timestamp", live)
);

-- Sezione 2: Vincoli UNIQUE e FOREIGN KEY
ALTER TABLE IF EXISTS fincato_palmieri."INTERAZIONE"
	ADD CONSTRAINT "INTERAZIONE_live_fkey" FOREIGN KEY (live)
		REFERENCES fincato_palmieri."LIVE" (url) MATCH SIMPLE
		ON UPDATE CASCADE
		ON DELETE CASCADE
		NOT VALID,
	ADD CONSTRAINT "INTERAZIONE_utente_fkey" FOREIGN KEY (utente)
		REFERENCES fincato_palmieri."REGISTRATO" (nome_utente) MATCH SIMPLE
		ON UPDATE CASCADE
		ON DELETE CASCADE
		NOT VALID;

-- Sezione 3: Aggiunta di vincoli CHECK
ALTER TABLE IF EXISTS fincato_palmieri."INTERAZIONE"
	ADD CONSTRAINT check_messaggio CHECK (messaggio IS NULL OR messaggio <> '') NOT VALID,
	ADD CONSTRAINT check_tipologia CHECK (tipologia = 'commento' OR tipologia = 'reazione') NOT VALID,
	ADD CONSTRAINT check_tipologia_messaggio CHECK ((tipologia = 'commento' AND messaggio IS NOT NULL AND messaggio <> '') OR (tipologia = 'reazione' AND messaggio IS NULL)) NOT VALID,
	ADD CONSTRAINT check_timestamp CHECK (timestamp > CURRENT_TIMESTAMP) NOT VALID;

ALTER TABLE IF EXISTS fincato_palmieri."INTERAZIONE"
	OWNER to postgres;

COMMENT ON TABLE fincato_palmieri."INTERAZIONE"
	IS 'Tabella contenente le interazioni (commenti e reazioni) effettuate dagli utenti registrati verso le live';
```

### PRESENZA

```sql
-- Table: fincato_palmieri.PRESENZA

-- DROP TABLE IF EXISTS fincato_palmieri."PRESENZA";

-- Sezione 1: Creazione della Tabella PRESENZA
CREATE TABLE IF NOT EXISTS fincato_palmieri."PRESENZA"
(
	utente text,
	"timestamp" timestamp with time zone,
	live text,
	emoji text,
	PRIMARY KEY (utente, "timestamp", live, emoji)
);

-- Sezione 2: Vincoli UNIQUE e FOREIGN KEY
ALTER TABLE IF EXISTS fincato_palmieri."PRESENZA"
	ADD CONSTRAINT "PRESENZA_emoji_fkey" FOREIGN KEY (emoji)
		REFERENCES fincato_palmieri."EMOJI" (codice) MATCH SIMPLE
		ON UPDATE CASCADE
		ON DELETE CASCADE
		NOT VALID,
	ADD CONSTRAINT "PRESENZA_utente_timestamp_live_fkey" FOREIGN KEY (utente, "timestamp", live)
		REFERENCES fincato_palmieri."INTERAZIONE" (utente, "timestamp", live) MATCH SIMPLE
		ON UPDATE CASCADE
		ON DELETE CASCADE
		NOT VALID;

-- Sezione 3: Aggiunta di vincoli CHECK

ALTER TABLE IF EXISTS fincato_palmieri."PRESENZA"
	OWNER to postgres;

COMMENT ON TABLE fincato_palmieri."PRESENZA"
	IS 'Tabella "ponte" per permettere ai commenti e reazioni di avere emoji';
```

### AFFLUENZA

```sql
-- Table: fincato_palmieri.AFFLUENZA

-- DROP TABLE IF EXISTS fincato_palmieri."AFFLUENZA";

-- Sezione 1: Creazione della Tabella AFFLUENZA
CREATE TABLE IF NOT EXISTS fincato_palmieri."AFFLUENZA"
(
	live text,
	"timestamp" timestamp with time zone,
	numero_spettatori integer NOT NULL,
	PRIMARY KEY (live, "timestamp")
);

-- Sezione 2: Vincoli UNIQUE e FOREIGN KEY
ALTER TABLE IF EXISTS fincato_palmieri."AFFLUENZA"
	ADD CONSTRAINT "AFFLUENZA_live_fkey" FOREIGN KEY (live)
		REFERENCES fincato_palmieri."LIVE" (url) MATCH SIMPLE
		ON UPDATE CASCADE
		ON DELETE CASCADE
		NOT VALID;

-- Sezione 3: Aggiunta di vincoli CHECK
ALTER TABLE IF EXISTS fincato_palmieri."AFFLUENZA"
	ADD CONSTRAINT check_numero_spettatori CHECK (numero_spettatori >= 0) NOT VALID,
	ADD CONSTRAINT check_timestamp CHECK (timestamp <= CURRENT_TIMESTAMP) NOT VALID;

ALTER TABLE IF EXISTS fincato_palmieri."AFFLUENZA"
	OWNER to postgres;

COMMENT ON TABLE fincato_palmieri."AFFLUENZA"
	IS 'Tabella contenente l''affluenza di una specifica istantanea della live';
```

### VIDEO

```sql
-- Table: fincato_palmieri.VIDEO

-- DROP TABLE IF EXISTS fincato_palmieri."VIDEO";

-- Sezione 1: Creazione della Tabella VIDEO
CREATE TABLE IF NOT EXISTS fincato_palmieri."VIDEO"
(
	contenuto_multimediale text PRIMARY KEY,
	live text NOT NULL,
	durata integer NOT NULL
);

-- Sezione 2: Vincoli UNIQUE e FOREIGN KEY
ALTER TABLE IF EXISTS fincato_palmieri."VIDEO"
	ADD CONSTRAINT "VIDEO_live_key" UNIQUE (live),
	ADD CONSTRAINT "VIDEO_contenuto_multimediale_fkey" FOREIGN KEY (contenuto_multimediale)
		REFERENCES fincato_palmieri."CONTENUTO MULTIMEDIALE" (url) MATCH SIMPLE
		ON UPDATE CASCADE
		ON DELETE CASCADE
		NOT VALID,
	ADD CONSTRAINT "VIDEO_live_fkey" FOREIGN KEY (live)
		REFERENCES fincato_palmieri."LIVE" (url) MATCH SIMPLE
		ON UPDATE CASCADE
		ON DELETE CASCADE
		NOT VALID;

-- Sezione 3: Aggiunta di vincoli CHECK
ALTER TABLE IF EXISTS fincato_palmieri."VIDEO"
	ADD CONSTRAINT check_durata CHECK (durata > 0) NOT VALID;

ALTER TABLE IF EXISTS fincato_palmieri."VIDEO"
	OWNER to postgres;

COMMENT ON TABLE fincato_palmieri."VIDEO"
	IS 'Tabella contenente le live passate sottoforma di video';
```

### CLIP

```sql
-- Table: fincato_palmieri.CLIP

-- DROP TABLE IF EXISTS fincato_palmieri."CLIP";

-- Sezione 1: Creazione della Tabella CLIP
CREATE TABLE IF NOT EXISTS fincato_palmieri."CLIP"
(
	contenuti_multimediale text PRIMARY KEY,
	durata integer NOT NULL,
	video text NOT NULL,
	minutaggio integer NOT NULL
);

-- Sezione 2: Vincoli UNIQUE e FOREIGN KEY
ALTER TABLE IF EXISTS fincato_palmieri."CLIP"
	ADD CONSTRAINT "CLIP_video_fkey" FOREIGN KEY (video)
		REFERENCES fincato_palmieri."VIDEO" (contenuto_multimediale) MATCH SIMPLE
		ON UPDATE CASCADE
		ON DELETE CASCADE
		NOT VALID;

-- Sezione 3: Aggiunta di vincoli CHECK
ALTER TABLE IF EXISTS fincato_palmieri."CLIP"
	ADD CONSTRAINT check_durata CHECK (durata > 0) NOT VALID,
	ADD CONSTRAINT check_minutaggio CHECK (minutaggio > 0) NOT VALID;

ALTER TABLE IF EXISTS fincato_palmieri."CLIP"
	OWNER to postgres;

COMMENT ON TABLE fincato_palmieri."CLIP"
	IS 'Tabella che contiene le clip, ovvero estratti di durata inferiore al video originale';
```
