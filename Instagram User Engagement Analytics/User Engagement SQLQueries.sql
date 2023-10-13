---Find the 5 oldest users of the Instagram from the database provided

select top 5 username from [dbo].[users] order by created_at asc

--- Find the users who have never posted a single photo on Instagram

SELECT u.id, u.username, Count(p.user_id) AS 'no._of_posts'
FROM [dbo].[users]  u  LEFT JOIN [dbo].[photos] p ON u.id = p.user_id
GROUP  BY u.id, u.username
HAVING Count(p.user_id) = 0

---Identify the winner of the contest and provide their details to the team
  
 SELECT id,username FROM users
WHERE  id =(select user_id FROM   photos WHERE  id = (SELECT top 1 photo_id FROM likes GROUP  BY photo_id
ORDER  BY Count(photo_id) DESC))

---Identify and suggest the top 5 most commonly used hashtags on the platform

SELECT t.tag_name, Count(t.tag_name) AS "tags count"
FROM   tags t INNER JOIN photo_tags ph ON t.id = ph.tag_id
GROUP  BY t.tag_name
ORDER  BY Count(t.tag_name) DESC

----What day of the week do most users register on? Provide insights on when to schedule an ad campaign

SELECT datename(WEEKDAY,created_at) 'day of week', Count(created_at) 'count of users registered'
FROM   users GROUP  BY datename(WEEKDAY,created_at)
ORDER  BY 2 DESC

--User Engagement: Are users still as active and post on Instagram or they are making fewer posts */
 			
WITH Average_posts_per_User AS (SELECT Count([id]) /  Count(DISTINCT[user_id]) AS Average_posts FROM photos) ,
 
Ratio AS (SELECT (SELECT Count(id) FROM photos) / (SELECT Count(id)
 FROM   users)  AS Ratio_of_Total_Posts_to_Total_Users)

SELECT case when (SELECT * FROM Ratio) < (SELECT * FROM Average_posts_per_User) then 'Not Active'
else 'Active' end as Status

---Bots & Fake Accounts: The investors want to know if the platform is crowded with fake and dummy accounts*/
SELECT id, username FROM   users
WHERE  id IN (SELECT user_id FROM  likes
GROUP  BY user_id HAVING Count(user_id) = (SELECT Count(id) FROM photos)); 
