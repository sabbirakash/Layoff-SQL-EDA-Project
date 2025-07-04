-- EDA

-- Here we are just going to explore the data and find trends or patterns or anything interesting like outliers

-- normally when you start the EDA process you have some idea of what you're looking for

-- with this info we are just going to look around and see what we find!

USE world_layoffs;

SELECT *
FROM layoffs_staging1;

-- EASIER QUERIES

SELECT MAX(total_laid_off)
FROM layoffs_staging1;

SELECT MAX(percentage_laid_off)
FROM layoffs_staging1;

-- Looking at Percentage to see how big these layoffs were

SELECT MAX(percentage_laid_off), MIN(percentage_laid_off)
FROM layoffs_staging1
WHERE percentage_laid_off IS NOT NULL;

-- Which companies had 1 which is basically 100 percent of they company laid off
SELECT *
FROM layoffs_staging1
WHERE percentage_laid_off = 1;

-- these are mostly startups it looks like who all went out of business during this time

-- if we order by funcs_raised_millions we can see how big some of these companies were
SELECT *
FROM layoffs_staging1
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- BritishVolt looks like an EV company, Quibi! - wow raised like 2 billion dollars and went under - ouch

-- Companies with the biggest single Layoff
SELECT company, total_laid_off
FROM layoffs_staging1
ORDER BY 2 DESC
LIMIT 5;
-- now that's just on a single day

-- Companies with the most Total Layoffs
SELECT company, SUM(total_laid_off) laid_off
FROM layoffs_staging1
GROUP BY company
ORDER BY 2 DESC
LIMIT 10;

-- by location
SELECT location, SUM(total_laid_off) laid_off
FROM layoffs_staging1
GROUP BY location
ORDER BY 2 DESC
LIMIT 10;

-- this it total in the past 3 years or in the dataset
SELECT country, SUM(total_laid_off) laid_off
FROM layoffs_staging1
GROUP BY country
ORDER BY 2 DESC
LIMIT 10;

SELECT YEAR(date) AS `year`, SUM(total_laid_off) laid_off
FROM layoffs_staging1
GROUP BY `year`
ORDER BY 2 DESC;

SELECT industry, SUM(total_laid_off) laid_off
FROM layoffs_staging1
GROUP BY industry
ORDER BY 2 DESC
LIMIT 10;

SELECT stage, SUM(total_laid_off) laid_off
FROM layoffs_staging1
GROUP BY stage
ORDER BY 2 DESC
LIMIT 10;


-- Rolling Sum of Lay offs via months.
SELECT SUBSTRING(`date`, 1, 7) AS `Months`, SUM(total_laid_off) AS laid_off
FROM layoffs_staging1
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `Months`
ORDER BY `Months`;


-- now use it in a CTE so we can query off of it
WITH rolling_cte AS
(
SELECT SUBSTRING(`date`, 1, 7) AS `Months`, SUM(total_laid_off) AS laid_off
FROM layoffs_staging1
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `Months`
ORDER BY `Months`
)
SELECT `Months`, laid_off, 
SUM(laid_off) OVER(ORDER BY `Months`) AS rolling_total_off
FROM rolling_cte;


-- TOUGHER QUERIES------------------------------------------------------------------------------------------------------------------------------------

-- Earlier we looked at Companies with the most Layoffs. Now let's look at that per year. It's a little more difficult.
-- I want to look at 


SELECT company, `date`, SUM(total_laid_off)
FROM layoffs_staging1
GROUP BY company, `date`
ORDER BY 3 DESC
;


WITH Company_year (company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off) 
FROM layoffs_staging1
GROUP BY company, YEAR(`date`)
),
Company_year_rank AS
(
SELECT *,
DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_year
WHERE years IS NOT NULL
ORDER BY Ranking
)
SELECT *
FROM Company_year_rank
WHERE Ranking <= 5
ORDER BY years ASC, total_laid_off DESC;



