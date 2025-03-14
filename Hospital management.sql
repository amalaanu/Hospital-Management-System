#creation the databases

create database Hospital;
use Hospital;

#DOCTOR TABLE CREATION 
    
create table Doctor(doc_id int primary key auto_increment,
name varchar(20) not null,speciality varchar(30),email varchar(15));

insert into Doctor(name,speciality,email) values('jeev','cardiology','jee@17'),
('Dr. John Smith', 'Cardiologist', 'smith@4'),
    ('Dr. Emily Davis', 'Neurologist', 'davis@73'),
    ('Dr. Michael Brown', 'Pedia', 'BROWN@37'),
    ('Dr. Sarah Lee', 'Orthopedic', 'lee@72'),
    ('Dr. Robert Taylor', 'Dermatologist', 'taylor@3'),
('babu','phisiology','babu@29'),('kavi','scyclogist','kavi@64'),
('hem','astrology','hem@78'),('ghee','sociologist','ghee@88');

#PATIENT TABLE CREATOIN

create table Patient(patient_id int primary key auto_increment,
firstname varchar(10) not null,lastname varchar(20) not null,age int,
email varchar(10),Dateofbirth date);

insert into Patient(firstname,lastname,age,email,Dateofbirth) values('Emily', 'Davis', 30, 'davis@37', '1994-07-05'),
    ('Chris', 'Brown', 27, 'brown@73', '1997-12-22'),
    ('Sarah', 'Wilson', 29, 'wilson@28', '1995-10-08'),
    ('Robert', 'Taylor', 35, 'Taylor@38', '1989-06-17'),
    ('Sophia', 'Moore', 26, 'moore@I3', '1998-01-19'),
    ('Daniel', 'Anderson', 31, 'ason@37', '1993-04-24'),
    ('dr.john','son',23,'john@33','1998-09-07'),
('jack','line',24,'jack@383','1999-10-04'),('angel','line',28,'angel@74','2005-08-30'),
('mack','sigh',25,'mack@78','2000-04-06'),('rose','line',27,'rose@373','2003-04-20');

#APPOINTMENT TABLE CREATION
    
create table Appointment(appointment_id int primary key auto_increment,
reason varchar(15),Appointment_date datetime not null,
doc_id int,foreign key (doc_id) references Doctor(doc_id),patient_id int,
foreign key (patient_id) references Patient(patient_id));

#ALTER FUNCTIONS USING MTHD
    
alter table Appointment drop column reason;
drop table if exists Appointment;    

insert into Appointment(reason,Appointment_date,doc_id,patient_id) values('Check-up', '2024-12-22', 1,2),
    ('Flu Symptoms', '2024-12-23', 2,3),
    ('Back Pain', '2024-12-25', 3,4),
    ('Skin Rash', '2024-12-26', 4, 5),
    ('Headache', '2024-12-27',5, 6),
    ('Blood Test', '2024-12-28', 6,7),('fever','2004-10-05',6,2),('head pain','2005-08-11',9,9);

#NURSE TABLE CREATION
    
create table nurse(nurse_id int primary key auto_increment
,name varchar(10),location varchar(16),salary int);
 
insert into nurse(name,location,salary) values('Bob Smith','goa', 3800),
    ('Charlie', 'Chicago', 4200),
    ('Diana', 'america', 3900),
    ('Evan', 'chennai', 4100),
    ('FionA', 'salem', 3600),('jee','goa',2000),('babu','chennai',4000),('jee','salem',5000);


select*from nurse;

drop table nurse;

#MEDICALRECORDS TABLE CREATION
    
create table MedicalRecords(medical_id int primary key auto_increment,
diagnosis varchar(10),treatment varchar(15),
doc_id int,foreign key (doc_id) references Doctor(doc_id),patient_id int,
foreign key (patient_id) references Patient(patient_id));

insert into MedicalRecords(diagnosis,treatment,doc_id,patient_id) values('Diabetes','InsulinTherapy',1,2),
    ('HighBLOD', 'Medication',3,4),
    ('Fracture','Application', 5,6),
    ('Allergy', 'Antihistamines',4,5),
    ('Arthritis', 'Pain Management',2,3);
    
drop table Patient;    
drop table Appointment;
drop table MedicalRecrods;

select * from Doctor a inner join Appointment b on a.doc_id=b.doc_id;
#TO RETREIVE ALL THE TABLES 
    
select*FROM Patient;
select* from Doctor;
select *from Appointment;
select *from MedicalRecords;

drop table Doctor;

/* QUERIES */

----JOIN FUNCTION USING WITH FOREIGN KEY-----

select a.name,a.speciality,b.Appointment_date from Doctor a inner join Appointment b on a.doc_id=b.doc_id
where a.name='babu';

select patient_id,Dateofbirth from Patient
where patient_id in(select patient_id from Patient where Dateofbirth='1998-09-07');

