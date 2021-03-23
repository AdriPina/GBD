DROP DATABASE IF EXISTS `SQL1NORMALDATES`;
CREATE DATABASE `SQL1NORMALDATES`;
USE `SQL1NORMALDATES`;

CREATE TABLE `DEPARTMENTS` (
  `num` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `town_code` varchar(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `DEPARTMENTS` (`num`, `name`, `town_code`) VALUES
(10, 'ACCOUNTING', 'SVQ'),
(20, 'RESEARCH', 'MAD'),
(30, 'SALES', 'BCN'),
(40, 'PRODUCTION', 'BIO');

CREATE TABLE `EMPLOYEES` (
  `num` int(11) NOT NULL,
  `surname` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `manager` int(11) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `salary` int(11) DEFAULT NULL,
  `commission` int(11) DEFAULT NULL,
  `dept_num` int(11) DEFAULT NULL,
  `occu_code` varchar(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `EMPLOYEES` (`num`, `surname`, `name`, `manager`, `start_date`, `salary`, `commission`, `dept_num`, `occu_code`) VALUES
(1000, 'PITT', 'BRAD', NULL, '2004-01-01', 1040, NULL, 20, NULL),
(7369, 'SÁNCHEZ', 'SERGIO', 8001, '2010-12-17', 1040, NULL, 20, 'EMP'),
(7499, 'ARROYO', 'MARTA', 7698, '2010-02-20', 1500, 390, 30, 'SAL'),
(7521, 'GONZÁLEZ', 'RAUL', 7782, '2011-02-22', 1625, 650, 30, 'SAL'),
(7566, 'JIMÉNEZ', 'JUAN JOSÉ', 1000, '2017-04-02', 2900, NULL, 20, 'MAN'),
(7654, 'MARTÍN', 'MONICA', 7698, '2017-09-29', 1600, 1020, 30, 'SAL'),
(7698, 'GUASP', 'BARTOLOME', 1000, '2017-05-01', 3005, NULL, 30, 'MAN'),
(7782, 'CEREZO', 'JOSÉ', 1000, '2010-06-09', 2885, NULL, 10, 'MAN'),
(7788, 'GIL', 'JAVIER', 8000, '2010-11-09', 3000, NULL, 20, NULL),
(7844, 'TOVAR', 'LUIS', 7698, '2018-09-08', 1350, 0, 30, 'SAL'),
(7876, 'ALONSO', 'FERNANDO', 7788, '2018-09-23', 1430, NULL, 20, 'EMP'),
(7900, 'JIMENO', 'XAVIER', 8001, '2017-12-03', 1335, NULL, 30, 'EMP'),
(7902, 'FERNÁNDEZ', 'ANA', 8000, '2016-12-03', 3000, NULL, 20, NULL),
(7934, 'MUÑOZ', 'ANTONIA', 8001, '2016-01-23', 1690, NULL, 10, 'EMP'),
(8000, 'BANDERAS', 'ANTONIO', 1000, '2017-01-09', 2885, NULL, 20, 'MAN'),
(8001, 'RUIZ', 'FERNANDA', 1000, '2018-06-10', 2885, NULL, 20, 'MAN');

CREATE TABLE `OCCUPATIONS` (
  `code` varchar(3) NOT NULL,
  `name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `OCCUPATIONS` (`code`, `name`) VALUES
('ANA', 'ANALIST'),
('EMP', 'EMPLOYEE'),
('MAN', 'MANAGER'),
('PRE', 'PRESIDENT'),
('SAL', 'SALESMAN');

CREATE TABLE `TOWNS` (
  `code` varchar(3) NOT NULL,
  `name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `TOWNS` (`code`, `name`) VALUES
('BCN', 'BARCELONA'),
('BIO', 'BILBAO'),
('MAD', 'MADRID'),
('SVQ', 'SEVILLA');

ALTER TABLE `DEPARTMENTS`
  ADD PRIMARY KEY (`num`),
  ADD KEY `town_code` (`town_code`);

ALTER TABLE `EMPLOYEES`
  ADD PRIMARY KEY (`num`),
  ADD KEY `dept_num` (`dept_num`),
  ADD KEY `manager` (`manager`),
  ADD KEY `occu_code` (`occu_code`);

ALTER TABLE `OCCUPATIONS`
  ADD PRIMARY KEY (`code`);

ALTER TABLE `TOWNS`
  ADD PRIMARY KEY (`code`);

ALTER TABLE `DEPARTMENTS`
  ADD CONSTRAINT `DEPARTMENTS_ibfk_1` FOREIGN KEY (`town_code`) REFERENCES `TOWNS` (`code`);

ALTER TABLE `EMPLOYEES`
  ADD CONSTRAINT `EMPLOYEES_ibfk_1` FOREIGN KEY (`dept_num`) REFERENCES `DEPARTMENTS` (`num`),
  ADD CONSTRAINT `EMPLOYEES_ibfk_2` FOREIGN KEY (`manager`) REFERENCES `EMPLOYEES` (`num`),
  ADD CONSTRAINT `EMPLOYEES_ibfk_3` FOREIGN KEY (`occu_code`) REFERENCES `OCCUPATIONS` (`code`);


#1
select day(last_day(curdate())) as last_day;

#2
select day(last_day(curdate() - interval 3 month)) as last_day;

#3
select date_format(last_day(curdate() - interval 3 month),'%M %d,%y') as last_day;

#4
select date(680001) as date;

#5
select convert_tz(now(),'+1:00','-5:00') as panama;

#6
select convert_tz(now(),'+1:00','+11:00') as sydney;

#7
select date_sub(now(), interval 205 minute );

#8
select dayofyear(now()) as TodayNumber;

#9
select str_to_date('Sunday, March 21, 2021', '%W, %M %e, %Y') as Date;

#10
select period_add(2011,3) as Startof2ndEvaluation;

#11
select datediff(max(start_date),min(start_date)) as MyDay from EMPLOYEES;

#12
select surname, name, start_date from EMPLOYEES
where 'Tuesday'=date_format(start_date,'%W');

#13
select * from EMPLOYEES
where start_date in (select min(start_date) from EMPLOYEES);

#14
select name,surname, datediff(curdate(), start_date)/365 as Years from EMPLOYEES
order by Years desc;

select name,surname, date_format(from_days(datediff(curdate(), start_date)), '%y years  %m months %d days') as Years from EMPLOYEES
order by Years desc ;

#15
select year(start_date) as Year, month(start_date) as Month, day(start_date) as Day from EMPLOYEES;

#16
select surname, name, start_date from EMPLOYEES
where 'June'=date_format(start_date,'%M');

#17
select surname, name, date_format(start_date, '%W %D %M %Y %H:%i:%S') as start_date from EMPLOYEES
where 'June'=date_format(start_date,'%M');

#18
select year(start_date) as Year, count(year(start_date)) as Num from EMPLOYEES
group by Year;

#19
select max(a.Num) as max_num from (
select year(start_date) as Year, count(year(start_date)) as Num from EMPLOYEES
group by Year) as a;

#20
select a.Year from (
select year(start_date) as Year, count(year(start_date)) as Num from EMPLOYEES
group by Year order by Num desc limit 1) as a;

#21
select num, name, surname, datediff(curdate(), start_date)/365 as Years
from EMPLOYEES where num in (select manager from EMPLOYEES);

#22
select num, name, surname from (
select num, name, surname, datediff(curdate(), start_date)/365 as Years
from EMPLOYEES where num in (select manager from EMPLOYEES)) as W where W.Years>5;

#23
select * from EMPLOYEES where start_date between '1999-01-01' and '2013-01-01' ;

