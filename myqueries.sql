-----------------------------------------------------------------------------------------
--Only used for COMP6240 students in S2 2021
--Please enter your SQL queries to Question 1.1-1.10 
--Please input your UID here: u7274552
------------------------------------------------------------------------------------------

-- Q1.1

SELECT count(* )
from movie 
where major_genre = 'drama'
AND country = 'New Zealand';


-- Q1.2


select m.title, m.production_year
from movie as m, restriction as r
where m.title = r.title 
and m.production_year = r.production_year 
and r.country = 'Sweden'
and r.description = 'Btl'
order by m.production_year DESC;


-- Q1.3

select country,count(DISTINCT description)
from restriction
group by country
having count(DISTINCT description)>2
;



-- Q1.4
select title,production_year
from(select title,production_year,result
from director_award 
UNION 
select title,production_year,result
from writer_award)
 as new 
 where result = 'won';


-- Q1.5

select m.title, m.production_year, age
from movie as m left join (
    select title, (d.production_year - p.year_born) as age
from director as d left join person as p
on d.id = p.id
) as pp
on m.title = pp.title
where m.country = 'Germany';




-- Q1.6


select max(c)

from (
    select count(*) as c, title 
from crew 
group by title 
) as n;



-- Q1.7


select id, first_name,last_name 
from person as p right join  (
    select did, count(wid)
from (select d.id as did, d.title, d.production_year,w.id as wid 
from writer as w right join director as d 
on d.title = w.title  and d.production_year = w. production_year
) as n
where did <> wid
group by did 
having count(wid)>1
order by did 

) as the_man
on p.id = the_man.did
order by last_name ASC
;

-- Q1.8


select count(*)
from (select title, count(id)
from writer 
group by title
having count(id) = 1) as a;
-- Q1.9


select distinct id
from director as d left join director_award as a
on d.title = a.title and d.production_year = a.production_year
where (result <> 'won' or result is null)
and (id in (select id 
from (
select count(m.title) as count,id
from movie as m left join director as di 
on m.title = di.title and m.production_year = di.production_year
group by id
) as aa
where count=3))
group by id ,result
order by id
;


-- Q1.10


select p.id , p.first_name,p.last_name
from person as p , (select *from ((select d.id 
from director as d left join role as r 
on d.id = r.id and d.title = r.title and d.production_year = r.production_year
where d.id = r.id order by d.id) except (
    select distinct d.id from director as d left join role as r 
on d.id = r.id and d.title = r.title and d.production_year = r.production_year
where  r.id is null order by d.id)) as aa) as bb where p.id = bb.id
;


----------------------------------------------------------------
-- End of your answers
-----------------------------------------------------------------
