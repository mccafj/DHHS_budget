USE DHHS_project;

-- testing csv upload
SELECT *
FROM [FY2020Q1-P12_All_FA_AccountBreakdownByAward];

-- AWARDS BY STATE

-- calculating total awards by state for 2020
-- Example of temp table
DROP TABLE IF EXISTS #StateCount2020
CREATE TABLE #StateCount2020
(
State nvarchar(255),
StateCount numeric
)
INSERT INTO #StateCount2020
SELECT DISTINCT recipient_state AS State
	,COUNT(recipient_state) AS StateCount
FROM [FY2020Q1-P12_All_FA_AccountBreakdownByAward]
GROUP BY recipient_state

SELECT *
FROM #StateCount2020
ORDER BY StateCount DESC;

-- Opting to use CTE to be able to use in View / visualizations later
-- and creating separate CTEs for later combination
WITH Count2020 (State, StateCount)
AS
(
SELECT DISTINCT recipient_state AS State
	,COUNT(recipient_state) AS StateCount
FROM [FY2020Q1-P12_All_FA_AccountBreakdownByAward]
GROUP BY recipient_state
)
SELECT *
FROM Count2020
ORDER BY StateCount DESC;


-- total awards by state for 2021
WITH Count2021 (State, StateCount)
AS
(
SELECT DISTINCT(recipient_state) AS State
	, COUNT(recipient_state) AS StateCount
FROM [FY2021P01-P12_All_FA_AccountBreakdownByAward]
GROUP BY recipient_state
)
SELECT *
FROM Count2021
ORDER BY StateCount DESC;

-- and total awards by state for 2022
WITH Count2022 (State, StateCount)
AS
(
SELECT DISTINCT(recipient_state) AS State
	, COUNT(recipient_state) AS StateCount
FROM [FY2022P01-P12_All_FA_AccountBreakdownByAward]
GROUP BY recipient_state
)
SELECT *
FROM Count2022
ORDER BY StateCount DESC;

-- Saving as a view for later visualization and to calculate totals
CREATE VIEW PerStateCount AS
(
SELECT DISTINCT recipient_state AS State
	,COUNT(recipient_state) AS StateCount
FROM [FY2020Q1-P12_All_FA_AccountBreakdownByAward]
GROUP BY recipient_state
)
UNION
(
SELECT DISTINCT(recipient_state) AS State
	, COUNT(recipient_state) AS StateCount
FROM [FY2021P01-P12_All_FA_AccountBreakdownByAward]
GROUP BY recipient_state
)
UNION
(
SELECT DISTINCT(recipient_state) AS State
	, COUNT(recipient_state) AS StateCount
FROM [FY2022P01-P12_All_FA_AccountBreakdownByAward]
GROUP BY recipient_state
);

CREATE VIEW TotalStateCount
AS
(
SELECT State, SUM(StateCount) AS total_count
FROM PerStateCount
GROUP BY State
-- ORDER BY total_count DESC
);

SELECT *
FROM TotalStateCount
ORDER BY total_count DESC;



-- AWARDS BY CONGRESSIONAL DISTRICT

-- calculating total awards by congressional district, for 2020 and creating CTE

WITH ConDist2020 (State, ConDist, TotalConDistCount)
AS
(
SELECT DISTINCT recipient_state
	, recipient_congressional_district AS ConDist
	, COUNT(recipient_congressional_district) AS TotalConDistCount
FROM [FY2020Q1-P12_All_FA_AccountBreakdownByAward]
WHERE recipient_congressional_district IS NOT NULL
GROUP BY recipient_state
	, recipient_congressional_district
)
SELECT *
FROM ConDist2020
ORDER BY TotalConDistCount DESC;


-- and for 2021

WITH ConDist2021 (State, ConDist, TotalConDistCount)
AS
(
SELECT DISTINCT recipient_state
	, recipient_congressional_district AS ConDist
	, COUNT(recipient_congressional_district) AS TotalConDistCount
FROM [FY2021P01-P12_All_FA_AccountBreakdownByAward]
WHERE recipient_congressional_district IS NOT NULL
GROUP BY recipient_state
	, recipient_congressional_district
)
SELECT *
FROM ConDist2021
ORDER BY TotalConDistCount DESC;

