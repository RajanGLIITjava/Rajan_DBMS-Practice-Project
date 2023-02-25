/*A travel company TravelOnTheGo maintains the record of passengers and price to travel between two cities, for bus types (Sitting and Sleeper).*/

create database if not exists TravelOnTheGo;
use TravelOnTheGo;

create table if not exists Passenger(
Passenger_Id int primary key,
Passenger_Name varchar(30),
Category varchar(20),
Gender varchar(20),
Boarding_City varchar(20),
Destination_City varchar(20),
Distance int,
Bus_Type varchar(20)
);

create table if not exists Prices(
Bus_Type varchar(20),
Distance int,
Price int
);

INSERT INTO Passenger VALUES(1,"Sejal","AC","F","Bengaluru","Chennai",350,"Sleeper");
INSERT INTO Passenger VALUES(2,"Anmol","Non-AC","M","Mumbai","Hyderabad",700,"Sitting");
INSERT INTO Passenger VALUES(3,"Pallavi", "AC", "F", "Panaji", "Bengaluru",600, "Sleeper");
INSERT INTO Passenger VALUES(4,"Khusboo", "AC", "F","Chennai","Mumbai",1500,"Sleeper");
INSERT INTO Passenger VALUES(5,"Udit", "Non-AC", "M","Trivandrum","panaji",1000,"Sleeper");
INSERT INTO Passenger VALUES(6,"Ankur","AC","M","Nagpur","Hyderabad",500,"Sitting");
INSERT INTO Passenger VALUES(7,"Hemant","Non-AC", "M","panaji","Mumbai",700,"Sleeper");
INSERT INTO Passenger VALUES(8,"Manish","Non-AC", "M","Hyderabad","Bengaluru",500,"Sitting");
INSERT INTO Passenger VALUES(9,"Piyush","AC","M","Pune","Nagpur",700,"Sitting");

INSERT INTO Prices VALUES("Sleeper",350,770);
INSERT INTO Prices VALUES("Sleeper",500,1100);
INSERT INTO Prices VALUES("Sleeper",600,1320);
INSERT INTO Prices VALUES("Sleeper",700,1540);
INSERT INTO Prices VALUES("Sleeper",1000,2200);
INSERT INTO Prices VALUES("Sleeper",1200,2640);
INSERT INTO Prices VALUES("Sleeper",1500,2700);
INSERT INTO Prices VALUES("Sitting",500,620);
INSERT INTO Prices VALUES("Sitting",600,744);
INSERT INTO Prices VALUES("Sitting",700,868);
INSERT INTO Prices VALUES("Sitting",1000,1240);
INSERT INTO Prices VALUES("Sitting",1200,1488);
INSERT INTO Prices VALUES("Sitting",1500,1860);


/*3)	How many females and how many male passengers travelled for a minimum distance of 600 KM s? */
SELECT Gend1.Gender, count(1) from
(SELECT Passenger_Id,Gender,Distance from Passenger where Distance<600 order by Distance asc) 
as Gend1
group by Gend1.Gender;



/*4) Find the minimum ticket price for Sleeper Bus. */
SELECT min(price) as minimumPrice from Prices;



/*5)Select passenger names whose names start with character 'S' */
SELECT Passenger_Id,Passenger_Name,Gender from Passenger where Passenger_Name like 's%';



/*6)	Calculate price charged for each passenger displaying Passenger name, Boarding City, 
Destination City, Bus_Type, Price in the output */
SELECT Passenger.Passenger_Name, Passenger.Boarding_City,Passenger.Destination_city, Passenger.Bus_Type, prices.Price 
from Passenger, prices
where Passenger.Distance=prices.Distance and Passenger.Bus_Type=prices.Bus_Type;



/*7)	What are the passenger name/s and his/her ticket price who travelled in the Sitting bus  for a distance of 1000 KM s 
please note the result is coming null because non of the passenger has travelled 1000km  in the sitting bus, but sleeper u can
have the result by changing bus type ="sleeper*/
SELECT Passenger.Passenger_name, Passenger.Bus_type, prices.price 
from passenger, prices
WHERE Passenger.Distance=prices.Distance 
and Passenger.Bus_Type=prices.Bus_Type 
and Passenger.Distance=1000 and Passenger.Bus_type = 'sitting';



/*8)	What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji? 
		please note particular name"pallavi"has travelled only with sleeper class as per the record
        so if i print the Bus_type as result, query will show the fare as "sitting" based on distance ,
        henceforth i removed the colum  */
select Passenger.Passenger_Name, Passenger.Boarding_city, Passenger.Destination_City, prices.price 
from passenger, prices
where 
Passenger.Passenger_name= "Pallavi" 
and Passenger.Boarding_city="Panaji" and
Passenger.Destination_City="Bengaluru"  
and prices.Bus_type = 'sitting'
and passenger.Distance=prices.Distance;



/*9)	 List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order. */
Select distinct distance from Passenger order by Distance desc;



/*10)	Display the passenger name and percentage of distance travelled by that passenger from the total distance 
travelled by all passengers without using user variables */
select Passenger_Name,Distance, Distance * 100/ (SELECT SUM(Distance) FROM passenger)FROM passenger order by Distance;



/* 11)	Display the distance, price in three categories in table Price
a)	Expensive if the cost is more than 1000
b)	Average Cost if the cost is less than 1000 and greater than 500
c)	Cheap otherwise
 */
Select distance, price,
case  
	when price > 1000 then "Expensive"
    when price <= 1000 and price > 500 then "Average Cost"
    else "Cheap"
end as Remarks
from prices;
