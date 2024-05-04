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



 
