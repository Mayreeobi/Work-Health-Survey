
USE ProjectDB

 --Add a new column for days
ALTER TABLE WorkHealthSurvey
ADD Weekday VARCHAR(20);

UPDATE WorkHealthSurvey
SET Weekday = DATENAME(WEEKDAY, Survey_Date);


SELECT Weekday
FROM WorkHealthSurvey
ORDER BY Survey_Date;

-- ==============================================
-- SECTION 1: OVERVIEW METRICS
-- ==============================================

-- Total Respondents
SELECT COUNT(*) AS Total_Respondents
FROM WorkHealthSurvey;

-- Gender Distribution
SELECT 
    Gender,
    COUNT(*) AS Respondent_Count
FROM WorkHealthSurvey
GROUP BY Gender
ORDER BY Respondent_Count DESC;

-- Average Age
SELECT AVG(Age) AS Avg_Age
FROM WorkHealthSurvey;

-- Region Distribution
SELECT 
    Region,
    COUNT(*) AS Respondent_Count
FROM WorkHealthSurvey
GROUP BY Region
ORDER BY Respondent_Count DESC;

-- Work Arrangement Distribution
SELECT 
    Work_Arrangement,
    COUNT(*) AS Respondent_Count
FROM WorkHealthSurvey
GROUP BY Work_Arrangement
ORDER BY Respondent_Count DESC;

-- Industry Distribution 
SELECT 
    Industry,
    COUNT(*) AS Respondent_Count
FROM WorkHealthSurvey
GROUP BY Industry
ORDER BY Respondent_Count DESC;

-- Job Role Distribution (Top 10)
SELECT TOP 10
    Job_Role,
    COUNT(*) AS Respondent_Count
FROM WorkHealthSurvey
GROUP BY Job_Role
ORDER BY Respondent_Count DESC;

-- Salary Range Distribution
SELECT 
    Salary_Range,
    COUNT(*) AS Respondent_Count
FROM WorkHealthSurvey
GROUP BY Salary_Range
ORDER BY Respondent_Count DESC;

-- Work arangement Preferences by Gender
SELECT 
    Gender,
    Work_Arrangement,
    COUNT(*) AS Respondent_count
FROM WorkHealthSurvey
GROUP BY Gender, Work_Arrangement
ORDER BY Gender, Respondent_Count DESC;

-- ==============================================
-- SECTION 2: BURNOUT ANALYSIS
-- ==============================================

-- Burnout Level Distribution
SELECT 
    Burnout_Level,
    COUNT(*) AS Count
FROM WorkHealthSurvey
GROUP BY Burnout_Level
ORDER BY Count DESC;

-- Burnout Rate by Gender
SELECT 
    Gender,
    COUNT(*) AS Total,
    SUM(CASE WHEN Burnout_Level = 'High' THEN 1 ELSE 0 END) AS High_Burnout,
    CAST(ROUND(100.0 * SUM(CASE WHEN Burnout_Level = 'High' THEN 1 ELSE 0 END) / COUNT(*), 2) AS DECIMAL(5,2)) AS Burnout_Rate
FROM WorkHealthSurvey
GROUP BY Gender
ORDER BY Burnout_Rate DESC;

-- Burnout Rate by Job Role (Top 10)
SELECT TOP 10
    Job_Role,
    COUNT(*) AS Total,
    SUM(CASE WHEN Burnout_Level = 'High' THEN 1 ELSE 0 END) AS High_Burnout,
    CAST(ROUND(100.0 * SUM(CASE WHEN Burnout_Level = 'High' THEN 1 ELSE 0 END) / COUNT(*), 2) AS DECIMAL(5,2)) AS Burnout_Rate
FROM WorkHealthSurvey
GROUP BY Job_Role
ORDER BY Burnout_Rate DESC;

-- Burnout Rate by Salary Range
SELECT 
    Salary_Range,
    COUNT(*) AS Total,
    SUM(CASE WHEN Burnout_Level = 'High' THEN 1 ELSE 0 END) AS High_Burnout,
    CAST(ROUND(100.0 * SUM(CASE WHEN Burnout_Level = 'High' THEN 1 ELSE 0 END) / COUNT(*), 2) AS DECIMAL(5,2)) AS Burnout_Rate
FROM WorkHealthSurvey
GROUP BY Salary_Range
ORDER BY Burnout_Rate DESC;

-- Burnout vs Work-Life Balance
SELECT 
    Burnout_Level,
    AVG(Work_Life_Balance_Score) AS Avg_Work_Life_Balance
FROM WorkHealthSurvey
GROUP BY Burnout_Level
ORDER BY Avg_Work_Life_Balance ASC;

-- Burnout vs Hours Worked
SELECT 
    Burnout_Level,
    AVG(Hours_Per_Week) AS Avg_Hours
FROM WorkHealthSurvey
GROUP BY Burnout_Level
ORDER BY Avg_Hours DESC;

-- ==============================================
-- SECTION 3: HEALTH INSIGHTS
-- ==============================================

