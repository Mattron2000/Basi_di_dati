# Basi di dati e Sistemi Informativi: Sperimentazioni A.A. 2023-2024 <!-- omit in toc -->

## BOZZA DDL E DML <!-- omit in toc -->

---

## Sommario <!-- omit in toc -->

- [3 DDL di creazione del database](#3-ddl-di-creazione-del-database)
  - [3.1 Tabella "Utente" e "Registrato"](#31-tabella-utente-e-registrato)
  - [3.2 Amministratore](#32-amministratore)
  - [3.3 Rinnovo](#33-rinnovo)
  - [3.4 Programmazione](#34-programmazione)
  - [3.5 LinkSocial](#35-linksocial)
  - [3.6 Abbonamento](#36-abbonamento)
  - [3.7 Contenuto Multimediale](#37-contenuto-multimediale)
  - [3.8 Voto](#38-voto)
  - [3.9 Interazione](#39-interazione)
- [4 DML di popolamento di tutte le tabelle del database](#4-dml-di-popolamento-di-tutte-le-tabelle-del-database)
- [5 DML di modifica](#5-dml-di-modifica)

## 3 DDL di creazione del database

> <qui inserite solo qualche commento su cosa avete fatto (es. spiegazione di vincoli complessi). Mettete il codice di creazione del database in un file a parte denominato VostriCognomi_DDL.sql (es. Rossi_DDL.sql)>

### 3.1 Tabella "Utente" e "Registrato"

La tabella "Utente" contiene solamente gli username di utenti sia guest e registrato, invece "Registrato" contiene tutte le informazioni degli utenti registrati nella piattaforma dove quelle degli utenti guest non sono necessarie.

Questa suddivisione fisica in due tabelle permette di evidenziare i permessi concessi agli utenti guest e registrati, tabella "Utente" gli é permesso visitare e osservare contenuti multimediali non-premium (una sorta di permesso di sola lettura in ambito OS), la tabella "Registrato" ha invece i permessi di scrittura di messaggi, di inviare likert, di diventare utenti premium, di abbonarsi ai singoli canali, etc... (simile al permesso di scrittura in OS).

I check impostati a queste tabelle garantiscono che:

- l'etá minima di 13 anni come é richiesto dalla UE sia rispettata
- l'email inserita dagli utenti registrati sia conforme al moderno formato delle e-mail 'username(+alias)@host.domain'.
- la password per essere sufficientemente forte deve avere almeno 8 caratteri.
- il numero di telefono deve rispettare diversi formati internazionali.

Gli utenti guest, come abbiamo capito, avranno solo l'username per essere identificati, per distinguere un utente guest da quello registrato nella tabella "Utente", si nota dalla stringa che `e composto da un prefisso 'guest_' + \<integer\> (all'inizio pensavamo a una alternativa piú elegante e professionale come 'guest_' + UUID, ma risulta che bisogna attivare una estensione per il corretto funzionamento, alla fine abbiamo optato con la piú semplice SEQUENCE di interi).

### 3.2 Amministratore

Il vincolo UNIQUE del set "Nome" e "Cognome" é originato semplicemente dall'evitare duplicati logici e garantire l'integrità dei dati e facilitare le operazioni di ricerca e gestione.

### 3.3 Rinnovo

Dato che abbiamo impostato PRIMARY KEY al set ("Amministratore", "Provider"), ci impossibilita ad avere uno storico dei rinnovi passati, ma conterrá solamente gli ultimi rinnovi di quel specifico PRIMARY KEY set.

Se l'amministratore vuole continuare con lo stesso provider, verrá aggiornata solo la data di scadenza, altrimenti se vuole cambiare provider, verrá aggiornato il set PRIMARY KEY oltre alla data di scadenza.

### 3.4 Programmazione

"Programmazione" é una tabella 'parallela' alla tabella "ContenutoMultimediale" dove hanno molti attributi in comune ma vengono utilizzati in contesti diversi.

### 3.5 LinkSocial

All'attributo "LinkProfilo" della tabella "LinkSocial" ho effettuato un CHECK regex simile ai CHECK presenti nella tabella "Registrato", ma per gli indirizzi URL.

### 3.6 Abbonamento

Qui presente il set UNIQUE proponendo le stesse meccaniche della tabella "Rinnovo".

### 3.7 Contenuto Multimediale

Questa é l'altra tabella 'parallela' con "Programmazione".

Anche qui, l'attributo "IdURL" ha un CHECK similare con quello di "LinkSocial" per validare tramite regex l'indirizzo URL, ma per motivi di semplicitá nel debug visto il contesto dell'esame universitario e il permesso del prof utilizzeremo il seguente formato piú: url1, url2, url3, ... (in generale 'url' + \<integer\> generata da una differente sequence dedicata proprio per gli url).

L'esistenza di questa tabella é dettata dalla necessitá di semplificare la comunicazione utenti-contenuti in modo che ci sia solamente una tabella "Voto", "Interazione" e "Visita" invece che avere le stesse tabelle moltiplicate per ogni tipo di contenuto multimediale ("Live", "Video" e "Clip").

### 3.8 Voto

In questa tabella abbiamo applicato il DOMAIN all'attributo "Likert" per assicurare che il valore sia compreso nell'intervallo tra 1 e 10, estremi compresi.

### 3.9 Interazione

In questa tabella abbiamo applicato il DOMAIN all'attributo "Tipologia" per assicurare che il valore sia 'commento' oppure 'reazione'.

Abbiamo incorporato dalla progettazione logica le tabelle "Commento" e "Reazione" in "Interazione" risolvendo con un attributo "Tipologia".

## 4 DML di popolamento di tutte le tabelle del database

> <non è richiesto (ed è una perdita di tempo) inserire una grande quantità di dati. Una cosa sensata: le tabelle fisse andrebbero popolate tutte (se piccole), per quelle variabili e/o grandi bastano pochi elementi (5, max 10). Se popolate il database con dati verosimili potreste rendervi conto di errori commessi nella fase di progettazione concettuale e di cui avreste dovuto rendervi conto prima>

> <qui inserite solo qualche commento (es. spiegazione del perché i dati da voi inseriti coprono i casi più frequenti e – possibilmente – quelli limite). Mettete il codice in un file a parte denominato VostriCognomi_DMLPOP.sql (es. Rossi_DMLPOP.sql)>

I dati inseriti ricoprono i casi più frequenti di inserimento in una basi di dati di questo tipo.
Ci sono infatti inserimenti più frequenti per elementi cardine della piattaforma, come ad esempio l'aggiunta di un utente guest o registrato oppure l'aggiunta di un contenuto multimediale, mentre per altri elementi meno frequenti sono stai eseguiti pochi inserimenti, come ad esempio l'aggiunta di un amministratore o di un portafoglio.
Come si può notare, molti casi limite sono stati coperti, come ad esempio l'aggiunta di un utente registrato che non è uno streamer oppure l'aggiunta di un portafoglio non per forza a tutti gli utenti registrati.
A dimostrazione di ciò si può notare come in alcuni casi le informazioni opzionali vengano omesse oppure valorizzate tramite valori di default, per rappresentare ad esempio la mancanza di **_descrizione_** e **_trailer_** di un canale oppure le opzioni **_premium_** o **_LIS_** valorizzate di default a _false_.
Nella fase di popolamento si è quindi cercato di inserire dati basandosi su un'applicazione realistica di questo tipo.

## 5 DML di modifica

> <soltanto qualche modifica del DB che rispecchi le operazioni più frequenti (es. aggiunta di un utente)>
>
> <qui inserite solo qualche commento (es. quali operazioni del file corrispondono a quali operazioni della tabella delle operazioni). Mettete il codice in un file a parte denominato VostriCognomi_DMLUPD.sql (es. Rossi_DMLUPD.sql)>
