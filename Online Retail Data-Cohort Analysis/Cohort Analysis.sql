--COHORT ANALYSIS
--The unique identifier (CustomerID) will be obtained and linked to the
---date of the first purchase (First Invoice Date).

with firstpurchase as(
select distinct CustomerID,min(InvoiceDate) as FirstPurchasedate,year(min(InvoiceDate)) as cohortyear
,month(min(InvoiceDate)) as cohortmonth
FROM [dbo].[Online Retail] group by CustomerID)

--Join the #onlineretail and #firstpurchase on CustomerID. 
--Retrieve the invoice dates and the cohort dates from each table

,cte as (select a.*,year(a.InvoiceDate) Invoiceyear,month(a.InvoiceDate) invoicemonth,
b.FirstPurchasedate,b.cohortyear,b.cohortmonth,CONCAT(b.cohortyear,'-',b.cohortmonth,'-',01) as cohortdate
FROM [dbo].[Online Retail] a left join firstpurchase b on a.CustomerID=b.CustomerID)

--Derive the year_diff and month_diff columns

,Differences AS (
select aa.*,aa.year_diff*12+aa.month_diff+1 AS cohort_index
from(SELECT cte.*,year_diff=Invoiceyear-cohortyear,month_diff=Invoicemonth-cohortmonth FROM cte ) aa
)

--------------- Creating indexes for cohorts--------

,cohortretention as(
SELECT DISTINCT(CustomerID),
		convert (date,cohortdate) as cohortdate,
		cohort_index
FROM Differences
)

---------------Cohort Analysis---------

,cohortanalysis as(
SELECT * FROM cohortretention 
PIVOT(COUNT(CustomerID)
FOR cohort_index In ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13]))AS PIVOT_TABLE)

-----------Cohort Retention Rate-------

SELECT cohortdate, 
	1.0*[1]/[1]*100 AS [1],
	1.0*[2]/[1]*100 AS [2],
	1.0*[3]/[1]*100 AS [3],
	1.0*[4]/[1]*100 AS [4],
	1.0*[5]/[1]*100 AS [5],
	1.0*[6]/[1]*100 AS [6],
	1.0*[7]/[1]*100 AS [7],
	1.0*[8]/[1]*100 AS [8],
	1.0*[9]/[1]*100 AS [9],
	1.0*[10]/[1]*100 AS [10],
	1.0*[11]/[1]*100 AS [11],
	1.0*[13]/[1]*100 AS [12],
	1.0*[13]/[1]*100 AS [13]
FROM cohortanalysis ORDER BY cohortdate