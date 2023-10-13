-- ---------------------------- Generic ------------------------------
-- --------------------------------------------------------------------
-- How many unique cities does the data have?
SELECT 
	DISTINCT city
FROM [dbo].[WalmartSalesData];

-- In which city is each branch?
SELECT 
	DISTINCT city,
    branch
FROM [dbo].[WalmartSalesData] ;

-- --------------------------------------------------------------------
-- ---------------------------- Product -------------------------------
-- --------------------------------------------------------------------

-- How many unique product lines does the data have?
SELECT
	DISTINCT [Product line]
FROM [dbo].[WalmartSalesData]

-- What is the most selling product line
SELECT [Product line],
	SUM(quantity) as qty
FROM [dbo].[WalmartSalesData]
GROUP BY [Product line]
ORDER BY qty DESC;

-- What is the total revenue by month
SELECT
	Year(Date) as Year,Month(Date) AS month,
	SUM(total) AS total_revenue
FROM [dbo].[WalmartSalesData]
GROUP BY Year(Date),Month(Date)
ORDER BY total_revenue asc;

-- What month had the largest COGS?
SELECT
	Year(Date) as Year,Month(Date) AS month,
	SUM(cogs) AS cogs
FROM [dbo].[WalmartSalesData]
GROUP BY Year(Date),Month(Date)
ORDER BY cogs;


-- What product line had the largest revenue?
SELECT
	[Product line],
	SUM(total) as total_revenue
FROM [dbo].[WalmartSalesData]
GROUP BY [Product line]
ORDER BY total_revenue DESC;

-- What is the city with the largest revenue?
SELECT
	branch,
	city,
	SUM(total) AS total_revenue
FROM [dbo].[WalmartSalesData]
GROUP BY city, branch 
ORDER BY total_revenue;


-- What product line had the largest VAT?
SELECT
	[Product line],
	AVG([Tax 5%]) as avg_tax
FROM [dbo].[WalmartSalesData]
GROUP BY [Product line]
ORDER BY avg_tax DESC;


-- Fetch each product line and add a column to those product 
-- line showing "Good", "Bad". Good if its greater than average sales
With cte as (
SELECT 
	AVG(quantity) AS avg_sales
FROM [dbo].[WalmartSalesData])

SELECT [Product line],AVG(quantity) as avg_sales,
CASE WHEN AVG(quantity) > (select * from cte) THEN 'Good' ELSE 'Bad'
 END AS Remark
FROM [dbo].[WalmartSalesData] 
GROUP BY [Product line];

-- Which branch sold more products than average product sold?
SELECT city,branch, 
 SUM(quantity) AS sales
FROM [dbo].[WalmartSalesData] 
GROUP BY city,branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM [dbo].[WalmartSalesData] );

-- What is the most common product line by gender
SELECT
	gender,
    [Product line],
    COUNT(gender) AS total_cnt
FROM [dbo].[WalmartSalesData]
GROUP BY gender, [Product line]
ORDER BY total_cnt DESC;

-- What is the average rating of each product line
SELECT  [Product line],
	ROUND(AVG(rating), 2) as avg_rating
FROM [dbo].[WalmartSalesData]
GROUP BY [Product line]
ORDER BY avg_rating DESC;


-- --------------------------------------------------------------------
-- -------------------------- Customers -------------------------------
-- --------------------------------------------------------------------

-- How many unique customer types does the data have?
SELECT
	DISTINCT [Customer type]
FROM [Practice Db].[dbo].[WalmartSalesData];

-- How many unique payment methods does the data have?
SELECT
	DISTINCT payment
FROM [Practice Db].[dbo].[WalmartSalesData];


-- What is the most common customer type?
SELECT
	[Customer type],
	count([Customer type]) as customertypecount
FROM [dbo].[WalmartSalesData]
GROUP BY [Customer type]
ORDER BY 2 DESC;

