create table three(
salesman_id int primary key,
name varchar(25) not null,
city varchar(15),
commission decimal not null);


insert into three('salesman_id','name','city','commission')
values(5001,'James Hoog','New York',0.15),
(5002,'Nail Knite','Paris',0.13),
(5005,'Pit Alex','London',0.11),
(5006,'Mc Lyon','Paris',0.14),
(5003,'Lauson Hen','',0.12),
(5007,'Paul Adam','Rome',0.13);
insert into three("salesman_id","name","city","commission")
values(5001,'James Hoog','New York',0.15),
(5002,'Nail Knite','Paris',0.13),
(5005,'Pit Alex','London',0.11),
(5006,'Mc Lyon','Paris',0.14),
(5003,'Lauson Hen','',0.12),
(5007,'Paul Adam','Rome',0.13);


select * from three;
 salesman_id |    name    |   city   | commission 
-------------+------------+----------+------------
        5001 | James Hoog | New York |       0.15
        5002 | Nail Knite | Paris    |       0.13
        5005 | Pit Alex   | London   |       0.11
        5006 | Mc Lyon    | Paris    |       0.14
        5003 | Lauson Hen |          |       0.12
        5007 | Paul Adam  | Rome     |       0.13
(6 rows)

----------------------------------------------------------
create table two(
customer_id int primary key,
cust_name varchar(20) not null,
city varchar(15),
grade int not null,
salesman_id int not null,
foreign key (salesman_id) references three(salesman_id));


insert into two ("customer_id","cust_name","city","grade","salesman_id")
values (3002,'Nick Rimando','New york',100,5001),
(3005,'Graham Zusi','California',200,5002),
(3001,'Brad Guzan','London',100,5005);
insert into two ("customer_id","cust_name","city","grade","salesman_id")
values (3004,'Fabian Johns','Paris',300,5006),
(3007,'Brad Davis','New York',200,5001),
(3009,'Geoff Camero','Berlin',100,5003);
insert into two ("customer_id","cust_name","city","grade","salesman_id")
values (3008,'Julian Green','London',300,5002),
(3003,'Jozy Altidor','Moncow',200,5007);


select * from two;
 customer_id |  cust_name   |    city    | grade | salesman_id 
-------------+--------------+------------+-------+-------------
        3002 | Nick Rimando | New york   |   100 |        5001
        3005 | Graham Zusi  | California |   200 |        5002
        3001 | Brad Guzan   | London     |   100 |        5005
        3004 | Fabian Johns | Paris      |   300 |        5006
        3007 | Brad Davis   | New York   |   200 |        5001
        3009 | Geoff Camero | Berlin     |   100 |        5003
        3008 | Julian Green | London     |   300 |        5002
        3003 | Jozy Altidor | Moncow     |   200 |        5007
(8 rows)

----------------------------------------------------------
create table one(
ord_no int primary key,
purch_amt decimal not null,
ord_date date not null,
customer_id int not null,
salesman_id int not null,
foreign key (customer_id) references two(customer_id),
foreign key (salesman_id) references three(salesman_id));


insert into one ("ord_no","purch_amt","ord_date","customer_id","salesman_id")
values('70001',150.5,'2012-10-05',3005,5002);
values('70009',270.65,'2012-09-10',3001,5005),
(70002,65.26,'2012-10-05',3002,5001),
(70004,110.5,'2012-08-17',3009,5003);
values('70007',948.5,'2012-09-10',3005,5002),
(70005,2400.6,'2012-07-27',3007,5001),
(70008,5760,'2012-09-10',3002,5001);
insert into one ("ord_no","purch_amt","ord_date","customer_id","salesman_id")
values('70010',1983.43,'2012-10-10',3004,5006),
(70003,2408.4,'2012-10-10',3009,5003),
(70012,250.45,'2012-06-27',3008,5002);
insert into one ("ord_no","purch_amt","ord_date","customer_id","salesman_id")
values(70011,75.29,'2012-08-17',3003,5007),
(70013,3045.6,'2012-04-25',3002,5001);


select * from one;
 ord_no | purch_amt |  ord_date  | customer_id | salesman_id 
--------+-----------+------------+-------------+-------------
  70001 |     150.5 | 2012-10-05 |        3005 |        5002
  70009 |    270.65 | 2012-09-10 |        3001 |        5005
  70002 |     65.26 | 2012-10-05 |        3002 |        5001
  70004 |     110.5 | 2012-08-17 |        3009 |        5003
  70007 |     948.5 | 2012-09-10 |        3005 |        5002
  70005 |    2400.6 | 2012-07-27 |        3007 |        5001
  70008 |      5760 | 2012-09-10 |        3002 |        5001
  70010 |   1983.43 | 2012-10-10 |        3004 |        5006
  70003 |    2408.4 | 2012-10-10 |        3009 |        5003
  70012 |    250.45 | 2012-06-27 |        3008 |        5002
  70011 |     75.29 | 2012-08-17 |        3003 |        5007
  70013 |    3045.6 | 2012-04-25 |        3002 |        5001
