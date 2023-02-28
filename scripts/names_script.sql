-- ## SQL Names

SELECT *
FROM names
LIMIT 10

-- 1. How many rows are in the names table?

SELECT COUNT(*)
FROM names;

--Answer: 1957046

-- 2. How many total registered people appear in the dataset?

SELECT SUM(num_registered)
FROM names

--Answer: 351653025

-- 3. Which name had the most appearances in a single year in the dataset?

SELECT name, year, MAX(num_registered)
FROM names
GROUP BY name, year
ORDER BY MAX(num_registered) DESC
LIMIT 1;

--Answer: "Linda"	1947	99689


-- 4. What range of years are included?

SELECT MAX(year), MIN(year)
FROM names

--Answer: 1880-2018

-- 5. What year has the largest number of registrations?

SELECT DISTINCT year, SUM(num_registered) AS total_reg
FROM names
GROUP BY year
ORDER BY total_reg DESC
LIMIT 10;

--Answer: 1957 with	4200022 registered

-- 6. How many different (distinct) names are contained in the dataset?

SELECT COUNT(DISTINCT name)
FROM names

--Answer: 98400

-- 7. Are there more males or more females registered?

SELECT gender, SUM(num_registered) AS total_registered
FROM names
GROUP BY gender;

--Answer: There are more male (177573793) than female (174079232)

-- 8. What are the most popular male and female names overall (i.e., the most total registrations)?

SELECT name, gender, SUM(num_registered) as total_reg
FROM names
GROUP BY name, gender
ORDER BY total_reg DESC
LIMIT 10;

--Answer: Most popular boy name is James (5164280), most popular girl name is Mary (4125675)

-- 9. What are the most popular boy and girl names of the first decade of the 2000s (2000 - 2009)?

SELECT name, SUM(num_registered) AS total_reg
FROM names
WHERE year BETWEEN 2000 AND 2009
AND gender = 'M'
GROUP BY name
ORDER BY total_reg DESC
LIMIT 1;

SELECT name, SUM(num_registered) AS total_reg
FROM names
WHERE year BETWEEN 2000 AND 2009
AND gender = 'F'
GROUP BY name
ORDER BY total_reg DESC
LIMIT 1;

--Answer: "Jacob"	273844
--And "Emily"	223690

-- 10. Which year had the most variety in names (i.e. had the most distinct names)?

SELECT year, COUNT(DISTINCT name) AS distinct_names
FROM names
GROUP BY year
ORDER BY distinct_names DESC
LIMIT 1;

--Answer: 2008 had 32518 distinct names

-- 11. What is the most popular name for a girl that starts with the letter X?

SELECT name, SUM(num_registered) AS total_reg
FROM names
WHERE name LIKE 'X%'
AND gender = 'F'
GROUP BY name
ORDER BY total_reg DESC
LIMIT 1;

--Answer: Ximena

-- 12. How many distinct names appear that start with a 'Q', but whose second letter is not 'u'?

SELECT COUNT(DISTINCT name)
FROM names
WHERE name LIKE 'Q%' AND name NOT LIKE '%u%'

--Answer: 45


-- 13. Which is the more popular spelling between "Stephen" and "Steven"? Use a single query to answer this question.

SELECT name, SUM(num_registered) AS total_reg
FROM names
WHERE name = 'Stephen'
OR name = 'Steven'
GROUP BY name

--Answer: Steven with 1286951 versus Stephen with 860972

-- 14. What percentage of names are "unisex" - that is what percentage of names have been used both for boys and for girls?

SELECT name
FROM names
GROUP BY name
HAVING COUNT(DISTINCT gender) = 2;

--Answer: 10773 names are unisex, which is 10.95% of the total

-- 15. How many names have made an appearance in every single year since 1880?

SELECT name
FROM names
GROUP BY name
HAVING COUNT(DISTINCT year) = 139;

--Answer: 921

-- 16. How many names have only appeared in one year?

SELECT name
FROM names
GROUP BY name
HAVING COUNT(DISTINCT year) = 1;

--Answer: 21123

-- 17. How many names only appeared in the 1950s?

SELECT name
FROM names
GROUP BY name
HAVING MIN(year) >= 1950
	AND MAX(year) <= 1959;
	
--Answer: 661

-- 18. How many names made their first appearance in the 2010s?

SELECT name
FROM names
GROUP BY name
HAVING MIN(year) >= 2010;

--Answer: 11270

-- 19. Find the names that have not be used in the longest.

SELECT name, MAX(year) AS last_appearance
FROM names
GROUP BY name
ORDER BY last_appearance
LIMIT 5;

