
--inserimento utente
insert into "Utente" values(DEFAULT,DEFAULT);
insert into "Utente" values(DEFAULT,DEFAULT);
insert into "Utente" values(DEFAULT,DEFAULT);
insert into "Utente" values(DEFAULT,DEFAULT);
insert into "Utente" values(DEFAULT,DEFAULT);
insert into "Utente" values('utente1',DEFAULT);
insert into "Utente" values('utente2',DEFAULT);
insert into "Utente" values('utente3',DEFAULT);
insert into "Utente" values('utente4',DEFAULT);
insert into "Utente" values('utente5',DEFAULT);
insert into "Utente" values('utente6',DEFAULT);

--inserimento utente registrato
insert into "Registrato"("Username","UserPassword","DataDiNascita","DataRegistrazione","LIS")
	values('utente1','password1!','2000-05-19','2020-05-18',false);
insert into "Registrato"("Username","UserPassword","DataDiNascita","DataRegistrazione","NumeroDiTelefono","Affiliate","LIS")
	values('utente2','password2!','2002-05-19','2021-09-14','+391111111111',true,false);
insert into "Registrato"("Username","UserPassword","DataDiNascita","DataRegistrazione","NumeroDiTelefono","IndirizzoMail","Affiliate","Premium","LIS")
	values('utente3','password3!','2005-09-17','2019-01-25','+391114113111','test1@gmail.com',false,true,false);
insert into "Registrato"("Username","UserPassword","DataDiNascita","DataRegistrazione","IndirizzoMail","Affiliate","LIS")
	values('utente4','password4!','2003-12-19','2019-04-26','test2@yahoo.it',false,false);
insert into "Registrato"("Username","UserPassword","DataDiNascita","DataRegistrazione","NumeroDiTelefono","IndirizzoMail","Premium","LIS")
	values('utente5','password5!','2006-05-25','2022-02-25','+39111411353','test3@libero.it',false,false);
insert into "Registrato"("Username","UserPassword","DataDiNascita","DataRegistrazione","IndirizzoMail","Premium","LIS")
	values('utente6','password6!','1998-01-22','2018-03-25','test4@libero.it',true,false);

--inserimento messaggio
insert into "Messaggio"("Mittente","TimestampMessaggio","Destinatario","Testo")
	values('utente1','2024-07-22 14:06:25','utente3','ciao, come va?');
insert into "Messaggio"("Mittente","TimestampMessaggio","Destinatario","Testo")
	values('utente3','2024-07-23 20:37:35','utente1','tutto bene grazie, tu?');
insert into "Messaggio"("Mittente","TimestampMessaggio","Destinatario","Testo")
	values('utente4','2024-03-20 14:16:25','utente5','hello');
insert into "Messaggio"("Mittente","TimestampMessaggio","Destinatario","Testo")
	values('utente2','2024-07-29 20:09:35','utente1','ciaooo');
insert into "Messaggio"("Mittente","TimestampMessaggio","Destinatario","Testo")
	values('utente5','2024-07-29 20:09:35','utente2','ciao utente');

--inserimento portafoglio
insert into "Portafoglio"("UtenteProprietario","TotaleBits") values ('utente1',150);
insert into "Portafoglio"("UtenteProprietario","TotaleBits") values ('utente2',100);
insert into "Portafoglio"("UtenteProprietario","TotaleBits") values ('utente3',26);
insert into "Portafoglio"("UtenteProprietario","TotaleBits") values ('utente4',68);
insert into "Portafoglio"("UtenteProprietario","TotaleBits") values ('utente6',119);

--inserimento provider
insert into "Provider"("NomeProvider") values ('Aruba');
insert into "Provider"("NomeProvider") values ('Google');
insert into "Provider"("NomeProvider") values ('Amazon AWS');
insert into "Provider"("NomeProvider") values ('Tiscali');
insert into "Provider"("NomeProvider") values ('VHOSTING');

