-- Data cleaning

SELECT *
FROM layoffs;

-- 1. Remove duplicates
-- 2. Standardize data
-- 3. Null values/ blank values/ populate if possible
-- 4. Remove any column which are unecessary/irrevalant


-- (i) creating a table to prevent deletion from raw data.


CREATE TABLE layoffs_staging
LIKE layoffs;

 -- (ii) populate the new table
 
INSERT layoffs_staging
SELECT * 
FROM layoffs;

SELECT * 
FROM layoffs_staging;

-- (iii) creating CTEs
WITH DUP_CTE AS
(
SELECT *,
ROW_NUMBER() OVER(
				PARTITION BY company,location,industry,
                total_laid_off,percentage_laid_off,
				`date`,stage,country,funds_raised_millions
                
) AS row_num
FROM layoffs_staging)
SELECT *
FROM DUP_CTE
WHERE row_num>1; 


SELECT * 
FROM layoffs_staging
WHERE company='Ericsson'
;

WITH DUP_CTE AS
(
SELECT *,
ROW_NUMBER() OVER(
				PARTITION BY company,location,industry,
                total_laid_off,percentage_laid_off,
				`date`,stage,country,funds_raised_millions
                
) AS row_num
FROM layoffs_staging)
DELETE
FROM DUP_CTE
WHERE row_num>1; 


CREATE TABLE `layoffs_staging2` (
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
FROM layoffs_staging2
WHERE row_num >1;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
				PARTITION BY company,location,industry,
                total_laid_off,percentage_laid_off,
				`date`,stage,country,funds_raised_millions
                
) AS row_num
FROM layoffs_staging
;

SET SQL_SAFE_UPDATES=0;

DELETE
FROM layoffs_staging2
WHERE row_num >1;

SELECT *
FROM layoffs_staging2
;


-- 2. Standardize data

SELECT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company= TRIM(company);

SELECT *
FROM layoffs_staging2
WHERE industry LIKE '%Crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry like '%Crypto%';

SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1
; 

UPDATE layoffs_staging2
SET country = 'United States'
WHERE country like '%United States%';

SELECT DISTINCT country, TRIM(TRAILING'.' FROM country)
FROM layoffs_staging2
ORDER BY 1
; 

UPDATE layoffs_staging2
SET country = TRIM(TRAILING'.' FROM country)
WHERE country like '%United States%';

SELECT DISTINCT country
FROM layoffs_staging2;

SELECT `date`
FROM layoffs_staging2
; 

UPDATE layoffs_staging2
SET `date`= STR_TO_DATE(`date`,'%m/%d/%Y');

SET SQL_SAFE_UPDATES = 0;

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL;


SELECT  *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry='';

SELECT  *
FROM layoffs_staging2



