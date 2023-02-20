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

SELECT 'Male', COUNT(gender) 
FROM names
WHERE gender = 'M'
UNION
SELECT 'Female', COUNT(gender)
FROM names
WHERE gender = 'F'

--Answer: There are more female (1156527) than males (800519)

-- 8. What are the most popular male and female names overall (i.e., the most total registrations)?

SELECT name, gender, SUM(num_registered) as total_reg
FROM names
GROUP BY name, gender
ORDER BY total_reg DESC
LIMIT 10;

--Answer: Most popular boy name is James (5164280), most popular girl name is Mary (4125675)

-- 9. What are the most popular boy and girl names of the first decade of the 2000s (2000 - 2009)?

SELECT name, year, gender, SUM(num_registered) AS total_reg
FROM names
WHERE year BETWEEN 2000 AND 2009
AND gender = 'M'
GROUP BY name, year, gender
ORDER BY total_reg DESC
LIMIT 1;

SELECT name, year, gender, SUM(num_registered) AS total_reg
FROM names
WHERE year BETWEEN 2000 AND 2009
AND gender = 'F'
GROUP BY name, year, gender
ORDER BY total_reg DESC
LIMIT 1;

--Answer: "Jacob"	2000	"M"	34477
--And "Emily"	2000	"F"	25956

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
WHERE name LIKE 'Q%' AND name NOT LIKE 'Qu%'

--Answer: 46

-- 13. Which is the more popular spelling between "Stephen" and "Steven"? Use a single query to answer this question.

SELECT name, SUM(num_registered) AS total_reg
FROM names
WHERE name = 'Stephen'
OR name = 'Steven'
GROUP BY name

--Answer: Steven with 1286951 versus Stephen with 860972

-- 14. What percentage of names are "unisex" - that is what percentage of names have been used both for boys and for girls?

-- 15. How many names have made an appearance in every single year since 1880?

-- 16. How many names have only appeared in one year?

-- 17. How many names only appeared in the 1950s?

-- 18. How many names made their first appearance in the 2010s?

-- 19. Find the names that have not be used in the longest.

-- 20. Come up with a question that you would like to answer using this dataset. Then write a query to answer this question.
