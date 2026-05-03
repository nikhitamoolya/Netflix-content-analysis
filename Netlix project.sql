CREATE DATABASE netflix_db;
USE netflix_db;
CREATE TABLE netflix (
    duration_minutes INT,
    duration_seasons INT,
    type VARCHAR(20),
    title TEXT,
    date_added DATE,
    release_year INT,
    rating VARCHAR(20),
    description TEXT,
    show_id VARCHAR(20),
    content_age INT,
    content_type_flag INT,
    year_added INT,
    month_added INT
);

SELECT * FROM netflix LIMIT 10;

#Q.1. Movies vs TV Shows count
SELECT type, COUNT(*) AS total_count
FROM netflix
GROUP BY type;

#Q.2. Total number of titles
SELECT COUNT(*) AS total_titles
FROM netflix;

#Q.3.Unique ratings available
SELECT DISTINCT rating
FROM netflix;

#Q.4 Titles released after 2015
SELECT title, release_year
FROM netflix
WHERE release_year > 2015;

#Q.5 Count of content per rating
SELECT rating, COUNT(*) AS total
FROM netflix
GROUP BY rating
ORDER BY total DESC;

#Q.6 Top 5 years with most content
SELECT release_year, COUNT(*) AS total
FROM netflix
GROUP BY release_year
ORDER BY total DESC
LIMIT 5;

#Q.7 Average movie duration
SELECT AVG(duration_minutes) AS avg_duration
FROM netflix
WHERE type = 'Movie';

#Q.8 TV Shows with more than 3 seasons
SELECT title, duration_seasons
FROM netflix
WHERE duration_seasons > 3;

#Q.9 Content added each year
SELECT year_added, COUNT(*) AS total
FROM netflix
GROUP BY year_added
ORDER BY year_added;

#Q.10 Most recent content added
SELECT title, date_added
FROM netflix
ORDER BY date_added DESC
LIMIT 10;

#Q.11 Percentage of Movies vs TV Shows
SELECT 
    type,
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM netflix) AS percentage
FROM netflix
GROUP BY type;

#Q.12 Top 3 ratings per type 
SELECT type, rating, total FROM (
    SELECT 
        type, 
        rating, 
        COUNT(*) AS total,
        RANK() OVER (PARTITION BY type ORDER BY COUNT(*) DESC) AS rnk
    FROM netflix
    GROUP BY type, rating
) t
WHERE rnk <= 3;

# Q.13 Oldest and newest content
SELECT 
    MIN(release_year) AS oldest,
    MAX(release_year) AS newest
FROM netflix;

#Q.14 Content age distribution
SELECT content_age, COUNT(*) AS total
FROM netflix
GROUP BY content_age
ORDER BY content_age;

#Q.15 Monthly trend of content addition
SELECT month_added, COUNT(*) AS total
FROM netflix
GROUP BY month_added
ORDER BY month_added;


