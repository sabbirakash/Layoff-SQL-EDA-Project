CREATE DATABASE world_layoffs;
USE world_layoffs;

SELECT *
FROM layoffs;
-- Required Steps :
-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null Values or Blank Values
-- 4. Remove Any Columns or Rows

CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT *
FROM layoffs_staging;

INSERT INTO layoffs_staging 
SELECT * FROM layoffs;

-- Finding Duplicates


WITH duplicate_cte AS
(SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,
 'date', stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging)
SELECT * FROM duplicate_cte
WHERE row_num > 1;



SELECT *
FROM layoffs_staging
WHERE company = 'Ola';



CREATE TABLE `layoffs_staging1` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


SELECT *
FROM layoffs_staging1;


INSERT INTO layoffs_staging1
WITH duplicate_cte AS
(SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,
 'date', stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging)
SELECT * FROM duplicate_cte
WHERE row_num > 1;


TRUNCATE layoffs_staging1;


INSERT INTO layoffs_staging1
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off,
 'date', stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;


SELECT *
FROM layoffs_staging1
WHERE row_num > 1;

SELECT *
FROM layoffs_staging1
WHERE company = 'Elemy';

SET SQL_SAFE_UPDATES= 0 ;

DELETE
FROM layoffs_staging1
WHERE row_num > 1;

SELECT *
FROM layoffs_staging1;

-- Standardizing data

UPDATE layoffs_staging1
SET company = TRIM(company);

SELECT DISTINCT industry
FROM layoffs_staging1
ORDER BY industry;

SELECT *
FROM layoffs_staging1
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging1
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT *
FROM layoffs_staging1
WHERE industry LIKE '';


SELECT DISTINCT location
FROM layoffs_staging1
ORDER BY 1;

UPDATE layoffs_staging1
SET industry = TRIM(industry);

SELECT DISTINCT country
FROM layoffs_staging1
ORDER BY 1;

UPDATE layoffs_staging1
SET country = TRIM(country);

UPDATE layoffs_staging1
SET country = 'United States'
WHERE country LIKE 'United States%';

SELECT *
FROM layoffs_staging1
WHERE country LIKE 'United States%'
ORDER BY 1;

SELECT `date`
FROM layoffs_staging1;

UPDATE layoffs_staging1
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging1
MODIFY `date` DATE;

SELECT `date`
FROM layoffs_staging1;

-- Handling Blanks and Nulls

SELECT *
FROM layoffs_staging1;


SELECT DISTINCT industry
FROM layoffs_staging1
ORDER BY 1;


SELECT *
FROM layoffs_staging1
WHERE
	industry IS NULL
	OR
    industry = '';

SELECT *
FROM layoffs_staging1
WHERE company = 'Airbnb';


SELECT *
FROM layoffs_staging1
WHERE company = 'Carvana';

UPDATE layoffs_staging1
SET industry = NULL
WHERE industry = '';

SELECT t1.industry, t2.industry
FROM layoffs_staging1 AS t1
JOIN layoffs_staging1 AS t2
	ON (t1.company = t2.company
    AND
    t1.location = t2.location)
WHERE
	((t1.industry IS NULL OR t1.industry = '')
    AND
    t2.industry IS NOT NULL);

SET SQL_SAFE_UPDATES = 0;

UPDATE layoffs_staging1 AS t1
JOIN layoffs_staging1 AS t2
	ON
    (t1.company = t2.company
    AND
    t1.location = t2.location)
SET t1.industry = t2.industry
WHERE
	((t1.industry IS NULL OR t1.industry = '')
    AND
    t2.industry IS NOT NULL);

SELECT *
FROM layoffs_staging1
WHERE
	total_laid_off IS NULL
	AND
    percentage_laid_off IS NULL;

-- Removing Unwanted Rows and Columns

DELETE
FROM layoffs_staging1
WHERE
	total_laid_off IS NULL
	AND
    percentage_laid_off IS NULL;

ALTER TABLE layoffs_staging1
DROP COLUMN row_num;


SELECT *
FROM layoffs_staging1;