-- Physical Health Issue Frequency (Split Strings)
-- SQL Server syntax for STRING_SPLIT
SELECT 
    TRIM(value) AS Physical_Issue,
    COUNT(*) AS Occurrence
FROM WorkHealthSurvey
CROSS APPLY STRING_SPLIT(Physical_Health_Issues, ';')
WHERE value IS NOT NULL AND value <> ''
GROUP BY TRIM(value)
ORDER BY Occurrence DESC;

-- Social Isolation by Work Arrangement
SELECT 
    Work_Arrangement,
    AVG(Social_Isolation_Score) AS Avg_Isolation
FROM WorkHealthSurvey
GROUP BY Work_Arrangement
ORDER BY Avg_Isolation DESC;

-- Work-Life Balance by Work Arrangement
SELECT 
    Work_Arrangement,
    AVG(Work_Life_Balance_Score) AS Avg_Work_Life_Balance
FROM WorkHealthSurvey
GROUP BY Work_Arrangement
ORDER BY Avg_Work_Life_Balance DESC;

-- Average Hours Worked by Work Arrangement
SELECT 
    Work_Arrangement,
    AVG(Hours_Per_Week) AS Avg_Hours
FROM WorkHealthSurvey
GROUP BY Work_Arrangement
ORDER BY Avg_Hours DESC;

-- ==============================================
-- SECTION 4: MENTAL HEALTH ANALYSIS
-- ==============================================

-- Mental Health Condition Distribution
SELECT 
    Mental_Health_Status,
    COUNT(*) AS Count
FROM WorkHealthSurvey
GROUP BY Mental_Health_Status
ORDER BY Count DESC;

-- Burnout Rate by Mental Health Condition
SELECT 
    Mental_Health_Status,
    COUNT(*) AS Total,
    SUM(CASE WHEN Burnout_Level = 'High' THEN 1 ELSE 0 END) AS HighBurnout,
    CAST(ROUND(100.0 * SUM(CASE WHEN Burnout_Level = 'High' THEN 1 ELSE 0 END) / COUNT(*), 2) AS DECIMAL(5,2)) AS BurnoutRate
FROM WorkHealthSurvey
WHERE Mental_Health_Status IS NOT NULL
GROUP BY Mental_Health_Status
ORDER BY BurnoutRate DESC;

-- ==============================================
-- SECTION 5: TIME-BASED ANALYSIS 
-- ==============================================

-- Daily Survey Participation Trend
SELECT 
    Survey_Date, 
    COUNT(*) AS Respondent_Count
FROM WorkHealthSurvey
GROUP BY Survey_Date
ORDER BY Survey_Date;


/* Weekly Pattern Analysis: Respondent Trends & Well-being */

WITH RespondentCount AS (
    SELECT 
        Weekday,
        COUNT(*) AS Respondent_Count
    FROM WorkHealthSurvey
    GROUP BY Weekday
),
BurnoutDistribution AS (
    SELECT 
        Weekday,
        SUM(CASE WHEN Burnout_Level = 'High' THEN 1 ELSE 0 END) AS High_Burnout,
        SUM(CASE WHEN Burnout_Level = 'Medium' THEN 1 ELSE 0 END) AS Medium_Burnout,
        SUM(CASE WHEN Burnout_Level = 'Low' THEN 1 ELSE 0 END) AS Low_Burnout
    FROM WorkHealthSurvey
    GROUP BY Weekday
),
WorkLifeBalance AS (
    SELECT 
        Weekday,
        AVG(Work_Life_Balance_Score) AS Avg_Work_Life_Balance
    FROM WorkHealthSurvey
    GROUP BY Weekday
),
SocialIsolation AS (
    SELECT 
        Weekday,
        AVG(Social_Isolation_Score) AS Avg_Social_Isolation
    FROM WorkHealthSurvey
    GROUP BY Weekday
)

SELECT 
    RC.Weekday,
    RC.Respondent_Count,
    BD.High_Burnout,
    BD.Medium_Burnout,
    BD.Low_Burnout,
    WLB.Avg_Work_Life_Balance,
    SI.Avg_Social_Isolation
FROM RespondentCount RC
LEFT JOIN BurnoutDistribution BD ON RC.Weekday = BD.Weekday
LEFT JOIN WorkLifeBalance WLB ON RC.Weekday = WLB.Weekday
LEFT JOIN SocialIsolation SI ON RC.Weekday = SI.Weekday
ORDER BY 
    CASE 
        WHEN RC.Weekday = 'Sunday' THEN 1
        WHEN RC.Weekday = 'Monday' THEN 2
        WHEN RC.Weekday = 'Tuesday' THEN 3
        WHEN RC.Weekday = 'Wednesday' THEN 4
        WHEN RC.Weekday = 'Thursday' THEN 5
        WHEN RC.Weekday = 'Friday' THEN 6
        WHEN RC.Weekday = 'Saturday' THEN 7
    END;



