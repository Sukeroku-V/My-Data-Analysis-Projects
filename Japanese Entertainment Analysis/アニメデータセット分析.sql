SELECT *
FROM anime

--Most Common Genre
WITH GenreCounts AS (
    SELECT TRIM(value) AS genre
    FROM anime
    CROSS APPLY STRING_SPLIT(genre, ',')
)
SELECT TOP 4 genre, COUNT(*) AS count
FROM GenreCounts
GROUP BY genre
ORDER BY count DESC;

--Most Common Type
SELECT TOP 3 type, COUNT(*) AS count
FROM anime
GROUP BY type
ORDER BY count DESC;

--Longest Anime
SELECT TOP 10 name, CAST(episodes AS INT) AS episodes
FROM anime
WHERE episodes IS NOT NULL AND episodes != 'Unknown'
ORDER BY episodes DESC;

--Most Popular Anime
SELECT TOP 10 name, members
FROM anime
ORDER BY members DESC;

--TOP 10 highest rated anime
SELECT TOP 5 name, rating
FROM anime
WHERE rating IS NOT NULL
ORDER BY rating DESC;


