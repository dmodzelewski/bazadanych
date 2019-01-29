
SET DATEFORMAT ymd;
GO

--Utworzenie wymaganych tabel
CREATE TABLE karta_czl (
  id_karta_czl INT IDENTITY(1,1) PRIMARY KEY,
  produkt VARCHAR(50) NOT NULL,
  rabat DECIMAL(8,2) NOT NULL,
  data_zalozenia DATETIME,
);
GO

CREATE TABLE klient (
  id_klient INT IDENTITY(1,1) PRIMARY KEY,
  id_karta_czl INTEGER REFERENCES karta_czl(id_karta_czl),
  imie VARCHAR(25) NOT NULL,
  nazwisko VARCHAR(30) NOT NULL,
  nr_tel VARCHAR(20) NOT NULL,
  email VARCHAR(30) NOT NULL,
  ulica VARCHAR(30) NOT NULL,
  miasto VARCHAR(30) NOT NULL,
  nr_dom VARCHAR(10) NOT NULL,
  kod CHAR(6) NOT NULL,
  rabat BIT DEFAULT 0,
  

);
GO

CREATE TABLE pracownik (
  id_pracownik INT IDENTITY(1,1) PRIMARY KEY,
  imie VARCHAR(25) NOT NULL,
  nazwisko VARCHAR(30) NOT NULL,
  nr_tel VARCHAR(20) NOT NULL,
  email VARCHAR(30) NOT NULL,
  stanowisko VARCHAR(30) NOT NULL,
);
GO
CREATE TABLE reklamacje (
  id_reklamacje INT IDENTITY(1,1) PRIMARY KEY,
  id_pracownik INTEGER NOT NULL REFERENCES pracownik(id_pracownik),
  opis_uszkodzenia VARCHAR(100) NOT NULL,
  data_uszko DATETIME NOT NULL,
  zwrot_pieniedzy BIT NOT NULL DEFAULT 0,
  naprawa BIT NOT NULL DEFAULT 0,
  czy_zasadna BIT DEFAULT 0,
);
GO
CREATE TABLE sprzedawcy (
  id_sprzedawca INT IDENTITY(1,1) PRIMARY KEY,
  imie VARCHAR(25) NOT NULL,
  nazwisko VARCHAR(30) NOT NULL,
  nr_tel VARCHAR(20) NOT NULL,
  email VARCHAR(30) NOT NULL,
);
GO
CREATE TABLE rabat (
  id_rabat INT IDENTITY(1,1) PRIMARY KEY,
  rabat_procent DECIMAL(10,2) NOT NULL ,
);
GO


CREATE TABLE but (
  id_but INT IDENTITY(1,1) PRIMARY KEY,
  model VARCHAR(50) NOT NULL,
  rozmiar VARCHAR(50) NOT NULL,
  kod_kreskowy CHAR(12) NOT NULL,
  rodzaj VARCHAR(30) NOT NULL,
);
GO

CREATE TABLE akcesoria (
  id_akcesoria INT IDENTITY(1,1) PRIMARY KEY,
  model VARCHAR(50) NOT NULL,
  rodzaj VARCHAR(50) NOT NULL,
  material VARCHAR(50) NOT NULL,
  kod_kreskowy CHAR(12) NOT NULL,
);
GO
CREATE TABLE cena (
  id_cena INT IDENTITY(1,1) PRIMARY KEY,
  id_but INTEGER REFERENCES but(id_but),
  id_akcesoria INTEGER REFERENCES akcesoria(id_akcesoria),
  id_rabat INTEGER REFERENCES rabat(id_rabat),
  wartosc  MONEY NOT NULL,
  czy_rabat BIT NOT NULL DEFAULT 0, 
);
GO
CREATE TABLE adres(
  id_adres INT IDENTITY(1,1) PRIMARY KEY,
  id_pracownik INTEGER REFERENCES pracownik(id_pracownik),
  id_sprzedawca INTEGER REFERENCES sprzedawcy(id_sprzedawca),
  miasto VARCHAR(50) NOT NULL,
  ulica VARCHAR(50) NOT NULL,
  numer VARCHAR(50) NOT NULL, 
  kod CHAR(10) NOT NULL,
);

CREATE TABLE sprzedaz (
  id_sprzedaz INT IDENTITY(1,1) PRIMARY KEY,
  id_klient INTEGER NOT NULL REFERENCES klient(id_klient),
  id_sprzedawca INTEGER NOT NULL REFERENCES sprzedawcy(id_sprzedawca),
  id_cena INTEGER REFERENCES cena(id_cena),
  data_zakupu DATETIME NOT NULL 

);
GO

