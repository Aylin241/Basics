--SPALTEN 
-- Spalte ANLEGEN 
ALTER TABLE Tabelle  
	ADD ( SpalteX NUMBER(10) NOT NULL ,   
		  SpalteY DATE  NOT NULL ); 
 
-- Spalten ÄNDERN 
ALTER TABLE Tabelle  
	MODIFY ( SpalteX NUMBER(2)  NOT NULL ,    
			 SpalteY VARCHAR2(10)); 
 
-- Spalten LÖSCHEN 
ALTER TABLE Tabelle  
	DROP ( SpalteX, SpalteY ); 
	
--SpaltenNAME ÄNDERN
alter table lib_rental
rename column return to rückgabe; --von return zu rückgabe
	

--LÖSCHE den Kategorie-Eintrag „Kinderbuch“ in der Tabelle lib_category. 
delete 
from lib_category
where cat_name like 'Kinderbuch';

--Löschen Sie alle Personen, deren letzte Bestellung vom heutigen Tag aus gesehen mehr als ein Jahr zurückliegt
delete 
from person
where pnr in (select pnr
				from bestellung
				group by pnr
				having max(datum) < sysdate -INTERVAL '1' year);
				
				
			
--Löschen Sie alle Kunden außer denjenigen mit der Kundennr 1 und jenen, 
--die eine Reklamation angemeldet haben, welche von der Mitarbeiternr 16 bearbeitet wird.			
delete 
from kunde
where kundennr != 1 and kundennr not in (select kundennr
										 from reklamation
										 where reklamationnr not in (select reklamationnr
																	from reklamationposition 
																	where bearbeitungsnr not in (select bearbeitungsnr
																								from reklamationbearbeitung
																								where Mitarbeiternr=16)));


--in die Tabelle studentische_person EINFÜGEN
Insert into studentische_person (matrikelnr, name, studiengangnr, unix_name)
values (999999, 'blabla', 15, 'bala');

Insert into fach (fachnr, bezeichnung)
values (903, 'Advanced Databases');


--Fügen Sie sich selbst als Person ein und leihen Sie sich ein Exemplar des Videotitels ‚Rambo’ aus.
insert into person (pnr, name, geburtsdatum)
values (12345, 'aylin', to_date('24.01.1994', 'dd.mm.yyyy'));

--select titel, exnr from videotitel, videoexemplar where titel ='rambo';
insert into Ausleihe
values (12345, sysdate, 3, sysdate+7,sysdate+50);

----------------------------------------------------------------------------------------------


--TABELLE 
-- Tabelle UMBENENNEN 
ALTER TABLE Tabelle  
RENAME TO neuer_name;  
 
-- Tabelle LÖSCHEN 
DROP TABLE Tabelle; 
 
-- Tabelle LÖSCHEN UND CONSTRAINTS VERWERFEN 
DROP TABLE Tabelle CASCADE CONSTRAINTS; 



Create table ausleihe(
exnr 						number(5) not null,
kundenr 					number(5) not null,
mitarbeiter 				number(5) not null,
rueckgabe_plan 				date      not null, 
rueckgabe_tatsaechlich 		date, 
ausleih_datum 				date 	  not null,
PRIMARY KEY (exnr, kundenr, mitarbeiter)
);


Create table Ausleihe(
pnr 						number(5) not null,
datum 						date	  not null,
exnr		 				number(5) not null,
rueckgabe_geplant			date, 
rueckgabe_tatsaechlich 		date, 
PRIMARY KEY (pnr, datum, exnr), 
FOREIGN KEY (pnr) REFERENCES person (pnr),
FOREIGN KEY (exnr) REFERENCES videoexemplar (exnr)
);



--ÄNDERN

-- Tragen Sie in der Bestellung mit Nr 19366 ein Lieferdatum ein, 
--das neun Tage in der Zukunft liegt von heute aus gesehen!
update bestellung
set lieferdatum= sysdate +9
where bestellnr=19366;

--Ändern Sie Ihr Geburtdatum  auf den 7. August 1974!
update person
set geburtsdatum= to_date('07.August 1974', 'dd.MONTH yyyy');
where name='aylin';


--Reduziere die Seitenzahl aller Bücher der Autoren mit dem Nachnamen „Feuerstein“ um 100. 
update lib_book 
set pages= pages-100
where book_id in (select book_id 
				  from lib_did_write
				  where auth_id in (select auth_id
									from lib_author
									where surname like 'Feuerstein'));
									
update lib_book 
set pages= pages-100
where book_id in (select book_id 
				  from lib_did_write ldw
				  inner join lib_author la on ldw.auth_id=la.auth_id
				  where surname like 'Feuerstein');			


				  

--Ändere bei allen Büchern, die von „Heyne“ herausgegeben wurden, den Verleger in „Fischer“ um. 
UPDATE lib_publisher
SET pub_name = 'Fischer'
WHERE pub_name = 'Heyne';

