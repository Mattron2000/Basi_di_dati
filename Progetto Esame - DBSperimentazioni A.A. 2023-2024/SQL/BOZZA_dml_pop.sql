
--inserimento utente
insert into fincato_palmieri."Utente" values(DEFAULT);
insert into fincato_palmieri."Utente" values(DEFAULT);
insert into fincato_palmieri."Utente" values(DEFAULT);
insert into fincato_palmieri."Utente" values(DEFAULT);
insert into fincato_palmieri."Utente" values(DEFAULT);
insert into fincato_palmieri."Utente" values('utente1');
insert into fincato_palmieri."Utente" values('utente2');
insert into fincato_palmieri."Utente" values('utente3');
insert into fincato_palmieri."Utente" values('utente4');
insert into fincato_palmieri."Utente" values('utente5');

--inserimento utente registrato
insert into fincato_palmieri."Registrato"("Username","UserPassword","DataDiNascita","DataRegistrazione","LIS")
	values('utente1','password1!','19-05-2000','18-05-2020',false);
insert into fincato_palmieri."Registrato"("Username","UserPassword","DataDiNascita","DataRegistrazione","NumeroDiTelefono","LIS")
	values('utente2','password2!','19-05-2002','14-09-2021','+391111111111',false);
insert into fincato_palmieri."Registrato"("Username","UserPassword","DataDiNascita","DataRegistrazione","NumeroDiTelefono","IndirizzoMail","LIS")
	values('utente3','password3!','17-09-2005','25-01-2019','+391114113111','test1@gmail.com',false);
insert into fincato_palmieri."Registrato"("Username","UserPassword","DataDiNascita","DataRegistrazione","IndirizzoMail","Affiliate","LIS")
	values('utente4','password4!','19-12-2003','26-04-2019','test2@yahoo.it',false,false);
insert into fincato_palmieri."Registrato"("Username","UserPassword","DataDiNascita","DataRegistrazione","NumeroDiTelefono","IndirizzoMail","Affiliate","Premium","LIS")
	values('utente5','password5!','25-05-2006','25-02-2022','+39111411353','test3@libero.it',false,false,false);

--inserimento messaggio
insert into fincato_palmieri."Messaggio"("Mittente","TimestampMessaggio","Destinatario","Testo")
	values('utente1','22-07-2024 14:06:25','utente3','ciao, come va?');
insert into fincato_palmieri."Messaggio"("Mittente","TimestampMessaggio","Destinatario","Testo")
	values('utente3','23-07-2024 20:37:35','utente1','tutto bene grazie, tu?');
insert into fincato_palmieri."Messaggio"("Mittente","TimestampMessaggio","Destinatario","Testo")
	values('utente4','20-03-2024 14:16:25','utente5','hello');
insert into fincato_palmieri."Messaggio"("Mittente","TimestampMessaggio","Destinatario","Testo")
	values('utente2','29-07-2024 20:09:35','utente1','ciaooo');
insert into fincato_palmieri."Messaggio"("Mittente","TimestampMessaggio","Destinatario","Testo")
	values('utente5','29-07-2024 20:09:35','utente2','ciao utente');

--inserimento portafoglio
insert into fincato_palmieri."Portafoglio"("UtenteProprietario","TotaleBits") values ('utente1',150);
insert into fincato_palmieri."Portafoglio"("UtenteProprietario","TotaleBits") values ('utente3',26);
insert into fincato_palmieri."Portafoglio"("UtenteProprietario","TotaleBits") values ('utente4',68);

--inserimento provider
insert into fincato_palmieri."Provider"("NomeProvider") values ('Aruba');
insert into fincato_palmieri."Provider"("NomeProvider") values ('Google');
insert into fincato_palmieri."Provider"("NomeProvider") values ('Amazon AWS');
insert into fincato_palmieri."Provider"("NomeProvider") values ('Tiscali');
insert into fincato_palmieri."Provider"("NomeProvider") values ('VHOSTING');

