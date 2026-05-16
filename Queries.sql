CREATE TABLE netflix
(
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);

select * from netflix;

select count(*) from netflix;

-- clean date added
alter table netflix
add column added_date Date;

update netflix
set added_date = to_date(date_added,'Month dd, YYYY')
where date_added is not null;

select date_added, added_date
from netflix
limit 10;

-- Data quality check
SELECT 
    COUNT(*) AS total_rows,
    COUNT(director) AS director_not_null,
    COUNT(country) AS country_not_null,
    COUNT(date_added) AS date_added_not_null
FROM netflix;

-- Standardize duration
ALTER TABLE netflix
ADD COLUMN duration_int INT;

UPDATE netflix
SET duration_int = SPLIT_PART(duration, ' ', 1)::INT
WHERE duration IS NOT NULL;

SELECT duration, duration_int
FROM netflix
LIMIT 10;

-- Separate tv shows and movies
SELECT type, COUNT(*)
FROM netflix
GROUP BY type;

-- Analyze movies
SELECT 
    MIN(duration_int) AS shortest_movie,
    MAX(duration_int) AS longest_movie,
    ROUND(AVG(duration_int), 2) AS avg_movie_duration
FROM netflix
WHERE type = 'Movie';

-- Check for outliers in movies
SELECT title, duration_int
FROM netflix
WHERE type = 'Movie'
AND (duration_int < 30 OR duration_int > 240)
ORDER BY duration_int;

-- Analyze TV shows
SELECT 
    MIN(duration_int) AS min_seasons,
    MAX(duration_int) AS max_seasons,
    ROUND(AVG(duration_int), 2) AS avg_seasons
FROM netflix
WHERE type = 'TV Show';

-- Check season distribution pattern
SELECT 
    duration_int AS number_of_seasons,
    COUNT(*) AS total_shows
FROM netflix
WHERE type = 'TV Show'
GROUP BY duration_int
ORDER BY number_of_seasons;

-- Top 5 longest running shows
SELECT 
    title,
    duration_int AS seasons,
    RANK() OVER (ORDER BY duration_int DESC) AS season_rank
FROM netflix
WHERE type = 'TV Show'
ORDER BY season_rank
LIMIT 5;

-- Top 5 Countries with the Most Content on Netflix
select country,count(*) as content_count
from netflix
where country is not null and  country <>''
group by country
order by content_count desc
limit 5;

-- Analyze business trend
SELECT 
    release_year,
    COUNT(*) AS total_titles
FROM netflix
GROUP BY release_year
ORDER BY release_year;

-- YoY growth %
WITH yearly_content AS (
    SELECT 
        release_year,
        COUNT(*) AS total_titles
    FROM netflix
    GROUP BY release_year
)
SELECT 
    release_year,
    total_titles,
    ROUND(
        (total_titles - LAG(total_titles) OVER (ORDER BY release_year)) * 100.0 
        / NULLIF(LAG(total_titles) OVER (ORDER BY release_year), 0),
        2
    ) AS yoy_growth_percent
FROM yearly_content
ORDER BY release_year;

-- Analyze platform strategy
SELECT 
    EXTRACT(YEAR FROM added_date) AS year_added,
    COUNT(*) AS titles_added
FROM netflix
WHERE added_date IS NOT NULL
GROUP BY year_added
ORDER BY year_added;

-- Movies vs tv shows per year added
SELECT 
    EXTRACT(YEAR FROM added_date) AS year_added,
    type,
    COUNT(*) AS total_titles
FROM netflix
WHERE added_date IS NOT NULL
GROUP BY year_added, type
ORDER BY year_added, type;

-- % Contribution of Movies vs TV Shows
SELECT 
    type,
    COUNT(*) AS total_titles,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage_share
FROM netflix
GROUP BY type;




