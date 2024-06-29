# Controlli da fare per evitare gli errori più frequenti nella progettazione

**Contrassegnare tutti i controlli effettuati:**

## Requisiti rivisti

- [ ] I requisiti rivisti non comprendono sinonimi e omonimi.
- [ ] I requisiti rivisti comprendono anche le informazioni date dalle schermate che sono state fornite come parte dei requisiti iniziali.

## Schema ER iniziale

- [ ] Le entità hanno solo attributi nominati nei requisiti rivisti.
- [ ] Ogni entità ha un identificatore.
- [ ] Gli identificatori delle entità non sono ID o codici (a meno dei rari casi in cui ID e codici sono stati nominati nei requisiti).
- [ ] Le associazioni non hanno identificatori.
- [ ] Le entità non hanno attributi che corrispondono a “chiavi esterne”. I “collegamenti” tra entità devono essere rappresentati tramite associazioni.
- [ ] Per ogni generalizzazione è stato indicato il tipo.
- [ ] Le associazioni ternarie indicano che potenzialmente è possibile avere ogni combinazione di occorrenze delle tre entità collegate. Se ciò non è quello che si desidera usare associazioni binarie.
- [ ] Lo schema ER iniziale contiene ridondanze che saranno poi analizzate nella fase di progettazione logica.

## Regole aziendali

- [ ] Le regole aziendali sono effettivamente controllabili utilizzando i dati rappresentati nell’ER.
- [ ] Le regole aziendali sono sufficientemente precise da essere implementabili da un programmatore.

## Schema ER iniziale+regole aziendali

- [ ] Per ogni ridondanza esiste o una regola aziendale che indica come mantenere la coerenza o una regola aziendale di derivazione che indica come derivare la ridondanza.
- [ ] Lo schema ER iniziale + regole aziendali sono equivalenti ai requisiti rivisti.

## Tavola dei volumi

- [ ] La tavola dei volumi contiene tutte le entità e le associazioni presenti nello schema ER iniziale.
- [ ] La tavola dei volumi contiene numeri coerenti con lo schema ER iniziale e con il funzionamento a regime del sistema.

## Tavola delle operazioni

- [ ] La tavola delle operazioni contiene operazioni coerenti con i requisiti: sono state considerate sia le operazioni citate esplicitamente nei requisiti iniziali sia le schermate fornite
- [ ] La tavola delle operazioni contiene sia operazioni che “leggono” i dati che operazioni che modificano e inseriscono dati.
- [ ] La tavola delle operazioni contiene numeri coerenti con il funzionamento a regime del sistema.
- [ ] Gli schemi delle operazioni (cioè le analisi degli accessi) non sono riportate qui, ma nell’analisi delle ridondanze perché sono specifici per la singola ridondanza.

## Analisi delle ridondanze

- [ ] Nell’analisi delle ridondanze si procede considerando ogni ridondanza significativa, non ogni operazione.
- [ ] Per ogni ridondanza significativa:
    1. Separatamente per ogni ridondanza sono state elencate le operazioni di lettura dei dati e di modifica/inserimento più significative che modificano/utilizzano la ridondanza
    2. Separatamente per ogni ridondanza e per ogni relativa operazione sono stati riportati gli schemi delle operazioni in presenza e assenza della ridondanza
    3. Separatamente per ogni ridondanza e per ogni relativa operazione sono state riportate le tavole degli accessi in presenza e assenza della ridondanza
    4. Separatamente per ogni ridondanza è stato riportato lo spazio occupato dalla ridondanza
    5. Separatamente per ogni ridondanza è stato confrontato lo spazio e il numero di accessi in presenza di ridondanza con lo spazio e il numero di accessi in assenza di ridondanza e si è deciso se tenere la ridondanza o no.

## Schema ER ristrutturato+regole aziendali

- [ ] Ogni generalizzazione è stata eliminata motivando la scelta e rispettandone la semantica (parziale/totale e sovrapposta/esclusiva).
- [ ] Le associazioni/attributi sui figli/genitori eliminati in una generalizzazione sono stati sostituiti rispettando la semantica della generalizzazione (eventualmente introducendo nuove regole aziendali).
- [ ] Le associazioni non hanno identificatori.
- [ ] Le entità non hanno attributi che corrispondono a “chiavi esterne” e che possono essere rappresentati tramite associazioni.
- [ ] Lo schema ER ristrutturato + regole aziendali sono equivalenti allo schema ER iniziale + regole aziendali: nello schema ER ristrutturato non si possono introdurre nuovi attributi/entità/associazioni se non quelli che derivano dalla ristrutturazione.

## Schema relazionale

- [ ] Lo schema relazionale è equivalente allo schema ER ristrutturato: non si possono introdurre nuovi attributi/tabelle/vincoli se non quelli derivanti dalla traduzione dello schema ER ristrutturato.
- [ ] Per ogni tabella è indicata la chiave primaria
- [ ] Per ogni tabella sono stati indicati i vincoli di integrità referenziale.
- [ ] Ogni associazione dello schema ER ristrutturato è stata tradotta nello schema relazionale rispettandone il tipo (uno a uno, uno a molti, molti a molti, …).