--inserimento amministratore
insert into fincato_palmieri."Amministratore"("CodiceAdmin","Nome","Cognome") values (00050101,'Carlo','Neri');
insert into fincato_palmieri."Amministratore"("CodiceAdmin","Nome","Cognome") values (00050102,'Andrea','Verdi');
insert into fincato_palmieri."Amministratore"("CodiceAdmin","Nome","Cognome") values (00050103,'Mario','Rossi');

--inserimento rinnovo hosting
insert into fincato_palmieri."Rinnovo"("Amministratore","Provider","DataScadenza")
	values (00050101,'Aruba','12-10-2024');
insert into fincato_palmieri."Rinnovo"("Amministratore","Provider","DataScadenza")
	values (00050102,'Tiscali','02-10-2024');
insert into fincato_palmieri."Rinnovo"("Amministratore","Provider","DataScadenza")
	values (00050103,'VHOSTING','28-09-2024');

--inserimento canale
insert into fincato_palmieri."Canale"("StreamerProprietario","AdminCanale","HostingProvider")
	values ('utente3',00050103,'VHOSTING');
insert into fincato_palmieri."Canale"("StreamerProprietario","AdminCanale","HostingProvider","Descrizione")
	values ('utente2',00050102,'Tiscali','Canale utente2');
insert into fincato_palmieri."Canale"("StreamerProprietario","AdminCanale","HostingProvider","Descrizione","ImmagineProfilo","Trailer")
	values ('utente4',00050101,'Aruba','Canale utente4','foto_utente2','trailer_canale');

--inserimento programmazione
insert into fincato_palmieri."Programmazione"("Streamer","ProgTimestamp","Titolo","LIS","Premium")
	values ('utente3','20-08-2024 16:00:00','Prog utente3',true,false);
insert into fincato_palmieri."Programmazione"("Streamer","ProgTimestamp","Titolo","LIS","Premium")
	values ('utente3','22-08-2024 19:00:00','Prog utente3 seconda',false,true);
insert into fincato_palmieri."Programmazione"("Streamer","ProgTimestamp","Titolo","LIS","Premium")
	values ('utente2','21-08-2024 19:30:00','Prog utente2',false,false);
insert into fincato_palmieri."Programmazione"("Streamer","ProgTimestamp","Titolo","LIS","Premium")
	values ('utente4','11-08-2024 10:30:00','Prog utente4',true,true);

--inserimento link social
insert into fincato_palmieri."LinkSocial"("CanaleAssociato","Social","LinkProfilo")
	values ('utente3','Instagram','https://www.instagram.com');
insert into fincato_palmieri."LinkSocial"("CanaleAssociato","Social","LinkProfilo")
	values ('utente3','Twitter','https://www.twitter.com');
insert into fincato_palmieri."LinkSocial"("CanaleAssociato","Social","LinkProfilo")
	values ('utente3','Facebook','https://www.facebook.com');
insert into fincato_palmieri."LinkSocial"("CanaleAssociato","Social","LinkProfilo")
	values ('utente4','Instagram','https://www.instagram.com');
insert into fincato_palmieri."LinkSocial"("CanaleAssociato","Social","LinkProfilo")
	values ('utente2','Snapchat','https://www.snapchat.com');

--inserimento donazione
insert into fincato_palmieri."Donazione"("ProprietarioPortafoglio","CanaleStreamer","Timestamp","Bits")
	values ('utente1','utente2','25-04-2023 15:03:12',20);
insert into fincato_palmieri."Donazione"("ProprietarioPortafoglio","CanaleStreamer","Timestamp","Bits")
	values ('utente4','utente3','29-04-2023 15:03:12',15);
insert into fincato_palmieri."Donazione"("ProprietarioPortafoglio","CanaleStreamer","Timestamp","Bits")
	values ('utente3','utente4','21-04-2023 15:03:12',10);

