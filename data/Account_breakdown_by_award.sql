USE DHHS_project

SELECT *
FROM [FY2020Q1-P12_All_FA_AccountBreakdownByAward]

SELECT
	DISTINCT(recipient_state)
	, COUNT(recipient_state) AS total_count
FROM [FY2020Q1-P12_All_FA_AccountBreakdownByAward]
GROUP BY recipient_state
ORDER BY total_count DESC

SELECT
	DISTINCT(recipient_state)
	, COUNT(recipient_state) AS total_count
FROM [FY2021P01-P12_All_FA_AccountBreakdownByAward]
GROUP BY recipient_state
ORDER BY total_count DESC

--SELECT
--	DISTINCT(a.recipient_state)
--	, COUNT(a.recipient_state) AS total_2020_count
--	, DISTINCT(b.recipient_state)
--	, COUNT(b.recipient_state) AS total_2021_count
--	, DISTINCT(c.recipient_state)
--	, COUNT(c.recipient_state) AS total_2022_count
--FROM [FY2020Q1-P12_All_FA_AccountBreakdownByAward] a
--	JOIN [FY2021P01-P12_All_FA_AccountBreakdownByAward] b
--	ON a.recipient_state = b.recipient_state
--	JOIN [FY2022P01-P12_All_FA_AccountBreakdownByAward] c
--	ON a.recipient_state= c.recipient_state
--GROUP BY a.recipient_state
--ORDER BY total_count DESC


--SELECT 
--	DISTINCT(a.recipient_state)
--	, COUNT(a.recipient_state + b.recipient_state + c.recipient_state) AS total_count_by_state
--FROM [FY2020Q1-P12_All_FA_AccountBreakdownByAward] a
--	JOIN [FY2021P01-P12_All_FA_AccountBreakdownByAward] b
--	ON a.recipient_state = b.recipient_state
--	JOIN [FY2022P01-P12_All_FA_AccountBreakdownByAward] c
--	ON a.recipient_state= c.recipient_state
--GROUP BY a.recipient_state
--ORDER BY total_count_by_state DESC

--SELECT 
--	a.recipient_congressional_district,
--	COUNT(a.recipient_congressional_district + b.recipient_congressional_district + c.recipient_congressional_district) AS total_count_by_congressional_district
--FROM [FY2020Q1-P12_All_FA_AccountBreakdownByAward] a
--	INNER JOIN [FY2021P01-P12_All_FA_AccountBreakdownByAward] b
--	ON a.federal_account_name = b.federal_account_name
--	INNER JOIN [FY2022P01-P12_All_FA_AccountBreakdownByAward] c
--	ON a.federal_account_name = c.federal_account_name
--GROUP BY a.recipient_congressional_district
--ORDER BY total_count_by_congressional_district DESC
