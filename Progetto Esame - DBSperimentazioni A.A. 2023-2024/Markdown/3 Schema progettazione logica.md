# Basi di dati e Sistemi Informativi: Sperimentazioni A.A. 2023-2024 <!-- omit in toc -->

## BOZZA PROGETTAZIONE LOGICA <!-- omit in toc -->

---

## Sommario <!-- omit in toc -->

- [2.1 Tavola dei volumi](#21-tavola-dei-volumi)
- [2.2 Tavola delle operazioni](#22-tavola-delle-operazioni)
- [2.3 Ristrutturazione dello schema E-R](#23-ristrutturazione-dello-schema-e-r)
  - [2.3.1 Analisi delle ridondanze](#231-analisi-delle-ridondanze)
    - [2.3.1.1 RIDONDANZA 1 (\<nome ridondanza (attributo, associazione, ...)\>)](#2311-ridondanza-1-nome-ridondanza-attributo-associazione-)
    - [2.3.1.2 RIDONDANZA 2 (\<nome ridondanza (attributo, associazione, ...)\>)](#2312-ridondanza-2-nome-ridondanza-attributo-associazione-)
  - [2.3.2 Eliminazione delle generalizzazioni](#232-eliminazione-delle-generalizzazioni)
    - [2.3.2.1 Generalizzazione 1 ()](#2321-generalizzazione-1-)
  - [2.3.3 Partizionamento/accorpamento di entità e associazioni](#233-partizionamentoaccorpamento-di-entità-e-associazioni)
    - [2.3.3.1 Partizionamento/Accorpamento 1 ()](#2331-partizionamentoaccorpamento-1-)
  - [2.3.4.scelta degli identificatori principali](#234scelta-degli-identificatori-principali)
- [2.4 Schema E-R ristrutturato + regole aziendali](#24-schema-e-r-ristrutturato--regole-aziendali)
- [2.5 Schema relazionale con vincoli di integrità referenziale](#25-schema-relazionale-con-vincoli-di-integrità-referenziale)

## 2.1 Tavola dei volumi

| Concetto   | Tipo  | Volume   |
| ---------- | ----- | -------- |
| <concetto> | <E/A> | <volume> |
|            |       |          |

> < eventuali osservazioni. In particolare descrivere il ragionamento che ha portato a certi valori non espliciti nei requisiti.>
>
| Concetto               | Tipo | Volume     |
| ---------------------- | ---- | ---------- |
| UTENTI                 | E    | 100,000    |
| PORTAFOGLIO            | E    | 100,000    |
| DONAZIONI              | A    | 500,000    |
| REGISTRATI             | E    | 80,000     |
| PREMIUM                | A    | 20,000     |
| STREAMER               | E    | 10,000     |
| SPETTATORI             | E    | 70,000     |
| PROGRAMMAZIONE         | A    | 200,000    |
| CANALE                 | E    | 10,000     |
| CATEGORIA              | E    | 100        |
| CONTENUTI_MULTIMEDIALI | E    | 1,000,000  |
| LIVE                   | A    | 100,000    |
| VIDEO                  | A    | 500,000    |
| CLIP                   | A    | 200,000    |
| VISUALIZZAZIONI_VIDEO  | A    | 10,000,000 |
| VISUALIZZAZIONI_CLIP   | A    | 5,000,000  |
| SOCIAL                 | E    | 1,000      |
| LINK                   | E    | 100,000    |
| VISITE                 | A    | 20,000,000 |
| COMMENTI               | A    | 5,000,000  |
| REAZIONI               | A    | 15,000,000 |
| EMOJIS                 | E    | 5,000,000  |
| HASHTAG                | E    | 10,000     |
| CONTENUTI_HASHTAG      | A    | 1,000,000  |
| FOLLOW                 | A    | 500,000    |
| MESSAGGI               | A    | 2,000,000  |
| VOTI                   | A    | 8,000,000  |
| HOSTING                | A    | 50,000     |

1. **UTENTI**: Entità che rappresenta gli utenti della piattaforma.
2. **PORTAFOGLIO**: Entità che rappresenta il portafoglio di ciascun utente.
3. **DONAZIONI**: Associazione che rappresenta le donazioni effettuate tra utenti.
4. **REGISTRATI**: Entità che rappresenta gli utenti registrati con informazioni aggiuntive.
5. **PREMIUM**: Associazione che rappresenta gli abbonamenti premium degli utenti.
6. **STREAMER**: Entità che rappresenta gli utenti che sono streamer.
7. **SPETTATORI**: Entità che rappresenta gli utenti che sono spettatori.
8. **PROGRAMMAZIONE**: Associazione che rappresenta gli eventi di programmazione.
9. **CANALE**: Entità che rappresenta il canale gestito dallo streamer.
10. **CATEGORIA**: Entità che rappresenta le categorie dei contenuti.
11. **CONTENUTI_MULTIMEDIALI**: Entità che rappresenta i contenuti multimediali.
12. **LIVE**: Associazione che rappresenta i contenuti live.
13. **VIDEO**: Associazione che rappresenta i video.
14. **CLIP**: Associazione che rappresenta le clip.
15. **VISUALIZZAZIONI_VIDEO**: Associazione che rappresenta le visualizzazioni dei video.
16. **VISUALIZZAZIONI_CLIP**: Associazione che rappresenta le visualizzazioni delle clip.
17. **SOCIAL**: Entità che rappresenta i social media collegati.
18. **LINK**: Entità che rappresenta i link associati ai social media.
19. **VISITE**: Associazione che rappresenta le visite ai contenuti multimediali.
20. **COMMENTI**: Associazione che rappresenta i commenti sui contenuti multimediali.
21. **REAZIONI**: Associazione che rappresenta le reazioni ai commenti.
22. **EMOJIS**: Entità che rappresenta gli emoji usati nelle reazioni.
23. **HASHTAG**: Entità che rappresenta gli hashtag utilizzati.
24. **CONTENUTI_HASHTAG**: Associazione che rappresenta la relazione tra contenuti multimediali e hashtag.
25. **FOLLOW**: Associazione che rappresenta i follow tra utenti.
26. **MESSAGGI**: Associazione che rappresenta i messaggi inviati tra utenti.
27. **VOTI**: Associazione che rappresenta i voti sui contenuti multimediali.
28. **HOSTING**: Associazione che rappresenta i servizi di hosting utilizzati dagli utenti.

## 2.2 Tavola delle operazioni

| Operazione | Descrizione                                             | Tipo | Frequenza |
| ---------- | ------------------------------------------------------- | ---- | --------- |
| Op1        | Creazione di un nuovo utente                            | I    | 150       |
| Op2        | Aggiornamento delle informazioni del portafoglio        | I    | 300       |
| Op3        | Registrazione di una donazione                          | I    | 200       |
| Op4        | Aggiornamento delle informazioni dell'utente registrato | I    | 250       |
| Op5        | Sottoscrizione di un abbonamento premium                | I    | 180       |
| Op6        | Creazione di un nuovo streamer                          | I    | 50        |
| Op7        | Aggiunta di un nuovo spettatore                         | I    | 400       |
| Op8        | Pianificazione di un evento di programmazione           | I    | 120       |
| Op9        | Creazione di un nuovo canale                            | I    | 110       |
| Op10       | Aggiunta di una nuova categoria                         | I    | 30        |
| Op11       | Upload di un contenuto multimediale                     | I    | 450       |
| Op12       | Creazione di un contenuto live                          | I    | 200       |
| Op13       | Upload di un nuovo video                                | I    | 500       |
| Op14       | Creazione di una nuova clip                             | I    | 400       |
| Op15       | Registrazione di una visualizzazione di un video        | B    | 10000     |
| Op16       | Registrazione di una visualizzazione di una clip        | B    | 8000      |
| Op17       | Aggiunta di un nuovo social                             | I    | 40        |
| Op18       | Inserimento di un nuovo link                            | I    | 60        |
| Op19       | Registrazione di una visita a un contenuto multimediale | B    | 12000     |
| Op20       | Aggiunta di un nuovo commento                           | I    | 700       |
| Op21       | Aggiunta di una reazione a un commento                  | I    | 600       |
| Op22       | Aggiunta di un nuovo emoji                              | I    | 100       |
| Op23       | Aggiunta di un nuovo hashtag                            | I    | 90        |
| Op24       | Associazione di un hashtag a un contenuto multimediale  | I    | 200       |
| Op25       | Follow di un utente                                     | I    | 500       |
| Op26       | Invio di un messaggio tra utenti                        | I    | 400       |
| Op27       | Voto su un contenuto multimediale                       | I    | 600       |
| Op28       | Registrazione di un servizio di hosting utilizzato      | I    | 80        |

## 2.3 Ristrutturazione dello schema E-R

### 2.3.1 Analisi delle ridondanze

> <minimo 2 massimo 4 ridondanze>
>
> <specificare eventuale soglia accessi risparmiati/byte aggiuntivi>

#### 2.3.1.1 RIDONDANZA 1 (<nome ridondanza (attributo, associazione, ...)>)

> Schema riassuntivo della ridondanza (vedi slide)

**DERIVAZIONE:** <descrivere come la ridondanza è derivabile>

**OPERAZIONI COINVOLTE**
    • Opx
    • Opy
    • Opz

**PRESENZA DI RIDONDANZA**

**Opx**

> Schema di operazione

Tavola degli accessi:

| Concetto | Costrutto | Accessi | Tipo | Descrizione |
| -------- | --------- | ------- | ---- | ----------- |
|          |           |         |      |             |
|          |           |         |      |             |

| Costo | Valori |
| ----- | ------ |
| S:    |        |
| L:    |        |
| TOT:  |        |

**Opy**

> Schema di operazione

Tavola degli accessi:

| Concetto | Costrutto | Accessi | Tipo | Descrizione |
| -------- | --------- | ------- | ---- | ----------- |
|          |           |         |      |             |
|          |           |         |      |             |

| Costo | Valori |
| ----- | ------ |
| S:    |        |
| L:    |        |
| TOT:  |        |

...

**ASSENZA DI RIDONDANZA**

**Opx**

> Schema di operazione

Tavola degli accessi:

| Concetto | Costrutto | Accessi | Tipo | Descrizione |
| -------- | --------- | ------- | ---- | ----------- |
|          |           |         |      |             |
|          |           |         |      |             |

| Costo | Valori |
| ----- | ------ |
| S:    |        |
| L:    |        |
| TOT:  |        |

**Opy**

> Schema di operazione

Tavola degli accessi:

| Concetto | Costrutto | Accessi | Tipo | Descrizione |
| -------- | --------- | ------- | ---- | ----------- |
|          |           |         |      |             |
|          |           |         |      |             |

| Costo | Valori |
| ----- | ------ |
| S:    |        |
| L:    |        |
| TOT:  |        |

...

**TOTALI PER RIDONDANZA 1**

| **Presenza di ridondanza** |       |
| ------------------------- | ----- |
| Spazio:                   | <...> |
| Tempo:                    | <...> |
| Decisione:                | <...> |

| **Assenza di ridondanza** |       |
| ------------------------- | ----- |
| Spazio:                   | <...> |
| Tempo:                    | <...> |
| Decisione:                | <...> |

#### 2.3.1.2 RIDONDANZA 2 (<nome ridondanza (attributo, associazione, ...)>)

> <come per ridondanza 1>

> <eventuali ridondanze 3 e 4>

### 2.3.2 Eliminazione delle generalizzazioni

> <se ce ne sono>

#### 2.3.2.1 Generalizzazione 1 (<generalizzazione>)

> <commenti su tecnica usata e motivazioni.>
> <regole aziendali introdotte>

### 2.3.3 Partizionamento/accorpamento di entità e associazioni

> <se ce ne sono>

#### 2.3.3.1 Partizionamento/Accorpamento 1 (<generalizzazione>)

> PORZIONE DI SCHEMA PRIMA E DOPO  DEL PARTIZIONAMENTO/ACCORPAMENTO

> <commenti su tecnica usata e motivazioni>

### 2.3.4.scelta degli identificatori principali

| Entità        | Identificatore principale               |
| ------------- | --------------------------------------- |
| <nome entità> | <attributo/i scelto/i oppure SURROGATO> |
|               |                                         |

> <eventuali commenti. In particolare, va spiegata la scelta di introdurre identificatori surrogati>

## 2.4 Schema E-R ristrutturato + regole aziendali

> QUI CI VA IL VOSTRO SCHEMA ER RISTRUTTURATO

**Regole aziendali**

**Vincoli di Integrità:**


|     |                                        |
| --- | -------------------------------------- |
| RV1 | <concetto> deve/non deve <espressione> |
|     |                                        |

Derivazioni:

|     |                                    |
| --- | ---------------------------------- |
| RD1 | <concetto> si ottiene <operazione> |
|     |                                    |

## 2.5 Schema relazionale con vincoli di integrità referenziale

> <Relazione1 (Identificatore, Attributo1, …)>
> <Relazione2 (Identificatore, Attributo1, …) Relazione2 (Attributo1) referenzia Relazionex (Attributoy)>
> <Relazione3 (Identificatore, Attributo1, …)>
