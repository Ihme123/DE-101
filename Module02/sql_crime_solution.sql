-- This is my solution to the interesting SQL murder quest: http://mystery.knightlab.com/
select *
FROM crime_scene_report
WHERE type = 'murder'
	AND city = 'SQL City'
    AND date = '20180115';
	
-- The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave" 
-- Info on the first witness : id 14887, Morty Schapiro, licence 118009
-- ssn 111564949

SELECT *
FROM person
WHERE address_street_name = 'Northwestern Dr'
	AND address_number = (
	  SELECT MAX(address_number)
	  FROM person
	  WHERE address_street_name = 'Northwestern Dr'
	  );
	  
-- First inteview: I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W".
SELECT *
FROM interview
WHERE person_id = 14887;
-- Info on the second witness : id 16371, Annabel Miller, licence 490173
-- ssn 318771143
SELECT *
FROM person
WHERE address_street_name = 'Franklin Ave'
	AND name LIKE 'Annabel%';
--working out last week on January the 9th
SELECT *
FROM interview
WHERE person_id = 16371	
SELECT *
FROM get_fit_now_member
WHERE person_id = 16371;
-- 3 suspects 49550 Tomas Baisley, 28819 Joe Germuska, 67318 Jeremy Bowers
SELECT *
FROM get_fit_now_member
WHERE id LIKE '48Z%'
-- Suspects 51739 Tushar Chandra, 67318 Jeremy Bowers, 78193 Maxine Whitely
SELECT p.name, p.id, dl.plate_number
FROM drivers_license dl JOIN person p ON dl.id = p.license_id
WHERE plate_number LIKE '%H42W%'
-- Jeremy Bowers gym id 48Z55
-- he was at the gym on 9.01 from 15:30 to 17:00
SELECT gf.id, gf.name, ci.check_in_date, ci.check_in_time, ci.check_out_time
FROM person p JOIN get_fit_now_member gf ON p.id = gf.person_id
JOIN get_fit_now_check_in ci ON ci.membership_id = gf.id
WHERE p.id = 67318
-- Annabel was there on 9.01 from 16 to 17
SELECT gf.id, gf.name, ci.check_in_date, ci.check_in_time, ci.check_out_time
FROM person p JOIN get_fit_now_member gf ON p.id = gf.person_id
JOIN get_fit_now_check_in ci ON ci.membership_id = gf.id
WHERE p.id = 16371
-- he checked in on The Funky Grooves Tour on 01.15, event_id 4719
-- Testimony:
-- I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). 
-- She has red hair and she drives a Tesla Model S. 
--I know that she attended the SQL Symphony Concert 3 times in December 2017.

-- 3 Customer suspects: 78881 Red Korb (65') ssn 961388910, 
-- 90700 Regina George ssn 337169072, 99716 Miranda Priestly ssn 987756388 
SELECT p.id, p. name, dl.height, p.ssn
FROM drivers_license dl JOIN person p ON dl.id = p.license_id
WHERE dl.car_make = 'Tesla'
	AND dl.car_model = 'Model S'
	AND dl.gender = 'female'
	AND dl.hair_color = 'red';
-- They all have a lot of money
-- 99716 Miranda Priestly went to SQL Symphony Concert 3 times in Dec 2017
SELECT *
FROM facebook_event_checkin
WHERE person_id in (78881, 90700, 99716)