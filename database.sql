--High Distinction, Autumn Semester, 2020
-- Student Name: Tiange Lei
-- Student Email Address: 13794856@student.uts.edu.au
-- Student No: 13794856
-- Description of my database:This database is designed for air companies to manage booking records, tickets and flights information in one system. Employee can not only put the booking records into a table, but also retrieve the ticket information of a customer. In addition, through this database, employee can analyze the target customer of a specific flight which is quite important for marketing.

drop table aircompany_flight CASCADE;
drop table aircompany_planeModel CASCADE;
drop table aircompany_ticketSegment CASCADE;
drop table aircompany_ticket CASCADE;
drop table aircompany_passenger CASCADE;
drop table aircompany_cabin CASCADE;
drop table aircompany_bookingRecord CASCADE;

create table aircompany_planemodel 
	(	model text,
		seats int,
		maxRange int,
		constraint aircompany_planemodelPK Primary Key (model)
	);

create table aircompany_flight
	(	flightNo text,
		departCity varchar(3),
		arriveCity varchar(3),
		departTime text,
		arriveTime text,
		model text,
		constraint aircompany_flightPK Primary Key (flightNo),
		constraint aircompany_flightFK Foreign Key (model) references aircompany_planemodel on delete restrict
	);

create table aircompany_passenger
	(	firstName text,
		lastName text,
		passportNo text,
		gender text,
		age int,
		nationality text,
		phoneNo text,
		emergencyContactphoneNo text,
		constraint aircompany_passengerPK Primary Key (passportNo),
		constraint di_aircompany_passenger_gender check( gender in ('Male','Female')), 
		constraint di_aircompany_passenger_age check( (age is not null) and (age > 0) and (age <= 70) )--The age of passengers can not be over 70.
		);

create table aircompany_cabin
	(	cabin varchar(1),
		cabinClass text,
		bagageAllowance int,
		constraint aircompany_cabinPK Primary Key (cabin),
		constraint di_aircompany_cabin_cabinClass check( cabinClass in ('business','economic')), 
		constraint di_aircompany_cabin_bagageAllowance check( bagageAllowance in (1,2))
		);

create table aircompany_bookingRecord
	( bookingNo text,
	  bookingDate text,
	  constraint aircompany_bookingRecordPK Primary Key (bookingNo)
	  );

create table aircompany_ticket
	(	ticketNo int,
		passportNo text,
		price int,
		cabin varchar(1),
		bookingNo text,
		constraint aircompany_ticketPK Primary Key (ticketNo,passportNo),
		constraint aircompany_ticketFK_passenger Foreign Key (passportNo) references aircompany_passenger,
		constraint aircompany_ticketFK_cabin Foreign Key (cabin) references aircompany_cabin,
		constraint aircompany_ticketFK_bookingRecord Foreign Key (bookingNo) references aircompany_bookingRecord
		);

create table aircompany_ticketSegment
	( ticketNo int,
	  passportNo text,
	  flightNo text,
	  constraint aircompany_ticketSegmentPK Primary Key (ticketNo,passportNo,flightNo),
	  constraint aircompany_ticketSegmentFK_ticket Foreign Key (ticketNo,passportNo) references aircompany_ticket on delete cascade, --when ticket is deleted, ticketsegment is deleted as well
	  constraint aircompany_ticketSegmentFK_flight Foreign Key (flightNo) references aircompany_flight on delete restrict
	  );

insert into aircompany_planemodel values ('A333',283,10400);
insert into aircompany_planemodel values ('A332',222,10400);
insert into aircompany_planemodel values ('B738',164,5665);
insert into aircompany_planemodel values ('B789',283,15200);
insert into aircompany_planemodel values ('B788',213,15200);

insert into aircompany_flight values('HU481','PEK','BOS','13:55','15:10','B789');
insert into aircompany_flight values('HU482','BOS','PEK','17:10','19:00+1','B789');
insert into aircompany_flight values('HU7989','PEK','SJC','16:00','12:30','B788');
insert into aircompany_flight values('HU7990','PEK','BOS','14:30','17:40+1','B788');
insert into aircompany_flight values('HU7969','PEK','LAS','1:45','23:00+1','B789');
insert into aircompany_flight values('HU7970','LAS','PEK','1:00','5:05+1','B789');
insert into aircompany_flight values('HU495','PEK','SEA','15:50','11:35','A333');
insert into aircompany_flight values('HU496','SEA','PEK','14:00','16:35+1','A333');
insert into aircompany_flight values('HU497','PEK','ORD','13:40','13:20','B789');
insert into aircompany_flight values('HU498','ORD','PEK','15:20','18:05','B789');
insert into aircompany_flight values('HU7919','PEK','HND','20:40','1:00+1','B738');
insert into aircompany_flight values('HU7920','HND','PEK','2:00','4:45','B738');