--inserimento follower
insert into fincato_palmieri."Follower" values('utente1','utente2');
insert into fincato_palmieri."Follower" values('utente2','utente3');
insert into fincato_palmieri."Follower" values('utente3','utente4');
insert into fincato_palmieri."Follower" values('utente5','utente4');
insert into fincato_palmieri."Follower" values('utente2','utente2');

--inserimento abbonamento ad un canale
insert into fincato_palmieri."Subscription" values ('utente1','utente2');
insert into fincato_palmieri."Subscription" values ('utente1','utente3');
insert into fincato_palmieri."Subscription" values ('utente3','utente2');
insert into fincato_palmieri."Subscription" values ('utente5','utente4');
insert into fincato_palmieri."Subscription" values ('utente2','utente4');

--inserimento categoria
insert into fincato_palmieri."Categoria" values('Tecnologia');
insert into fincato_palmieri."Categoria" values('Cibo');
insert into fincato_palmieri."Categoria" values('Gaming');
insert into fincato_palmieri."Categoria" values('Sport');
insert into fincato_palmieri."Categoria" values('Musica');

--inserimento hashtag
insert into fincato_palmieri."Hashtag" values('game');
insert into fincato_palmieri."Hashtag" values('food');
insert into fincato_palmieri."Hashtag" values('music');
insert into fincato_palmieri."Hashtag" values('sport');
insert into fincato_palmieri."Hashtag" values('technology');

--inserimento contenuto multimediale
insert into fincato_palmieri."ContenutoMultimediale" values (DEFAULT,'utente2','Live at the pub','Musica',false,false);
insert into fincato_palmieri."ContenutoMultimediale" values (DEFAULT,'utente2','La storia del rock','Musica',true,false);
insert into fincato_palmieri."ContenutoMultimediale" values (DEFAULT,'utente2','Live in Rome','Musica',false,true);
insert into fincato_palmieri."ContenutoMultimediale" values (DEFAULT,'utente3','Ricetta della nonna #1','Cibo',false,false);
insert into fincato_palmieri."ContenutoMultimediale" values (DEFAULT,'utente3','Cucina e videogames','Gaming',false,true);
insert into fincato_palmieri."ContenutoMultimediale" values (DEFAULT,'utente3','Esercizi per il benessere fisico','Sport',false,false);
insert into fincato_palmieri."ContenutoMultimediale" values (DEFAULT,'utente3','App e attività fisica','Gaming',false,false);
insert into fincato_palmieri."ContenutoMultimediale" values (DEFAULT,'utente4','Pettorali e addominali','Sport',false,true);
insert into fincato_palmieri."ContenutoMultimediale" values (DEFAULT,'utente4','Jogging e camminate','Sport',false,true);
insert into fincato_palmieri."ContenutoMultimediale" values (DEFAULT,'utente4','Come installare giochi su pc','Tecnologia',false,false);

--inserimento visita
insert into fincato_palmieri."Visita" values ('guest_1','url1');
insert into fincato_palmieri."Visita" values ('guest_2','url1');
insert into fincato_palmieri."Visita" values ('utente1','url1');
insert into fincato_palmieri."Visita" values ('utente2','url9');
insert into fincato_palmieri."Visita" values ('utente3','url10');

--inserimento voto
insert into fincato_palmieri."Voto" values ('utente1','url8',9);
insert into fincato_palmieri."Voto" values ('utente2','url8',10);
insert into fincato_palmieri."Voto" values ('utente3','url7',8);
insert into fincato_palmieri."Voto" values ('utente4','url3',7);
insert into fincato_palmieri."Voto" values ('utente5','url3',3);

--inserimento live
insert into fincato_palmieri."Live" values ('url6','25-02-2024 15:00:00','25-02-2024 17:05:26');
insert into fincato_palmieri."Live" values ('url9','24-02-2024 15:00:00','24-02-2024 17:05:24');
insert into fincato_palmieri."Live" values ('url2','15-06-2024 14:00:00','15-06-2024 17:45:26');
insert into fincato_palmieri."Live" values ('url1','27-02-2024 15:00:00','27-02-2024 17:05:26');
insert into fincato_palmieri."Live" values ('url5','27-02-2024 15:00:00','27-02-2024 17:05:26');

