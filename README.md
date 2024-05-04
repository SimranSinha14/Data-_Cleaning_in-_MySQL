# SQL-Project
## Problem Statemet: 
The project aims to clean layoff data, ensuring accuracy and reliability. By removing duplicates, standardizing formats, handling null values, and trimming unnecessary columns, the refined dataset will facilitate insightful analysis of layoff trends, supporting informed decision-making for workforce management strategies and organizational resilience.

### Steps followed 
- STEP 1 : Remove Duplicate
   - What I Did: Created a special list (like a temporary table) called "duplicate_cte" from our layoff data.
   - Why I Did It: I wanted to find out if there were any companies with the same information listed more than once.
   - How I Did It: Used a a "window function" - 'ROW_NUMBER' to give each row a number, like a serial number. Rows with the same company details got the same number.
   - My Logic: If any company had more than one row with the same number, it means there's a duplicate. So, I made a list of those duplicates using the "duplicate_cte".
   - Final Check: I checked my list of duplicates to make sure I was right, making sure the rows with the same number were indeed duplicates.
```
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
```
   
- STEP 2 : Standardize the data
  - Task 1: Removing Extra Spaces
    - What I Did: Noticed some extra spaces hanging around company names.
    - Action Taken: Used a  SQL command -TRIM() to trim those spaces and make everything look clean.
```
SELECT company, (TRIM(company))
from layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);
```
   - Task 2: Correcting Industry Labels
       - The Issue: Some companies were tagged as "Crypto" but not all of them excatly wore the label.
       - The Fix: Updated those companies to make sure they all  belong to the "Crypto" industry
```
SELECT distinct(industry)
from layoffs_staging2;

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry like 'Crypto%';
```
  - Task 3 : Part 3: Standardizing Country Names
       - The Discovery: Country names should look sharp, but some had unnecessary dots at the end, like a stray pen mark on a clean sheet.
       - The Remedy: We polished these country names by trimming any trailing dots, ensuring they're sleek and consistent.
```
SELECT  country 
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country like 'United States%';
```
  - Task 4 : Standardizing Dates
       - Objective: Convert date data from string format to the "month/day/year" format using the STR_TO_DATE function.
       - Procedure: Employed the STR_TO_DATE function to convert date strings into the desired format, ensuring uniformity across the dataset.
       - Subsequent Action: Altered the data type of the date column from text to Date to reflect the updated format accurately.
```
SELECT `date`,
STR_TO_DATE( `date` , '%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE( `date` , '%m/%d/%Y');

SELECT `date`
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE; 
```
- Step 3 : Removing Null value
   - Objective: Before addressing null values, I ensured that any blank cells in the dataset were updated to null values.
   - Explanation: This step aimed to standardize the representation of missing data, ensuring consistency throughout the dataset.
```
UPDATE layoffs_staging2
SET industry = null
WHERE industry = ' ';


SELECT * 
FROM layoffs_staging2
WHERE industry is NULL;
```
   - Some rows lacked an industry designation, while other rows with the same company had it filled in.
   - Approach: Leveraged a JOIN operation to pair up rows with the same company, where one had a null industry value and the other did not. Then, updated the null industry values with the corresponding industry.
```
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
```
   - Deleting all null values present in total_laid_off and percentage_laid_off
```
SELECT *
FROM layoffs_staging2 
WHERE total_laid_off is NULL AND percentage_laid_off is NULL;

DELETE 
FROM layoffs_staging2 
WHERE total_laid_off is NULL AND percentage_laid_off is NULL;

SELECT *
FROM layoffs_staging2;
```
   - Removing unwanted columns and rows
   - We don't need row_num any more
```
ALter TABLE layoffs_staging2 
DROP COLUMN row_num;
```
   - Cleaned , structured dataset is available
```
SELECT *
FROM layoffs_staging2;
```

![SQL project 1](https://github.com/SimranSinha14/SQL_Project-Data_Cleaning/assets/127465330/4f10992d-a6d3-4fcd-bee2-ae689500c2b0)
 


   
            
     
           
          






        
    



 
