--01. Welches Department (Deptno) hat die meisten Mitarbeiter?
select deptno
from emp
group by deptno
having count(*) = (select max(count(*))
				   from emp
 				   group by deptno);

--02. Welcher Mitarbeiter/in (Empno, Ename) hat das höchste Gehalt von denen, die ab dem 01.03.1981 eingestellt wurden?
select empno, ename
from emp
where sal in (select max(sal)
			  from emp
			  where hiredate >= to_date('01.03.1981', 'dd.mm.yyyy'));
			  
--03. Wie viele Mitarbeiter/innen gibt es je Job? Leere Jobs sollen durch ein '-' dargestellt werden!
select count(nvl(job,'-')) as mitarbeiter, job
from emp
group by job;

--04. Wie viele Mitarbeiter/innen gibt es je Department? Geben Sie die Depno, DName und die Anzahl der Mitarbeiter aus.
select d.deptno, dname, count(e.deptno) mitarbeiter
from dept d
inner join emp e on d.deptno=e.deptno
group by dname,deptno;


-- 05. Wie hoch sind die monatlichen Lohnkosten (inkl. Provision)?
select sum( nvl(sal,0) + nvl(comm,0)) Lohnkosten
from emp;


-- 06. Geben Sie alle Mitarbeiter/innen (Empno, Ename, Job) aus, die keine Provision erhalten.
select empno, ename, job
from emp
where comm is null or comm=0;

-- 07. Geben Sie alle Mitarbeiter/innen aus, deren Name auf 'S' endet.
select ename, empno 
from emp
where upper(ename) like '%S';

-- 08. Geben Sie alle Mitarbeiter/innen aus, deren Empno eine 9 enthält.
select *
from emp 
where to_char(empno) like '%9%';

-- 09. Welche Mitarbeiter wurden im Februar 1981 eingestellt?
select *
from emp
where to_char(hiredate, 'mm.yyyy') = '02.1981';

-- 10. Wie viele Mitarbeiter/innen wurden je Monat-Jahr eingestellt? Die Ausgabe soll aufsteigend nach Jahr und Monat sortiert sein!
select to_char(hiredate, 'yyyy-mm') year_month, count(*) employees
from emp
where hiredate is not null
group by to_char(hiredate, 'yyyy-mm')
order by to_char(hiredate, 'yyyy-mm');

-- 11. Welcher Student hat sich zu welcher Klausur angemeldet? Geben Sie Matrikelnr, Name des Studenten, Klausurnr, Datum, Raum sowie die Fachnr und Fachbezeichnung aus!
select distinct stp.matrikelnr, stp.name, kl.klausurnr, kl.datum, kl.raum, fa.fachnr, fa.bezeichnung
from studentische_person stp
inner join anmeldung an on stp.matrikelnr = an.matrikelnr
inner join klausur kl on an.klausurnr = kl.klausurnr
inner join klaus_bezie_angebo kba on kl.klausurnr = kba.klausurnr
inner join fach fa on kba.fachnr = fa.fachnr;








