/* =======================================================
   IBM SQL Final Project — Chicago Data Analysis
   Author: Rosanne Sim
   Course: Databases and SQL for Data Science with Python (IBM)
   Description: SQL queries used to analyze socioeconomic,
                education, and crime data across Chicago.
   ======================================================= */


/* -------------------------------------------------------
   Problem 1: Total number of crimes recorded
   ------------------------------------------------------- */
-- Counts all crime records in the CHICAGO_CRIME_DATA table
SELECT COUNT(*) AS total_crimes
FROM CHICAGO_CRIME_DATA;
/* Insight: Provides the overall scale of reported incidents in the dataset. */


/* -------------------------------------------------------
   Problem 2: Community areas with per capita income < 11,000
   ------------------------------------------------------- */
SELECT community_area_name, community_area_number
FROM CENSUS_DATA
WHERE per_capita_income < 11000;
/* Insight: Identifies communities with lower income levels — potential hotspots for social vulnerability. */


/* -------------------------------------------------------
   Problem 3: Crimes involving minors
   ------------------------------------------------------- */
SELECT case_number, primary_type, description
FROM CHICAGO_CRIME_DATA
WHERE description LIKE '%MINOR%';
/* Insight: Detects all crimes that explicitly mention minors in their descriptions. */


/* -------------------------------------------------------
   Problem 4: Kidnapping crimes involving children
   ------------------------------------------------------- */
SELECT case_number, primary_type, description
FROM CHICAGO_CRIME_DATA
WHERE primary_type = 'KIDNAPPING'
  AND description LIKE '%CHILD%';
/* Insight: Extracts all child-related kidnapping cases for focused safety analysis. */


/* -------------------------------------------------------
   Problem 5: Crime types recorded at schools (no repetitions)
   ------------------------------------------------------- */
SELECT DISTINCT primary_type
FROM CHICAGO_CRIME_DATA
WHERE location_description LIKE '%SCHOOL%';
/* Insight: Highlights common crime categories that occur within or near school premises. */


/* -------------------------------------------------------
   Problem 6: Average school safety score by type
   ------------------------------------------------------- */
SELECT elementary_middle_or_high_school AS school_type,
       AVG(safety_score) AS avg_safety_score
FROM CHICAGO_PUBLIC_SCHOOLS
GROUP BY elementary_middle_or_high_school;
/* Insight: Measures perceived safety differences across elementary, middle, and high schools. */


/* -------------------------------------------------------
   Problem 7: Top 5 community areas with highest poverty %
   ------------------------------------------------------- */
SELECT community_area_name,
       percent_households_below_poverty
FROM CENSUS_DATA
ORDER BY percent_households_below_poverty DESC
LIMIT 5;
/* Insight: Pinpoints neighborhoods facing the most economic hardship. */


/* -------------------------------------------------------
   Problem 8: Community area most prone to crime
   ------------------------------------------------------- */
SELECT community_area_number,
       COUNT(*) AS total_crimes
FROM CHICAGO_CRIME_DATA
GROUP BY community_area_number
ORDER BY total_crimes DESC
LIMIT 1;
/* Insight: Identifies the single community area with the highest crime frequency. */


/* -------------------------------------------------------
   Problem 9: Community area with highest hardship index
   ------------------------------------------------------- */
SELECT community_area_name, hardship_index
FROM CENSUS_DATA
WHERE hardship_index = (
    SELECT MAX(hardship_index)
    FROM CENSUS_DATA
);
/* Insight: Returns the area under greatest social and economic stress based on the hardship index metric. */


/* -------------------------------------------------------
   Problem 10: Community area with most number of crimes
   ------------------------------------------------------- */
SELECT community_area_name
FROM CENSUS_DATA
WHERE community_area_number = (
    SELECT community_area_number
    FROM CHICAGO_CRIME_DATA
    GROUP BY community_area_number
    ORDER BY COUNT(*) DESC
    LIMIT 1
);
/* Insight: Combines subqueries and joins logic to match the most crime-prone community with its name. */

