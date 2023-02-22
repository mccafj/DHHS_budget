USE DHHS_project

-- testing csv upload
SELECT *
FROM [FY2020Q1-P12_All_FA_AccountBreakdownByAward]

-- AWARDS BY STATE

-- calculating total awards by state for 2020
SELECT DISTINCT recipient_state
	,COUNT(recipient_state) AS "2020_total_state_count"
FROM [FY2020Q1-P12_All_FA_AccountBreakdownByAward]
GROUP BY recipient_state
ORDER BY "2020_total_count" DESC

-- total awards by state for 2021
SELECT DISTINCT(recipient_state)
	, COUNT(recipient_state) AS "2021_total_state_count"
FROM [FY2021P01-P12_All_FA_AccountBreakdownByAward]
GROUP BY recipient_state
ORDER BY"2021_total_count" DESC 

-- and total awards by state for 2022
SELECT DISTINCT(recipient_state)
	, COUNT(recipient_state) AS "2022_total_state_count"
FROM [FY2022P01-P12_All_FA_AccountBreakdownByAward]
GROUP BY recipient_state
ORDER BY"2022_total_count" DESC

-- AWARDS BY CONGRESSIONAL DISTRICT

-- calculating total awards by congressional district, for 2020
SELECT DISTINCT recipient_congressional_district
	, COUNT(recipient_congressional_district) AS "2020_total_cong_count"
	, recipient_state
	, recipient_county
	, recipient_city
FROM [FY2020Q1-P12_All_FA_AccountBreakdownByAward]
GROUP BY recipient_congressional_district, recipient_state, recipient_county, recipient_city
ORDER BY "2020_total_cong_count" DESC

-- and for 2021
SELECT DISTINCT recipient_congressional_district
	, COUNT(recipient_congressional_district) AS "2021_total_cong_count"
	, recipient_state
	, recipient_county
	, recipient_city
FROM [FY2021P01-P12_All_FA_AccountBreakdownByAward]
GROUP BY recipient_congressional_district, recipient_state, recipient_county, recipient_city
ORDER BY "2021_total_cong_count" DESC

-- also for 2022
SELECT DISTINCT recipient_congressional_district
	, COUNT(recipient_congressional_district) AS "2022_total_cong_count"
	, recipient_state
	, recipient_county
	, recipient_city
FROM [FY2022P01-P12_All_FA_AccountBreakdownByAward]
GROUP BY recipient_congressional_district, recipient_state, recipient_county, recipient_city
ORDER BY "2022_total_cong_count" DESC

--SELECT COUNT(a.recipient_state) + COUNT(b.recipient_state) + COUNT(c.recipient_state) AS total_count
--FROM [FY2020Q1-P12_All_FA_AccountBreakdownByAward] a
--	JOIN [FY2021P01-P12_All_FA_AccountBreakdownByAward] b
--	ON a.recipient_state = b.recipient_state
--	JOIN [FY2022P01-P12_All_FA_AccountBreakdownByAward] c
--	ON a.recipient_state = c.recipient_state
--GROUP BY a.recipient_state
--ORDER BY total_count DESC

-- GROSS OUTLAY AMOUNT in these tables

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

--SELECT a.gross_outlay_amount_FYB_to_period_end AS "2020_gross_FYB"
--	,b.gross_outlay_amount_FYB_to_period_end AS "2021_gross_FYB"
--	,c.gross_outlay_amount_FYB_to_period_end AS "2022_gross_FYB"
--	,(a.gross_outlay_amount_FYB_to_period_end + 
--		b.gross_outlay_amount_FYB_to_period_end + 
--		c.gross_outlay_amount_FYB_to_period_end) AS "combined_gross_FYB"
--	, a.federal_account_name
--	, b.federal_account_name
--	, c.federal_account_name
--FROM [FY2020Q1-P12_All_FA_AccountBreakdownByAward] a
--	INNER JOIN [FY2021P01-P12_All_FA_AccountBreakdownByAward] b
--	ON a.federal_account_name = b.federal_account_name
--	INNER JOIN [FY2022P01-P12_All_FA_AccountBreakdownByAward] c
--	ON a.federal_account_name = c.federal_account_name
--WHERE a.gross_outlay_amount_FYB_to_period_end IS NOT NULL
--	AND b.gross_outlay_amount_FYB_to_period_end IS NOT NULL
--	AND c.gross_outlay_amount_FYB_to_period_end IS NOT NULL
--ORDER BY combined_gross_FYB DESC, a.federal_account_name