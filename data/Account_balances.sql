Use DHHS_project

SELECT *
FROM [FY2020Q1-P12_All_FA_AccountBalances]

SELECT a.gross_outlay_amount AS "2020_gross"
	,b.gross_outlay_amount AS "2021_gross"
	,c.gross_outlay_amount AS "2022_gross"
	,(a.gross_outlay_amount + b.gross_outlay_amount + c.gross_outlay_amount) AS "combined_gross"
	,a.federal_account_name
FROM [FY2020Q1-P12_All_FA_AccountBalances] a
	INNER JOIN [FY2021P01-P12_All_FA_AccountBalances] b 
	ON a.federal_account_name = b.federal_account_name
	INNER JOIN [FY2022P01-P12_All_FA_AccountBalances] c
	ON a.federal_account_name = c.federal_account_name
ORDER BY combined_gross DESC