/*Answer; "Roll"
"Zilpah"
"Crete"
"Sip"
"Lelie"*/

--BONUS QUESTIONS
-- 	1. Find the longest name contained in this dataset. What do you notice about the long names?

SELECT name, LENGTH(name) AS name_length
FROM names
GROUP BY name
ORDER BY name_length DESC
LIMIT 15;

/*There are several with 15 characters, this may be the maximum allowed?  Here are 5:
"Christopherjame"
"Muhammadibrahim"
"Christopherjose"
"Christiandaniel"
"Hannahelizabeth"*/

-- 	2. How many names are palindromes (i.e. read the same backwards and forwards, such as Bob and Elle)?


-- 	3. Find all names that contain no vowels (for this question, we'll count a,e,i,o,u, and y as vowels). (Hint: you might find this page helpful: https://www.postgresql.org/docs/8.3/functions-matching.html)

SELECT DISTINCT name
FROM names
WHERE name NOT LIKE '%a%'
AND name NOT LIKE 'A%'
AND name NOT LIKE '%a'
AND name NOT LIKE '%e%'
AND name NOT LIKE 'E%'
AND name NOT LIKE '%e'
AND name NOT LIKE '%i%'
AND name NOT LIKE 'I%'
AND name NOT LIKE '%i'
AND name NOT LIKE '%o%'
AND name NOT LIKE 'O%'
AND name NOT LIKE '%o'
AND name NOT LIKE '%u%'
AND name NOT LIKE 'U%'
AND name NOT LIKE '%u'
AND name NOT LIKE '%y%'
AND name NOT LIKE 'Y%'
AND name NOT LIKE '%y'
GROUP BY name;

--Answer: 43 names


-- 	4. How many double-letter names show up in the dataset? Double-letter means the same letter repeated back-to-back, like Matthew or Aaron. Are there any triple-letter names?

-- For the next few questions, you'll likely need to make use of subqueries. A subquery is a SQL query nested inside another query. You'll learn more about subqueries over the next few DataCamp assignments.

-- 	5. On question 17 of the first part of the exercise, you found names that only appeared in the 1950s. Now, find all names that did not appear in the 1950s but were used both before and after the 1950s. We'll answer this question in two steps.
-- 		a. First, write a query that returns all names that appeared during the 1950s.
-- 		b. Now, make use of this query along with the IN keyword in order the find all names that did not appear in the 1950s but which were used both before and after the 1950s. See the example "A subquery with the IN operator." on this page: https://www.dofactory.com/sql/subquery.
	
-- 	6. In question 16, you found how many names appeared in only one year. Which year had the highest number of names that only appeared once?

-- 	7. Which year had the most new names (names that hadn't appeared in any years before that year)? For this question, you might find it useful to write a subquery and then select from this subquery. See this page about using subqueries in the from clause: https://www.geeksforgeeks.org/sql-sub-queries-clause/

-- 	8. Is there more variety (more distinct names) for females or for males? Is this true for all years or are their any years where this is reversed? Hint: you may need to make use of multiple subqueries and JOIN them in order to answer this question.

-- 	9. Which names are closest to being evenly split between male and female usage? For this question, consider only names that have been used at least 10000 times in total. 

-- For the last questions, you might find window functions useful (see https://www.postgresql.org/docs/9.1/sql-expressions.html#SYNTAX-WINDOW-FUNCTIONS and https://www.postgresql.org/docs/9.1/functions-window.html for a list of window function available in PostgreSQL). A window function is like an aggregate function in that it can be applied across a group, but a window function does not collapse each group down to a single summary statistic. The groupings for a window function are specified using the PARTITION BY keyword (and can include an ORDER BY when it is needed). The PARTITION BY and ORDER BY associated with a window function are CONTAINED in an OVER clause.
-- For example, to rank each row by the value of num_registered, we can use the query
-- ```
-- SELECT name, year, num_registered, RANK() OVER(ORDER BY num_registered DESC)
-- FROM names;
-- ```

-- If I want to rank within gender, I can add a PARTITION BY:  
-- ```
-- SELECT name, year, num_registered, RANK() OVER(PARTITION BY gender ORDER BY num_registered DESC)
-- FROM names;
-- ```

-- 	10. Which names have been among the top 25 most popular names for their gender in every single year contained in the names table? Hint: you may have to combine a window function and a subquery to answer this question.

-- 	11. Find the name that had the biggest gap between years that it was used. 

-- 	12. Have there been any names that were not used in the first year of the dataset (1880) but which made it to be the most-used name for its gender in some year? Difficult follow-up: What is the shortest amount of time that a name has gone from not being used at all to being the number one used name for its gender in a year?
