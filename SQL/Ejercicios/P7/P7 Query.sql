CREATE DATABASE `SQL1NORMALSTRINGS`;
USE `SQL1NORMALSTRINGS`;

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
  `begin_date` date DEFAULT NULL,
  `salary` int(11) DEFAULT NULL,
  `commission` int(11) DEFAULT NULL,
  `dept_num` int(11) DEFAULT NULL,
  `occu_code` varchar(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `EMPLOYEES` (`num`, `surname`, `name`, `manager`, `begin_date`, `salary`, `commission`, `dept_num`, `occu_code`) VALUES
(1000, 'PITT   ', 'BRAD', NULL, '2004-01-01', 1040, NULL, 20, NULL),
(7369, 'SÁNCHEZ', 'SERGIO', 8001, '2010-12-17', 1040, NULL, 20, 'EMP'),
(7499, 'ARROYO', 'MARTA', 7698, '2010-02-20', 1500, 390, 30, 'SAL'),
(7521, 'SALA', 'REBECA', 7782, '2011-02-22', 1625, 650, 30, 'SAL'),
(7566, 'JIMÉNEZ', 'JUAN', 1000, '2017-04-02', 2900, NULL, 20, 'MAN'),
(7654, 'MARTÍN', 'MONICA', 7698, '2017-09-29', 1600, 1020, 30, 'SAL'),
(7698, 'GOMIS', 'BARTOLOME', 1000, '2017-05-01', 3005, NULL, 30, 'MAN'),
(7782, 'CEREZO', 'MARIA', 1000, '2010-06-09', 2885, NULL, 10, 'MAN'),
(7788, 'GILBERTO', 'JESUS', 8000, '2010-11-09', 3000, NULL, 20, NULL),
(7844, 'TOVAR', 'LUIS', 7698, '2018-09-08', 1350, 0, 30, 'SAL'),
(7876, 'ALONSO   ', 'FERNANDO', 7788, '2018-09-23', 1430, NULL, 20, 'EMP'),
(7900, 'JIMENO', 'XAVIER', 8001, '2017-12-03', 1335, NULL, 30, 'EMP'),
(7902, 'FERNÁNDEZ   ', 'ANA', 8000, '2016-12-03', 3000, NULL, 20, NULL),
(7934, 'MUÑOZ', 'ANTONIA', 8001, '2016-01-23', 1690, NULL, 10, 'EMP'),
(8000, 'BANDERAS', 'ANTONIO', 1000, '2017-01-09', 2885, NULL, 20, 'MAN'),
(8001, 'RUIZ', 'FERNANDA', 1000, '2018-06-10', 2885, NULL, 20, 'MAN');

CREATE TABLE `OCCUPATIONS` (
  `code` varchar(3) NOT NULL,
  `name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `OCCUPATIONS` (`code`, `name`) VALUES
('ANA', 'ANALYST'),
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



use SQL1NORMALSTRINGS;
#1
SELECT concat_ws(' ',name,surname) as FullName FROM EMPLOYEES;

#2
SELECT format(commission,2,'es_ES') as ComissionF FROM EMPLOYEES;

#3
SELECT surname, locate('a',surname) as position FROM EMPLOYEES;

#4
select surname, if ( instr(substring(surname, instr(surname,'a')+1),'a')=0, 0,
    instr(surname,'a')+instr(substring(surname, instr(surname,'a')+1),'a')
) as SecondA from EMPLOYEES;

#5
SELECT concat_ws(' ',concat(left(name,1),lower(substring(name,2,length(name)))),concat(left(surname,1),lower(substring(surname,2,length(surname))))) as FullName
FROM EMPLOYEES;

#6
SELECT replace(concat_ws(' ',name,surname), 'IO','IOTE') as IOTE_Name FROM EMPLOYEES;

#7
UPDATE EMPLOYEES
SET name = replace(name, 'ANTONIA','TONIA'), name = replace(name, 'ANTONIO','TONIO');

#8
SELECT concat_ws('_',substring(surname,1,2),substring(surname,3,length(surname))) as Surname FROM EMPLOYEES;

#9
SELECT left(surname,1) as FirstChar, ascii(left(surname,1)) as SurnameAscii FROM EMPLOYEES;

#10
SELECT concat_ws(' ',trim(name),trim(surname)) as FullName FROM EMPLOYEES;