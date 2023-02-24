Use DHHS_project

-- testing csv upload
SELECT *
FROM [FY2020Q1-P12_All_FA_AccountBalances];

-- calculating gross outlay by year and organized by federal account name
SELECT a.gross_outlay_amount AS "2020_gross"
	, b.gross_outlay_amount AS "2021_gross"
	, c.gross_outlay_amount AS "2022_gross"
	,(a.gross_outlay_amount + b.gross_outlay_amount + c.gross_outlay_amount) AS "combined_gross"
	, a.federal_account_name
FROM [FY2020Q1-P12_All_FA_AccountBalances] a
	INNER JOIN [FY2021P01-P12_All_FA_AccountBalances] b 
	ON a.federal_account_name = b.federal_account_name
	INNER JOIN [FY2022P01-P12_All_FA_AccountBalances] c
	ON a.federal_account_name = c.federal_account_name
ORDER BY combined_gross DESC;

-- Creating a view of the above query for later visualization
CREATE VIEW CombGross AS
SELECT a.gross_outlay_amount AS "2020_gross"
	, b.gross_outlay_amount AS "2021_gross"
	, c.gross_outlay_amount AS "2022_gross"
	,(a.gross_outlay_amount + b.gross_outlay_amount + c.gross_outlay_amount) AS "combined_gross"
	, a.federal_account_name
FROM [FY2020Q1-P12_All_FA_AccountBalances] a
	INNER JOIN [FY2021P01-P12_All_FA_AccountBalances] b 
	ON a.federal_account_name = b.federal_account_name
	INNER JOIN [FY2022P01-P12_All_FA_AccountBalances] c
	ON a.federal_account_name = c.federal_account_name;

SELECT *
FROM CombGross
ORDER BY combined_gross DESC;

-- Investigating "budget_authority_appropriated_amount" and "combined outlay"
SELECT a.federal_account_name
	, a.budget_authority_appropriated_amount AS "2020_budget"
	, b.budget_authority_appropriated_amount AS "2021_budget"
	, c.budget_authority_appropriated_amount AS "2022_budget"
	, (a.budget_authority_appropriated_amount + b.budget_authority_appropriated_amount + c.budget_authority_appropriated_amount) AS "combined_budget"
	, a.gross_outlay_amount AS "2020_outlay"
	, b.gross_outlay_amount AS "2021_outlay"
	, c.gross_outlay_amount AS "2022_outlay"
	, (a.gross_outlay_amount + b.gross_outlay_amount + c.gross_outlay_amount) AS "combined_outlay"
FROM [FY2020Q1-P12_All_FA_AccountBalances] a
	INNER JOIN [FY2021P01-P12_All_FA_AccountBalances] b
	ON a.federal_account_name = b.federal_account_name
	INNER JOIN [FY2022P01-P12_All_FA_AccountBalances] c
	ON a.federal_account_name = c.federal_account_name
WHERE a.budget_authority_appropriated_amount != 0
ORDER BY a.federal_account_name;

-- Creating a view of the above query as well
CREATE VIEW CombBudgOutlay AS 
SELECT a.federal_account_name
	, a.budget_authority_appropriated_amount AS "2020_budget"
	, b.budget_authority_appropriated_amount AS "2021_budget"
	, c.budget_authority_appropriated_amount AS "2022_budget"
	, (a.budget_authority_appropriated_amount + b.budget_authority_appropriated_amount + c.budget_authority_appropriated_amount) AS "combined_budget"
	, a.gross_outlay_amount AS "2020_outlay"
	, b.gross_outlay_amount AS "2021_outlay"
	, c.gross_outlay_amount AS "2022_outlay"
	, (a.gross_outlay_amount + b.gross_outlay_amount + c.gross_outlay_amount) AS "combined_outlay"
FROM [FY2020Q1-P12_All_FA_AccountBalances] a
	INNER JOIN [FY2021P01-P12_All_FA_AccountBalances] b
	ON a.federal_account_name = b.federal_account_name
	INNER JOIN [FY2022P01-P12_All_FA_AccountBalances] c
	ON a.federal_account_name = c.federal_account_name
WHERE a.budget_authority_appropriated_amount != 0;

SELECT *
FROM CombBudgOutlay
ORDER BY combined_outlay DESC;