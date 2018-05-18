--Liste den Namen des Mitarbeiters, der am längsten eingestellt war
select ename 
from emp
where hiredate in (select min(hiredate)
				   from emp);
				   
--Wie heißt der zweitälteste Mitarbeiter?
select vorname, nachname
from mitarbeiter
where geburtstag in (select min(geburtstag)
					 from mitarbeiter 
					 where geburtstag > (select min(geburtstag)
										 from mitarbeiter));
				   
--Wie heißt der drittjüngste Mitarbeiter?
select vorname 
from mitarbeiter
where geburtstag= (select max(geburtstag)
				   from mitarbeiter
				   where geburtstag < (select max(geburtstag)
									   from mitarbeiter
									   where geburtstag < (select max(geburtstag)
														   from mitarbeiter)));
				   
--Ermitteln Sie alle Sonntagskinder				   
select nachname, geburtstag, to_char(geburtstag,'fmDAY') 
from mitarbeiter 
where to_char(geburtstag,'fmDAY') = 'SONNTAG';



--Gebe Mitarbeiter aus, die nicht in den Departments 30 und 10 arbeiten
select ename
from emp
where deptno not in (30,10);

--Wie heißt das teuerste gekaufte Produkt von der PNR=102?
select max(preis), bezeichnung
from artikel a 
inner join bestellposition bp on a.artikelnr=bp.artikelnr 
inner join lieferung l on bp.lieferungsnr=l.lieferungsnr
inner join person p on l.pnr=p.pnr 
where p.pnr=102
group by bezeichnung;


--Welche Produkte sind überdurchschnittlich teuer?
select bezeichnung, preis 
from artikel 
where preis > (select avg(preis)
			   from artikel);


--Welcher Kunde hat bisher am meisten bestellt?----????????????????????????????
select pnr, umsatz 
from (select sum(bp.menge*preis) as umsatz 
	  from artikel a 
	  inner join bestellposition bp on a.artikelnr=bp.artikelnr
	  inner join lieferung l on bp.lieferungsnr=l.lieferungsnr
	  inner join person p on l.pnr=p.pnr)
where umsatz= (select max(umsatz) 
			   from (select sum(menge*preis) as umsatz 
					 from artikel a 
					 inner join bestellposition bp on a.artikelnr=bp.artikelnr));


--Welcher Kunde hat am häufigsten bestellt?					 
select p.pnr
from person p 
inner join bestellung b on p.pnr=b.pnr 
group by p.pnr 
having count(*) in (select max(count(*))
					from bestellung
					group by pnr);
					

--den ersten und den letzten Buchstaben von vornamen der Mitarbeiter in Großbuchstaben und den Rest in Kleinbuchstaben ausgeben
select initcap(substr(vorname,1,length(vorname)-1)) || upper(substr(vorname,-1,1)) 
from mitarbeiter;



--Welcher Mitarbeiter verdient am meisten?
select vorname, gehalt
from mitarbeiter
where gehalt in (select max(gehalt)
				 from mitarbeiter);



--Deptno mit den meisten Angestellten
select deptno 
from emp
group by deptno 
having count(*) in (select max(count(*))
					from emp 
					group by deptno);


select deptno 
from emp 
group by deptno 
having count(*) = (select max(anzahl) 
					from (select count(*) anzahl
						  from emp
						  group by deptno));



























