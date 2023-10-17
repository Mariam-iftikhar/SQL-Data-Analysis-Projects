---------Q1. Top 5 cities with highest spends  and their % contribution of total credit card spend

select top 5 bb.City,bb.Amt,aa.TotalAmt, round((bb.Amt/aa.TotalAmt)*100,2) as '%Contribution' from (

select sum([Amount]) as TotalAmt,1 'Num'
from [Practice Db].[dbo].['Credit card transactions - Indi$'])aa

left join (select city,sum([Amount]) as Amt,1 'Num'
from [Practice Db].[dbo].['Credit card transactions - Indi$'] group by city)bb

on aa.Num=bb.Num order by  Amt desc

-----Q2. Find the highest spend month and amt spend in that month for each card type

with cte as (
select top 1 year(Date) as Years,month([Date]) as Months,sum(Amount)as Amt 
from [Practice Db].[dbo].['Credit card transactions - Indi$']
group by year(Date),month([Date]) order by 3 desc)

select year(Date) as Years,month([Date]) as Months,[Card Type],sum(Amount)as Amt 
from [Practice Db].[dbo].['Credit card transactions - Indi$'] where year(Date)= (select Years from cte)
and MONTH(Date)= (select Months from cte)
group by year(Date),month([Date]),[Card Type]

------Q3. Query to find city which had lowest %spend for gold card type

select bb.City,bb.Amt,aa.TotalAmt, round((bb.Amt/aa.TotalAmt)*100,2) as '%Contribution' from (
select sum([Amount]) as TotalAmt,1 'Num'
from [Practice Db].[dbo].['Credit card transactions - Indi$'] where [Card Type]='Gold')aa

left join (select city,sum([Amount]) as Amt,1 'Num'
from [Practice Db].[dbo].['Credit card transactions - Indi$'] where [Card Type]='Gold' group by city) bb 
on aa.Num=bb.Num order by '%Contribution' asc

-------Q4. % contribution of spend by females for each expense type

select bb.[Exp Type],bb.Amt,aa.TotalAmt, round((bb.Amt/aa.TotalAmt)*100,2) as '%Contribution' from 
(select sum([Amount]) as TotalAmt,1 'Num'
from [Practice Db].[dbo].['Credit card transactions - Indi$'] where [Gender]='F')aa

left join (select [Exp Type],sum([Amount]) as Amt ,1 'Num'
from [Practice Db].[dbo].['Credit card transactions - Indi$']
where [Gender]='F' group by [Exp Type])bb 
on aa.Num=bb.Num order by  Amt desc

-----Q5. Which card and expense type combination show highest mom growth in Jan2014--

with cte as (SELECT year(Date) as y1,month([Date])as m1, CONCAT([Card Type],'+',[Exp Type]) as concatcol
,sum(Amount) as amt from [Practice Db].[dbo].['Credit card transactions - Indi$']
group by CONCAT([Card Type],'+',[Exp Type]),year(Date),month([Date]) )

select aa.*,round(((aa.amt-aa.lastmonth)/nullif(aa.lastmonth,0)),2)*100 as momperc from 
(select y1,m1,concatcol,amt, LAG(amt,1,0) over (partition by concatcol order by y1,m1 asc) as lastmonth from cte)aa 
 where aa.y1=2014 and aa.m1=1 order by 6 desc

----Q6. During weekends which city has highest total spend to total no of transaction ratio

select year(Date) as Years,month([Date]) as Months,DATENAME(WEEKDAY,date) as Daynames,city
,( sum([Amount])/ count(*)) as ratio from [Practice Db].[dbo].['Credit card transactions - Indi$']
group by year(Date),month([Date]),DATENAME(WEEKDAY,date),city ORDER BY 5 DESC

----Q7. Which city took least no of days to reach its 500th transaction after the 1st transaction in that city

with m as (select *,ROW_NUMBER() over(partition by city  order by date asc) as rn from 
[Practice Db].[dbo].['Credit card transactions - Indi$']),

t as (select * from m where rn=1)

,n as (select * from m where rn=500)

select top 1 t.city,t.date,n.date,DATEDIFF(day,t.date,n.date) as diff 
from n inner join t on n.City=t.City
order by DATEDIFF(day,t.date,n.date) asc