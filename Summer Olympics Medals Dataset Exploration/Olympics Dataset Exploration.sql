--Who has won the most gold medals?
SELECT TOP 1 Name, count(*) as Total_Gold
FROM olympics_dataset
WHERE Medal = 'Gold'
GROUP BY Name
ORDER BY Total_Gold desc;

--Athletes who have won he most medals medals 
SELECT TOP 1 Name, Sport, count(*) AS Total_Medals
FROM olympics_dataset
GROUP BY Name, Sport
ORDER BY Total_Medals desc
;

--Atheletes who have never won a gold but won other medals
SELECT Name, Medal
FROM olympics_dataset
WHERE Medal IN ('Silver', 'Bronze')
AND Name NOT IN (
    SELECT Name FROM olympics_dataset WHERE Medal = 'Gold'
);


--Athletes who have participated in the last 3 Olympics in the dataset
SELECT Name, COUNT(DISTINCT event) AS total_events
FROM olympics_dataset
GROUP BY Name
HAVING COUNT(DISTINCT event) >= 3;


--top 3 athletes with the most medals for each Olympic year
WITH RankedAthletes AS (
    SELECT year, name,
           RANK() OVER (PARTITION BY year ORDER BY total_medals DESC) AS rank
    FROM (
        SELECT year, name, COUNT(*) AS total_medals
        FROM olympics_dataset
        GROUP BY year, name
    ) AS athlete_medals
)
SELECT year, name, rank
FROM RankedAthletes
WHERE rank <= 3;

--the running total of medals won by each athlete, ordered by year and event
SELECT athlete_id, year, event_id, 
       SUM(COUNT(*)) OVER (PARTITION BY athlete_id ORDER BY year, event_id) AS running_total
FROM olympics_dataset
GROUP BY name, year, event;

--the average number of medals won by athletes who participated in at least two Olympic events
SELECT AVG(total_medals) AS avg_medals
FROM (
    SELECT name, COUNT(DISTINCT event) AS total_events, COUNT(*) AS total_medals
    FROM olympics_dataset
    GROUP BY name
    HAVING COUNT(DISTINCT event) >= 2
) AS athletes_with_two_events;

--the top 3 Olympic years with the highest total number of medals awarded
SELECT TOP 3 year, COUNT(*) AS total_medals
FROM olympics_dataset
GROUP BY year
ORDER BY total_medals DESC;

--The Olympic year where the least number of gold medals were awarded
SELECT TOP 1 year
FROM olympics_dataset
WHERE medal = 'Gold'
GROUP BY year
ORDER BY COUNT(*) ASC;

--top 3 athletes who won the most medals overall, calculating their average medals per Olympic year, and for each of these athletes, displaying the year in which they won their maximum number of medals
WITH total_medals_per_athlete AS (
    -- 1: Calculate the total number of medals for each athlete
    SELECT name, COUNT(*) AS total_medals
    FROM olympics_dataset
    GROUP BY name
),
top_3_athletes AS (
    -- 2: Get the top 3 athletes with the most medals
    SELECT TOP 3 name, total_medals
    FROM total_medals_per_athlete
    ORDER BY total_medals DESC
),
athlete_medals_per_year AS (
    -- 3: Calculate the number of medals each athlete won per year
    SELECT name, year, COUNT(*) AS medals_per_year
    FROM olympics_dataset
    WHERE name IN (SELECT name FROM top_3_athletes)
    GROUP BY name, year
),
max_medals_per_year AS (
    -- 4: Find the year in which each top athlete won the maximum medals
    SELECT name, year, medals_per_year,
           RANK() OVER (PARTITION BY name ORDER BY medals_per_year DESC) AS year_rank
    FROM athlete_medals_per_year
),
average_medals_per_year AS (
    -- 5: Calculate the average number of medals each top athlete won per year
    SELECT name, AVG(medals_per_year) AS avg_medals_per_year
    FROM athlete_medals_per_year
    GROUP BY name
)
-- Final Query: Combine all results
SELECT t3.name, 
       t3.total_medals,
       a.avg_medals_per_year, 
       m.year AS max_medals_year, 
       m.medals_per_year AS max_medals
FROM top_3_athletes t3
JOIN average_medals_per_year a ON t3.name = a.name
JOIN max_medals_per_year m ON t3.name = m.name
WHERE m.year_rank = 1
ORDER BY t3.total_medals DESC;