--inserimento amministratore
insert into "Amministratore"("CodiceAdmin","Nome","Cognome") values (00050101,'Carlo','Neri');
insert into "Amministratore"("CodiceAdmin","Nome","Cognome") values (00050102,'Andrea','Verdi');
insert into "Amministratore"("CodiceAdmin","Nome","Cognome") values (00050103,'Mario','Rossi');

--inserimento rinnovo hosting
insert into "Rinnovo"("Amministratore","Provider","DataScadenza")
	values (00050101,'Aruba','2024-10-12');
insert into "Rinnovo"("Amministratore","Provider","DataScadenza")
	values (00050101,'Amazon AWS','2024-10-10');
insert into "Rinnovo"("Amministratore","Provider","DataScadenza")
	values (00050102,'Tiscali','2024-10-02');
insert into "Rinnovo"("Amministratore","Provider","DataScadenza")
	values (00050103,'VHOSTING','2024-09-28');

--inserimento canale
insert into "Canale"("StreamerProprietario","AdminCanale","HostingProvider")
	values ('utente3',00050103,'VHOSTING');
insert into "Canale"("StreamerProprietario","AdminCanale","HostingProvider","Descrizione")
	values ('utente2',00050102,'Tiscali','Canale utente2');
insert into "Canale"("StreamerProprietario","AdminCanale","HostingProvider","Descrizione","ImmagineProfilo","Trailer")
	values ('utente4',00050101,'Aruba','Canale utente4','foto_utente2','trailer_canale');
insert into "Canale"("StreamerProprietario","AdminCanale","HostingProvider","Trailer")
	values ('utente6',00050101,'Amazon AWS','trailer_canale_utente6');

--inserimento programmazione
insert into "Programmazione"("Streamer","ProgTimestamp","Titolo","LIS","Premium")
	values ('utente3','2024-10-20 16:00:00','Prog utente3',true,false);
insert into "Programmazione"("Streamer","ProgTimestamp","Titolo","LIS","Premium")
	values ('utente3','2024-10-22 19:00:00','Prog utente3 seconda',false,true);
insert into "Programmazione"("Streamer","ProgTimestamp","Titolo","LIS","Premium")
	values ('utente2','2024-10-21 19:30:00','Prog utente2',false,false);
insert into "Programmazione"("Streamer","ProgTimestamp","Titolo","LIS","Premium")
	values ('utente4','2024-10-11 10:30:00','Prog utente4',true,true);

--inserimento link social
insert into "LinkSocial"("CanaleAssociato","Social","LinkProfilo")
	values ('utente3','Instagram','https://www.instagram.com');
insert into "LinkSocial"("CanaleAssociato","Social","LinkProfilo")
	values ('utente3','Twitter','https://www.twitter.com');
insert into "LinkSocial"("CanaleAssociato","Social","LinkProfilo")
	values ('utente3','Facebook','https://www.facebook.com');
insert into "LinkSocial"("CanaleAssociato","Social","LinkProfilo")
	values ('utente4','Instagram','https://www.instagram.com');
insert into "LinkSocial"("CanaleAssociato","Social","LinkProfilo")
	values ('utente2','Snapchat','https://www.snapchat.com');

--inserimento donazione
insert into "Donazione"("ProprietarioPortafoglio","CanaleStreamer","Timestamp","Bits")
	values ('utente1','utente3','2023-04-25 15:03:10',20);
insert into "Donazione"("ProprietarioPortafoglio","CanaleStreamer","Timestamp","Bits")
	values ('utente4','utente3','2023-04-29 15:13:12',15);
insert into "Donazione"("ProprietarioPortafoglio","CanaleStreamer","Timestamp","Bits")
	values ('utente3','utente4','2023-04-21 15:23:18',10);
insert into "Donazione"("ProprietarioPortafoglio","CanaleStreamer","Timestamp","Bits")
	values ('utente6','utente4','2024-04-05  19:03:22',30);
insert into "Donazione"("ProprietarioPortafoglio","CanaleStreamer","Timestamp","Bits")
	values ('utente6','utente3','2024-05-05  19:43:22',4);
insert into "Donazione"("ProprietarioPortafoglio","CanaleStreamer","Timestamp","Bits")
	values ('utente1','utente2','2024-05-25 16:03:12',5);

