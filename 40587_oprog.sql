 /*
CREATE VIEW widok1 AS
SELECT k.imie,k.nazwisko,s.email,c.wartosc
 FROM klient k JOIN sprzedaz sp ON
  k.id_klient=sp.id_sprzedaz JOIN sprzedawcy s 
  ON s.id_sprzedawca=sp.id_sprzedaz JOIN cena c ON 
  c.id_cena=sp.id_cena  GROUP BY k.imie,k.nazwisko,s.email,c.wartosc 
  HAVING AVG(c.wartosc) > 600

  CREATE VIEW widok2 AS
SELECT s.imie , s.nazwisko ,
 a.model,a.rodzaj,COUNT(a.id_akcesoria)+COUNT(b.id_but)AS'Liczba sprzedanych przedmiotów' FROM 
 klient k JOIN sprzedaz sp ON
  k.id_klient=sp.id_sprzedaz JOIN sprzedawcy s 
  ON s.id_sprzedawca=sp.id_sprzedawca JOIN cena c ON c.id_cena=sp.id_cena JOIN but b ON 
  c.id_but=b.id_but LEFT JOIN akcesoria a ON a.id_akcesoria = c.id_akcesoria GROUP BY s.imie,s.nazwisko,b.model,a.rodzaj,a.model
   
   
  CREATE FUNCTION spr_rabaty(@model VARCHAR(50))
  RETURNS @Raport TABLE(model VARCHAR(15) NULL,rozmiar VARCHAR(12) NULL,cena_rabatu DECIMAL(12,2))
  BEGIN
	INSERT @Raport(model,rozmiar,cena_rabatu)
	SELECT b.model,b.rozmiar,((1-ka.rabat)*c.wartosc) AS 'cena po rabacie'
	FROM karta_czl ka JOIN klient k ON ka.id_karta_czl=k.id_karta_czl JOIN sprzedaz sp ON
	k.id_klient=sp.id_klient JOIN sprzedawcy s 
	ON s.id_sprzedawca=sp.id_sprzedawca JOIN cena c ON c.id_cena=sp.id_cena JOIN but b ON 
	b.id_but=c.id_but WHERE  b.rodzaj = @model
	RETURN
  END

  CREATE FUNCTION ilosc_zakupow(@id_klient INT)
  RETURNS INT
  BEGIN
	DECLARE @ile INT
	SELECT @ile = COUNT(*)
	FROM klient k JOIN sprzedaz sp ON
	k.id_klient=sp.id_klient WHERE k.id_klient = @id_klient
	RETURN @ile
  END
     
	 CREATE PROC dodaj_klienta
	 @imie VARCHAR(20),@nazwisko VARCHAR(30),
	 @nr_tel VARCHAR(20) ,@email VARCHAR(30),
	 @ulica VARCHAR(20) , @miasto VARCHAR(20),
	 @nr_dom VARCHAR(20) , @KOD CHAR(6),@rabat BIT,
	 @data_zalozenia DATETIME
	AS
	 INSERT INTO klient(imie,nazwisko,
	 nr_tel,email,ulica,miasto,nr_dom,kod,rabat,data_zalozenia)
	 VALUES (@imie,@nazwisko,
	 @nr_tel ,@email,
	 @ulica, @miasto,
	 @nr_dom, @KOD,@rabat,
	 @data_zalozenia)
	 GO

	 CREATE PROC przecena1
	 @id_prod INT , @nowa_cena MONEY OUTPUT,@proc INT = 10
	 AS
	 BEGIN 
		SELECT @nowa_cena=wartosc - wartosc*@proc/100
		FROM cena
		WHERE id_cena=@id_prod

		UPDATE cena
		SET wartosc = @nowa_cena
		WHERE id_cena=@id_prod
	END;
	GO

	DECLARE @n_c MONEY
	EXEC przecena1 2 , @n_c OUTPUT
	PRINT @n_c


CREATE TRIGGER nie_usuwaj ON pracownik
INSTEAD OF DELETE 
AS
BEGIN
	UPDATE pracownik
	SET usuniety=1
	WHERE id_pracownik IN(SELECT id_pracownik FROM DELETED)
END
GO

CREATE TRIGGER usuniecie_info ON pracownik
AFTER DELETE 
AS
BEGIN
	PRINT 'Usuniêto ' + STR(@@ROWCOUNT) + ' rekordów'
	PRINT 'Rekordy usuniête z bazy o nazwie ' + DB_NAME()
	PRINT ''
END
GO

CREATE TRIGGER INFO ON pracownik
AFTER INSERT,DELETE
AS

IF @@ROWCOUNT>1
BEGIN
		PRINT 'Mo¿na usun¹æ tylko poojedyñczo pracownika'
		ROLLBACK
	END
	GO
	
CREATE TRIGGER usuwanie_ceny ON cena
AFTER DELETE
AS
BEGIN
	DECLARE kursor CURSOR
	FOR SELECT wartosc,czy_rabat FROM DELETED;
	DECLARE @imie VARCHAR(20),@nazwisko VARCHAR(30)

	OPEN kursor
	FETCH NEXT FROM kursor INTO @imie,@nazwisko

	WHILE @@FETCH_STATUS = 0
	BEGIN 
		PRINT 'Usuniêto ' + @imie + @nazwisko
		FETCH NEXT FROM kursor INTO @imie , @nazwisko
	END

	CLOSE kursor
	DEALLOCATE kursor
END
*/