insert into aircompany_passenger values('James','Harden','123456789','Male',30,'US','0433123456','0433123456');
insert into aircompany_passenger values('Lebron','James','223456789','Male',36,'AU','0433123457','0433123457');
insert into aircompany_passenger values('Allen','Iverson','323456789','Male',42,'US','0433123458','0433123458');
insert into aircompany_passenger values('Jason','Terry','423456789','Male',15,'US','0433123459','0433123458');
insert into aircompany_passenger values('Steve','Mabury','523456789','Male',25,'AU','0433123460','0433123460');
insert into aircompany_passenger values('Mary','Miller','623456789','Female',27,'US','0433123461','0433123461');
insert into aircompany_passenger values('Janson','kidd','723456789','Male',5,'AU','0433123462','0433123461');
insert into aircompany_passenger values('Lopez','Gasol','823456789','Male',18,'CN','0433123463','0433123463');
insert into aircompany_passenger values('Dwyane','Wade','923456789','Male',26,'US','0433123464','0433123464');
insert into aircompany_passenger values('Lucy','Miller','333456789','Female',69,'AU','0433123465','0433123465');
insert into aircompany_passenger values('Selina','Laurence','433456789','Female',17,'AU','0433123466','0433123465');
insert into aircompany_passenger values('Taylor','Swift','543456789','Female',64,'AU','0433123478','0433123478');
insert into aircompany_passenger values('Joyce','Encore','643456789','Female',22,'CN','0433123480','0433123480');

insert into aircompany_cabin values('C','business','2');
insert into aircompany_cabin values('D','business','2');
insert into aircompany_cabin values('Z','business','2');
insert into aircompany_cabin values('I','business','2');
insert into aircompany_cabin values('R','business','2');
insert into aircompany_cabin values('J','business','2');
insert into aircompany_cabin values('Y','economic','1');
insert into aircompany_cabin values('B','economic','1');
insert into aircompany_cabin values('H','economic','1');
insert into aircompany_cabin values('K','economic','1');
insert into aircompany_cabin values('L','economic','1');
insert into aircompany_cabin values('M','economic','1');
insert into aircompany_cabin values('X','economic','1');
insert into aircompany_cabin values('V','economic','1');
insert into aircompany_cabin values('N','economic','1');

insert into aircompany_bookingRecord values('M7SCL','July 11');
insert into aircompany_bookingRecord values('8MSDQ','July 12');
insert into aircompany_bookingRecord values('MUD09','July 13');
insert into aircompany_bookingRecord values('7DDK0','July 14');
insert into aircompany_bookingRecord values('POO4S','July 15');
insert into aircompany_bookingRecord values('NNDP1','July 15');
insert into aircompany_bookingRecord values('UIN55','July 15');
insert into aircompany_bookingRecord values('98YIS','July 16');
insert into aircompany_bookingRecord values('P9Q2Q','July 17');
insert into aircompany_bookingRecord values('TYY12','July 17');
insert into aircompany_bookingRecord values('SH614','July 18');
insert into aircompany_bookingRecord values('00BV0','July 18');

insert into aircompany_ticket values('88012345','123456789','20000','C','M7SCL');
insert into aircompany_ticket values('88012345','223456789','20000','C','M7SCL');
insert into aircompany_ticket values('88022345','323456789','10000','Y','8MSDQ');
insert into aircompany_ticket values('88032346','423456789','6200','K','MUD09');	
insert into aircompany_ticket values('88012359','523456789','5000','X','7DDK0');
insert into aircompany_ticket values('88012361','523456789','4500','V','POO4S');
insert into aircompany_ticket values('88012370','623456789','8500','H','NNDP1');
insert into aircompany_ticket values('88012388','723456789','2500','N','UIN55');
insert into aircompany_ticket values('88012388','823456789','9500','B','UIN55');
insert into aircompany_ticket values('88012400','923456789','10500','R','98YIS');
insert into aircompany_ticket values('88012511','333456789','14500','I','TYY12');
insert into aircompany_ticket values('88012577','433456789','17500','D','P9Q2Q');
insert into aircompany_ticket values('88012666','543456789','8600','H','SH614');
insert into aircompany_ticket values('88012909','643456789','5900','L','00BV0');

insert into aircompany_ticketSegment values('88012345','123456789','HU7920');
insert into aircompany_ticketSegment values('88012345','123456789','HU7919');
insert into aircompany_ticketSegment values('88012345','223456789','HU7920');
insert into aircompany_ticketSegment values('88012345','223456789','HU7920');
insert into aircompany_ticketSegment values('88032346','423456789','HU481');
insert into aircompany_ticketSegment values('88032346','423456789','HU482');
insert into aircompany_ticketSegment values('88012359','523456789','HU7990');
insert into aircompany_ticketSegment values('88012361','523456789','HU7919');
insert into aircompany_ticketSegment values('88012370','623456789','HU7989');
insert into aircompany_ticketSegment values('88012388','723456789','HU497');
insert into aircompany_ticketSegment values('88012388','823456789','HU497');
insert into aircompany_ticketSegment values('88012388','723456789','HU498');
insert into aircompany_ticketSegment values('88012388','823456789','HU498');
insert into aircompany_ticketSegment values('88012400','923456789','HU495');
insert into aircompany_ticketSegment values('88012400','923456789','HU496');
insert into aircompany_ticketSegment values('88012511','333456789','HU7969');
insert into aircompany_ticketSegment values('88012511','333456789','HU7970');
insert into aircompany_ticketSegment values('88012577','433456789','HU7989');
insert into aircompany_ticketSegment values('88012666','543456789','HU7990');
insert into aircompany_ticketSegment values('88012909','643456789','HU481');










