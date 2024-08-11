# Basi di dati e Sistemi Informativi: Sperimentazioni A.A. 2023-2024 <!-- omit in toc -->

## BOZZA PROGETTAZIONE CONCETTUALE <!-- omit in toc -->

---

## Sommario <!-- omit in toc -->

- [Componenti del gruppo](#componenti-del-gruppo)
- [1.1 Requisiti iniziali](#11-requisiti-iniziali)
  - [1.1.1 Requisiti degli utenti iscritti](#111-requisiti-degli-utenti-iscritti)
  - [1.1.2 Requisiti degli utenti che streammano](#112-requisiti-degli-utenti-che-streammano)
  - [1.1.3 Requisiti delle live, video e clip](#113-requisiti-delle-live-video-e-clip)
  - [1.1.4 Requisiti della statistica degli streamer](#114-requisiti-della-statistica-degli-streamer)
  - [1.1.5 Requisiti della statistica dei canali](#115-requisiti-della-statistica-dei-canali)
  - [1.1.6 Requisiti dei bit](#116-requisiti-dei-bit)
  - [1.1.7 Requisiti dei follower](#117-requisiti-dei-follower)
  - [1.1.8 Requisiti delle diverse chat](#118-requisiti-delle-diverse-chat)
  - [1.1.9 Requisiti della ricerca degli streramer per tutti i tipi di utenti](#119-requisiti-della-ricerca-degli-streramer-per-tutti-i-tipi-di-utenti)
  - [1.1.10 Requisiti degli utenti fragili](#1110-requisiti-degli-utenti-fragili)
  - [1.1.11 Volume delle operazioni](#1111-volume-delle-operazioni)
  - [1.1.12 Requisiti gestione e costi della piattaforma](#1112-requisiti-gestione-e-costi-della-piattaforma)
- [1.2 Glossario dei termini](#12-glossario-dei-termini)
- [1.3 Requisiti riscritti](#13-requisiti-riscritti)
- [1.4 Requisiti strutturati in gruppi di frasi omogenee](#14-requisiti-strutturati-in-gruppi-di-frasi-omogenee)
- [1.5 Schema E-R](#15-schema-e-r)
  - [Commenti sullo Schema ER](#commenti-sullo-schema-er)
    - [Pattern di Progettazione Utilizzati](#pattern-di-progettazione-utilizzati)
    - [Strategia di Progetto Utilizzata](#strategia-di-progetto-utilizzata)
  - [Commento finale](#commento-finale)
    - [Analisi delle Relazioni e degli Attributi](#analisi-delle-relazioni-e-degli-attributi)
  - [1.5.1 Regole aziendali](#151-regole-aziendali)
  - [1.5.2 Vincoli d'integritá](#152-vincoli-dintegritá)
  - [1.5.3 Derivazioni](#153-derivazioni)

---

## Componenti del gruppo

1. Componente 1: Matteo, Palmieri, 20038775
2. Componente 2: Andrea, Fincato, 20050547

---

## 1.1 Requisiti iniziali

<!-- > qui ci va il testo iniziale integrato con osservazioni fatte da voi. Per esempio, se vi vengono forniti dei file integrativi (screenshot dell’applicazione), potete integrare il testo con descrizioni di elementi/funzionalità che sono evidenti dai file. Oppure, potete integrare il testo con funzionalità ovvie dato il problema: se sto gestendo una piattaforma con degli utenti, ovviamente dovrò avere la possibilità di aggiungere un utente. -->

"*Si vuole realizzare una base di dati per un servizio che permette di fare live streaming su vari argomenti. Il live streaming (o, più sinteticamente, la live) permette di interagire con il pubblico in tempo reale grazie a feed video, chat e altro.*"

### 1.1.1 Requisiti degli utenti iscritti

"*Ogni utente può essere spettatore o streamer, o entrambi.*"

- Ogni utente può essere **spettatore** o **streamer**, o entrambi (generalizzazione totale e sovrapposta)

"*Gli spettatori possono essere registrati al servizio oppure possono guardare le live in modo anonimo (guest).*"

- Gli spettatori possono essere **registrati** al servizio oppure possono guardare le live in modo anonimo come **“guest”** (quindi nel DB faremo dei vincoli tali da bloccare operazioni che normalmente solo gli utenti iscritti farebbero, come chattare o abbonarsi)

"*Per registrarsi, gli utenti devono indicare nome utente, password, data di nascita, numero di telefono o indirizzo mail.*"

- Per registrarsi, gli utenti devono indicare **nome utente**, **password**, **data di nascita**, **numero di telefono** o **indirizzo mail** (opzionali il numero di telefono e indirizzo email)

"*Gli utenti iscritti possono chattare, seguire lo streamer, creare dirette. Gli utenti registrati possono abbonarsi (diventando utenti “premium”) ed avere così accesso a contenuti extra come interviste esclusive, podcast e chattare direttamente con i conduttori/artisti protagonisti dei film/concerti etc...*"

- Mediante dei vincoli, verrà impedito agli spettatori “guest” di **chattare**, **abbonarsi**, **seguire lo streamer** e **creare dirette**

### 1.1.2 Requisiti degli utenti che streammano

"*Gli streamer hanno ciascuno un canale, che può essere caratterizzato tramite una descrizione. Per ogni canale, è possibile specificare una lista di social associati (ad esempio Instagram, YouTube, ecc.), un’immagine profilo e anche un trailer (Figura 1(a))*"

- Ogni streamer può avere **un solo canale**
- **Streamer** e **Canale** saranno due entità legate da un vincolo di integrità referenziale

### 1.1.3 Requisiti delle live, video e clip

"*In ogni canale possono esserci live, video (live passate) e clip (video di durata breve). Le live possono anche non diventare video del canale ma ad ogni diretta live, viene inviata una notifica agli utenti che seguono il canale. Ognuno ha un titolo, una durata, appartiene a una categoria (Figura 1(b) e può essere associato a diversi hashtags/emojis etc..). Per ogni live, viene memorizzato il numero medio di spettatori, i commenti e le reazioni (emojis, hashtags etc..) mentre per i video e le clip il numero di visualizzazioni*"

- L'entità **Live** non avrà un attributo **durata**, siccome non è possibile calcolarne la durata al suo inizio. Per una live si salveranno quindi **data** e **ora** di inizio e di fine

### 1.1.4 Requisiti della statistica degli streamer

"*Per ogni creatore di contenuti, si memorizzano il numero di live effettuate, il numero di minuti trasmessi (in diretta e non) e il numero medio di spettatori/utenti simultanei (sia premium che guest)*"

- Mediante dei **contatori**, verranno calcolati questi valori

"*Inoltre, sulla pagina del canale viene visualizzato il numero di followers. Quando uno streamer rispetta determinati parametri di performance (un minimo di 500 minuti trasmessi, una media di tre o più spettatori simultanei, almeno 50 followers), può diventare affiliate*"

- Si aggiunge un attributo **affiliate**, con valore sì oppure no, che sarà assegnato agli streamer a seguito di una selezione con queste condizioni

"*Le stream hanno degli orari. Ogni streamer ha un calendario in cui può dire quando farà stream e indicare il titolo delle prossime live. Inoltre, ogni streamer può anche decidere di trasmettere dirette live solo agli utenti premium (che hanno accesso a contenuti esclusivi)*"

### 1.1.5 Requisiti della statistica dei canali

- Tra i follower del canale, verrà inviata una notifica della live solo agli **utenti premium**. Con dei **vincoli**, verrà impedito ai follower non premium di vedere la live

"*I viewer possono diventare follower del canale degli streamer che preferiscono, e le loro preferenze sono raccolte in un elenco di followee a cui possono accedere dal loro profilo. I viewer possono inoltre supportare gli streamer tramite la subscription (a pagamento) al loro canale, ottenendo dei privilegi (emoticon personalizzate, nessun limite di caratteri nella lunghezza dei commenti, ecc...)*"

- Per ogni canale, verranno forniti dei **privilegi** a tutti **gli utenti che supportano il canale** tramite un abbonamento

### 1.1.6 Requisiti dei bit

"*Inoltre, gli utenti hanno un portafoglio di bit (moneta virtuale che possono acquistare tramite la piattaforma), utilizzabile per effettuare donazioni agli streamer tramite differenti metodi di pagamento elettronici*"

- Solo gli **utenti registrati** al servizio possono avere un **portafoglio di bit**

### 1.1.7 Requisiti dei follower

"*Una volta che i viewer diventano follower, possono votare i contenuti multimediali degli streamer, esprimendosi tramite l’utilizzo di un voto su scala likert (nel range [1,10])*"

- Il voto sarà concesso solo ai **follower**

### 1.1.8 Requisiti delle diverse chat

"*Oltre a chattare pubblicamente, gli utenti – attraverso un sistema di messaggistica privato embedded nella piattaforma - possono scambiarsi messaggi e contenuti multimediali privati*"

### 1.1.9 Requisiti della ricerca degli streramer per tutti i tipi di utenti

"*Gli utenti (sia guest che registrati), possono cercare i contenuti multimediali per hashtag o per categorie (ad es. Musica, Sport, Personaggi famosi, Arte, Talk-show, Games, Simulation, food&drinks, Creative, Strategy, Technology, etc…). Ogni utente registrato, in base ai contenuti/pagine/streamer che segue, ha una lista di contenuti multimediali suggeriti.*"

### 1.1.10 Requisiti degli utenti fragili

"*Infine, gli utenti fragili, possono registrarsi al servizio avendo però a disposizione contenuti multimediali più inclusivi e accessibili (ad es. contenuti in LIS – Lingua Italiana dei Segni per le persone non udenti), oppure una versione delle pagine ad accesso facilitato (caratteri aumentati, stile delle pagine dei canali in b/w).*"

- Viene tenuta traccia degli **utenti fragili** e per loro i contenuti verranno erogati in **modalità differente**

### 1.1.11 Volume delle operazioni

<em>"La base di dati deve supportare le seguenti operazioni:

- Una volta al giorno si controllano le condizioni per la qualifica di affiliate
- Una volta a settimana viene calcolata la classifica degli streamer più seguiti
- Una volta al giorno, viene calcolata la media dei like per ogni contenuto multimediale (per ogni streamer)
- Una volta al giorno, gli amministratori, per ogni contenuto multimediale di ogni streamer, stilano il rating dei video più votati (quelli che, in media, hanno ricevuto una votazione maggiore rispetto agli altri)
- Dieci volte al giorno, vengono controllati ed eliminati tutti i commenti con contenuti offensivi fatti dagli utenti per ogni contenuto multimediale (per ogni streamer), nelle categorie, nei canali e durante le dirette live
- Due volte al giorno vengono controllati i nuovi utenti registrati (sia premium – nuovi abbonati – sia utenti appartenenti a categorie fragili)
- Cinque volte al giorno, gli amministratori delle pagine degli streamer segnalano agli amministratori della base di dati, i profili fake che seguono i loro streamer
- Una volta ogni 6 mesi, gli amministratori possono visualizzare lo storico degli utenti premium (quelli storici (dato un range di date) che quelli recenti (relativi all’ultimo mese)

Qualsiasi altra operazione/funzionalità del sistema e/o modellazione di requisiti non descritti, purché motivata, è ben accetta! (… un po' di fantasia!!!)"</em>

### 1.1.12 Requisiti gestione e costi della piattaforma

"*Si può assumere che i contenuti multimediali vengano gestiti da una piattaforma/server di video hosting esterna (e che quindi sia sufficiente memorizzare solo un URL o indirizzo IP). Per il servizio di hosting, gli amministratori delle pagine, devono pagare un corrispettivo mensile di 50$ al provider che fornisce il servizio di hosting. Se si verificano ritardi per un massimo di 15 giorni a partire dalla data di acquisto/rinnovo dell’hosting, il profilo/canale dello streamer verrà sospeso fino alla data di rinnovo (data di accredito) del pagamento del servizio di hosting*"

---

## 1.2 Glossario dei termini

| Termine           | Descrizione                                                                   | Sinonimi        | Collegamenti             |
| ----------------- | ----------------------------------------------------------------------------- | --------------- | ------------------------ |
| utente            | fruitore del servizio di live streaming                                       |                 | spettatore, streamer     |
| spettatore        | utente che osserva le live e chatta                                           | viewer          | utente registrato, guest |
| streamer          | utente registrato che crea live e contenuti  |amministratore delle pagine, creatore di contenuti| canale, follower         |
| guest             | utente non registrato che osserva le live                                     |                 | live                     |
| utente registrato | utente che si è registrato al servizio                                        | utente iscritto | follower                 |
| utente premium    | utente registrato che paga la piattaforma per benefici maggiori               |                 | utente registrato        |
| canale            | pagina dello streamer, dove pubblica le live                                  |                 | streamer, social         |
| social            | link social dello streamer                                                    |                 | canale                   |
| live              | live corrente che lo streamer sta trasmettendo                                | stream, diretta | canale, streamer         |
| video             | live passate dello streamer                                                   |                 | canale                   |
| clip              | parte di un video di tot. secondi                                             |                 | canale                   |
| affilitate        | streamer che ha superato determinati criteri                                  |                 | streamer                 |
| follower          | utente registrato che segue lo streamer e riceve notifiche delle sue attivitá |                 | streamer, canale         |
| utente fragile    | utente registrato che ha determinate disabilitá                               |                 | utente registrato        |
| bit               | moneta virtuale per effettuare donazioni agli streamer                        |                 | utenti                   |
| subscription      | supporto economico che riceve uno streamer dagli spettatori                   |                 | spettatore, streamer     |
| followee          | streamer che viene seguito dai follower                                       | streamer        | streamer, follower       |
| trailer           | video creato dallo streamer come presentazione del canale                     |                 | canale                   |

## 1.3 Requisiti riscritti

<!-- > qui ci vanno i requisiti della sezione 1.1 riscritti senza sinonimi e con frasi standardizzate.
> Ricordarsi di marcare in maniera grafica <span style="color:red">~~ciò che è stato cancellato/sostituito~~</span> e <span style="color:blue">**ciò che è stato aggiunto**</span>. -->

Si vuole realizzare una base di dati per un servizio che permette di fare live streaming su vari argomenti. Il live streaming (o, più sinteticamente, la live) permette di interagire con il pubblico in tempo reale grazie a feed video, chat e altro.

Ogni utente può essere <span style="color:red">~~spettatore o streamer,~~</span> <span style="color:blue">**spettatore, streamer**</span> o entrambi. Gli spettatori possono essere registrati al servizio oppure possono guardare le live in modo anonimo (guest). Per registrarsi, gli utenti devono indicare nome utente, password, data di nascita, <span style="color:blue">**oppure anche**</span> numero di telefono o indirizzo mail. Gli <span style="color:red">~~utenti iscritti~~</span> <span style="color:blue">**utenti registrati**</span> possono chattare, seguire lo streamer, creare <span style="color:red">~~dirette~~</span> <span style="color:blue">**live**</span>. Gli utenti registrati possono abbonarsi (diventando utenti “premium”) <span style="color:red">~~ed avere così~~</span> <span style="color:blue">**per avere**</span> accesso a contenuti extra come interviste esclusive, podcast e chattare direttamente con i conduttori/artisti protagonisti dei film/concerti etc..

<span style="color:red">~~Gli~~</span> <span style="color:blue">**Ogni**</span> streamer <span style="color:red">~~hanno ciascuno~~</span> <span style="color:blue">**ha**</span> un canale, che può essere caratterizzato tramite una descrizione. <span style="color:red">~~Per ogni~~</span> <span style="color:blue">**Ogni**</span> canale <span style="color:red">~~, è possibile specificare~~</span> <span style="color:blue">**può avere**</span> una lista di social associati (ad esempio Instagram, YouTube, ecc.), un’immagine profilo e anche un trailer (Figura 1(a)). In ogni canale possono esserci live, video (live passate) e clip (video di durata breve). Le live possono anche non diventare video del canale ma ad ogni <span style="color:red">~~diretta live~~</span> <span style="color:blue">**live**</span>, viene inviata una notifica <span style="color:red">~~agli utenti che seguono il canale~~</span> <span style="color:blue">**ai follower del canale**</span>. Ognuno ha un titolo, una durata, appartiene a una categoria (Figura 1(b)) e può essere associato a diversi hashtags/emojis etc..). Per ogni live <span style="color:red">~~, viene memorizzato~~</span> <span style="color:blue">**si rappresentano**</span> il numero medio di spettatori, i commenti e le reazioni (emojis, hashtags etc..) mentre per i video e le clip <span style="color:blue">**si rappresentano**</span> il numero di visualizzazioni.

Per ogni <span style="color:red">~~creatore di contenuti~~</span> <span style="color:blue">**streamer**</span> <span style="color:red">~~, si memorizzano~~</span> <span style="color:blue">**si rappresentano**</span> il numero di live effettuate, il numero di minuti trasmessi (in <span style="color:red">~~diretta~~</span> <span style="color:blue">**live**</span> e non) e il numero medio di spettatori/utenti simultanei (sia premium che guest). Inoltre, sulla pagina del canale viene visualizzato il numero di followers. Quando uno streamer rispetta determinati parametri di performance (un minimo di 500 minuti trasmessi, una media di tre o più spettatori simultanei, almeno 50 followers), può diventare affiliate. Le <span style="color:red">~~stream~~</span> <span style="color:blue">**live**</span> hanno degli orari. Ogni streamer ha un calendario in cui può dire quando farà <span style="color:red">~~stream~~</span> <span style="color:blue">**live**</span> e indicare il titolo delle prossime live. Inoltre, ogni streamer può anche decidere di trasmettere <span style="color:red">~~dirette live~~</span> <span style="color:blue">**live**</span> solo agli utenti premium (che hanno accesso a contenuti esclusivi).

<span style="color:red">~~I viewer~~</span> <span style="color:blue">**Gli spettatori**</span> possono <span style="color:red">~~diventare follower del canale degli streamer che preferiscono,~~</span> <span style="color:blue">**seguire i canali dei loro streamer preferiti.**</span> <span style="color:red">~~e le loro~~</span> <span style="color:blue">**Le**</span> preferenze <span style="color:blue">**degli spettatori**</span> sono raccolte in un elenco di followee a cui <span style="color:red">~~possono~~</span> <span style="color:blue">**ogni spettatore può**</span> accedere dal <span style="color:red">~~loro~~</span> <span style="color:blue">**proprio**</span> profilo. <span style="color:red">~~I viewer~~</span> <span style="color:blue">**Gli spettatori**</span> possono inoltre supportare gli streamer tramite la subscription (a pagamento) al loro canale, ottenendo dei privilegi (emoticon personalizzate, nessun limite di caratteri nella lunghezza dei commenti, ecc.). Inoltre, gli utenti <span style="color:blue">**registrati**</span> hanno un portafoglio di bit (moneta virtuale che possono acquistare tramite la piattaforma), utilizzabile per effettuare donazioni agli streamer tramite differenti metodi di pagamento elettronici.

Una volta che <span style="color:red">~~i viewer~~</span> <span style="color:blue">**gli spettatori**</span> diventano follower, possono votare i contenuti multimediali degli streamer <span style="color:red">~~, esprimendosi tramite l’utilizzo di~~</span> <span style="color:blue">**attraverso**</span> un voto su scala likert (nel range [1,10]). Oltre a chattare pubblicamente, gli utenti – attraverso un sistema di messaggistica privato embedded nella piattaforma - possono scambiarsi messaggi e contenuti multimediali privati.

Gli utenti (sia guest che registrati), possono cercare i contenuti multimediali per hashtag o per categorie (ad es. Musica, Sport, Personaggi famosi, Arte, Talk-show, Games, Simulation, food&drinks, Creative, Strategy, Technology, etc…). Ogni utente registrato, in base ai contenuti/pagine/streamer che segue, ha una lista di contenuti multimediali suggeriti.

Infine, gli utenti fragili, possono registrarsi al servizio avendo però a disposizione contenuti multimediali più inclusivi e accessibili (ad es. contenuti in LIS – Lingua Italiana dei Segni per le persone non udenti), oppure una versione delle pagine ad accesso facilitato (caratteri aumentati, stile delle pagine dei canai in b/w).

La base di dati deve supportare le seguenti operazioni:

- Una volta al giorno si controllano le condizioni per la qualifica di affiliate
- Una volta a settimana viene calcolata la classifica degli streamer più seguiti
- Una volta al giorno, viene calcolata la media dei like per ogni contenuto multimediale (per ogni streamer)
- Una volta al giorno, gli amministratori, per ogni contenuto multimediale di ogni streamer, stilano il rating dei video più votati (quelli che, in media, hanno      ricevuto una votazione maggiore rispetto agli altri)
- Dieci volte al giorno, vengono controllati ed eliminati tutti i commenti con contenuti offensivi fatti dagli utenti per ogni contenuto multimediale (per ogni  streamer), nelle categorie, nei canali e durante le dirette live
- Due volte al giorno vengono controllati i nuovi utenti registrati (sia premium – nuovi abbonati – sia utenti appartenenti a categorie fragili)
- Cinque volte al giorno, gli amministratori delle pagine degli streamer segnalano agli amministratori della base di dati, i profili fake che seguono i loro streamer
- Una volta ogni 6 mesi, gli amministratori possono visualizzare lo storico degli utenti premium (quelli storici (dato un range di date) che quelli recenti (relativi all’ultimo mese))

Qualsiasi altra operazione/funzionalità del sistema e/o modellazione di requisiti non descritti, purché motivata, è ben accetta! (… un po' di fantasia!!!)

Si può assumere che i contenuti multimediali vengano gestiti da una piattaforma/server di video hosting esterna (e che quindi sia sufficiente memorizzare solo un URL o indirizzo IP). Per il servizio di hosting, gli <span style="color:red">~~amministratori delle pagine~~</span> <span style="color:blue">**streamer**</span>, devono pagare un corrispettivo mensile di 50$ al provider che fornisce il servizio di hosting. Se si verificano ritardi per un massimo di 15 giorni a partire dalla data di acquisto/rinnovo dell’hosting, il profilo/canale dello streamer verrà sospeso fino alla data di rinnovo (data di accredito) del pagamento del servizio di hosting.

## 1.4 Requisiti strutturati in gruppi di frasi omogenee

| **Frasi di carattere generale** |
| --- |
| Si vuole realizzare una base di dati per un servizio che permette di fare live streaming su vari argomenti. Il live streaming (o, più sinteticamente, la live) permette di interagire con il pubblico in tempo reale grazie a feed video, chat e altro. |

| Frasi relative a agli **utenti** |
| --- |
| Ogni utente può essere spettatore, streamer o entrambi. Oltre a chattare pubblicamente, gli utenti – attraverso un sistema di messaggistica privato embedded nella piattaforma - possono scambiarsi messaggi e contenuti multimediali privati. Gli utenti (sia guest che registrati), possono cercare i contenuti multimediali per hashtag o per categorie (ad es. Musica, Sport, Personaggi famosi, Arte, Talk-show, Games, Simulation, food&drinks, Creative, Strategy, Technology, etc…). |

| Frasi relative agli **spettatori** |
| --- |
| Gli spettatori possono essere registrati al servizio oppure possono guardare le live in modo anonimo (guest). Gli spettatori possono seguire i canali dei loro streamer preferiti. |

| Frasi relative agli **streamer** |
| --- |
| Per ogni streamer si rappresentano il numero di live effettuate, il numero di minuti trasmessi (in  live e non) e il numero medio di spettatori/utenti simultanei (sia premium che guest). Ogni streamer ha un calendario in cui può dire quando farà live e indicare il titolo delle prossime live. Inoltre, ogni streamer può anche decidere di trasmettere live solo agli utenti premium (che hanno accesso a contenuti esclusivi). |

| Frasi relative ai **guest** |
| --- |
| Gli spettatori [..] possono guardare le live in modo anonimo (guest). |

| Frasi relative agli **utenti registrati** |
| --- |
| Gli utenti registrati possono chattare, seguire lo streamer, creare live. Ogni utente registrato, in base ai contenuti/pagine/streamer che segue, ha una lista di contenuti multimediali suggeriti. |

| Frasi relative agli **utenti premium** |
| --- |
| Gli utenti registrati possono abbonarsi (diventando utenti “premium”) per avere accesso a contenuti extra come interviste esclusive, podcast e chattare direttamente con i conduttori/artisti protagonisti dei film/concerti etc.. |

| Frasi relative ai **canali** |
| --- |
| Ogni streamer ha un canale, che può essere caratterizzato tramite una descrizione. Ogni canale, può avere una lista di social associati (ad esempio Instagram, YouTube, ecc.), un’immagine profilo e anche un trailer (Figura 1(a)). In ogni canale possono esserci live, video (live passate) e clip (video di durata breve). Inoltre, sulla pagina del canale viene visualizzato il numero di followers. |

| Frasi relative ai **social** |
| --- |
| Ogni canale, può avere una lista di social associati (ad esempio Instagram, YouTube, ecc.) [..] |

| Frasi relative alle **live** |
| --- |
| Le live possono anche non diventare video del canale ma ad ogni live, viene inviata una notifica ai follower del canale. Ognuna ha un titolo, una durata, appartiene a una categoria (Figura 1(b)) e può essere associata a diversi hashtags/emojis etc... Per ogni live si rappresentano il numero medio di spettatori, i commenti e le reazioni (emojis, hashtags etc..) [..]. Le live hanno degli orari. |

| Frasi relative ai **video** |
| --- |
| Ognuno ha un titolo, una durata, appartiene a una categoria (Figura 1(b)) e può essere associato a diversi hashtags/emojis etc... [..] per i video [..] si rappresentano il numero di visualizzazioni. |

| Frasi relative alle **clip** |
| --- |
| Ognuna ha un titolo, una durata, appartiene a una categoria (Figura 1(b)) e può essere associata a diversi hashtags/emojis etc... [..] per [..] le clip si rappresentano il numero di visualizzazioni. |

| Frasi relative agli **affilitate** |
| --- |
| Quando uno streamer rispetta determinati parametri di performance (un minimo di 500 minuti trasmessi, una media di tre o più spettatori simultanei, almeno 50 followers), può diventare affiliate. |

| Frasi relative ai **follower** |
| --- |
| Una volta che gli spettatori diventano follower, possono votare i contenuti multimediali degli streamer attraverso un voto su scala likert (nel range [1,10]). |

| Frasi relative agli **utenti fragili** |
| --- |
| [..] gli utenti fragili, possono registrarsi al servizio avendo però a disposizione contenuti multimediali più inclusivi e accessibili (ad es. contenuti in LIS – Lingua Italiana dei Segni per le persone non udenti), oppure una versione delle pagine ad accesso facilitato (caratteri aumentati, stile delle pagine dei canai in b/w). |

| Frasi relative alle **subscription** |
| --- |
| Gli spettatori possono inoltre supportare gli streamer tramite la subscription (a pagamento) al loro canale, ottenendo dei privilegi (emoticon personalizzate, nessun limite di caratteri nella lunghezza dei commenti, ecc.). |

| Frasi relative ai **followee** |
| --- |
| Le preferenze degli spettatori sono raccolte in un elenco di streamer a cui ogni spettatore può accedere dal proprio profilo. |

| Frasi relative ai **trailer** |
| --- |
| Ogni canale, può avere [..] anche un trailer (Figura 1(a)). |

| Frasi relative ai  **bit** |
| --- |
| gli utenti registrati hanno un portafoglio di bit (moneta virtuale che possono acquistare tramite la piattaforma), utilizzabile per effettuare donazioni agli streamer tramite differenti metodi di pagamento elettronici. |

| Frasi relative alla **registrazione** |
| --- |
| Per registrarsi, gli utenti devono indicare nome utente, password, data di nascita, oppure anche numero di telefono o indirizzo mail. |

| Frasi relative alle **operazioni della base di dati** |
| --- |
| La base di dati deve supportare le seguenti operazioni: <br><br>- Una volta al giorno si controllano le condizioni per la qualifica di affiliate <br>- Una volta a settimana viene calcolata la classifica degli streamer più seguiti <br>- Una volta al giorno, viene calcolata la media dei like per ogni contenuto multimediale (per ogni streamer) <br>- Una volta al giorno, gli amministratori, per ogni contenuto multimediale di ogni streamer, stilano il rating dei video più votati (quelli che, in media, hanno ricevuto una votazione maggiore rispetto agli altri) <br>- Dieci volte al giorno, vengono controllati ed eliminati tutti i commenti con contenuti offensivi fatti dagli utenti per ogni contenuto multimediale (per ogni streamer), nelle categorie, nei canali e durante le dirette live <br>- Due volte al giorno vengono controllati i nuovi utenti registrati (sia premium – nuovi abbonati – sia utenti appartenenti a categorie fragili) <br>- Cinque volte al giorno, gli amministratori delle pagine degli streamer segnalano agli amministratori della base di dati, i profili fake che seguono i loro streamer <br>- Una volta ogni 6 mesi, gli amministratori possono visualizzare lo storico degli utenti premium (quelli storici (dato un range di date) che quelli recenti (relativi all’ultimo mese)) |

| Frasi relative al **servizio di hosting** |
| --- |
| Si può assumere che i contenuti multimediali vengano gestiti da una piattaforma/server di video hosting esterna (e che quindi sia sufficiente memorizzare solo un URL o indirizzo IP). Per il servizio di hosting, gli streamer, devono pagare un corrispettivo mensile di 50$ al provider che fornisce il servizio di hosting. Se si verificano ritardi per un massimo di 15 giorni a partire dalla data di acquisto/rinnovo dell’hosting, il profilo/canale dello streamer verrà sospeso fino alla data di rinnovo (data di accredito) del pagamento del servizio di hosting. |

## 1.5 Schema E-R

![Mappa E-R](../Immagini/1.5%20Schema%20E-R.png)

### Commenti sullo Schema ER

#### Pattern di Progettazione Utilizzati

1. **Reificazione di attributo di entità**:
   - **Categoria e Hashtag**: Gli attributi `categoria` e `hashstag` dell'entità `CONTENUTO MULTIMEDIALE` sono stati reificati nelle due entità `CATEGORIA` e `HASHTAG` rispettivamente, permettendo quindi una migliore gestione di hashtag e categorie.
   - **Link Social**: L'attributo `link social` dell'entità `CANALE` è stato reificato nell'entità `LINK SOCIAL`, in modo tale da permettere una migliore gestione dei profili social del canale.

2. **Instance-Of (Istanza di)**:
   - **Utenti e Registrati/Guest/Streamer/Spettatore**:
   Gli utenti del sistema possono essere istanze di diverse categorie, come registrati, guest, streamer o spettatori. Ogni categoria di utente ha attributi e permessi specifici, ma tutti derivano dalla stessa entità di base `UTENTE`.
   - **Interazione e Commento/Reazione/Emoji**:
   Le interazioni rappresentano una classe generale di azioni che includono commenti, reazioni ed emoji. Ogni tipo di interazione è un'istanza specifica di questa classe generale.
   - **Clip, Video e Live**:
   Le entità `CLIP`, `VIDEO` e `LIVE` sono istanze specifiche della classe generale `CONTENUTO MULTIMEDIALE`, entità che rappresenta il concetto generico di "contenuto multimediale".

3. **Reificazione di un’associazione ricorsiva**:
   - **Messaggi**: L'associazione tra `UTENTE` (mittente) e `UTENTE` (destinatario) attraverso i messaggi è stata reificata in un'entità `MESSAGGIO`, catturando dettagli come il testo e il timestamp.
   - **Donazione e Portafoglio**: L'associazione `donazione` tra due portafogli è stata reificata in un'entità `DONAZIONE` per poter tenere traccia delle singole donazioni, grazie anche all'introduzione delle relazioni **_mittente<sub>(P-D)</sub>_** e **_destinatario<sub>(P-D)</sub>_** per tracciare ogni transazione di bit.

4. **Evoluzione di concetto**:
   - **Utenti**: La distinzione tra `GUEST`, `REGISTRATO`, `SPETTATORE` e `STREAMER` rappresenta l'evoluzione del concetto di utente nel sistema, con ruoli e permessi differenti.

#### Strategia di Progetto Utilizzata

- Nella realizzazione dello schema ER è stata utilizzata una **Strategia Mista**:
  - **Top-down**: Inizialmente, sono state identificate le entità principali (ad es. `UTENTE`, `CONTENUTO MULTIMEDIALE`, `CANALE`) e le loro relazioni fondamentali.
  - **Bottom-up**: Successivamente, sono stati dettagliati attributi specifici e relazioni più complesse (ad es. `MESSAGGIO` e `DONAZIONE`), costruendo sulla struttura esistente.
  - **Inside-out**: Alcune parti dello schema, come la gestione dei contenuti multimediali e le interazioni sociali, sono state sviluppate concentrandosi su entità centrali (`CONTENUTO MULTIMEDIALE`) e espandendo verso l'esterno.

### Commento finale

1. **Gerarchie di Generalizzazione**:
   - L'entità `UTENTE` è generalizzata in `GUEST` e `REGISTRATO`. Questo pattern è utilizzato per rappresentare le diverse tipologie/ruoli di utenti, dove `REGISTRATO` ha vari attributi in più rispetto a `GUEST`.

2. **Pattern di Aggregazione**:
   - Lo schema utilizza l'aggregazione in modo logico per raggruppare entità correlate in una struttura più gerarchica come `CONTENUTO MULTIMEDIALE`, che include `LIVE`, `CLIP`, e `VIDEO`.

3. **Separazione delle Responsabilità**:
   - Le entità e le relazioni sono ben definite per separare le responsabilità e facilitare la gestione dei dati. Ad esempio, `MESSAGGIO` é prerogativa di `UTENTE`, separando così la gestione dei messaggi dagli utenti.
  
#### Analisi delle Relazioni e degli Attributi

1. **Relazioni Utente-Contenuto**:
   - Gli utenti registrati possono seguire altri utenti (streamer), inviare messaggi e votare contenuti multimediali, permettendo una migliore interazione sociale tra gli utenti.

2. **Gestione dei Contenuti**:
   - Gli `STREAMER` gestiscono i `CANALI`, che a loro volta contengono `CONTENUTI MULTIMEDIALI`. Questo rispecchia la struttura tipica delle piattaforme di streaming, dove i creatori di contenuti hanno un controllo completo sui loro canali e sui contenuti.

3. **Abbonamenti e Donazioni**:
   - La presenza di `PREMIUM`, `PORTAFOGLIO`, e `DONAZIONI` indica un sistema di monetizzazione che permette agli utenti di effettuare donazioni e sottoscrivere abbonamenti premium.

4. **Molteplicità delle Relazioni**:
   - La molteplicità delle relazioni è stata definita in modo preciso per garantire che le cardinalità vengano rispettate. Ad esempio, un `UTENTE` può mandare e ricevere zero, uno o più messaggi (0,N) ma ogni `MESSAGGIO` ha un solo mittente (1,1) e un solo destinatario (1,1).

5. **Attributi Chiave**:
   - Gli attributi chiave sono chiaramente identificati, come "nome utente" per `UTENTE` e "timestamp" per `MESSAGGIO`, assicurando l'unicità e la tracciabilità dei dati.
  
6. **Reazioni ed Emoji**:
   - La relazione tra `REAZIONE` ed `EMOJI` è da intendersi come segue: in una **_reazione_** è presente uno ed un solo _emoji_ (siccome una reazione è essa stessa un singolo emoji) mentre ogni singolo **_emoji_** può essere presente molte volte nelle varie _reazioni_ oppure non venire mai utlizzato in nessuna _reazione_.

### 1.5.1 Regole aziendali

### 1.5.2 Vincoli d'integritá

| RVI  | \<concetto\> deve/non deve \<espressione\>                                                           |
| ---- | ---------------------------------------------------------------------------------------------------- |
| RV1  | Uno streamer deve essere un utente registrato al servizio.                                           |
| RV2  | Un guest non deve avere accesso alle funzionalità riservate agli utenti registrati.                  |
| RV3  | Un messaggio deve avere un mittente e un destinatario.                                               |
| RV4  | Una donazione deve essere associata a un portafoglio e avere un mittente e un destinatario.          |
| RV5  | Il destinatario di una donazione deve essere uno streamer.                                           |
| RV6  | Un canale deve essere gestito da uno streamer.                                                       |
| RV7  | Il "nome utente" dell'utente guest deve essere composto dalla stringa 'guest_' piú l'UUID.           |
| RV8  | Ogni programmazione deve avere un titolo e un timestamp, oltre alle opzioni LIS e premium compilate. |
| RV9  | Ogni contenuto multimediale deve avere una categoria.                                                |
| RV10 | Ogni reazione deve essere associata ad una emoji.                                                    |
| RV11 | Ogni video deve essere associato ad una live per poter esistere.                                     |
| RV12 | Ogni clip deve essere associata ad un video per poter esistere.                                      |
| RV13 | La durata di una clip deve essere inferiore a quella di un video.                                    |
| RV14 | Il voto ai contenuti multimediali di uno streamer deve essere concesso solo ai suoi follower.        |

### 1.5.3 Derivazioni

| RDI | \<concetto\> si ottiene \<operazione\>                                                                                                              |
| --- | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| RD1 | Il numero totale di follower si ottiene sommando tutti gli utenti registrati che seguono il canale.                                                 |
| RD2 | Il numero di visualizzazioni di una clip o di un video si ottiene sommando tutti gli utenti (registrati e non) che hanno visualizzato il contenuto. |
| RD3 | Il numero totale di minuti trasmessi da uno streamer si ottiene sommando la durata di ogni live del canale.                                         |
| RD4 | Il permesso di voto si ottiene verificando che lo spettatore sia un utente registrato al servizio e che segua il canale.                            |
| RD5 | La popolarità di un contenuto multimediale si ottiene contando il numero di visualizzazioni, commenti e reazioni ricevute.                          |
| RD6 | L'affluenza media di una live si ottiene dividendo l'affluenza totale per il numero di affluenze momentanee calcolate durante la live.              |
| RD7 | Il numero di interazioni si ottiene sommando commenti e reazioni associate a un contenuto multimediale.                                             |
