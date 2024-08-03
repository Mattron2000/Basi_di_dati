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

| Concetto                      | Tipo | Volume     |
| ----------------------------- | ---- | ---------- |
| UTENTE                        | E    | 100,000    |
| PORTAFOGLIO                   | E    | 70,000     |
| conto                         | A    | 35,000     |
| DONAZIONE                     | E    | 500,000    |
| REGISTRATO                    | E    | 80,000     |
| STREAMER                      | E    | 10,000     |
| gestione<sub>(S-C)</sub>      | A    | 10,000     |
| SPETTATORE                    | E    | 70,000     |
| streaming                     | A    | 150,000    |
| PROGRAMMAZIONE                | E    | 200,000    |
| CANALE                        | E    | 10,000     |
| associazione<sub>(CM-H)</sub> | A    | 500,000    |
| CATEGORIA                     | E    | 100        |
| appartenenza                  | A    | 250,000    |
| CONTENUTO MULTIMEDIALE        | E    | 1,000,000  |
| LIVE                          | E    | 100,000    |
| VIDEO                         | E    | 500,000    |
| CLIP                          | E    | 900,000    |
| LINK SOCIAL                   | E    | 1,000      |
| visita                        | A    | 20,000,000 |
| INTERAZIONE                   | E    | 20,000,000 |
| COMMENTO                      | E    | 5,000,000  |
| REAZIONE                      | E    | 15,000,000 |
| EMOJI                         | E    | 3,800      |
| HASHTAG                       | E    | 5,000      |
| follower                      | A    | 500,000    |
| MESSAGGIO                     | E    | 2,000,000  |
| voto                          | A    | 700,000    |
| abbonamento                   | A    | 20,000     |
| HOSTING                       | E    | 50,000     |
| rinnovo                       | A    | 100,000    |
| contenitore                   | A    | 40,000     |
| AFFLUENZA                     | E    | 500,000    |
| media spettatori              | A    | 250,000    |
| riferimento                   | A    | 200,000    |
| scomposizione                 | A    | 900,000    |
| presenza<sub>(C-E)</sub>      | A    | 1,000,000  |
| presenza<sub>(R-E)</sub>      | A    | 15,000,000 |
| gestione<sub>(I-R)</sub>      | A    | 20,000,000 |
| associazione<sub>(LS-C)</sub> | A    | 5,000      |
| mittente<sub>(M-R)</sub>      | A    | 2,000,000  |
| mittente<sub>(P-D)</sub>      | A    | 100,000    |
| destinatario<sub>(M-R)</sub>  | A    | 2,000,000  |
| destinatario<sub>(P-D)</sub>  | A    | 100,000    |

1. **UTENTE**: Entità che rappresenta gli utenti della piattaforma.
2. **PORTAFOGLIO**: Entità che rappresenta il portafoglio di ciascun utente registrato.
3. **DONAZIONE**: Entità che rappresenta le donazioni effettuate da utenti a streamer.
4. **REGISTRATO**: Entità che rappresenta gli utenti registrati con informazioni aggiuntive.
5. **INTERAZIONE**: Entità che rappresenta tutte le interazioni (commenti e reazioni) ad una live.
6. **STREAMER**: Entità che rappresenta gli utenti che sono streamer.
7. **SPETTATORE**: Entità che rappresenta gli utenti che sono spettatori.
8. **PROGRAMMAZIONE**: Entità che rappresenta gli eventi programmati di live streaming.
9. **CANALE**: Entità che rappresenta il canale gestito dallo streamer.
10. **CATEGORIA**: Entità che rappresenta le categorie dei contenuti.
11. **CONTENUTO MULTIMEDIALE**: Entità generale che rappresenta i contenuti multimediali.
12. **LIVE**: Entità che rappresenta le live.
13. **VIDEO**: Entità che rappresenta i video.
14. **CLIP**: Entità che rappresenta le clip.
15. **LINK SOCIAL**: Entità che rappresenta i link dei social media scritti dal gestore del canale (streamer).
16. **visita**: Associazione che rappresenta le visite ai contenuti multimediali.
17. **COMMENTO**: Entità che rappresenta i commenti sulle live.
18. **REAZIONE**: Entità che rappresenta le reazioni alle live.
19. **EMOJI**: Entità che rappresenta gli emoji usati nei commenti e reazioni.
20. **HASHTAG**: Entità che rappresenta gli hashtag utilizzati.
21. **follower**: Associazione che rappresenta i follow tra utenti registrati.
22. **MESSAGGIO**: Entità che rappresenta i messaggi inviati tra utenti.
23. **voto**: Associazione che rappresenta i voti ai contenuti multimediali.
24. **abbonamento**: Associazione che rappresenta l'abbonamento degli utenti registrati a uno specifico utente streamer.
25. **HOSTING**: Entità che rappresenta i servizi di hosting utilizzati dagli streamer.
26. **conto**: Associazione che rappresenta il conto associato al portafoglio di bit dell'utente.
27. **gestione<sub>(S-C)</sub>**: Associazione che rappresenta la gestione del canale da parte dello streamer.
28. **streaming**: Associazione che rappresenta l'attività di streaming.
29. **associazione<sub>(CM-H)</sub>**: Associazione che rappresenta l'associazione di un contenuto multimediale ad un hashtag.
30. **appartenenza**: Associazione che rappresenta l'appartenenza di un contenuto multimediale ad una categoria.
31. **rinnovo**: Associazione che rappresenta il rinnovo di un servizio di hosting.
32. **contenitore**: Associazione che rappresenta la presenza di contenuti multimediali in un canale.
33. **AFFLUENZA**: Entità che rappresenta il numero totale di spettatori di una live in un dato momento.
34. **media spettatori**: Associazione che rappresenta le medie di spettatori di una live.
35. **scomposizione**: Associazione che rappresenta la scomposizione di un video in clip.
36. **presenza<sub>(C-E)</sub>**: Associazione che indica la presenza di emoji in un commento.
37. **presenza<sub>(R-E)</sub>**: Associazione che indica la presenza di emoji in una reazione.
38. **gestione<sub>(I-R)</sub>**: Associazione che rappresenta la gestione delle interazioni di ogni utente registrato.
39. **associazione<sub>(LS-C)</sub>**: Associazione che rappresenta il collegamento tra il canale e i suoi profili social.
40. **mittente<sub>(M-R)</sub>**: Associazione che rappresenta il mittente di un messaggio.
41. **mittente<sub>(P-D)</sub>**: Associazione che rappresenta il mittente di una donazione.
42. **destinatario<sub>(M-R)</sub>**: Associazione che rappresenta il destinatario di un messaggio.
43. **destinatario<sub>(P-D)</sub>**: Associazione che rappresenta il destinatario di una donazione.

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
