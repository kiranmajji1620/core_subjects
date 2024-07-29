-- Q-1. Write an SQL query to fetch “FIRST_NAME” from Worker table using the alias name as <WORKER_NAME>.
SELECT FIRST_NAME AS WORKER_NAME FROM Worker;

-- Q-2. Write an SQL query to fetch “FIRST_NAME” from Worker table in upper case.
SELECT UPPER(FIRST_NAME) FROM Worker;

-- Q-3. Write an SQL query to fetch unique values of DEPARTMENT from Worker table.
SELECT DISTINCT DEPARTMENT FROM Worker; -- CAN BE DONE USING GROUP BY

-- Q-4. Write an SQL query to print the first three characters of  FIRST_NAME from Worker table.
SELECT SUBSTRING(FIRST_NAME, 1, 3) FROM Worker;

-- Q-5. Write an SQL query to find the position of the alphabet (‘b’) in the first name column ‘Amitabh’ from Worker table.
SELECT INSTR(FIRST_NAME, 'B') FROM Worker WHERE FIRST_NAME = 'Amitabh'; -- CASE INSENSITIVE

-- Q-6. Write an SQL query to print the FIRST_NAME from Worker table after removing white spaces from the right side.
SELECT RTRIM(FIRST_NAME) FROM Worker;

-- Q-7. Write an SQL query to print the DEPARTMENT from Worker table after removing white spaces from the left side.
SELECT LTRIM(FIRST_NAME) FROM Worker;

-- Q-8. Write an SQL query that fetches the unique values of DEPARTMENT from Worker table and prints its length.
SELECT DISTINCT DEPARTMENT, LENGTH(DEPARTMENT) FROM WORKER;

-- Q-9. Write an SQL query to print the FIRST_NAME from Worker table after replacing ‘a’ with ‘A’.
SELECT REPLACE(FIRST_NAME, 'a', 'A') FROM WORKER;

-- Q-10. Write an SQL query to print the FIRST_NAME and LAST_NAME from Worker table into a single column COMPLETE_NAME.
-- A space char should separate them.
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS COMPLETE_NAME FROM Worker;

-- Q-11. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending.
SELECT * FROM WORKER ORDER BY FIRST_NAME;

-- Q-12. Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending and DEPARTMENT desc
SELECT * FROM WORKER ORDER BY FIRST_NAME, DEPARTMENT DESC;

-- Q-13. Write an SQL query to print details for Workers with the first name as “Vipul” and “Satish” from Worker table.
SELECT * FROM WORKER WHERE FIRST_NAME IN ('Vipul', 'Satish');

-- Q-14. Write an SQL query to print details of workers excluding first names, “Vipul” and “Satish” from Worker table.
SELECT * FROM WORKER WHERE FIRST_NAME NOT IN ('Vipul', 'Satish');

-- Q-15. Write an SQL query to print details of Workers with DEPARTMENT name as “Adm*”.
SELECT * FROM WORKER WHERE DEPARTMENT LIKE 'Adm%';

-- Q-16. Write an SQL query to print details of the Workers whose FIRST_NAME contains ‘a’.
SELECT * FROM WORKER WHERE FIRST_NAME LIKE '%a%';

-- Q-17. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘a’.
SELECT * FROM WORKER WHERE FIRST_NAME LIKE '%a';

-- Q-18. Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets.
SELECT * FROM WORKER WHERE FIRST_NAME LIKE '%H' AND char_length(FIRST_NAME) = 6;
SELECT * FROM WORKER WHERE FIRST_NAME LIKE '_____H';

-- Q-19. Write an SQL query to print details of the Workers whose SALARY lies between 100000 and 500000.
SELECT * FROM WORKER WHERE SALARY BETWEEN 100000 AND 500000; -- INCLUSIVE

-- Q-20. Write an SQL query to print details of the Workers who have joined in Feb’2014.
SELECT * FROM WORKER WHERE YEAR(JOINING_DATE) = 2014 AND MONTH(JOINING_DATE) = 02;

