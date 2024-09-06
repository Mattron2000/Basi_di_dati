# Basi di dati e Sistemi Informativi: Sperimentazioni A.A. 2023-2024 <!-- omit in toc -->

## BOZZA DDL E DML <!-- omit in toc -->

---

## Sommario <!-- omit in toc -->

- [3 DDL di creazione del database](#3-ddl-di-creazione-del-database)
- [4 DML di popolamento di tutte le tabelle del database](#4-dml-di-popolamento-di-tutte-le-tabelle-del-database)
- [5 DML di modifica](#5-dml-di-modifica)

## 3 DDL di creazione del database

> <qui inserite solo qualche commento su cosa avete fatto (es. spiegazione di vincoli complessi). Mettete il codice di creazione del database in un file a parte denominato VostriCognomi_DDL.sql (es. Rossi_DDL.sql)>

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
