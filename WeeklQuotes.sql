
--get weekly sum of Is  Quotes 
-- SELECT *
-- FROM [BI].[BI].[HomeNewBusiness]
-- where StartDate >= '2012-01-22'

SELECT 
datepart(mm,FirstQuoteDate) AS MonthNumber,
datepart(ww,FirstQuoteDate) AS WeekNumber,

sum(IsQuote) AS 'Sum of Quotes'
FROM [BI].[BI].[HomeNewBusiness] ren
where FirstQuoteDate >= '2022-01-01'
GROUP BY datepart(mm,FirstQuoteDate), datepart(ww,FirstQuoteDate)
ORDER BY datepart(mm,FirstQuoteDate), datepart(ww,FirstQuoteDate)


--get weekly quotes using First Quotes Date and IsQuote column and groupby month and week