--inserimento follower
insert into "Follower" values('utente1','utente2');
insert into "Follower" values('utente1','utente3');
insert into "Follower" values('utente3','utente4');
insert into "Follower" values('utente5','utente4');
insert into "Follower" values('utente6','utente2');

--inserimento abbonamento ad un canale
insert into "Subscription" values ('utente1','utente2');
insert into "Subscription" values ('utente1','utente3');
insert into "Subscription" values ('utente3','utente2');
insert into "Subscription" values ('utente5','utente4');
insert into "Subscription" values ('utente6','utente4');

--inserimento categoria
insert into "Categoria" values('Tecnologia');
insert into "Categoria" values('Cibo');
insert into "Categoria" values('Gaming');
insert into "Categoria" values('Sport');
insert into "Categoria" values('Musica');

--inserimento hashtag
insert into "Hashtag" values('game');
insert into "Hashtag" values('food');
insert into "Hashtag" values('music');
insert into "Hashtag" values('sport');
insert into "Hashtag" values('technology');

--inserimento contenuto multimediale
/*contenuti per tutti gli utenti*/
insert into "ContenutoMultimediale" values (DEFAULT,'utente2','Live at the pub','Musica',false,false); 
insert into "ContenutoMultimediale" values (DEFAULT,'utente2','La storia del rock','Musica',true,false); 
insert into "ContenutoMultimediale" values (DEFAULT,'utente2','Live in Rome','Musica',false,false); 
insert into "ContenutoMultimediale" values (DEFAULT,'utente3','Ricetta della nonna #1','Cibo',false,false);
insert into "ContenutoMultimediale" values (DEFAULT,'utente3','Ricette fatte in casa','Cibo',true,false);
insert into "ContenutoMultimediale" values (DEFAULT,'utente3','Esercizi per il benessere fisico dopo i pasti','Sport',false,false);
insert into "ContenutoMultimediale" values (DEFAULT,'utente3','App e attività fisica','Gaming',false,false);
insert into "ContenutoMultimediale" values (DEFAULT,'utente4','Componenti e giochi per pc da gaming','Tecnologia',true,false);
insert into "ContenutoMultimediale" values (DEFAULT,'utente4','Come installare giochi su pc','Tecnologia',true,false);
insert into "ContenutoMultimediale" values (DEFAULT,'utente4','Come sostituire hdd con ssd','Tecnologia',false,false);
/*contenuti solo per utenti premium*/
insert into "ContenutoMultimediale" values (DEFAULT,'utente2','Intervista alla band','Musica',true,true); 
insert into "ContenutoMultimediale" values (DEFAULT,'utente2','La musica rock','Musica',true,true); 
insert into "ContenutoMultimediale" values (DEFAULT,'utente4','Passare da HDD a SSD facilmente','Tecnologia',false,true); 
insert into "ContenutoMultimediale" values (DEFAULT,'utente4','Boot order UEFI','Tecnologia',true,true);
insert into "ContenutoMultimediale" values (DEFAULT,'utente4','Boot order BIOS','Tecnologia',true,true); 

--inserimento live
insert into "Live" values ('url1','2024-02-25 15:00:00','2024-02-25 17:15:00'); 
insert into "Live" values ('url2','2024-02-26 15:00:00','2024-02-26 16:25:00');
insert into "Live" values ('url4','2024-06-15 14:00:00','2024-06-15 16:45:00');
insert into "Live" values ('url8','2024-08-27 15:00:00','2024-08-27 17:05:00');
insert into "Live" values ('url11','2024-09-01 15:00:00','2024-09-01 17:25:26');

--inserimento video
insert into "Video" values ('url3',135,'url1');
insert into "Video" values ('url5',305,'url4');
insert into "Video" values ('url9',125,'url8');
insert into "Video" values ('url12',145,'url2');

--inserimento clip
insert into "Clip" values ('url6',1,200,'url5');
insert into "Clip" values ('url7',2,235,'url5');
insert into "Clip" values ('url10',1,105,'url9');
insert into "Clip" values ('url13',3,100,'url9');
insert into "Clip" values ('url14',1,105,'url9');
insert into "Clip" values ('url15',1,108,'url9');

