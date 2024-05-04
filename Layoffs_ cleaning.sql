-- CLEANING DATA
-- STEP 1. Remove Duplicates

-- 1. Find out duplicate using row_num window function

WITH duplicate_cte as (
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,`date`, stage, country,
funds_raised_millions) as row_num
FROM layoffs_staging
)

Select *
from duplicate_cte
where row_num > 1;

-- 2. Created Stage 2 table 
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
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,`date`, stage, country,
funds_raised_millions) as row_num
FROM layoffs_staging;

-- Delete update is available
-- Duplicate data removed
delete
from layoffs_staging2
where row_num >1;


-- STEP 2. Standardizing data

-- TRIMING the White spaces

SELECT company, (TRIM(company))
from layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);


-- Correcting labels under industry column
SELECT distinct(industry)
from layoffs_staging2;

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry like 'Crypto%';


SELECT  country 
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country like 'United States%';

-- standardizing date 

SELECT `date`,
STR_TO_DATE( `date` , '%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE( `date` , '%m/%d/%Y');

SELECT `date`
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE; 

SELECT *
FROM layoffs_staging2;

-- STEP 3 Removing NULLS

UPDATE layoffs_staging2
SET industry = null
WHERE industry = ' ';


SELECT * 
FROM layoffs_staging2
WHERE industry is NULL;

SELECT l1.industry,l2.industry
FROM layoffs_staging2 l1
JOIN layoffs_staging2 l2
ON l1.company = l2.company
WHERE l1.industry is NULL and l2.industry is not null;


UPDATE layoffs_staging2 l1
JOIN  layoffs_staging2 l2
   ON l1.company = l2.company
SET l1.industry = l2.industry
WHERE l1.industry is NULL and l2.industry is not null;


SELECT *
FROM layoffs_staging2 
WHERE total_laid_off is NULL AND percentage_laid_off is NULL;

DELETE 
FROM layoffs_staging2 
WHERE total_laid_off is NULL AND percentage_laid_off is NULL;

SELECT *
FROM layoffs_staging2;

-- STEP 4 Removing Any columns and rows
-- row_num is removed

ALter TABLE layoffs_staging2 
DROP COLUMN row_num;



















