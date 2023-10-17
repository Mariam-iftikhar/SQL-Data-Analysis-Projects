--------Q1. Sales and order frequency by year, month and product line-----------
SELECT 
	YEAR_ID,
	month_Id,
	PRODUCTLINE,
	ROUND(SUM(sales),2) AS Revenue,
	COUNT(ORDERNUMBER) AS Frequency
FROM [Practice Db].[dbo].[sales_data_sample]
GROUP BY YEAR_ID,MONTH_ID,PRODUCTLINE
ORDER BY Revenue DESC 

----------Q2. Products Sold Together----------------

--Gives the Number of products per order.
SELECT
	[ORDERNUMBER],[PRODUCTLINE],
	COUNT(*) AS rn
FROM [Practice Db].[dbo].[sales_data_sample]
WHERE status ='Shipped' 
GROUP BY ORDERNUMBER,[PRODUCTLINE];

--Build a subquery that gives us the order numbers when two products are ordered together(rn=2)
SELECT ORDERNUMBER
FROM (
SELECT
	[ORDERNUMBER],[PRODUCTLINE],
	COUNT(*) AS rn
FROM [Practice Db].[dbo].[sales_data_sample]
WHERE status ='Shipped'
GROUP BY ORDERNUMBER,[PRODUCTLINE]
) AS m
WHERE rn=2;

--------Making combinations-----
SELECT DISTINCT concat(a.[PRODUCTLINE],'+',b.[PRODUCTLINE]) as pro
FROM [Practice Db].[dbo].[sales_data_sample] a CROSS JOIN
[Practice Db].[dbo].[sales_data_sample] b  order by 1 asc

---- Combination of products that are bought together-----

select products,count(ORDERNUMBER) as boughttogether
from (SELECT distinct a.[ORDERNUMBER] as ORDERNUMBER,a.[PRODUCTLINE] ,b.[PRODUCTLINE] as p2,
concat(a.[PRODUCTLINE],'+',b.[PRODUCTLINE]) as products
from [Practice Db].[dbo].[sales_data_sample] a	left join  [Practice Db].[dbo].[sales_data_sample] b
on  a.[ORDERNUMBER]=b.[ORDERNUMBER] and a.[PRODUCTLINE]!= b.[PRODUCTLINE] and a.status ='Shipped') aa
where p2 is not null group by products

 -----Testing above Query---

 select * from [Practice Db].[dbo].[sales_data_sample] where ORDERNUMBER in (
select distinct ORDERNUMBER  FROM [Practice Db].[dbo].[sales_data_sample]
  WHERE [PRODUCTLINE]='Ships' and STATUS='Shipped') and [PRODUCTLINE]= 'Motorcycles'

---------------Q3. Best Customers Using RFM Analysis---------------
--Use DATEDIFF() to calculate recency (time between customer last order and most recent date in table)

WITH rfm AS (SELECT CUSTOMERNAME,
	ROUND(SUM(sales),2) AS MonetaryValue,
	ROUND(AVG(sales),2) AS AvgValue,
	COUNT(ORDERNUMBER) AS Frequency
,DATEDIFF(dd, convert(date,max(ORDERDATE)), (SELECT convert(date,max(ORDERDATE))
	FROM [Practice Db].[dbo].[sales_data_sample])) AS Recency,
convert(date,MAX(ORDERDATE)) AS last_order_date
FROM [Practice Db].[dbo].[sales_data_sample]
GROUP BY CUSTOMERNAME)

, rfm_calc as (SELECT 
	rfm.*,
	NTILE(4) OVER (ORDER BY Recency DESC) AS rfm_recency,
	NTILE(4) OVER (ORDER BY Frequency) AS rfm_frequency,
	NTILE(4) OVER (ORDER BY MonetaryValue) AS rfm_monetary
FROM rfm )

--retrieve all columns from rfm-calc CTE 
--derive the rfm_cell & rfm_cell_string columns

,Concatenationcte as (SELECT rfm_calc.*, 
	   rfm_recency + rfm_frequency + rfm_monetary AS rfm_cell,
	   CAST(rfm_recency AS varchar) + CAST(rfm_frequency AS varchar)
	   +CAST(rfm_monetary AS varchar) AS rfm_cell_string from rfm_calc)

SELECT CUSTOMERNAME,rfm_recency,rfm_frequency,	rfm_monetary,rfm_cell_string,
CASE 
WHEN rfm_cell_string IN (111,112,121,122,123,132,211,212,114,141) THEN 'lost_customers'--lost customers
WHEN rfm_cell_string IN (133,134,143,244,334,343,344,144) 
THEN 'slipping away, cannot lose' --(big spenders that havent purchased lately)
WHEN rfm_cell_string IN (311,411,331) THEN 'new_customers'
WHEN rfm_cell_string IN (222,223,233,322) THEN 'potential_customers'
WHEN rfm_cell_string IN (323,333,321,422,332,432)
THEN 'active'--customers that buy often at lower price points
WHEN rfm_cell_string IN (433,434,443,444) THEN 'loyal'
END rfm_segment from Concatenationcte