--inserimento visita
insert into "Visita" values ('guest_1','url1');
insert into "Visita" values ('guest_2','url1');
insert into "Visita" values ('utente1','url1');
insert into "Visita" values ('utente6','url9'); 
insert into "Visita" values ('utente3','url10');
insert into "Visita" values ('utente3','url11');

--inserimento voto
insert into "Voto" values ('utente1','url3',9);
insert into "Voto" values ('utente3','url9',10);
insert into "Voto" values ('utente3','url10',8); 
insert into "Voto" values ('utente5','url9',7); 
insert into "Voto" values ('utente6','url3',3); 

--inserimento associazione hashtag-contenuto
insert into "Associazione" values ('game','url7');
insert into "Associazione" values ('food','url6');
insert into "Associazione" values ('music','url3');
insert into "Associazione" values ('sport','url6');
insert into "Associazione" values ('technology','url10');

--inserimento emoji
insert into "Emoji"("Codice") values('&#x1F44D'); --pollice in su'
insert into "Emoji"("Codice") values('&#x1F44E'); --pollice in giu'
insert into "Emoji"("Codice") values('&#x1F44F'); --applauso
insert into "Emoji"("Codice") values('&#x1F602'); --faccina che ride (dritta)
insert into "Emoji"("Codice","Personalizzato") values('&#x1F923','utente3'); --faccina che ride (inclinata)
insert into "Emoji"("Codice","Personalizzato") values('&#x1F60D','utente3'); --faccina con occhi a cuore
insert into "Emoji"("Codice") values('&#x1F62D'); --faccina che piange
insert into "Emoji"("Codice") values('&#x1F621'); --faccina arrabbiata 
insert into "Emoji"("Codice","Personalizzato") values('&#x1F625','utente2'); --faccina con goccia di sudore

--inserimento interazione
insert into "Interazione"("Spettatore","LiveCorrente","IntTimestamp","Tipologia")
	values ('utente3','url2','2024-02-26 14:15:00','reazione');
insert into "Interazione"("Spettatore","LiveCorrente","IntTimestamp","Tipologia","Messaggio")
	values ('utente3','url2','2024-02-26 14:26:00','commento','grande, continua così!');
insert into "Interazione"("Spettatore","LiveCorrente","IntTimestamp","Tipologia")
	values ('utente1','url4','2024-06-15 15:03:00','reazione'); 
insert into "Interazione"("Spettatore","LiveCorrente","IntTimestamp","Tipologia","Messaggio")
	values ('utente5','url8','2024-08-27 15:09:00','commento','molto utile:-)'); 

--inserimento presenza emoji in commenti e reazioni
insert into "Presenza"
	values ('utente3','url2','2024-02-26 14:15:00','&#x1F44D');
insert into "Presenza"
	values ('utente3','url2','2024-02-26 14:26:00','&#x1F44F');
insert into "Presenza"
	values ('utente1','url4','2024-06-15 15:03:00','&#x1F44D');
insert into "Presenza"
	values ('utente5','url8','2024-08-27 15:09:00','&#x1F923');

--inserimento affluenza
insert into "Affluenza" values ('url1','2024-02-25 16:10:00',200);
insert into "Affluenza" values ('url2','2024-02-26 14:30:00',250);
insert into "Affluenza" values ('url2','2024-02-26 15:30:00',290);
insert into "Affluenza" values ('url2','2024-02-26 16:00:00',290);
insert into "Affluenza" values ('url4','2024-06-15 15:20:00',190);
insert into "Affluenza" values ('url4','2024-06-15 16:40:00',214);
insert into "Affluenza" values ('url8','2024-08-27 16:00:00',90);
insert into "Affluenza" values ('url8','2024-08-27 17:00:00',110);
insert into "Affluenza" values ('url11','2024-09-01 15:45:00',79);
insert into "Affluenza" values ('url11','2024-09-01 16:30:00',95);
insert into "Affluenza" values ('url11','2024-09-01 17:15:00',86);

