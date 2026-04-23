USE Financedb;
SELECT COUNT(*) FROM hr_1;
SELECT COUNT(*) FROM hr_2;
select * from hr_2;

SHOW TABLES;
SHOW COLUMNS FROM hr_1 LIKE '%Employee%';
SHOW COLUMNS FROM hr_2 LIKE '%Employee%';
SELECT COUNT(*) AS TotalEmployees
FROM hr_1;
SELECT COUNT(*) AS AttritionCount
FROM hr_1
WHERE Attrition = 'Yes';
SELECT
  ROUND(SUM(Attrition = 'Yes') / COUNT(*) * 100, 2) AS AttritionRate
FROM hr_1;
SELECT COUNT(DISTINCT EmployeeNumber) FROM hr_1;
SELECT COUNT(DISTINCT EmployeeID) FROM hr_2;
SELECT COUNT(DISTINCT `Employee ID`)
FROM hr_2;
ALTER TABLE hr_2
CHANGE `Employee ID` EmployeeID INT;
describe table hr_2;
CREATE OR REPLACE VIEW hr_master AS
SELECT
    h1.*,
    h2.MonthlyIncome,
    h2.MonthlyRate,
    h2.NumCompaniesWorked,
    h2.Over18,
    h2.OverTime,
    h2.PercentSalaryHike,
    h2.PerformanceRating,
    h2.RelationshipSatisfaction,
    h2.StandardHours,
    h2.StockOptionLevel,
    h2.TotalWorkingYears,
    h2.TrainingTimesLastYear,
    h2.WorkLifeBalance,
    h2.YearsInCurrentRole,
    h2.YearsWithCurrManager
FROM hr_1 AS h1
LEFT JOIN hr_2 AS h2
    ON h1.EmployeeNumber = h2.EmployeeID;

/* KPI 1 /*
SELECT
ROUND(SUM(Attrition = 'Yes') / COUNT(*) * 100, 2) AS AttritionRate
FROM hr_master;
/* KPI 2 /*
SELECT
ROUND(AVG(HourlyRate), 2) AS AvgHourlyRate
FROM hr_master
WHERE Gender = 'Male'
AND JobRole = 'Research Scientist';
/* KPI 3 /*
SELECT
JobRole,
ROUND(AVG(WorkLifeBalance), 2) AS AvgWLB
FROM hr_master
GROUP BY JobRole;
/* KPI 4 /*
SELECT
Department,
ROUND(AVG(TotalWorkingYears), 2) AS AvgWorkingYears
FROM hr_master
GROUP BY Department;
/* KPI 5 /*
SELECT
JobRole,
ROUND(AVG(WorkLifeBalance), 2) AS AvgWorkLifeBalance
FROM hr_master
GROUP BY JobRole;
/* KPI 6 /*
SELECT
    YearsInCurrentRole,
    ROUND(SUM(Attrition = 'Yes') / COUNT(*) * 100, 2) AS AttritionRate
FROM hr_master
GROUP BY YearsInCurrentRole
ORDER BY YearsInCurrentRole;