select a.diagnosis,a.treatment,b.patient_id from  MedicalRecords a inner join Patient b on a.patient_id=b.patient_id
where b.patient_id>=3;

select a.name,a.speciality,b.treatment from Doctor a right join MedicalRecords b on a.doc_id=b.doc_id
where a.name in('jee','ghee'',kavi');

#STORE PROCEDURE

delimiter $$
create procedure get_Patient(in input_patient_id int)
begin
    select count(patient_id) as TotalPatients from Patient where patient_id = input_patient_id;
end $$
delimiter ;    

# CALL HE FUNCTION 
    
call get_Patient(3);

show databases;	

#SELF JOIN FUNCTION DOCTOR 
alter table Doctor add referal_id int;

update Doctor set referal_id=2
where doc_id=4;

select a.doc_id,a.name,b.name as referal_by from Doctor a inner join Doctor b on a.referal_id=b.doc_id;

select a.medical_id,a.diagnosis,b.name from MedicalRecords a cross join Doctor b;

#JOIN FUNCION WITH CONDITIONS 
    
select a.appointment_id,a.reason,count(b.doc_id)
 from Appointment a right join Doctor b on a.doc_id=b.doc_id group by a.appointment_id;

select a.patient_id,a.Dateofbirth,b.reason,m.treatment from Patient a inner join Appointment b
 on a.patient_id=b.patient_id inner join MedicalRecords m on b.doc_id=m.doc_id;

select a.name,a.salary,b.location from nurse a inner join nurse b on a.nurse_id=b.nurse_id
where b.location not in('salem'); 

# SUBQUERIES METHOD
    
select a.name,a.salary,b.location from nurse a inner join nurse b on a.nurse_id=b.nurse_id
where a.salary>(select max(b.salary) from nurse b where b.nurse_id=2);

select nurse_id,location  from nurse order by location desc;
select nurse_id,salary  from nurse order by salary limit 1 offset 2;

select nurse_id,count(location) as location from nurse group by nurse_id;

select* from nurse where name like '%e%'; 
 # ALTER FUNCTION  
     
alter table nurse drop column name;
alter table nurse add name varchar(10);
alter table nurse modify salary decimal(10,2);

select avg(doc_id) from Doctor;

alter table nurse auto_increment=100;

select max(patient_id) from Patient where firstname='john' or age =28;

select *from nurse  where location ='chennai' and name='babu';
select* from nurse where salary between '2000' and '5000';

#CREATE VIEW METHOD
create view nurse_desc as
select* from nurse order by nurse_id desc;

select*from nurse_desc;

#STRING FUNCTION 
select char_length(diagnosis) from MedicalRecords;
select ucase(reason) from Appointment;

select concat('RS. ',salary) from nurse;
select lcase(treatment) from MedicalRecords;

#NUMBER OF COUNT SALARY INTO INNER JOIN METHOD
    
select a.name,count(a.salary) as count_sal,b.location from nurse a inner join nurse b on a.nurse_id=b.nurse_id group by
 a.name ,b.location having count(a.salary)>1;

#SINGLE SUBQUERIES
select*from Doctor where name=(select max(name) from Doctor where email='babu@29');

#MULIPLE SUBQUERIES
select*from nurse where salary>(select min(salary) from nurse where location='goa' and salary<=5000);

#AGGREGATE FUNCTOIN USING GROUP BY
select name,count(location) as count_loc from nurse group by name having count(location)>1;

select name,count(salary) from nurse group by name having count(salary)>1;

#SCALAR SUBQUERIES
    
select appointment_id,reason,Appointment_date,(select max(Appointment_date) 
from Appointment where doc_id=1) AS APP_DATE from Appointment;

#CASE METHOD USING 
select patient_id,age,case when age>23 then 'legend' 
 else 'older' end as age_grp from Patient;

#ODD FUNCION 
select * from nurse where nurse_id mod(nurse_id%2)=0;

select* from nurse where location='salem' and salary>=3000 order by salary desc;

# COMBINING GROUP BY AND ORDER BY FUNCTIONS QUERIES
    
select a.name,b.salary,count(b.location) as count_loc from nurse a join nurse b on a.nurse_id=b.nurse_id
 group by a.name,b.salary,b.location order by  b.salary desc;

select location,count(salary) from nurse group by location;

select * from Doctor where name=(select max(name) from Doctor where name not in('hem'));

select left(diagnosis,3) from MedicalRecords;

select right(reason,4) from Appointment;

# INDEX FUNCTION 
    
create index indx_salary on nurse(salary);

alter table nurse drop  index indx_salary;
truncate nurse;
show index from nurse;

# NULL FUNCTION
    
select * from Patient where Dateofbirth=(select Dateofbirth from Patient where Dateofbirth='1997-12-22' or null);

select doc_id,case when  speciality is null then 'general' else 'adult' end as speciality from Doctor;