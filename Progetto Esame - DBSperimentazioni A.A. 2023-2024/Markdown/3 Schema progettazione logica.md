# Basi di dati e Sistemi Informativi: Sperimentazioni A.A. 2023-2024 <!-- omit in toc -->

## BOZZA PROGETTAZIONE LOGICA <!-- omit in toc -->

---

## Sommario <!-- omit in toc -->

- [2.1 Tavola dei volumi](#21-tavola-dei-volumi)
- [2.2 Tavola delle operazioni](#22-tavola-delle-operazioni)
- [2.3 Ristrutturazione dello schema E-R](#23-ristrutturazione-dello-schema-e-r)
  - [2.3.1 Analisi delle ridondanze](#231-analisi-delle-ridondanze)
    - [2.3.1.1 RIDONDANZA 1 (ridondanza dei likert)](#2311-ridondanza-1-ridondanza-dei-likert)
      - [2.3.1.1.1 DERIVAZIONE](#23111-derivazione)
      - [2.3.1.1.2 OPERAZIONI COINVOLTE](#23112-operazioni-coinvolte)
      - [2.3.1.1.3 PRESENZA DI RIDONDANZA](#23113-presenza-di-ridondanza)
        - [2.3.1.1.3.1 Op3](#231131-op3)
        - [2.3.1.1.3.2 Op4](#231132-op4)
      - [2.3.1.1.4 ASSENZA DI RIDONDANZA](#23114-assenza-di-ridondanza)
        - [2.3.1.1.4.1 Op3](#231141-op3)
        - [2.3.1.1.4.2 Op4](#231142-op4)
      - [2.3.1.1.5 TOTALI PER RIDONDANZA 1](#23115-totali-per-ridondanza-1)
      - [2.3.1.1.6 Decisione](#23116-decisione)
    - [2.3.1.2 RIDONDANZA 2 (ridondanza dell'affluenza media)](#2312-ridondanza-2-ridondanza-dellaffluenza-media)
      - [2.3.1.2.1 DERIVAZIONE](#23121-derivazione)
      - [2.3.1.2.2 OPERAZIONI COINVOLTE](#23122-operazioni-coinvolte)
      - [2.3.1.2.3 PRESENZA DI RIDONDANZA](#23123-presenza-di-ridondanza)
        - [2.3.1.2.3.1 Op9](#231231-op9)
      - [2.3.1.2.4 ASSENZA DI RIDONDANZA](#23124-assenza-di-ridondanza)
        - [2.3.1.2.4.1 Op9](#231241-op9)
        - [2.3.1.2.5 TOTALI PER RIDONDANZA 2](#23125-totali-per-ridondanza-2)
        - [2.3.1.2.6 Decisione](#23126-decisione)
  - [2.3.2 Eliminazione delle generalizzazioni](#232-eliminazione-delle-generalizzazioni)
    - [2.3.2.1 Generalizzazione 1 (generalizzazione dell'utente)](#2321-generalizzazione-1-generalizzazione-dellutente)
    - [2.3.2.2 Generalizzazione 2 (generalizzazione del contenuto multimediale)](#2322-generalizzazione-2-generalizzazione-del-contenuto-multimediale)
    - [2.3.2.3 Generalizzazione 3 (generalizzazione del'interazione utenti-contenuto multimediale)](#2323-generalizzazione-3-generalizzazione-delinterazione-utenti-contenuto-multimediale)
  - [2.3.3 Partizionamento/accorpamento di entità e associazioni](#233-partizionamentoaccorpamento-di-entità-e-associazioni)
    - [2.3.3.1 Partizionamento/Accorpamento 1 ()](#2331-partizionamentoaccorpamento-1-)
  - [2.3.4.scelta degli identificatori principali](#234scelta-degli-identificatori-principali)
- [2.4 Schema E-R ristrutturato + regole aziendali](#24-schema-e-r-ristrutturato--regole-aziendali)
  - [2.4.1 Regole aziendali](#241-regole-aziendali)
  - [2.4.2 Vincoli di Integrità](#242-vincoli-di-integrità)
  - [2.4.3 Derivazioni](#243-derivazioni)
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
| UTENTE                        | E    | 200,000    |
| GUEST                         | E    | 100,000    |
| PORTAFOGLIO                   | E    | 70,000     |
| conto                         | A    | 35,000     |
| DONAZIONE                     | E    | 500,000    |
| REGISTRATO                    | E    | 80,000     |
| PREMIUM                       | E    | 35,000     |
| STREAMER                      | E    | 30,000     |
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

<!--
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
-->

| Operazione | Descrizione                                                                                                                        | Tipo | Frequenza              |
| ---------- | ---------------------------------------------------------------------------------------------------------------------------------- | ---- | ---------------------- |
| Op1        | Controlla le condizioni per la qualifica di affiliate                                                                              | B    | Una volta al giorno    |
| Op2        | Calcola la classifica degli streamer più seguiti                                                                                   | B    | Una volta a settimana  |
| Op3        | Calcola la media dei like per ogni contenuto multimediale per ogni streamer                                                        | B    | Una volta al giorno    |
| Op4        | Gli amministratori, per ogni contenuto multimediale di ogni streamer, stilano il rating dei video più votati                       | B    | Una  volta  al  giorno |
| Op5        | Controlla ed elimina tutti i commenti offensivi per ogni contenuto multimediale, nelle categorie, canali e durante le live         | B    | Dieci volte al giorno  |
| Op6        | Controlla i nuovi utenti registrati                                                                                                | B    | Due volte al giorno    |
| Op7        | Gli amministratori del DB controlla le segnalazioni inviate dagli streamer di profili fake che lo seguono                          | I    | Cinque volte al giorno |
| Op8        | Visualizzare agli amministratori lo storico degli utenti premium quelli storici (dato un range di dati)che quelli dell’ultimo mese | I    | Una volta ogni 6 mesi  |
| Op9        | Stilare la media dei degli spettatori per ogni live uscito in quel mese per ogni streamer                                          | B    | Una volta ogni mese    |

## 2.3 Ristrutturazione dello schema E-R

### 2.3.1 Analisi delle ridondanze

Nel processo di ristrutturazione, ci concentreremo sull'analisi e la risoluzione delle seguenti ridondanze:

- **ridondanza dei likert**
- **ridondanza dell'affluenza media**

#### 2.3.1.1 RIDONDANZA 1 (ridondanza dei likert)

![Ridondanza 1](../Immagini/2.3.1.1%20ridondanza%201.png)

##### 2.3.1.1.1 DERIVAZIONE

L'attributo "numero likert" presente nella tabella `CONTENUTO MULTIMEDIALE` é derivabile contando quantii voti sono presenti nella tabella `VOTO` fatti dagli utenti registrati a uno specifico contenuto multimediale.

L'attributo "totale likert" presente nella tabella `CONTENUTO MULTIMEDIALE` é derivabile dalla somma dei voti presenti nella tabella `VOTO` fatti dagli utenti registrati a uno specifico contenuto multimediale.

##### 2.3.1.1.2 OPERAZIONI COINVOLTE

| Operazione | Descrizione                                                                                                  | Tipo | Frequenza           |
| ---------- | ------------------------------------------------------------------------------------------------------------ | ---- | ------------------- |
| Op3        | Calcola la media dei like per ogni contenuto multimediale per ogni streamer                                  | B    | Una volta al giorno |
| Op4        | Gli amministratori, per ogni contenuto multimediale di ogni streamer, stilano il rating dei video più votati | B    | Una volta al giorno |

##### 2.3.1.1.3 PRESENZA DI RIDONDANZA

###### 2.3.1.1.3.1 Op3

> Schema di operazione

Tavola degli accessi:

| Concetto               | Costrutto | Accessi | Tipo | Descrizione                             |
| ---------------------- | --------- | ------- | ---- | --------------------------------------- |
| CONTENUTO MULTIMEDIALE | E         | 1       | L    | Cerco "totale likert" e "numero likert" |

> La media mi sembra scontata scrivere si ottiene facendo la seguente divisione "totale likert" / "numero likert"

| Costo | Valori           |
| ----- | ---------------- |
| S:    | 0                |
| L:    | 1                |
| TOT:  | 1 accesso/giorno |

###### 2.3.1.1.3.2 Op4

> Schema di operazione

Tavola degli accessi:

| Concetto               | Costrutto | Accessi | Tipo | Descrizione                                       |
| ---------------------- | --------- | ------- | ---- | ------------------------------------------------- |
| VIDEO                  | E         | 1       | L    | Prendo tutti gli identificativi dei video         |
| CONTENUTO MULTIMEDIALE | E         | 1       | L    | Cerco "totale likert" e "numero likert" dei video |

| Costo | Valori           |
| ----- | ---------------- |
| S:    | 0                |
| L:    | 2                |
| TOT:  | 2 accesso/giorno |

##### 2.3.1.1.4 ASSENZA DI RIDONDANZA

###### 2.3.1.1.4.1 Op3

> Schema di operazione

Tavola degli accessi:

| Concetto | Costrutto | Accessi | Tipo | Descrizione    |
| -------- | --------- | ------- | ---- | -------------- |
| VOTO     | E         | 1       | L    | Cerco "likert" |

| Costo | Valori           |
| ----- | ---------------- |
| S:    | 0                |
| L:    | 1                |
| TOT:  | 1 accesso/giorno |

###### 2.3.1.1.4.2 Op4

> Schema di operazione

Tavola degli accessi:

| Concetto | Costrutto | Accessi | Tipo | Descrizione                               |
| -------- | --------- | ------- | ---- | ----------------------------------------- |
| VIDEO    | E         | 1       | L    | Prendo tutti gli identificativi dei video |
| VOTO     | E         | 1       | L    | Cerco "likert"                            |

| Costo | Valori           |
| ----- | ---------------- |
| S:    | 0                |
| L:    | 2                |
| TOT:  | 2 accesso/giorno |

##### 2.3.1.1.5 TOTALI PER RIDONDANZA 1

| **Presenza di ridondanza** |                                   |
| -------------------------- | --------------------------------- |
| Spazio:                    | 8 * 1,000,000 Byte aggiuntivi |
| Tempo:                     | 4 accessi/giorno                  |

| **Assenza di ridondanza** |                  |
| ------------------------- | ---------------- |
| Spazio:                   | 0                |
| Tempo:                    | 4 accessi/giorno |

##### 2.3.1.1.6 Decisione

Questa ridondanza risulta inutile in quanto non risparmia nemmeno un singolo accesso sprecando circa 7.6 MB.

#### 2.3.1.2 RIDONDANZA 2 (ridondanza dell'affluenza media)

![Ridondanza 2](../Immagini/2.3.1.2%20ridondanza%202.png)

##### 2.3.1.2.1 DERIVAZIONE

L'attributo "affluenza media" presente nella tabella `LIVE` é derivabile dalla somma del numero degli utenti spettatori presenti nella tabella `AFFLUENZA` a uno specifico contenuto multimediale diviso il numero delle righe coinvolte nella somma semre dalla medesima tabella.

##### 2.3.1.2.2 OPERAZIONI COINVOLTE

| Operazione | Descrizione                                                                               | Tipo | Frequenza           |
| ---------- | ----------------------------------------------------------------------------------------- | ---- | ------------------- |
| Op9        | Stilare la media dei degli spettatori per ogni live uscito in quel mese per ogni streamer | B    | Una volta ogni mese |

##### 2.3.1.2.3 PRESENZA DI RIDONDANZA

###### 2.3.1.2.3.1 Op9

Tavola degli accessi:

| Concetto | Costrutto | Accessi | Tipo | Descrizione                             |
| -------- | --------- | ------- | ---- | --------------------------------------- |
| LIVE     | E         | 1       | L    | Cerco "media affluenza" e "data inizio" |

| Costo | Valori         |
| ----- | -------------- |
| S:    | 0              |
| L:    | 1              |
| TOT:  | 1 accesso/mese |

##### 2.3.1.2.4 ASSENZA DI RIDONDANZA

###### 2.3.1.2.4.1 Op9

Tavola degli accessi:

| Concetto  | Costrutto | Accessi | Tipo | Descrizione                                           |
| --------- | --------- | ------- | ---- | ----------------------------------------------------- |
| LIVE      | E         | 1       | L    | Cerco "data inizio" e filtro quelli del mese corrente |
| AFFLUENZA | E         | 1       | L    | Cerco "numero spettatori"                             |

> uno volta ottenuto questi due dati, faccio la somma del numero degli spettatori diviso il numero di righe coivolte di quella specifica live.

| Costo | Valori         |
| ----- | -------------- |
| S:    | 0              |
| L:    | 2              |
| TOT:  | 2 accessi/mese |

###### 2.3.1.2.5 TOTALI PER RIDONDANZA 2

| **Presenza di ridondanza** |                           |
| -------------------------- | ------------------------- |
| Spazio:                    | 4 * 100,000 Byte occupati |
| Tempo:                     | 1 accesso/mese            |

| **Assenza di ridondanza** |                |
| ------------------------- | -------------- |
| Spazio:                   | 0              |
| Tempo:                    | 2 accessi/mese |

###### 2.3.1.2.6 Decisione

In conclusione, si risulta uno spreco di circa 390 KB solamente per dimezzare il numero di accessi mensili.

### 2.3.2 Eliminazione delle generalizzazioni

Nel processo di ristrutturazione, ci concentreremo sull'analisi e la rimozione delle seguenti generalizzazioni:

- **generalizzazione dell'utente**
- **generalizzazione del contenuto multimediale**
- **generalizzazione del'interazione utenti-contenuto multimediale**

#### 2.3.2.1 Generalizzazione 1 (generalizzazione dell'utente)

![Generalizzazione 1a](../Immagini/2.3.2.1%20generalizzazione%201a.png)

Dallo schema E-R concettuale, noto che le tabelle figlie `GUEST`, `STREAMER` e `SPETTATORE` non hanno attributi, concentramoci prima sugli ultimi due:

`STREAMER` e `SPETTATORE`, le due tabelle non sono effettivamente delle entità ma dei ruoli che l'entità padre `REGISTRATO` può assumere di tanto in tanto, quindi le tabelle possono essere incorporate nella tabella `REGISTRATO` senza aggiungere attributi "tipo".

![Generalizzazione 1b](../Immagini/2.3.2.1%20generalizzazione%201b.png)

Adesso ci concentriamo sulla tabella senza attributi rimasta:

qui risulta controproducente incorporare le tabelle figlie, `GUEST` e `REGISTRATO`, alla tabella padre `UTENTE`, in quanto si creerebbero degli sprechi di spazio producendo una base dati denormalizzata con
valori nulli per colpa di `GUEST`, insomma non è l'opzione giusta, ma potremmo incorporare solamente la tabella `GUEST` alla tabella madre in quanto un'utente guest, per essere identificato, basta solamente un nome utente univoco.

![Generalizzazione 1c](../Immagini/2.3.2.1%20generalizzazione%201c.png)

Alla fine rimane solo la tabella figlia `REGISTRATO` che ha numerosi attributi, quindi per evitare di incorporare alla tabella madre che crea sprechi di spazio scritto precedentemente, sostituisco la generalizzazione con una associazione "parte di".

![Generalizzazione 1d](../Immagini/2.3.2.1%20generalizzazione%201d.png)

Avendo due tabelle si crea una divisione tra le due sui permessi, in modo che la tabella `UTENTE` comprende sia utenti guest e utenti registrati e può essere utilizzato per permettere alla sola visualizzazione dei contenuti multimediali.
Invece la tabella `REGISTRATO` viene utilizzato per compiere azioni dove gli utenti guest sono esclusi.

#### 2.3.2.2 Generalizzazione 2 (generalizzazione del contenuto multimediale)

![Generalizzazione 2a](../Immagini/2.3.2.2%20generalizzazione%202a.png)

#### 2.3.2.3 Generalizzazione 3 (generalizzazione del'interazione utenti-contenuto multimediale)

![Generalizzazione 3a](../Immagini/2.3.2.3%20generalizzazione%203a.png)

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

### 2.4.1 Regole aziendali

### 2.4.2 Vincoli di Integrità

|     |                                        |
| --- | -------------------------------------- |
| RV1 | <concetto> deve/non deve <espressione> |
|     |                                        |

### 2.4.3 Derivazioni

|     |                                    |
| --- | ---------------------------------- |
| RD1 | <concetto> si ottiene <operazione> |
|     |                                    |

## 2.5 Schema relazionale con vincoli di integrità referenziale

> <Relazione1 (Identificatore, Attributo1, …)>
> <Relazione2 (Identificatore, Attributo1, …) Relazione2 (Attributo1) referenzia Relazionex (Attributoy)>
> <Relazione3 (Identificatore, Attributo1, …)>
