# Basi di dati e Sistemi Informativi: Sperimentazioni A.A. 2023-2024 <!-- omit in toc -->

## BOZZA DDL E DML <!-- omit in toc -->

---

## Sommario <!-- omit in toc -->

- [3 DDL di creazione del database](#3-ddl-di-creazione-del-database)
  - [3.1 Utente e Registrato](#31-utente-e-registrato)
  - [3.2 Amministratore](#32-amministratore)
  - [3.3 Rinnovo](#33-rinnovo)
  - [3.4 Programmazione](#34-programmazione)
  - [3.5 LinkSocial](#35-linksocial)
  - [3.6 Subscription](#36-subscription)
  - [3.7 Contenuto Multimediale](#37-contenuto-multimediale)
  - [3.8 Voto](#38-voto)
  - [3.9 Interazione](#39-interazione)
- [4 DML di popolamento di tutte le tabelle del database](#4-dml-di-popolamento-di-tutte-le-tabelle-del-database)
  - [4.1 Utenti registrati e streamer](#41-utenti-registrati-e-streamer)
  - [4.2 Portafogli, donazioni e programmazioni delle live](#42-portafogli-donazioni-e-programmazioni-delle-live)
  - [4.3 Amministratori, provider e rinnovi](#43-amministratori-provider-e-rinnovi)
  - [4.4 Messaggi e interazioni](#44-messaggi-e-interazioni)
  - [4.5 Visite e voti](#45-visite-e-voti)
  - [4.6 Contenuti multimediali ed emoji](#46-contenuti-multimediali-ed-emoji)
  - [4.7 Canali e infromazioni opzionali nelle tabelle](#47-canali-e-infromazioni-opzionali-nelle-tabelle)
  - [4.8 Link social e subscription](#48-link-social-e-subscription)
- [5 DML di modifica](#5-dml-di-modifica)

## 3 DDL di creazione del database
<!--
> <qui inserite solo qualche commento su cosa avete fatto (es. spiegazione di vincoli complessi). Mettete il codice di creazione del database in un file a parte denominato VostriCognomi_DDL.sql (es. Rossi_DDL.sql)>
-->

### 3.1 Utente e Registrato

La tabella **_Utente_** contiene solamente gli username di tutti gli utenti sia guest che registrati e le eventuali segnalazioni agli utenti, invece **_Registrato_** contiene tutte e sole le informazioni degli utenti registrati nella piattaforma.

Questa suddivisione fisica in due tabelle permette di evidenziare i permessi concessi agli utenti guest e registrati:

- la tabella **_Utente_** possiede solamente il permesso di visitare e osservare contenuti multimediali non-premium (una sorta di permesso di sola lettura in ambito OS),
- la tabella **_Registrato_** ha invece il permesso di scrivere messaggi, inviare likert, diventare utente premium, abbonarsi ai singoli canali, etc... (simile al permesso di scrittura in OS).

I check imposti a queste tabelle garantiscono che:

- l'etá minima di 13 anni come é richiesto dalla UE sia rispettata
- l'email inserita dagli utenti registrati sia conforme al moderno formato delle e-mail _'username(+alias)@host.domain'_
- la password abbia almeno 8 caratteri, per essere sufficientemente forte
- il numero di telefono rispetti diversi formati internazionali.

Gli utenti guest sono identificati solo dal nome utente e per distinguerli dagli utenti registrati, nella tabella **_Utente_** il loro nome utente sarà la stringa composta da un prefisso **_'guest_'_ + numero intero univoco** incrementato ogni volta mediante una SEQUENCE di interi dedicata ai guest.

### 3.2 Amministratore

Il vincolo UNIQUE del set **(_"Nome"_, _"Cognome"_)** é imposto semplicemente per evitare duplicati logici, garantire l'integrità dei dati e facilitare le operazioni di ricerca e gestione.

### 3.3 Rinnovo

Dato che abbiamo impostato come PRIMARY KEY il set **(_"Amministratore"_, _"Provider"_)**, la tabella "Rinnovo" non conterrà lo storico dei rinnovi passati, ma solamente gli ultimi rinnovi di quello specifico set _("Amministratore", "Provider")_.

Se l'amministratore vuole continuare con lo stesso provider verrá aggiornata solo la data di scadenza, altrimenti in caso voglia cambiare provider verrá aggiornato il set PRIMARY KEY e la data di scadenza.

### 3.4 Programmazione

**_Programmazione_** é una tabella "parallela" alla tabella **_ContenutoMultimediale_**, dato che hanno molti attributi in comune che vengono utilizzati però in contesti diversi.

### 3.5 LinkSocial

Per l'attributo **_"LinkProfilo"_** della tabella **_LinkSocial_** abbiamo impostato un CHECK regex simile ai CHECK presenti nella tabella **_Registrato_**, ma questa volta relativo agli indirizzi URL.

### 3.6 Subscription

Il vincolo PRIMARY KEY presente in questa tabella segue gli stessi principi della PRIMARY KEY della tabella **_Rinnovo_**.

### 3.7 Contenuto Multimediale

Come precedentemente scritto, questa tabella è "parallela" alla tabella **_Programmazione_**.

Anche qui, l'attributo **_"IdURL"_** ha un CHECK simile a quello del sopracitato attributo **_"LinkSocial"_** per validare tramite regex l'indirizzo URL.  
Per semplicitá, utilizzeremo un formato simbolico per gli URL composto dalla stringa **_'url'_ + numero intero univoco** incrementato ogni volta da una SEQUENCE di interi dedicata agli URL.

L'esistenza di questa tabella é dettata dalla necessitá di semplificare la comunicazione utenti-contenuti in modo che ci sia solamente una singola tabella **_Voto_**, **_Interazione_** e **_Visita_** invece che avere le stesse tabelle moltiplicate per ogni tipo di contenuto multimediale (_Live_, _Video_ e _Clip_).

### 3.8 Voto

In questa tabella abbiamo applicato un DOMAIN personalizzato all'attributo **_"Likert"_** per assicurare che il valore inserito sia compreso nell'intervallo tra 1 e 10, estremi compresi.

### 3.9 Interazione

In questa tabella abbiamo applicato un altro DOMAIN personalizzato all'attributo **_"Tipologia"_** per assicurare che il valore inserito sia _'commento'_ oppure _'reazione'_.

Il CHECK presente in questa tabella impone che l'attributo **_"Messaggio"_** sia valorizzato solo nel caso in cui **_"Tipologia"_ = _'commento'_**.

## 4 DML di popolamento di tutte le tabelle del database
<!--
> <non è richiesto (ed è una perdita di tempo) inserire una grande quantità di dati. Una cosa sensata: le tabelle fisse andrebbero popolate tutte (se piccole), per quelle variabili e/o grandi bastano pochi elementi (5, max 10). Se popolate il database con dati verosimili potreste rendervi conto di errori commessi nella fase di progettazione concettuale e di cui avreste dovuto rendervi conto prima>

> <qui inserite solo qualche commento (es. spiegazione del perché i dati da voi inseriti coprono i casi più frequenti e – possibilmente – quelli limite). Mettete il codice in un file a parte denominato VostriCognomi_DMLPOP.sql (es. Rossi_DMLPOP.sql)>
>-->

I dati inseriti ricoprono i casi più frequenti di inserimento in una basi di dati di questo tipo, considerando anche molti casi limite che si possono verificare.  
Ci sono infatti inserimenti più frequenti per elementi cardine della piattaforma, come ad esempio l'aggiunta di un utente guest o registrato oppure l'aggiunta di un contenuto multimediale, mentre per altri elementi meno frequenti sono stati eseguiti pochi inserimenti, come ad esempio l'aggiunta di un amministratore o di un portafoglio.  
Nello specifico, i criteri principali che abbiamo utilizzato durante il popolamento della base di dati sono stati i seguenti (per comodità, vengono considerate alcune tabelle del database come esempio):

### 4.1 Utenti registrati e streamer

Nella tabella **_Utente_** sono state inserite tutte le tipologie di utenti, cercando di ricreare una situazione reale: ci sono infatti utenti che sono semplicemente guest, altri che sono o streamer o spettatori e altri ancora che sono sia streamer che spettatori.

Uno streamer può essere infatti spettatore quando non trasmette in streaming o crea contenuti, oppure non esserlo proprio.

### 4.2 Portafogli, donazioni e programmazioni delle live

Nella tabella **_Portafoglio_** sono stati inseriti i portafogli solo di alcuni utenti registrati, siccome un utente registrato non è obbligato ad avere un portafoglio di bit e a fare donazioni agli streamer, ma può averlo ed effettuare più donazioni.

Nella tabella **_Donazione_** si può notare infatti che non tutti gli streamer ricevono donazioni, ma un utente registrato può effettuare più donazioni a streamer diversi o allo stesso streamer.

Criterio simile è stato applicato nel popolare la tabella **_Programmazione_**: uno streamer può anche non programmare nessuna live oppure programmarne più di una.

### 4.3 Amministratori, provider e rinnovi

Per simulare ancora di più una situazione realistica, nelle tabella **_Amministratore_** e **_Rinnovo_** sono stati inseriti pochi dati perchè si suppone che i canali scelgano servizi di hosting diversi e che non tutti i provider vengano scelti dagli amministratori delle pagine.  

I rinnovi inseriti sono i rinnovi correnti, con la relativa data di scadenza.  

Sono stati inseriti anche i casi limite, che si possono verificare ad esempio quando un amministratore gestisce più di un canale e un provider non fornisce nessun servizio di hosting oppure quando un amministratore gestisce rinnovi verso provider diversi per canali diversi.

### 4.4 Messaggi e interazioni

Nella tabella **_Messaggio_** sono stati inseriti i messaggi privati scambiati tra gli utenti registrati alla piattaforma e come nella realtà, non tutti gli utenti inviano o ricevono messaggi.

Anche le interazioni sono state inserite in modo realistico: non tutti gli spettatori di una live interagiscono e se uno spettatore interagisce, può farlo attraverso commenti e/o reazioni.

### 4.5 Visite e voti

Qualsiasi utente può visualizzare contenuti multimediali pubblici, ma non tutti gli utenti possono assegnare un voto ai contenuti visualizzati.
  
Per questo motivo anche visite e voti sono stati inseriti tenendo conto che tutti gli utenti visitano contenuti pubblici e non tutti i viewer votano i contenuti visualizzati.  

### 4.6 Contenuti multimediali ed emoji

Tra i dati inseriti ci sono anche contenuti multimediali riservati agli utenti premium oppure emoji personalizate per un determinato canale, utilizzabili solo dagli utenti abbonati ad esso: questo per rispettare i privilegi concessi agli abbonati al canale o alla piattaforma, garantendo una separazione tra contenuti pubblici e riservati.

I contenuti multimediali sono stati inseriti in maniera il più possibile realistica: ci sono infatti live che non sono diventate video del canale e video che non sono stati divisi in clip.  

Sono state inserite inoltre live che non sono diventate video pubblici ma solo premium e clip di video pubblici che sono riservate agli utenti premium, per rappresentare i casi limite dell'aggiunta di contenuti da parte di uno streamer.

### 4.7 Canali e infromazioni opzionali nelle tabelle

In alcuni casi le informazioni opzionali sono state omesse oppure valorizzate tramite valori di default.

Ad esempio, la mancanza di descrizione, immagine profilo e/o trailer di un canale viene indicata omettendo l'inserimento nella tabella **_Canale_** degli attributi **_"Descrizione"_**, **_"ImmagineProfilo"_** e/o **_"Trailer"_**.

Situazione analoga si ritrova ad esempio nella tabella **_Registrato_** per gli attributi **_"Affiliate"_** nel caso di utenti non streamer, **_"NumeroDiTelefono"_** e **_"IndirizzoMail"_** per tutti gli utenti registrati.

L'utilizzo di valori di default si può notare ad esempio nelle opzioni **_"Premium"_** o **_"LIS"_** valorizzate di default a _false_, nella tabella **_"ContenutoMultimediale"_**.  

### 4.8 Link social e subscription

Siccome non è detto che ogni utente registrato debba per forza abbonarsi ad un canale, sono stati inseriti utenti che non sottoscrivono nessuna subscription, come potrebbe davvero avvenire in una piattaforma di streaming.

Considerando però che un utente può invece abbonarsi anche a più di un canale, sono stati in questo caso inseriti utenti che sottoscrivono una subscription a più canali e anche questo fatto non è raro in una piattaforma di streaming.

Situazione analoga si può verificare ad esempio per i link ai social di un canale: nel popolamento della tabella **_LinkSocial_** sono stati infatti considerati canali con nessun collegamento a profili social e canali con invece più profili collegati.

## 5 DML di modifica
<!--
> <soltanto qualche modifica del DB che rispecchi le operazioni più frequenti (es. aggiunta di un utente)>
>
> <qui inserite solo qualche commento (es. quali operazioni del file corrispondono a quali operazioni della tabella delle operazioni). Mettete il codice in un file a parte denominato VostriCognomi_DMLUPD.sql (es. Rossi_DMLUPD.sql)>
-->

Le operazioni sono state gestiste attraverso delle viste per semplificare la manipolazione dei dati.
