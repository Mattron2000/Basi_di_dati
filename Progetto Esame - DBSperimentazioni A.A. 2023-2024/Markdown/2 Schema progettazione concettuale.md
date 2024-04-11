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
  - [1.1.6 Requisiti dei follower](#116-requisiti-dei-follower)
  - [1.1.6 Requisiti delle diverse chat](#116-requisiti-delle-diverse-chat)
  - [1.1.7 Requisiti della ricerca degli streramer per tutti i tipi di utenti](#117-requisiti-della-ricerca-degli-streramer-per-tutti-i-tipi-di-utenti)
  - [1.1.8 Requisiti degli utenti fragili](#118-requisiti-degli-utenti-fragili)
  - [1.1.9 Volume delle operazioni](#119-volume-delle-operazioni)
  - [1.1.10 Requisiti gestione e costi della piattaforma](#1110-requisiti-gestione-e-costi-della-piattaforma)
- [1.2. Glossario dei termini](#12-glossario-dei-termini)
- [1.3. Requisiti riscritti](#13-requisiti-riscritti)

---

## Componenti del gruppo

1. Componente 1: Matteo, Palmieri, 20038775
2. Componente 2: Andrea, Fincato, 20050547

---

## 1.1 Requisiti iniziali

> qui ci va il testo iniziale integrato con osservazioni fatte da voi. Per esempio, se vi vengono forniti dei file integrativi (screenshot dell’applicazione), potete integrare il testo con descrizioni di elementi/funzionalità che sono evidenti dai file. Oppure, potete integrare il testo con funzionalità ovvie dato il problema: se sto gestendo una piattaforma con degli utenti, ovviamente dovrò avere la possibilità di aggiungere un utente.

"*Si vuole realizzare una base di dati per un servizio che permette di fare live streaming su vari argomenti. Il live streaming (o, più sinteticamente, la live) permette di interagire con il pubblico in tempo reale grazie a feed video, chat e altro*"

### 1.1.1 Requisiti degli utenti iscritti

"*Ogni utente può essere **spettatore** o **streamer**, o entrambi.*"

- Ogni utente può essere spettatore o streamer, o entrambi (generalizzazione totale e sovrapposta)

"*Gli spettatori possono essere registrati al servizio oppure possono guardare le live in modo anonimo (guest).*"

- Gli spettatori possono essere **registrati** al servizio oppure possono guardare le live in modo anonimo come **“guest”** (quindi nel DB non faremo la tabella dei guest perché altrimenti non sarebbero anonimi, al massimo faremo dei vincoli tali da bloccare operazioni che normalmente solo gli utenti iscritti farebbero, come chattare o abbonarsi)

"*Per registrarsi, gli utenti devono indicare nome utente, password, data di nascita, numero di telefono o indirizzo mail.*"

- Per registrarsi, gli utenti devono indicare **nome utente**, **password**, **data di nascita**, **numero di telefono** o **indirizzo mail** (opzionali il numero di telefono e indirizzo email)

"*Gli utenti iscritti possono chattare, seguire lo streamer, creare dirette. Gli utenti registrati possono abbonarsi (diventando utenti “premium”) ed avere così accesso a contenuti extra come interviste esclusive, podcast e chattare direttamente con i conduttori/artisti protagonisti dei film/concerti etc...*"

- Mediante dei vincoli, verrà impedito agli spettatori “guest” di **chattare**, **abbonarsi**, **seguire lo streamer** e **creare dirette**

### 1.1.2 Requisiti degli utenti che streammano

"*Gli streamer hanno ciascuno un canale, che può essere caratterizzato tramite una descrizione. Per ogni canale, è possibile specificare una lista di social associati (ad esempio Instagram, YouTube, ecc.), un’immagine profilo e anche un trailer (**Figura 1(a)**)*"

- Ogni streamer può avere **un solo canale**
- **Streamer** e **Canale** saranno due entità legate da un vincolo di integrità referenziale, così come le entità **Canale** e **Social**. Gli attributi **lista_social**, **immagine_profilo** e **trailer** sono opzionali, quindi potranno assumere il valore **null**

### 1.1.3 Requisiti delle live, video e clip

"*In ogni canale possono esserci live, video (live passate) e clip (video di durata breve). Le live possono anche non diventare video del canale ma ad ogni diretta live, viene inviata una notifica agli utenti che seguono il canale*"

- Per distinguere clip da video, si imposteranno dei limiti di durata per le clip.

"*Ognuno ha un titolo, una durata, appartiene a una categoria (Figura 1(b) e può essere associato a diversi hashtags/emojis etc..). Per ogni live, viene memorizzato il numero medio di spettatori, i commenti e le reazioni (emojis, hashtags etc..) mentre per i video e le clip il numero di visualizzazioni*"

- **Titolo**, **durata** e **categoria** saranno gli attributi delle entità **Live**, **Video** e **Clip**. L’attributo **categoria** è opzionale e in più le entità avranno gli attributi **canale** e **streamer** per poterne ricavare la provenienza. L’entità Live avrà anche gli attributi **media_spettatori**, **commenti** e **reazioni**, mentre le entità Video e Clip avranno anche l’attributo **visualizzazioni**

### 1.1.4 Requisiti della statistica degli streamer

"*Per ogni creatore di contenuti, si memorizzano il numero di live effettuate, il numero di minuti trasmessi (in diretta e non) e il numero medio di spettatori/utenti simultanei (sia premium che guest)*"

- Mediante dei **contatori**, verranno calcolati questi valori

"*Inoltre, sulla pagina del canale viene visualizzato il numero di followers. Quando uno streamer rispetta determinati parametri di performance (un minimo di 500 minuti trasmessi, una media di tre o più spettatori simultanei, almeno 50 followers), può diventare affiliate*"

- Si aggiunge un attributo **affiliate**, con valore sì oppure no, che sarà assegnato agli streamer a seguito di una selezione con queste condizioni

"*Le stream hanno degli orari. Ogni streamer ha un calendario in cui può dire quando farà stream e indicare il titolo delle prossime live. Inoltre, ogni streamer può anche decidere di trasmettere dirette live solo agli utenti premium (che hanno accesso a contenuti esclusivi)*"

### 1.1.5 Requisiti della statistica dei canali

- Tra i follower del canale, verrà inviata una notifica della live solo agli **utenti premium**. Con dei **vincoli**, verrà impedito ai follower non premium di vedere la live

"*I viewer possono diventare follower del canale degli streamer che preferiscono, e le loro preferenze sono raccolte in un elenco di followee a cui possono accedere dal loro profilo. I viewer possono inoltre supportare gli streamer tramite la subscription (a pagamento) al loro canale, ottenendo dei privilegi (emoticon personalizzate, nessun limite di caratteri nella lunghezza dei commenti, ecc...)*"

- Per ogni canale, verrà mantenuta una **lista degli utenti che supportano il canale** e che quindi avranno diritto a **privilegi**

### 1.1.6 Requisiti dei bit

"*Inoltre, gli utenti hanno un portafoglio di bit (moneta virtuale che possono acquistare tramite la piattaforma), utilizzabile per effettuare donazioni agli streamer tramite differenti metodi di pagamento elettronici*"

### 1.1.6 Requisiti dei follower

"*Una volta che i viewer diventano follower, possono votare i contenuti multimediali degli streamer, esprimendosi tramite l’utilizzo di un voto su scala likert (nel range [1,10])*"

- Il voto sarà concesso solo ai **follower**

### 1.1.6 Requisiti delle diverse chat

Oltre a chattare pubblicamente, gli utenti – attraverso un sistema di messaggistica privato embedded nella piattaforma - possono scambiarsi messaggi e contenuti multimediali privati

### 1.1.7 Requisiti della ricerca degli streramer per tutti i tipi di utenti

Gli utenti (sia guest che registrati), possono cercare i contenuti multimediali per hashtag o per categorie (ad es. Musica, Sport, Personaggi famosi, Arte, Talk-show, Games, Simulation, food&drinks, Creative, Strategy, Technology, etc…). Ogni utente registrato, in base ai contenuti/pagine/streamer che segue, ha una lista di contenuti multimediali suggeriti.

### 1.1.8 Requisiti degli utenti fragili

Infine, gli utenti fragili, possono registrarsi al servizio avendo però a disposizione contenuti multimediali più inclusivi e accessibili (ad es. contenuti in LIS – Lingua Italiana dei Segni per le persone non udenti), oppure una versione delle pagine ad accesso facilitato (caratteri aumentati, stile delle pagine dei canali in b/w).

- Viene tenuta traccia degli **utenti fragili** e per loro i contenuti verranno erogati in **modalità differente**

### 1.1.9 Volume delle operazioni

La base di dati deve supportare le seguenti operazioni:

- Una volta al giorno si controllano le condizioni per la qualifica di affiliate
- Una volta a settimana viene calcolata la classifica degli streamer più seguiti
- Una volta al giorno, viene calcolata la media dei like per ogni contenuto multimediale (per ogni streamer)
- Una volta al giorno, gli amministratori, per ogni contenuto multimediale di ogni streamer, stilano il rating dei video più votati (quelli che, in media, hanno ricevuto una votazione maggiore rispetto agli altri)
- Dieci volte al giorno, vengono controllati ed eliminati tutti i commenti con contenuti offensivi fatti dagli utenti per ogni contenuto multimediale (per ogni streamer), nelle categorie, nei canali e durante le dirette live
- Due volte al giorno vengono controllati i nuovi utenti registrati (sia premium – nuovi abbonati – sia utenti appartenenti a categorie fragili)
- Cinque volte al giorno, gli amministratori delle pagine degli streamer segnalano agli amministratori della base di dati, i profili fake che seguono i loro streamer
- Una volta ogni 6 mesi, gli amministratori possono visualizzare lo storico degli utenti premium (quelli storici (dato un range di date) che quelli recenti (relativi all’ultimo mese)

"*Qualsiasi altra operazione/funzionalità del sistema e/o modellazione di requisiti non descritti, purché motivata, è ben accetta! (… un po' di fantasia!!!)*"

### 1.1.10 Requisiti gestione e costi della piattaforma

"*Si può assumere che i contenuti multimediali vengano gestiti da una piattaforma/server di video hosting esterna (e che quindi sia sufficiente memorizzare solo un URL o indirizzo IP). Per il servizio di hosting, gli amministratori delle pagine, devono pagare un corrispettivo mensile di 50$ al provider che fornisce il servizio di hosting. Se si verificano ritardi per un massimo di 15 giorni a partire dalla data di acquisto/rinnovo dell’hosting, il profilo/canale dello streamer verrà sospeso fino alla data di rinnovo (data di accredito) del pagamento del servizio di hosting*"

---

## 1.2. Glossario dei termini

| Termine            | Descrizione                                                                   | Sinonimi | Collegamenti |
| ------------------ | ----------------------------------------------------------------------------- | -------- | ------------ |
| spettatore         | utente registrato che osserva le live e chatta                                | viewer   |              |
| streamer           | utente registrato che crea live                                               |          |              |
| guest              | utente non registrato che osserva le live                                     |          |              |
| utente premium     | utente registrato che paga la piattaforma per benefici maggiori               |          |              |
| canale             | pagina dello streamer, dove publbica le live                                  |          |              |
| social             | link social dello streamer                                                    |          |              |
| live               | live corrente che lo streamer sta trasmettendo                                |          |              |
| video              | live passate dello streamer                                                   |          |              |
| clip               | parte di un video di tot. secondi                                             |          |              |
| streamer affiliato | streamer che ha superato determinati criteri                                  |          |              |
| follower           | utente registrato che segue lo streamer e riceve notifiche delle sue attivitá |          |              |
| subscriber         | utente registrato spettatore che supporta uno streamer ottenendo privilegi    |          |              |
| utenti fragili     | utente registrato che ha determinate disabilitá                               |          |              |

## 1.3. Requisiti riscritti

> qui ci vanno i requisiti della sezione 1.1 riscritti senza sinonimi e con frasi standardizzate. Ricordarsi di marcare in maniera grafica ciò che è stato cancellato/sostituito e ciò che è stato aggiunto
