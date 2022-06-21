create table actors(
act_id int primary key,
act_fname varchar(10),
act_lname varchar(10),
act_gender varchar(1));


insert into actors("act_id","act_fname","act_lname","act_gender")
values(101,'James','Stewart','M'),(102,'Deborath','Kerr','F'),(107,'Nicole','Kidman','F'),
(110,'Mark','Wahlberg','M'),(111,'Woody','Allen','M'),(113,'Tim','Robbins','M'),
(114,'Kevin','Spacey','M'),(115,'Kate','Winslet','F'),(120,'Maggie','Gyllenhaal','F'),
(121,'Dev','Patel','M'),(123,'David','Aston','M'),
(124,'Ali','Astin','F');


select * from actors;
 act_id | act_fname | act_lname  | act_gender 
--------+-----------+------------+------------
    101 | James     | Stewart    | M
    102 | Deborath  | Kerr       | F
    107 | Nicole    | Kidman     | F
    110 | Mark      | Wahlberg   | M
    111 | Woody     | Allen      | M
    113 | Tim       | Robbins    | M
    114 | Kevin     | Spacey     | M
    115 | Kate      | Winslet    | F
    120 | Maggie    | Gyllenhaal | F
    121 | Dev       | Patel      | M
    123 | David     | Aston      | M
    124 | Ali       | Astin      | F
(12 rows)


________________________________________________________________________________________________
create table movie(mov_id int primary key,
mov_title varchar(25),
mov_year int,
mov_time int,
mov_lang varchar(10),
mov_dt_rel date,
mov_rel_country varchar(5));


insert into movie("mov_id","mov_title","mov_year","mov_time","mov_lang","mov_dt_rel","mov_rel_country")
values(901,'Vertigo',1985,128,'English','1958-08-24','UK'),
(902,'The Innocents',1961,100,'English','1962-02-19','SW'),
(907,'Eyes Wide Shut',1999,159,'English',null,'UK'),
(910,'Boogie Nights',1997,155,'English','1998-02-16','UK'),
(911,'Annie Hall',1977,93,'English','1977-04-20','USA'),
(913,'The Shawshank Redemption',1994,142,'English','1995-02-17','UK'),
(914,'American Beauty',1999,122,'English',null,'UK'),
(915,'Titanic',1997,194,'English','1998-01-23','UK'),
(920,'Donnie Darko',2001,113,'English',null,'UK'),
(921,'Slumdog Millionaire',2008,120,'English','2009-01-09','UK'),
(926,'Seven Samurai',1954,207,'Japanese','1954-04-26','JP'),
(927,'Spirited Away',2001,125,'Japanese','2003-09-12','UK'),
(928,'Back To The Future',1985,116,'English','1985-12-04','UK'),
(925,'Braveheart',1995,178,'English','1995-09-08','UK');


select * from movie;
 mov_id |        mov_title         | mov_year | mov_time | mov_lang | mov_dt_rel | mov_rel_country 
--------+--------------------------+----------+----------+----------+------------+-----------------
    901 | Vertigo                  |     1985 |      128 | English  | 1958-08-24 | UK
    902 | The Innocents            |     1961 |      100 | English  | 1962-02-19 | SW
    907 | Eyes Wide Shut           |     1999 |      159 | English  |            | UK
    910 | Boogie Nights            |     1997 |      155 | English  | 1998-02-16 | UK
    911 | Annie Hall               |     1977 |       93 | English  | 1977-04-20 | USA
    913 | The Shawshank Redemption |     1994 |      142 | English  | 1995-02-17 | UK
    914 | American Beauty          |     1999 |      122 | English  |            | UK
    915 | Titanic                  |     1997 |      194 | English  | 1998-01-23 | UK
    920 | Donnie Darko             |     2001 |      113 | English  |            | UK
    921 | Slumdog Millionaire      |     2008 |      120 | English  | 2009-01-09 | UK
    926 | Seven Samurai            |     1954 |      207 | Japanese | 1954-04-26 | JP
    927 | Spirited Away            |     2001 |      125 | Japanese | 2003-09-12 | UK
    928 | Back To The Future       |     1985 |      116 | English  | 1985-12-04 | UK
    925 | Braveheart               |     1995 |      178 | English  | 1995-09-08 | UK
