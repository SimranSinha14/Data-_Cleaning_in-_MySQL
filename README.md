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
 
   
  - STEP 2 : Standardize the data
     - Task 1: Removing Extra Spaces
        - What I Did: Noticed some extra spaces hanging around company names.
        - Action Taken: Used a  SQL command -TRIM() to trim those spaces and make everything look clean.
     - Task 2: Correcting Industry Labels
         - The Issue: Some companies were tagged as "Crypto" but not all of them excatly wore the label.
         - The Fix: Updated those companies to make sure they all  belong to the "Crypto" industry
     - Task 3 : Part 3: Standardizing Country Names
         - The Discovery: Country names should look sharp, but some had unnecessary dots at the end, like a stray pen mark on a clean sheet.
         - The Remedy: We polished these country names by trimming any trailing dots, ensuring they're sleek and consistent.
     - Task 4 : Standardizing Dates
         - Objective: Convert date data from string format to the "month/day/year" format using the STR_TO_DATE function.
         - Procedure: Employed the STR_TO_DATE function to convert date strings into the desired format, ensuring uniformity across the dataset.
         - Subsequent Action: Altered the data type of the date column from text to Date to reflect the updated format accurately.
   - Step 3: Eliminating Null Values
         - Identifying Null Values in Industry:
         - Action: Initially, I scoured the dataset to locate any rows where the industry column was null.
         - Filling Null Values with Relevant Data:
          - Insight: Some rows lacked an industry designation, but other rows with the same company had it filled in.
          - Approach: Utilized a JOIN operation to pair up rows with the same company, where one had a null industry value and the other did not.
          - Query Executed:
           
          - Updating Null Industry Values:
          - Strategy: Leveraged the paired rows from the previous step to update the null industry values with their corresponding industry.
          - SQL Command:
     
          - Handling Nulls in Other Columns:
          - Exploration: Investigated rows where both total_laid_off and percentage_laid_off were null.
          
         
          - Removing Rows with Null Values:
          - Decision: Opted to delete rows where both total_laid_off and percentage_laid_off were null, as they lacked crucial information.
            
     
           - Final Check:
           - Verification: Reviewed the dataset post-null removal to ensure all necessary adjustments were made.
           - Query Executed:
          






        
    



 