--karta_cz³onkowska
INSERT INTO karta_czl(produkt,rabat,data_zalozenia) VALUES	('mêski',0.20,'2018-08-13 21:27')
INSERT INTO karta_czl(produkt,rabat,data_zalozenia) VALUES	('mêski',0.20,'2018-08-13 21:27')
INSERT INTO karta_czl(produkt,rabat,data_zalozenia) VALUES	('mêski',0.20,'2018-08-13 21:27')
INSERT INTO karta_czl(produkt,rabat,data_zalozenia) VALUES	('mêski',0.20,'2018-08-13 21:27')
INSERT INTO karta_czl(produkt,rabat,data_zalozenia) VALUES	('mêski',0.20,'2018-08-13 21:27')
--klient
INSERT INTO klient(imie,nazwisko,nr_tel,email,ulica,miasto,nr_dom,kod,rabat) VALUES ('Aleksandra','Potocka','7539145688','aleksandrapotocka@gmail.com','Potok','Grunwald','10a','83-123',0);
INSERT INTO klient(id_karta_czl,imie,nazwisko,nr_tel,email,ulica,miasto,nr_dom,kod,rabat) VALUES (1,'Karolina','Kanigowska','7437589122','karola123@gmail.com','Rzeka','Warszawa','102a','85-123',1);
INSERT INTO klient(id_karta_czl,imie,nazwisko,nr_tel,email,ulica,miasto,nr_dom,kod,rabat) VALUES (3,'Tomasz','Radzewicz','7748021588','radzetom68@o2.pl','S³oneczna','Gdañsk','20a','84-163',1);
INSERT INTO klient(id_karta_czl,imie,nazwisko,nr_tel,email,ulica,miasto,nr_dom,kod,rabat) VALUES (1,'Juliusz','Machulski','71031201023','julius@o2.pl','Górska','Olsztyn','345','84-123',1);
INSERT INTO klient(id_karta_czl,imie,nazwisko,nr_tel,email,ulica,miasto,nr_dom,kod,rabat) VALUES (2,'Kazimierz','Jagielloñczyk','22011005321','brak','Dobra','Pruszcz Gdañski','456','83-543',1);
--pracownik
INSERT INTO pracownik(imie,nazwisko,nr_tel,email,stanowisko) VALUES ('Kamil','Jakoœ','7539145688','KJ@gmail.com','kierownik');
INSERT INTO pracownik(imie,nazwisko,nr_tel,email,stanowisko) VALUES ('Agata','Gmin','9163729103','agatagmin@gmail.com','lider');
INSERT INTO pracownik(imie,nazwisko,nr_tel,email,stanowisko) VALUES ('Monika','Len','7412586322','monikalen@gmail.com','menager');
INSERT INTO pracownik(imie,nazwisko,nr_tel,email,stanowisko) VALUES ('Adam','Ma³ysz','5374029857','adammalysz@gmail.com','informatyk');
INSERT INTO pracownik(imie,nazwisko,nr_tel,email,stanowisko) VALUES ('Piotr','¯yla','5750987461','piotrzyla@gmail.com','zatêpca kierownika');
--reklamacje
INSERT INTO reklamacje(id_pracownik,opis_uszkodzenia,data_uszko,zwrot_pieniedzy,naprawa) VALUES (1,'sdkjfo dsf sdfsf sdf','2015-08-13 21:27',0,1);
INSERT INTO reklamacje(id_pracownik,opis_uszkodzenia,data_uszko,zwrot_pieniedzy,naprawa) VALUES (5,'sdkjfo dsf sdfsf sdf','2015-08-13 21:27',0,1);
INSERT INTO reklamacje(id_pracownik,opis_uszkodzenia,data_uszko,zwrot_pieniedzy,naprawa) VALUES (5,'sdkjfo dsf sdfsf sdf','2015-08-13 21:27',1,0);
INSERT INTO reklamacje(id_pracownik,opis_uszkodzenia,data_uszko,zwrot_pieniedzy,naprawa) VALUES (1,'sdkjfo dsf sdfsf sdf','2015-08-13 21:27',0,1);
INSERT INTO reklamacje(id_pracownik,opis_uszkodzenia,data_uszko,zwrot_pieniedzy,naprawa) VALUES (1,'sdkjfo dsf sdfsf sdf','2015-08-13 21:27',1,0);
--rabat
INSERT INTO rabat(rabat_procent) VALUES (0.20);
INSERT INTO rabat(rabat_procent) VALUES (0.30);
INSERT INTO rabat(rabat_procent) VALUES (0.40);
INSERT INTO rabat(rabat_procent) VALUES (0.50);
INSERT INTO rabat(rabat_procent) VALUES (0.60);