(14 rows)


_____________________________________________________________________________________________________
create table movie_cast(
act_id int,
mov_id int,
role varchar(25),
foreign key(act_id) references actors(act_id),
foreign key(mov_id) references movie(mov_id));

insert into movie_cast("act_id","mov_id","role")
values(101,901,'John Scottie Ferguson'),(102,902,'MIss Giddest'),
(107,907,'Alice Harford'),(110,910,'Eddie Adams'),
(111,911,'Alvy Singer'),(113,913,'Andy Dufresne'),(114,914,'Lester Burnham'),
(115,915,'Rose DeWitt Bukater'),(120,920,'Elizabeth Darko'),(121,921,'Older Jamal'),
(114,921,'Bobby Darin');

task=# select * from movie_cast;
 act_id | mov_id |         role          
--------+--------+-----------------------
    101 |    901 | John Scottie Ferguson
    102 |    902 | MIss Giddest
    107 |    907 | Alice Harford
    110 |    910 | Eddie Adams
    111 |    911 | Alvy Singer
    113 |    913 | Andy Dufresne
    114 |    914 | Lester Burnham
    115 |    915 | Rose DeWitt Bukater
    120 |    920 | Elizabeth Darko
    121 |    921 | Older Jamal
    114 |    921 | Bobby Darin
(11 rows)

________________________________________________________________________________________________
create table rating(
mov_id int,
rev_id int,
rev_stars decimal,
num_o_ratings int,
foreign key(mov_id) references movie(mov_id));

insert into rating("mov_id","rev_id","rev_stars","num_o_ratings")
values(902,9001,8.40,263575),(902,9002,7.90,null),
(910,9009,3.00,195961),(911,9010,8.10,203875),(914,9013,7.00,862618),
(915,9001,7.70,830095),(925,9015,7.70,81328),(920,9017,8.10,609451),(921,9018,8.00,667758);

select * from rating;
 mov_id | rev_id | rev_stars | num_o_ratings 
--------+--------+-----------+---------------
    902 |   9001 |      8.40 |        263575
    902 |   9002 |      7.90 |              
    910 |   9009 |      3.00 |        195961
    911 |   9010 |      8.10 |        203875
    914 |   9013 |      7.00 |        862618
    915 |   9001 |      7.70 |        830095
    925 |   9015 |      7.70 |         81328
    920 |   9017 |      8.10 |        609451
    921 |   9018 |      8.00 |        667758
(9 rows)

________________________________________________________________________________________________
(1):Write a query in SQL to find the cast list for the movie Slumdog Millionaire.

select a.role as cast,b.mov_title as movie
from movie_cast a
inner join movie b
on a.mov_id=b.mov_id
where b.mov_title='Slumdog Millionaire';

    cast     |        movie        
-------------+---------------------
 Older Jamal | Slumdog Millionaire
 Bobby Darin | Slumdog Millionaire
(2 rows)

_________________________________________________________________________________________________
(2):Write a query in SQL to find the movie in which the actor appeared whose first and last name are 'Tim' and 'Robbins'.

select *
from movie
inner join movie_cast on movie.mov_id=movie_cast.mov_id
inner join actors on movie_cast.act_id=actors.act_id
where act_fname='Tim' and act_lname='Robbins';

 mov_id |        mov_title         | mov_year | mov_time | mov_lang | mov_dt_rel | mov_rel_country 
--------+--------------------------+----------+----------+----------+------------+-----------------
    913 | The Shawshank Redemption |     1994 |      142 | English  | 1995-02-17 | UK
(1 row)