(12 rows)

----------------------------------------------------------
(1): Write a query to find all orders with an amount smaller than any amount for a customer in London.

SELECT *
FROM one
WHERE purch_amt < ANY
(SELECT purch_amt
FROM one a, two b
WHERE  a.customer_id=b.customer_id
AND b.city='London');
 ord_no | purch_amt |  ord_date  | customer_id | salesman_id 
--------+-----------+------------+-------------+-------------
  70001 |     150.5 | 2012-10-05 |        3005 |        5002
  70002 |     65.26 | 2012-10-05 |        3002 |        5001
  70004 |     110.5 | 2012-08-17 |        3009 |        5003
  70012 |    250.45 | 2012-06-27 |        3008 |        5002
  70011 |     75.29 | 2012-08-17 |        3003 |        5007
(5 rows)

----------------------------------------------------------
(2):Write a query that extract the rows of all salesmen who have customers with more than one orders.

SELECT * 
FROM three a 
WHERE EXISTS     
(SELECT * FROM two b     
WHERE a.salesman_id=b.salesman_id     
AND 1<             
(SELECT COUNT (*)              
FROM one             
WHERE one.customer_id = b.customer_id));
 salesman_id |    name    |   city   | commission 
-------------+------------+----------+------------
        5001 | James Hoog | New York |       0.15
        5002 | Nail Knite | Paris    |       0.13
        5003 | Lauson Hen |          |       0.12
(3 rows)

----------------------------------------------------------
(3):Write a PSQL statement to make a list in ascending order for the customer who works either through a salesman or by own.

SELECT a.cust_name,a.city,a.grade, 
b.name AS "Salesman",b.city 
FROM two a 
LEFT JOIN three b 
ON a.salesman_id=b.salesman_id 
order by a.customer_id;
  cust_name   |    city    | grade |  Salesman  |   city   
--------------+------------+-------+------------+----------
 Brad Guzan   | London     |   100 | Pit Alex   | London
 Nick Rimando | New york   |   100 | James Hoog | New York
 Jozy Altidor | Moncow     |   200 | Paul Adam  | Rome
 Fabian Johns | Paris      |   300 | Mc Lyon    | Paris
 Graham Zusi  | California |   200 | Nail Knite | Paris
 Brad Davis   | New York   |   200 | James Hoog | New York
 Julian Green | London     |   300 | Nail Knite | Paris
 Geoff Camero | Berlin     |   100 | Lauson Hen | 
(8 rows)

----------------------------------------------------------
(4):Write a PSQL statement to make a cartesian product between salesman and customer i.e. each salesman will appear for all customer and vice versa for those salesmen who must belong to a city which is not the same as his customer and the customers should have their own grade.

SELECT * 
FROM three a 
CROSS JOIN two b 
WHERE a.city IS NOT NULL 
AND b.grade IS NOT NULL 
AND  a.city<>b.city;
 salesman_id |    name    |   city   | commission | customer_id |  cust_name   |    city    | grade | salesman_id 