--inserimento associazione hashtag-contenuto
insert into fincato_palmieri."Associazione" values ('game','url4');
insert into fincato_palmieri."Associazione" values ('food','url4');
insert into fincato_palmieri."Associazione" values ('music','url1');
insert into fincato_palmieri."Associazione" values ('sport','url7');
insert into fincato_palmieri."Associazione" values ('technology','url10');

--inserimento emoji
insert into fincato_palmieri."Emoji"("Codice") values('&#x1F44D'); --pollice in su'
insert into fincato_palmieri."Emoji"("Codice") values('&#x1F44E'); --pollice in giu'
insert into fincato_palmieri."Emoji"("Codice") values('&#x1F44F'); --applauso
insert into fincato_palmieri."Emoji"("Codice") values('&#x1F602'); --faccina che ride (dritta)
insert into fincato_palmieri."Emoji"("Codice","Personalizzato") values('&#x1F923','utente3'); --faccina che ride (inclinata)
insert into fincato_palmieri."Emoji"("Codice","Personalizzato") values('&#x1F60D','utente3'); --faccina con occhi a cuore
insert into fincato_palmieri."Emoji"("Codice") values('&#x1F62D'); --faccina che piange
insert into fincato_palmieri."Emoji"("Codice") values('&#x1F621'); --faccina arrabbiata 
insert into fincato_palmieri."Emoji"("Codice","Personalizzato") values('&#x1F625','utente2'); --faccina con goccia di sudore

--inserimento interazione
insert into fincato_palmieri."Interazione"("Spettatore","LiveCorrente","IntTimestamp","Tipologia")
	values ('utente3','url2','15-06-2024 14:15:00','reazione');
insert into fincato_palmieri."Interazione"("Spettatore","LiveCorrente","IntTimestamp","Tipologia","Messaggio")
	values ('utente3','url2','15-06-2024 14:26:00','commento','grande, continua così!');
insert into fincato_palmieri."Interazione"("Spettatore","LiveCorrente","IntTimestamp","Tipologia")
	values ('utente1','url9','24-02-2024 15:03:00','reazione');
insert into fincato_palmieri."Interazione"("Spettatore","LiveCorrente","IntTimestamp","Tipologia","Messaggio")
	values ('utente5','url9','24-02-2024 15:09:00','commento','Che fatica');

--inserimento presenza emoji in commenti e reazioni
insert into fincato_palmieri."Presenza"
	values ('utente3','url2','15-06-2024 14:15:00','&#x1F44D');
insert into fincato_palmieri."Presenza"
	values ('utente3','url2','15-06-2024 14:26:00','&#x1F44F');
insert into fincato_palmieri."Presenza"
	values ('utente1','url9','24-02-2024 15:03:00','&#x1F44D');
insert into fincato_palmieri."Presenza"
	values ('utente5','url9','24-02-2024 15:09:00','&#x1F923');

--inserimento affluenza
insert into fincato_palmieri."Affluenza" values ('url2','15-06-2024 14:10:00',200);
insert into fincato_palmieri."Affluenza" values ('url2','15-06-2024 14:50:00',250);
insert into fincato_palmieri."Affluenza" values ('url9','24-02-2024 15:05:00',100);
insert into fincato_palmieri."Affluenza" values ('url9','24-02-2024 16:40:00',90);

--inserimento video
insert into fincato_palmieri."Video" values ('url7',900,'url6');
insert into fincato_palmieri."Video" values ('url10',600,'url9');
insert into fincato_palmieri."Video" values ('url3',1200,'url1');

--inserimento clip
insert into fincato_palmieri."Clip" values ('url8',120,626,'url10');
insert into fincato_palmieri."Clip" values ('url4',90,3614,'url7');





