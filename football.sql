<<...creating table country...>>
create table country(
task(# ID int primary key,
task(# NAME varchar(15) not null);

<<...inserting values to country...>>
insert into  country ("id","name")
values(101,'England'),(102,'Argentina'),(109,'Portugal'),(124,'Germany'),
(135,'Spain'),(136,'Italy'),(149,'Egypt'),(158,'Brazil'),(202,'France');


select * from country;
 id  |   name    
-----+-----------
 101 | England
 102 | Argentina
 109 | Portugal
 124 | Germany
 135 | Spain
 136 | Italy
 149 | Egypt
 158 | Brazil
 202 | France
(9 rows)

<<...creating table coach...>>
create table coach(
id int primary key,
name varchar(15) not null,
age int not null,
country_id int,
foreign key (country_id) references country(id));

<<...inserting values to coach...>>
insert into coach("id","name","age","country_id")
values(2349,'Pochettino',50,102),(2648,'Allegri',54,136)
,(3414,'Conte',52,136),(4821,'Rangnick',63,124),
(5975,'Xavi',42,135),(7456,'Klopp',54,124);


select * from coach;
  id  |    name    | age | country_id 
------+------------+-----+------------
 2349 | Pochettino |  50 |        102
 2648 | Allegri    |  54 |        136
 3414 | Conte      |  52 |        136
 4821 | Rangnick   |  63 |        124
 5975 | Xavi       |  42 |        135
 7456 | Klopp      |  54 |        124
(6 rows)

<<...creating table club...>>
create table club (
id int primary key,
name varchar(15) not null,
coach_id int not null,
country_id int not null,
foreign key (coach_id) references coach(id),
foreign key (country_id) references country(id));

<<...inserting values to club...>>
insert into club("id","name","coach_id","country_id")
values(635,'Liverpool',7456,101),(723,'Juventus',2648,136),
(893,'Barcelona',5975,135),(897,'Manchester U.',4821,101),
(901,'PSG',2349,202),(975,'Tottenham',3414,101);


select * from club;
 id  |     name      | coach_id | country_id 
-----+---------------+----------+------------
 635 | Liverpool     |     7456 |        101
 723 | Juventus      |     2648 |        136
 893 | Barcelona     |     5975 |        135
 897 | Manchester U. |     4821 |        101
 901 | PSG           |     2349 |        202
 975 | Tottenham     |     3414 |        101
(6 rows)

<<...creating table players...>>
create table players(
id int primary key,
name varchar(15) not null,
age int not null,
goals int not null,
club_id int not null,
country_id int not null,
foreign key (club_id) references club(id),
foreign key (country_id) references country(id));

<<...inserting values to players...>>
insert into players("id","name","age","goals","club_id","country_id")
values(1,'Messi',34,761,901,102),(2,'Ronaldo',37,801,897,109),
(3,'Neymar',30,344,901,158),(4,'Salah',29,223,635,149),
(5,'Kane',28,241,975,101);


select * from players;
 id |  name   | age | goals | club_id | country_id 
----+---------+-----+-------+---------+------------
  1 | Messi   |  34 |   761 |     901 |        102
  2 | Ronaldo |  37 |   801 |     897 |        109
  3 | Neymar  |  30 |   344 |     901 |        158
  4 | Salah   |  29 |   223 |     635 |        149
  5 | Kane    |  28 |   241 |     975 |        101
(5 rows)

_________________________________________________________________________

(1):Write a query to find all clubs from ‘England’

select a.name as club,b.name as country
from club a 
inner join country b
on a.country_id=b.id
where b.name='England';

     club      | country 
---------------+---------
 Liverpool     | England
 Manchester U. | England
 Tottenham     | England
(3 rows)

_________________________________________________________________________

(2):Write a query to display all the players whose coach is from the same country

select players.name, players.club_id,club.coach_id,players.country_id 
  from players
  where players.club_id=(
  select id from club
  where club.coach_id=(
  select id from coach 
  where players.country_id=coach.country_id));

 name  | club_id | coach_id | country_id 
-------+---------+----------+------------
 Messi |     901 |     2349 |        102
(1 row)

_________________________________________________________________________

(3):Write a query to find all players whose club is from the same country

select players.name,players.club_id,players.country_id 
from players
inner join club 
on players.club_id = club.id 
players.country_id = club.country_id;

 name | club_id | country_id 
------+---------+------------
 Kane |     975 |        101
(1 row)


________________________________________________________________________

(4):Write a query to find all coaches who are coaching for teams from different countries and ages below 59 order by age.

select * from coach
where country_id not in (select country_id from club
where coach_id=coach.id) 
and age < 59
order by age;

  id  |    name    | age | country_id 
------+------------+-----+------------
 2349 | Pochettino |  50 |        102
 3414 | Conte      |  52 |        136
 7456 | Klopp      |  54 |        124
(3 rows)
______________________________________________________________________

(5):Write a query to create a view of the top 5 goals scored by player, country, age, goal, club, and coach 

select players.name as player,country.name as country, players.age, club.name as club, players.goals  
from players,club,country 
where players.country_id = country.id 
and players.club_id = club.id 
order by goals desc limit 5;

 player  |  country  | age |     club     | goals 
---------+-----------+-----+--------------+-------
 Ronaldo | Portugal  |  37 | Manchester U |   801
 Messi   | Argentina |  34 | PSG          |   761
 Neymar  | Brazil    |  30 | PSG          |   344
 Kane    | England   |  28 | Tottenham    |   241
 Salah   | Egypt     |  29 | Liverpool    |   223
(5 rows)