-------------+------------+----------+------------+-------------+--------------+------------+-------+-------------
        5001 | James Hoog | New York |       0.15 |        3002 | Nick Rimando | New york   |   100 |        5001
        5002 | Nail Knite | Paris    |       0.13 |        3002 | Nick Rimando | New york   |   100 |        5001
        5005 | Pit Alex   | London   |       0.11 |        3002 | Nick Rimando | New york   |   100 |        5001
        5006 | Mc Lyon    | Paris    |       0.14 |        3002 | Nick Rimando | New york   |   100 |        5001
        5003 | Lauson Hen |          |       0.12 |        3002 | Nick Rimando | New york   |   100 |        5001
        5007 | Paul Adam  | Rome     |       0.13 |        3002 | Nick Rimando | New york   |   100 |        5001
        5001 | James Hoog | New York |       0.15 |        3005 | Graham Zusi  | California |   200 |        5002
        5002 | Nail Knite | Paris    |       0.13 |        3005 | Graham Zusi  | California |   200 |        5002
        5005 | Pit Alex   | London   |       0.11 |        3005 | Graham Zusi  | California |   200 |        5002
        5006 | Mc Lyon    | Paris    |       0.14 |        3005 | Graham Zusi  | California |   200 |        5002
        5003 | Lauson Hen |          |       0.12 |        3005 | Graham Zusi  | California |   200 |        5002
        5007 | Paul Adam  | Rome     |       0.13 |        3005 | Graham Zusi  | California |   200 |        5002
        5001 | James Hoog | New York |       0.15 |        3001 | Brad Guzan   | London     |   100 |        5005
        5002 | Nail Knite | Paris    |       0.13 |        3001 | Brad Guzan   | London     |   100 |        5005
        5006 | Mc Lyon    | Paris    |       0.14 |        3001 | Brad Guzan   | London     |   100 |        5005
        5003 | Lauson Hen |          |       0.12 |        3001 | Brad Guzan   | London     |   100 |        5005
        5007 | Paul Adam  | Rome     |       0.13 |        3001 | Brad Guzan   | London     |   100 |        5005
        5001 | James Hoog | New York |       0.15 |        3004 | Fabian Johns | Paris      |   300 |        5006
        5005 | Pit Alex   | London   |       0.11 |        3004 | Fabian Johns | Paris      |   300 |        5006
        5003 | Lauson Hen |          |       0.12 |        3004 | Fabian Johns | Paris      |   300 |        5006
        5007 | Paul Adam  | Rome     |       0.13 |        3004 | Fabian Johns | Paris      |   300 |        5006
        5002 | Nail Knite | Paris    |       0.13 |        3007 | Brad Davis   | New York   |   200 |        5001
        5005 | Pit Alex   | London   |       0.11 |        3007 | Brad Davis   | New York   |   200 |        5001
        5006 | Mc Lyon    | Paris    |       0.14 |        3007 | Brad Davis   | New York   |   200 |        5001
        5003 | Lauson Hen |          |       0.12 |        3007 | Brad Davis   | New York   |   200 |        5001
        5007 | Paul Adam  | Rome     |       0.13 |        3007 | Brad Davis   | New York   |   200 |        5001
        5001 | James Hoog | New York |       0.15 |        3009 | Geoff Camero | Berlin     |   100 |        5003
        5002 | Nail Knite | Paris    |       0.13 |        3009 | Geoff Camero | Berlin     |   100 |        5003
        5005 | Pit Alex   | London   |       0.11 |        3009 | Geoff Camero | Berlin     |   100 |        5003
        5006 | Mc Lyon    | Paris    |       0.14 |        3009 | Geoff Camero | Berlin     |   100 |        5003
        5003 | Lauson Hen |          |       0.12 |        3009 | Geoff Camero | Berlin     |   100 |        5003
        5007 | Paul Adam  | Rome     |       0.13 |        3009 | Geoff Camero | Berlin     |   100 |        5003
        5001 | James Hoog | New York |       0.15 |        3008 | Julian Green | London     |   300 |        5002
        5002 | Nail Knite | Paris    |       0.13 |        3008 | Julian Green | London     |   300 |        5002
        5006 | Mc Lyon    | Paris    |       0.14 |        3008 | Julian Green | London     |   300 |        5002
        5003 | Lauson Hen |          |       0.12 |        3008 | Julian Green | London     |   300 |        5002
        5007 | Paul Adam  | Rome     |       0.13 |        3008 | Julian Green | London     |   300 |        5002
        5001 | James Hoog | New York |       0.15 |        3003 | Jozy Altidor | Moncow     |   200 |        5007
        5002 | Nail Knite | Paris    |       0.13 |        3003 | Jozy Altidor | Moncow     |   200 |        5007
        5005 | Pit Alex   | London   |       0.11 |        3003 | Jozy Altidor | Moncow     |   200 |        5007
        5006 | Mc Lyon    | Paris    |       0.14 |        3003 | Jozy Altidor | Moncow     |   200 |        5007
        5003 | Lauson Hen |          |       0.12 |        3003 | Jozy Altidor | Moncow     |   200 |        5007
        5007 | Paul Adam  | Rome     |       0.13 |        3003 | Jozy Altidor | Moncow     |   200 |        5007
(43 rows)

----------------------------------------------------------
(5):Write a PSQL statement to make a report with customer name, city, order no. order date, purchase amount for only those customers on the list who must have a grade and placed one or more orders or which order(s) have been placed by the customer who is neither in the list not have a grade.


select a.cust_name,a.city,b.ord_no,b.ord_date,b.purch_amt
from two a full outer join one b
on a.customer_id=b.customer_id
where a.grade is not null;
  cust_name   |    city    | ord_no |  ord_date  | purch_amt 
--------------+------------+--------+------------+-----------
 Graham Zusi  | California |  70001 | 2012-10-05 |     150.5
 Brad Guzan   | London     |  70009 | 2012-09-10 |    270.65
 Nick Rimando | New york   |  70002 | 2012-10-05 |     65.26
 Geoff Camero | Berlin     |  70004 | 2012-08-17 |     110.5
 Graham Zusi  | California |  70007 | 2012-09-10 |     948.5
 Brad Davis   | New York   |  70005 | 2012-07-27 |    2400.6
 Nick Rimando | New york   |  70008 | 2012-09-10 |      5760
 Fabian Johns | Paris      |  70010 | 2012-10-10 |   1983.43
 Geoff Camero | Berlin     |  70003 | 2012-10-10 |    2408.4
 Julian Green | London     |  70012 | 2012-06-27 |    250.45
 Jozy Altidor | Moncow     |  70011 | 2012-08-17 |     75.29
 Nick Rimando | New york   |  70013 | 2012-04-25 |    3045.6
(12 rows)

