--tabelle
create table Utente(
	NomeUtente varchar(50) default 'guest_UUID' primary key	
);

create table Categoria(
	NomeCategoria varchar(30) default 'non categorizzato' primary key
);

create table Hashtag(
	NomeHashtag varchar(30) primary key
);

create table Emoji(
	Codice integer primary key
);

create table Registrato(
	Username varchar(50) primary key references Utente(NomeUtente) 
		on update cascade 
		on delete cascade,
	"Password" varchar(15) not null,
	DataDiNascita date not null,
	NumeroDiTelefono varchar(13),	
	IndirizzoMail varchar(50),	 
	Affiliate boolean default false,
	Premium boolean default false,
	LIS boolean not null
);

create table Messaggio(
	Mittente varchar(50) references Registrato(Username)
		on update cascade 
		on delete set default,
	TimestampMessaggio timestamp(3),
	Destinatario varchar(50) references Registrato(Username)
		on update cascade 
		on delete set default,
	Testo varchar(1000) not null,	
	primary key(Mittente, TimestampMessaggio)
);

create table Portafoglio(
	UtenteProprietario varchar(50) primary key references Registrato(Username)
		on update cascade
		on delete cascade, 
	TotaleBits integer default 0
);

create table Donazione(
	MittenteDonazione varchar(50) references Portafoglio(UtenteProprietario)
		on update cascade
		on delete set default, 
	TimestampDonazione timestamp(3), 
	Destinatario varchar(50) references Portafoglio(UtenteProprietario)
		on update cascade
		on delete set default,	 
	Streamer boolean not null, 
	Bits integer default 0,
	primary key(MittenteDonazione, TimestampDonazione)
);

create table Hosting(
	UtenteStreamer varchar(50) references Registrato(Username)
		on update cascade
		on delete cascade, 
	TimestampRinnovo timestamp(3) not null, 
	Pagato boolean not null, 
	Corrispettivo integer not null,
	primary key(UtenteStreamer,TimestampRinnovo)
);

create table Programmazione(
	Streamer varchar(50) references Registrato(Username)
		on update cascade
		on delete cascade, 
	"Timestamp" timestamp(3) not null, 
	Titolo varchar(100) not null, 
	LIS boolean not null, 
	Premium boolean not null,
	primary key(Streamer, "Timestamp")
);

create table Canale(
	StreamerProprietario varchar(50) primary key references Registrato(Username)
		on update cascade
		on delete cascade, 
	Descrizione varchar(100), 
	ImmagineProfilo varchar(20), 
	Trailer varchar(100)
);

create table Abbonamento(
	UtenteAbbonato varchar(50) references Registrato(Username)
		on update cascade
		on delete cascade, 
	Streamer varchar(50) references Canale(StreamerProprietario)
		on update cascade
		on delete cascade,
	primary key(UtenteAbbonato,Streamer)
);

create table Follower(
	UtenteFollower varchar(50) references Registrato(Username)
		on update cascade
		on delete cascade, 
	StreamerSeguito varchar(50) references Canale(StreamerProprietario)
		on update cascade
		on delete cascade,
	primary key(UtenteFollower, StreamerSeguito)
);

create table LinkSocial(
	CanaleAssociato varchar(50) references Canale(StreamerProprietario)
		on update cascade
		on delete cascade, 
	Social varchar(20) not null, --nome social
	"Link" varchar(2100) not null, --URL
	primary key(CanaleAssociato, Social)
);

create table ContenutoMultimediale(
	IdContenuto integer primary key, 
	Canale varchar(50) references Canale(StreamerProprietario)
		on update cascade
		on delete cascade, 
	Titolo varchar(150) not null, 
	Categoria varchar(30) not null references Categoria(NomeCategoria)
		on update cascade
		on delete set default, 
	LIS boolean not null
);

create table Voto(
	UtenteRegistrato varchar(50) references Registrato(Username)
		on update cascade
		on delete set default, 
	ContenutoMultimediale integer references ContenutoMultimediale(IdContenuto)
		on update cascade
		on delete cascade, 
	Likert smallint not null check(Likert>=1 AND Likert<=10),
	primary key(UtenteRegistrato,ContenutoMultimediale)
);

create table Visita(
	Utente varchar(50) references Utente(NomeUtente)
		on update cascade
		on delete cascade, 
	ContenutoMultimediale integer references ContenutoMultimediale(IdContenuto)
		on update cascade
		on delete cascade, 
	"Like" boolean default false,
	primary key(Utente,ContenutoMultimediale)
);

create table Nuovo(
	NuovoHashtag  varchar(30) references Hashtag(NomeHashtag)
		on update cascade
		on delete no action, 
	ContenutoMultimediale integer references ContenutoMultimediale(IdContenuto)
		on update cascade,
	primary key(NuovoHashtag)
);

create table Predefinito(
	HashtagPredefinito  varchar(30) references Hashtag(NomeHashtag)
		on update cascade
		on delete no action, 
	ContenutoMultimediale integer references ContenutoMultimediale(IdContenuto)
		on update cascade,
	primary key(HashtagPredefinito)
);

create table Live(
	IdLive integer primary key references ContenutoMultimediale(IdContenuto)
		on update cascade
		on delete cascade, 
	DataInizio timestamp(3) not null, 
	DataFine timestamp(3) not null, 
	Premium boolean default false
);

create table Video(
	IdVideo integer primary key references ContenutoMultimediale(IdContenuto)
		on update cascade
		on delete cascade, 
	Durata time(2) not null, 
	Live integer not null references Live(IdLive)
		on update cascade
);

create table Clip(
	IdClip integer primary key references ContenutoMultimediale(IdContenuto)
		on update cascade
		on delete cascade, 
	Durata time(2) not null, 
	Minutaggio time(2) not null, 
	Video integer not null references Video(IdVideo)
		on update cascade
);

create table Affluenza(
	Live integer references Live(IdLive)
		on update cascade
		on delete cascade, 
	TimestampAffluenza timestamp(2), 
	NumeroSpettatori integer not null,
	primary key(Live,TimestampAffluenza)
);

create table Interazione(
	Spettatore varchar(50) references Registrato(Username)
		on update cascade
		on delete set default, 
	LiveCorrente integer references Live(IdLive)
		on update cascade
		on delete cascade, 
	Tipologia char(8) not null, 
	Messaggio varchar(150), 
	"Timestamp" timestamp(2),
	primary key(Spettatore, LiveCorrente)
);

create table Presenza(
	SpettatoreLive varchar(50), 
	LiveAssociata integer,
	CodiceEmoji integer,
	primary key(SpettatoreLive,LiveAssociata,CodiceEmoji),
	foreign key(SpettatoreLive,LiveAssociata) references Interazione(Spettatore,LiveCorrente)
		on update cascade
		on delete cascade,
	foreign key(CodiceEmoji) references Emoji(Codice)
		on update cascade
);