-- Q-21. Write an SQL query to fetch the count of employees working in the department ‘Admin’.
SELECT DEPARTMENT, COUNT(*) FROM WORKER WHERE DEPARTMENT = 'ADMIN';

-- Q-22. Write an SQL query to fetch worker full names with salaries >= 50000 and <= 100000.
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME), SALARY AS FULL_NAME FROM WORKER WHERE SALARY BETWEEN 50000 AND 100000;

-- Q-23. Write an SQL query to fetch the no. of workers for each department in the descending order.
SELECT DEPARTMENT, COUNT(*) FROM WORKER AS NO_OF_WORKERS GROUP BY DEPARTMENT ORDER BY COUNT(*) DESC;

-- Q-24. Write an SQL query to print details of the Workers who are also Managers.
SELECT W.* FROM WORKER AS W INNER JOIN TITLE AS T ON W.WORKER_ID = T.WORKER_REF_ID WHERE T.WORKER_TITLE = 'Manager';

-- Q-25. Write an SQL query to fetch number (more than 1) of same titles in the ORG of different types.
SELECT WORKER_TITLE, COUNT(*) FROM TITLE GROUP BY WORKER_TITLE HAVING COUNT(*) > 1;

-- Q-26. Write an SQL query to show only odd rows from a table.
SELECT * FROM WORKER WHERE MOD(WORKER_ID, 2) = 1;

-- Q-27. Write an SQL query to show only even rows from a table. 
SELECT * FROM WORKER WHERE MOD(WORKER_ID, 2) = 0;
SELECT * FROM WORKER WHERE MOD(WORKER_ID, 2) <> 0;

-- Q-28. Write an SQL query to clone a new table from another table.
CREATE TABLE WORKER_CLONE LIKE WORKER;
INSERT INTO WORKER_CLONE SELECT * FROM WORKER;
SELECT * FROM WORKER_CLONE;
-- Q-29. Write an SQL query to fetch intersecting records of two tables.
SELECT WORKER.* FROM WORKER INNER JOIN WORKER_CLONE USING(WORKER_ID);

-- Q-30. Write an SQL query to show records from one table that another table does not have.
-- MINUS
SELECT * FROM WORKER LEFT JOIN WORKER_CLONE USING(WORKER_ID) WHERE WORKER_CLONE.WORKER_ID IS NULL;

-- Q-31. Write an SQL query to show the current date and time.
-- DUAL
SELECT CURDATE();
SELECT NOW();

-- Q-32. Write an SQL query to show the top n (say 5) records of a table order by descending salary.
SELECT * FROM WORKER ORDER BY SALARY DESC LIMIT 5;

-- Q-33. Write an SQL query to determine the nth (say n=5) highest salary from a table.
SELECT * FROM WORKER ORDER BY SALARY DESC LIMIT 4, 1;

-- Q-34. Write an SQL query to determine the 5th highest salary without using LIMIT keyword.
SELECT SALARY FROM WORKER W1
WHERE 4 = (
	SELECT COUNT(DISTINCT (W2.SALARY)) FROM WORKER W2 WHERE W2.SALARY >= W1.SALARY
);
 
-- Q-35. Write an SQL query to fetch the list of employees with the same salary.
SELECT * FROM WORKER W1 INNER JOIN WORKER W2 USING(SALARY) WHERE W1.WORKER_ID != W2.WORKER_ID;
SELECT * FROM WORKER W1, WORKER W2 WHERE W1.SALARY = W2.SALARY AND W1.WORKER_ID != W2.WORKER_ID;

-- Q-36. Write an SQL query to show the second highest salary from a table using sub-query.
SELECT MAX(SALARY) FROM WORKER
WHERE SALARY NOT IN (SELECT MAX(SALARY) FROM WORKER);

-- Q-37. Write an SQL query to show one row twice in results from a table.
SELECT * FROM WORKER
UNION ALL
SELECT * FROM WORKER ORDER BY WORKER_ID;