-- Which customer type buys the most?
SELECT
	[Customer type],
   sum([Quantity]) as buy
FROM [dbo].[WalmartSalesData]
GROUP BY [Customer type] ORDER BY 2 DESC;


-- What is the gender of most of the customers?
SELECT
	gender,
	COUNT(*) as gender_cnt
FROM [dbo].[WalmartSalesData]
GROUP BY gender
ORDER BY gender_cnt DESC;

-- What is the gender distribution per branch?
SELECT
	gender,branch,
	COUNT(*) as gender_cnt
FROM [dbo].[WalmartSalesData]
GROUP BY gender,branch
ORDER BY gender_cnt DESC;
-- Gender per branch is more or less the same hence, I don't think has
-- an effect of the sales per branch and other factors.

-- Which time of the day do customers give most ratings?
with cte as (SELECT *,
	CASE
		WHEN convert([Time], time) BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN convert([Time], time) BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END as timeofday
FROM [dbo].[WalmartSalesData])
select timeofday,round(AVG(rating),2) AS avg_rating FROM cte GROUP BY timeofday
ORDER BY avg_rating DESC;
-- Looks like time of the day does not really affect the rating, its
-- more or less the same rating each time of the day.alter


-- Which time of the day do customers give most ratings per branch?
with cte as (SELECT *,
	CASE
		WHEN convert([Time], time) BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN convert([Time], time) BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END as timeofday
FROM [dbo].[WalmartSalesData])
SELECT branch,timeofday, round(AVG(rating),2) AS avg_rating
FROM cte
GROUP BY branch,timeofday
ORDER BY avg_rating DESC;
-- Branch A and C are doing well in ratings, branch B needs to do a 
-- little more to get better ratings.


-- Which day fo the week has the best avg ratings?
SELECT
	datename(WEEKDAY,date) as day_name,
	round(AVG(rating),2) AS avg_rating
FROM [dbo].[WalmartSalesData]
GROUP BY datename(WEEKDAY,date)
ORDER BY avg_rating DESC;
-- Mon, Tue and Friday are the top best days for good ratings
-- why is that the case, how many sales are made on these days?



-- Which day of the week has the best average ratings per branch?
SELECT 
	Branch,datename(WEEKDAY,date) as day_name,
	COUNT(datename(WEEKDAY,date)) total_sales
FROM [dbo].[WalmartSalesData]
GROUP BY Branch,datename(WEEKDAY,date)
ORDER BY total_sales DESC;


-- --------------------------------------------------------------------
-- ---------------------------- Sales ---------------------------------
-- --------------------------------------------------------------------

-- Number of sales made in each time of the day per weekday 
with cte as (SELECT *,
	CASE
		WHEN convert([Time], time) BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
        WHEN convert([Time], time) BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
        ELSE 'Evening'
    END as timeofday,datename(WEEKDAY,date) as day_name
FROM [dbo].[WalmartSalesData])
SELECT
	day_name,timeofday,
	COUNT(*) AS total_sales
FROM cte
GROUP BY timeofday ,day_name
ORDER BY total_sales DESC;
-- Evenings experience most sales, the stores are 
-- filled during the evening hours

-- Which of the customer types brings the most revenue?
SELECT
	[Customer type],
	SUM(total) AS total_revenue
FROM [dbo].[WalmartSalesData]
GROUP BY [Customer type]
ORDER BY total_revenue desc;

-- Which city has the largest tax/VAT percent?
SELECT
	city,
    ROUND(AVG([Tax 5%]), 2) AS avg_tax_pct
FROM [dbo].[WalmartSalesData]
GROUP BY city 
ORDER BY avg_tax_pct DESC;

-- Which customer type pays the most in VAT?
SELECT
	[Customer type],
	AVG([Tax 5%]) AS total_tax
FROM [dbo].[WalmartSalesData]
GROUP BY [Customer type]
ORDER BY total_tax;
