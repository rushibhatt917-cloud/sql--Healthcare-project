use project_medical_data_history;
-- 1. Show first name, last name, and gender of patients who's gender is 'M;
select * from patients;
select first_name , last_name,gender from patients where gender='M';
-- 2. Show first name and last name of patients who does not have allergies;
select first_name, last_name, allergies from patients where allergies IS NULL;
-- 3. Show first name of patients that start with the letter 'C'
select first_name from patients where first_name like 'C%';
-- 4. Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
select first_name, last_name, weight from patients where weight between 100 and 120;
-- 5. Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
-- select * from patients where allergies is null;
UPDATE patients SET allergies = 0 WHERE allergies IS NULL;
SELECT first_name,last_name,IFNULL(allergies, 'NKA') AS allergies FROM patients;
SELECT * FROM patients;
-- 6. Show first name and last name concatenated into one column to show their full name.
select concat(first_name, ' ', last_name) as Full_name from patients;
-- 7. Show first name, last name, and the full province name of each patient.
select * from province_names;
select pa.first_name, pa.last_name, pr.province_name from patients as pa left join province_names as pr on pa.province_id=pr.province_id ;
-- 8. Show how many patients have a birth_date with 2010 as the birth year.
select first_name, last_name, birth_date from patients where birth_date like '2010%';
-- 9. Show the first_name, last_name, and height of the patient with the greatest height.
select first_name, last_name, height from patients where height =(select max(height) from patients);
-- 10. Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000
select * from patients where patient_id in ('1','45','534','879','1000');
-- 11. Show the total number of admissions
select*from admissions;
select count(patient_id) from admissions;
-- 12. Show all the columns from admissions where the patient was admitted and discharged on the same day.
select * from admissions where admission_date = discharge_date;
-- 13. Show the total number of admissions for patient_id 579.
select * from admissions where patient_id = '579';
-- 14. Based on the cities that our patients live in, show unique cities that are in province_id 'NS'
select * from province_names;
select * from province_names where province_id = 'NS';
-- 15. Write a query to find the first_name, last name and birth date of patients who have height more than 160 and weight more than 70
select first_name , last_name , birth_date from patients where height > 160 and weight > 70;
select * from patients;
-- 16. Show unique birth years from patients and order them by ascending.
SELECT DISTINCT YEAR(birth_date) AS birth_year FROM patients ORDER BY birth_year ASC;
-- 17. Show unique first names from the patients table which only occurs once in the list.
select distinct(first_name) from patients;
select first_name from patients group by first_name having count(*) = 1; 
-- 18. Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long. 
select patient_id, first_name from patients where first_name like 'S%s' and length(first_name) >= 6;
-- 19. Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.   Primary diagnosis is stored in the admissions table.
select * from admissions;
select p.patient_id, p.first_name, p.last_name, a.diagnosis from patients as p left join admissions as a on p.patient_id = a.patient_id where diagnosis = 'Dementia';
-- 20. Display every patient's first_name. Order the list by the length of each name and then by alphbetically.
select first_name from patients order by first_name asc;
-- 21. Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row.
select count(if(gender = 'M',1,Null)) as total_Male , count(if(gender='F',1,Null)) as total_Female from patients;
-- 22. Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row.
select count(if(gender = 'M',1,Null)) as total_Male , count(if(gender='F',1,Null)) as total_Female from patients;
-- 23. Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
select patient_id , diagnosis from admissions;
SELECT patient_id, diagnosis, COUNT(*) AS admission_count FROM admissions GROUP BY patient_id, diagnosis HAVING COUNT(*) > 1;
-- 24. Show the city and the total number of patients in the city. Order from most to least patients and then by city name ascending.
select * from province_names;
select * from patients;
select city, count(*) as total_patients from patients group by city order by total_patients desc;
-- 25. Show first name, last name and role of every person that is either patient or doctor.    The roles are either "Patient" or "Doctor"
select * from doctors;
select * from patients;
select first_name, last_name, 'patients' as Role from patients union select first_name, last_name, 'doctors' as Role from doctors;
-- 26. Show all allergies ordered by popularity. Remove NULL values from query.
select allergies, count(*) as popularity from patients where allergies is not null group by allergies order by popularity desc;
-- 27. Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.
select first_name , last_name, birth_date from patients where year(birth_date) = '1970' order by birth_date;
-- 28. We want to display each patient's full name in a single column. 
-- Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order    EX: SMITH,jane
select concat(upper(last_name) , ',' , lower(first_name))  as Full_name from patients order by first_name desc;
-- 29. Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.
select * from province_names;
select * from patients;
select province_id, sum(height) as total_height from patients group by province_id having total_height >= 7000;
-- 30. Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
select max(weight) - min(weight) as differnce from patients where last_name= 'Maroni';
-- 31. Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.
select * from admissions;
select day(admission_date) as day_of_month, count(*) as total_admissions from admissions group by day(admission_date) order by total_admissions desc;
-- 32. Show all of the patients grouped into weight groups. Show the total amount of patients in each weight group. Order the list by the weight group decending. 
-- e.g. if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.
select (weight/10)*10 as weight_group , count(*) as total_patients from patients group by (weight/10)*10 order by weight_group desc;
-- 33. Show patient_id, weight, height, isObese from the patients table. Display isObese as a boolean 0 or 1. 
-- Obese is defined as weight(kg)/(height(m). Weight is in units kg. Height is in units cm.
SELECT patient_id, weight, height, CASE WHEN weight / POWER(height / 100.0, 2) >= 30 THEN 1 ELSE 0 END AS isObese FROM patients;
-- 34. Show patient_id, first_name, last_name, and attending doctor's specialty. Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'
-- Check patients, admissions, and doctors tables for required information.
select * from admissions;
select p.first_name, p.last_name, p.patient_id, d.specialty from patients as p join admissions as a on p.patient_id = a.patient_id join doctors as d on a.attending_doctor_id = d.doctor_id where a.diagnosis = 'Epilepsy' and p.first_name = 'Lisa';
SELECT p.patient_id, p.first_name, p.last_name, d.specialty FROM patients p JOIN admissions a ON p.patient_id = a.patient_id JOIN doctors d ON a.attending_doctor_id = d.doctor_id WHERE a.diagnosis = 'Epilepsy' AND d.first_name = 'Lisa';