--but
INSERT INTO but(model,rozmiar,kod_kreskowy,rodzaj) VALUES ('asd_cos',23,'174635465783','dziêciecy');
INSERT INTO but(model,rozmiar,kod_kreskowy,rodzaj) VALUES ('sd_90sd8',43,'174635465786','mêski');
INSERT INTO but(model,rozmiar,kod_kreskowy,rodzaj) VALUES ('DSF_dF3r',33,'174635463486','damski');
INSERT INTO but(model,rozmiar,kod_kreskowy,rodzaj) VALUES ('OIJ_789f',43,'123456789012','mêski');
INSERT INTO but(model,rozmiar,kod_kreskowy,rodzaj) VALUES ('dfo_df87',43,'174635465676','mêski');

--akcesoria
INSERT INTO akcesoria(model,rodzaj,material,kod_kreskowy) VALUES ('asd_ghs','torebka','skóra','123234345456');
INSERT INTO akcesoria(model,rodzaj,material,kod_kreskowy) VALUES ('a234_ghs','torba','sztuczna','123223345456');
INSERT INTO akcesoria(model,rodzaj,material,kod_kreskowy) VALUES ('345d_ghs','naszyjnik','z³oto','123234345567');
INSERT INTO akcesoria(model,rodzaj,material,kod_kreskowy) VALUES ('4g545t_ghs','portfel','skóra','123233455456');
INSERT INTO akcesoria(model,rodzaj,material,kod_kreskowy) VALUES ('5b6_ghs','szal','bawe³na','145634345456');
--cena
INSERT INTO cena(id_but,id_rabat,wartosc,czy_rabat) VALUES (1,1,100,1);
INSERT INTO cena(id_but,id_akcesoria,wartosc,czy_rabat) VALUES (2,2,200,0);
INSERT INTO cena(id_but,id_akcesoria,id_rabat,wartosc,czy_rabat) VALUES (3,3,2,159.99,1);
INSERT INTO cena(id_but,id_akcesoria,id_rabat,wartosc,czy_rabat) VALUES (4,4,3,699.99,1);
INSERT INTO cena(id_but,id_akcesoria,id_rabat,wartosc,czy_rabat) VALUES (5,5,4,40,1);
--sprzedawcy
INSERT INTO sprzedawcy(imie,nazwisko,nr_tel,email) VALUES ('Jan','Drzewo','587428964','jandrzewo@gmail.com');
INSERT INTO sprzedawcy(imie,nazwisko,nr_tel,email) VALUES ('Mateusz','Kowalski','147963357','mateuszkowalski@gmail.com');
INSERT INTO sprzedawcy(imie,nazwisko,nr_tel,email) VALUES ('Franciszek','Tusk','851964785','fracniszektusk@gmail.com');
INSERT INTO sprzedawcy(imie,nazwisko,nr_tel,email) VALUES ('£ukasz','Podolski','823657425','lukaszpodolski@gmail.com');
INSERT INTO sprzedawcy(imie,nazwisko,nr_tel,email) VALUES ('Cristiano','Ronaldo','692710158','cristianoronaldo@gmail.com');
--sprzedaz
INSERT INTO sprzedaz(id_klient,id_sprzedawca, id_cena,data_zakupu) VALUES (1,1,1,'2010-08-13 21:27');
INSERT INTO sprzedaz(id_klient,id_sprzedawca,id_cena,data_zakupu) VALUES (2,2,2,'2016-08-13 21:27');
INSERT INTO sprzedaz(id_klient,id_sprzedawca,id_cena,data_zakupu) VALUES (5,3,3,'2015-08-13 21:27');
INSERT INTO sprzedaz(id_klient,id_sprzedawca,id_cena,data_zakupu) VALUES (3,4,4,'2014-08-13 21:27');
INSERT INTO sprzedaz(id_klient,id_sprzedawca,id_cena,data_zakupu) VALUES (4,5,5,'2017-08-13 21:27');