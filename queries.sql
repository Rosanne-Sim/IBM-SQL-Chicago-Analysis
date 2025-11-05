/* -------------------------------------------------------
   Problem 1: Total number of crimes recorded
   ------------------------------------------------------- */
-- Counts all crime records in the CHICAGO_CRIME_DATA table
SELECT COUNT(*) AS total_crimes
FROM CHICAGO_CRIME_DATA;
/* Insight: Establishes the baseline scale of criminal activity across Chicago,
   serving as a reference point for comparing crime distribution and intensity
   between communities. */


/* -------------------------------------------------------
   Problem 2: Community areas with per capita income < 11,000
   ------------------------------------------------------- */
SELECT community_area_name, community_area_number
FROM CENSUS_DATA
WHERE per_capita_income < 11000;
/* Insight: Highlights low-income neighborhoods that may require greater
   socioeconomic support or targeted public investment to address inequality. */


/* -------------------------------------------------------
   Problem 3: Crimes involving minors
   ------------------------------------------------------- */
SELECT case_number, primary_type, description
FROM CHICAGO_CRIME_DATA
WHERE description LIKE '%MINOR%';
/* Insight: Reveals incidents involving minors, offering insights into youth-related
   crime exposure and informing child protection or school safety policies. */


/* -------------------------------------------------------
   Problem 4: Kidnapping crimes involving children
   ------------------------------------------------------- */
SELECT case_number, primary_type, description
FROM CHICAGO_CRIME_DATA
WHERE primary_type = 'KIDNAPPING'
  AND description LIKE '%CHILD%';
/* Insight: Identifies child-related kidnapping cases — a critical subset for
   law-enforcement prioritization and community safety awareness. */


/* -------------------------------------------------------
   Problem 5: Crime types recorded at schools (no repetitions)
   ------------------------------------------------------- */
SELECT DISTINCT primary_type
FROM CHICAGO_CRIME_DATA
WHERE location_description LIKE '%SCHOOL%';
/* Insight: Exposes the range of crime categories within school environments,
   guiding preventive measures and safety training for educational institutions. */


/* -------------------------------------------------------
   Problem 6: Average school safety score by type
   ------------------------------------------------------- */
SELECT elementary_middle_or_high_school AS school_type,
       AVG(safety_score) AS avg_safety_score
FROM CHICAGO_PUBLIC_SCHOOLS
GROUP BY elementary_middle_or_high_school;
/* Insight: Compares perceived safety levels across school types, highlighting
   where safety initiatives may be most needed (e.g., high schools often rate lower). */


/* -------------------------------------------------------
   Problem 7: Top 5 community areas with highest poverty %
   ------------------------------------------------------- */
SELECT community_area_name,
       percent_households_below_poverty
FROM CENSUS_DATA
ORDER BY percent_households_below_poverty DESC
LIMIT 5;
/* Insight: Pinpoints communities facing concentrated economic hardship,
   essential for resource allocation, social aid, and policy intervention planning. */


/* -------------------------------------------------------
   Problem 8: Community area most prone to crime
   ------------------------------------------------------- */
SELECT community_area_number,
       COUNT(*) AS total_crimes
FROM CHICAGO_CRIME_DATA
GROUP BY community_area_number
ORDER BY total_crimes DESC
LIMIT 1;
/* Insight: Determines the most crime-affected area, enabling data-driven
   prioritization of policing and community engagement programs. */


/* -------------------------------------------------------
   Problem 9: Community area with highest hardship index
   ------------------------------------------------------- */
SELECT community_area_name, hardship_index
FROM CENSUS_DATA
WHERE hardship_index = (
    SELECT MAX(hardship_index)
    FROM CENSUS_DATA
);
/* Insight: Surfaces the area experiencing the most compounded social and
   economic challenges — useful for integrated urban renewal and welfare planning. */


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
/* Insight: Connects census and crime data to identify the community facing the
   highest crime concentration, reinforcing the link between socioeconomic
   hardship and public safety outcomes. */