-- also for 2022
WITH ConDist2022 (State, ConDist, TotalConDistCount)
AS
(
SELECT DISTINCT recipient_state
	, recipient_congressional_district AS ConDist
	, COUNT(recipient_congressional_district) AS TotalConDistCount
FROM [FY2022P01-P12_All_FA_AccountBreakdownByAward]
WHERE recipient_congressional_district IS NOT NULL
GROUP BY recipient_state
	, recipient_congressional_district
)
SELECT *
FROM ConDist2022
ORDER BY TotalConDistCount DESC;


-- Creating a view for separate congressional districts
CREATE VIEW PerConDist AS
(
SELECT DISTINCT recipient_state
	, recipient_congressional_district AS ConDist
	, COUNT(recipient_congressional_district) AS TotalConDistCount
FROM [FY2020Q1-P12_All_FA_AccountBreakdownByAward]
WHERE recipient_congressional_district IS NOT NULL
GROUP BY recipient_state
	, recipient_congressional_district
)
UNION
(
SELECT DISTINCT recipient_state
	, recipient_congressional_district AS ConDist
	, COUNT(recipient_congressional_district) AS TotalConDistCount
FROM [FY2021P01-P12_All_FA_AccountBreakdownByAward]
WHERE recipient_congressional_district IS NOT NULL
GROUP BY recipient_state 
	, recipient_congressional_district
)
UNION
(
SELECT DISTINCT recipient_state
	, recipient_congressional_district AS ConDist
	, COUNT(recipient_congressional_district) AS TotalConDistCount
FROM [FY2022P01-P12_All_FA_AccountBreakdownByAward]
WHERE recipient_congressional_district IS NOT NULL
GROUP BY recipient_state 
	, recipient_congressional_district
);

SELECT *
FROM PerConDist
WHERE recipient_state IS NOT NULL
ORDER BY ConDist, TotalConDistCount DESC, recipient_state;


-- And creating a view for totals
CREATE VIEW TotalConDist
AS
(
SELECT recipient_state
	, ConDist
	, SUM(TotalConDistCount) AS total_count
FROM PerConDist
GROUP BY recipient_state 
	, ConDist
-- ORDER BY total_count DESC
);

SELECT DISTINCT recipient_state
	, ConDist
	, total_count
FROM TotalConDist
ORDER BY total_count DESC;

-- JOIN back to 2020 Account Breakdown by Award

SELECT a.recipient_state
	, b.ConDist
	, b.total_count
FROM [FY2020Q1-P12_All_FA_AccountBreakdownByAward] a
	JOIN TotalConDist b
	ON a.recipient_state = b.recipient_state
WHERE a.recipient_congressional_district IS NOT NULL
GROUP BY a.recipient_state
	, ConDist
	, total_count
ORDER BY total_count DESC;


-- GROSS OUTLAY AMOUNT

-- 2020
SELECT gross_outlay_amount_FYB_to_period_end AS total_FYB
	, federal_account_name
FROM [FY2020Q1-P12_All_FA_AccountBreakdownByAward]
WHERE gross_outlay_amount_FYB_to_period_end IS NOT NULL
ORDER BY total_FYB DESC

-- 2021
SELECT gross_outlay_amount_FYB_to_period_end AS total_FYB
	, federal_account_name
FROM [FY2021P01-P12_All_FA_AccountBreakdownByAward] 
WHERE gross_outlay_amount_FYB_to_period_end IS NOT NULL
ORDER BY total_FYB DESC

-- 2022
SELECT gross_outlay_amount_FYB_to_period_end AS total_FYB
	, federal_account_name
FROM [FY2022P01-P12_All_FA_AccountBreakdownByAward]
WHERE gross_outlay_amount_FYB_to_period_end IS NOT NULL
ORDER BY total_FYB DESC


-- Transaction Obligated Amount
-- many NULLs across both gross_outlay... and total_obligation.  Didn't do anything with this
SELECT DISTINCT federal_account_name
	, SUM(transaction_obligated_amount) AS total_obligation
	, gross_outlay_amount_FYB_to_period_end
	, submission_period
FROM [FY2020Q1-P12_All_FA_AccountBreakdownByAward]
GROUP BY gross_outlay_amount_FYB_to_period_end, federal_account_name, submission_period
ORDER BY submission_period