-- Q-38. Write an SQL query to list worker_id who does not get bonus.
SELECT WORKER_ID,BONUS_AMOUNT FROM WORKER W LEFT JOIN BONUS B ON W.WORKER_ID = B.WORKER_REF_ID WHERE BONUS_AMOUNT IS NULL;
SELECT WORKER_ID FROM WORKER WHERE WORKER_ID NOT IN (SELECT WORKER_REF_ID FROM BONUS);

-- Q-39. Write an SQL query to fetch the first 50% records from a table.
SELECT * FROM WORKER WHERE WORKER_ID <= (SELECT COUNT(WORKER_ID)/2 FROM WORKER);

-- Q-40. Write an SQL query to fetch the departments that have less than 4 people in it.
SELECT DEPARTMENT, COUNT(DEPARTMENT) AS Cnt FROM WORKER GROUP BY DEPARTMENT HAVING Cnt < 4;

-- Q-41. Write an SQL query to show all departments along with the number of people in there.
SELECT DEPARTMENT, COUNT(DEPARTMENT) AS CNT FROM WORKER GROUP BY DEPARTMENT;

-- Q-42. Write an SQL query to show the last record from a table.
SELECT * FROM WORKER ORDER BY WORKER_ID DESC LIMIT 1;
SELECT * FROM WORKER WHERE WORKER_ID = (SELECT MAX(WORKER_ID) FROM WORKER);

-- Q-43. Write an SQL query to fetch the first row of a table.
SELECT * FROM WORKER WHERE WORKER_ID = (SELECT MIN(WORKER_ID) FROM WORKER);

-- Q-44. Write an SQL query to fetch the last five records from a table.
SELECT * FROM WORKER ORDER BY WORKER_ID DESC LIMIT 5;

-- Q-45. Write an SQL query to print the name of employees having the highest salary in each department.
SELECT DEPARTMENT, MAX(SALARY) FROM WORKER GROUP BY DEPARTMENT;

SELECT W.FIRST_NAME, W.LAST_NAME
FROM WORKER W
JOIN (
    SELECT DEPARTMENT, MAX(SALARY) AS MAX_SALARY
    FROM WORKER
    GROUP BY DEPARTMENT
) W2 ON W.DEPARTMENT = W2.DEPARTMENT AND W.SALARY = W2.MAX_SALARY;

-- CORRELATED SUBQUERY IS MOST IMPORTANT
-- Q-46. Write an SQL query to fetch three max salaries from a table using co-related subquery
SELECT DISTINCT SALARY FROM WORKER W1
WHERE 3 >= (SELECT COUNT(DISTINCT SALARY) FROM WORKER W2 WHERE W1.SALARY <= W2.SALARY) ORDER BY W1.SALARY DESC;
-- 3 >= MEANS THAT THE SUBQUERY SHOULD RETURN 0, 1, 2 TO BE TRUE WHICH RETURNS TOP 3 SALARIES;
-- DRY RUN AFTER REVISING THE CORELATED SUBQUERY CONCEPT FROM LEC-9.

-- Q-47. Write an SQL query to fetch three min salaries from a table using co-related subquery
SELECT DISTINCT SALARY FROM WORKER W1
WHERE 3 >= (SELECT COUNT(DISTINCT SALARY) FROM WORKER W2 WHERE W1.SALARY >= W2.SALARY) ORDER BY W1.SALARY DESC;

-- Q-48. Write an SQL query to fetch nth max salaries from a table.
-- PUT N

-- Q-49. Write an SQL query to fetch departments along with the total salaries paid for each of them.
SELECT DEPARTMENT, SUM(SALARY) AS DEPT_SAL FROM WORKER GROUP BY DEPARTMENT ORDER BY DEPT_SAL DESC;

-- Q-50. Write an SQL query to fetch the names of workers who earn the highest salary.
SELECT FIRST_NAME, SALARY FROM WORKER WHERE SALARY = (SELECT MAX(SALARY) FROM WORKER);








