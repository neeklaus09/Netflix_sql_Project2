DROP TABLE IF EXISTS netflix;
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


-- BASIC ANALYSIS

--Country-wise Total Netflix Titles

--Ques 1 Which countries produce the highest number of titles available on Netflix?
select
	trim(country_name)as country_name,
	count (*) as total_titles
from netflix,
	UNNEST(string_to_array(country, ',')) AS country_name
where country is not null
group by trim(country_name)
order by total_titles desc;

-- Insight:
-- This analysis identifies the countries that contribute the most content to Netflix's global catalog.
-- Countries like the United States and India usually dominate due to their large entertainment industries.


--Country Contribution by Release Year

--Ques 2 How many titles were released each year from different countries?

SELECT
    release_year,
    TRIM(country_name) AS country_name,
    COUNT(*) AS total_titles
FROM netflix
CROSS JOIN UNNEST(string_to_array(country, ',')) AS country_name
WHERE country IS NOT NULL
GROUP BY release_year, TRIM(country_name)
ORDER BY release_year, total_titles DESC;


-- Insight:
-- This query shows how content production from each country has evolved over time.
-- It helps identify growth trends in global Netflix content.


-- Top Content Producing Country Each Year
--ques 3 Which country produced the highest number of Netflix titles in each year?

WITH yearly_country_titles AS (
    SELECT
        release_year,
        TRIM(country_name) AS country,
        COUNT(*) AS total_titles
    FROM netflix,
    UNNEST(string_to_array(country, ',')) AS country_name
    WHERE country IS NOT NULL
    GROUP BY release_year, TRIM(country_name)
)

SELECT *
FROM (
    SELECT *,
           RANK() OVER(PARTITION BY release_year ORDER BY total_titles DESC) AS rank
    FROM yearly_country_titles
) ranked
WHERE rank = 1
ORDER BY release_year;

-- Insight:
-- This analysis identifies the dominant content producing country for each year in the Netflix catalog.
-- It helps understand how global content production leadership has shifted over time.


--Country-wise Movies vs TV Shows

--Ques 4 What is the distribution of Movies and TV Shows across different countries?

select
	trim(country_name) as country,
	type,
	count(*) as total_titles
from netflix,
	unnest(string_to_array(country,',')) as country_name
where country is not null
	and trim(country_name) <> ''
group by trim(country_name), type
order by country, total_titles desc;

-- Insight:
-- This query highlights the type of content different countries primarily produce.
-- Some countries focus heavily on movies while others produce more TV series.



-- Most Recent Release Year by Country
--Ques 5 What is the most recent release year of Netflix titles for each country?
SELECT
    TRIM(country_name) AS country,
    MAX(release_year) AS latest_release_year
FROM netflix
CROSS JOIN UNNEST(string_to_array(country, ',')) AS country_name
WHERE country IS NOT NULL
  AND TRIM(country_name) <> ''
GROUP BY TRIM(country_name)
ORDER BY latest_release_year DESC;

-- Insight:
-- This query identifies countries that have recently contributed content to Netflix.
-- It helps detect active content production regions.


-- Emerging Content Markets
--Ques6 Which countries have produced fewer than 40 titles but still have recent Netflix releases?

with country_summary as(
	select
		trim(country_name) as country,
		count(*) as total_titles,
		max(release_year) as latest_release_year
	from netflix,
	unnest(string_to_array(country,',')) as country_name
	where country is not null
		and trim(country_name) <> ''
	group by trim(country_name)
) 
select 
	country,
	total_titles,
	latest_release_year
from country_summary
where total_titles <40
order by latest_release_year desc;

-- Insight:
-- This analysis highlights emerging content markets where the total number of titles is relatively low but recent releases indicate growing participation.


--Ques7 Find the Most Common Rating for Movies and TV Shows

WITH RatingCounts AS (
    SELECT 
        type,
        rating,
        COUNT(*) AS rating_count
    FROM netflix
    GROUP BY type, rating
),
RankedRatings AS (
    SELECT 
        type,
        rating,
        rating_count,
        RANK() OVER (PARTITION BY type ORDER BY rating_count DESC) AS rank
    FROM RatingCounts
)
SELECT 
    type,
    rating AS most_frequent_rating
FROM RankedRatings
WHERE rank = 1;


--Insight
--The analysis shows that TV-MA is the dominant rating category on Netflix, indicating a strong focus on mature audience content.
--Both Movies and TV Shows on the platform largely cater to adult and young adult viewers, reflecting Netflix’s strategy of producing edgy and mature storytelling compared to traditional television platforms.



--Ques 8 What does the overall Netflix library look like at a glance?

SELECT
    COUNT(*) AS total_titles,
    COUNT(CASE WHEN type = 'Movie' THEN 1 END) AS total_movies,
    COUNT(CASE WHEN type = 'TV Show' THEN 1 END) AS total_tv_shows,
    ROUND(100.0 * COUNT(CASE WHEN type = 'Movie' THEN 1 END) / COUNT(*), 1) AS movie_share_percentage,
	ROUND(100.0 * COUNT(CASE WHEN type = 'TVShow' THEN 1 END) / COUNT(*), 1) AS movie_share_percentage,
    COUNT(DISTINCT TRIM(SPLIT_PART(country, ',', 1))) AS countries_represented,
    COUNT(DISTINCT director) AS unique_directors,
    MIN(release_year) AS oldest_title,
    MAX(release_year) AS newest_title
FROM netflix;

-- Insight:
-- This query provides a high-level snapshot of Netflix’s entire content library.
-- It helps stakeholders quickly understand the scale, diversity, and composition of the platform’s catalog.




-- Ques9 : Year-on-Year growth of Netflix content

WITH yearly_titles AS (
    SELECT
        release_year,
        COUNT(*) AS total_titles
    FROM netflix
    GROUP BY release_year
)

SELECT
    release_year,
    total_titles,
    LAG(total_titles) OVER (ORDER BY release_year) AS previous_year_titles,
    total_titles - LAG(total_titles) OVER (ORDER BY release_year) AS yearly_growth
FROM yearly_titles
ORDER BY release_year;

-- Insights:
--The results typically show a strong increase in content production after 2015, reflecting Netflix’s aggressive global expansion strategy and increased investment in original content

-- Genre Breakdown
-- Ques 10 : Which genres dominate the Netflix platform?

SELECT
    TRIM(UNNEST(string_to_array(listed_in, ','))) AS genre,
    COUNT(*) AS total_titles,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_library
FROM netflix
GROUP BY 1
ORDER BY total_titles DESC
LIMIT 15;

-- Insight:
-- International Movies and Dramas are the top two genres, reflecting Netflix's
-- heavy investment in global and original dramatic content.

-- Audience Rating Distribution

-- Ques 11 : What audience segments is Netflix primarily serving?

SELECT
    rating,
    CASE
        WHEN rating IN ('TV-Y', 'TV-Y7', 'G', 'TV-G') THEN 'Kids'
        WHEN rating IN ('PG', 'TV-PG', 'PG-13', 'TV-14') THEN 'Family / Teens'
        WHEN rating IN ('R', 'TV-MA', 'NC-17') THEN 'Adults Only'
        ELSE 'Unrated / Other'
    END  AS audience_segment,
    COUNT(*) AS total_titles,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 1)  AS pct_of_library
FROM netflix
WHERE rating IS NOT NULL
GROUP BY rating
ORDER BY total_titles DESC;

-- Insight:
-- TV-MA is the single largest rating (36% of library), meaning Netflix is
-- heavily adult-oriented. This could be a mismatch in family-focused markets.


-- Audience Mismatch by Country
-- Ques 12 : Are there countries where Netflix's adult content is too high
--           relative to what the local audience likely wants?

WITH country_ratings AS (
    SELECT
        TRIM(SPLIT_PART(country, ',', 1)) AS country,
        COUNT(*)  AS total,
        COUNT(CASE WHEN rating IN ('TV-Y','TV-Y7','G','TV-G') THEN 1 END) AS kids_titles,
        COUNT(CASE WHEN rating IN ('R','TV-MA','NC-17') THEN 1 END) AS adult_titles
    FROM netflix
    WHERE country IS NOT NULL
      AND rating  IS NOT NULL
    GROUP BY TRIM(SPLIT_PART(country, ',', 1))
    HAVING COUNT(*) >= 30
)
SELECT
    country,
    total,
    kids_titles,
    adult_titles,
    ROUND(100.0 * adult_titles / NULLIF(total, 0), 1)  AS adult_pct,
    ROUND(100.0 * kids_titles  / NULLIF(total, 0), 1)  AS kids_pct,
    CASE
        WHEN ROUND(100.0 * adult_titles / NULLIF(total, 0), 1) > 50
        THEN 'High Risk — Adult-heavy'
        WHEN ROUND(100.0 * kids_titles  / NULLIF(total, 0), 1) > 25
        THEN 'Family-friendly market'
        ELSE 'Balanced'
    END  AS audience_fit
FROM country_ratings
ORDER BY adult_pct DESC;

-- Insight:
-- Countries where adult content exceeds 50% of the library pose a churn risk if the subscriber base is family-oriented. 
--Netflix should commission more family/kids content in those markets to reduce cancellations.




-- Best Month to Release Content
-- Ques 13 : Which months does Netflix add the most content?
--           When should a new title be released for maximum visibility?

SELECT
    EXTRACT(MONTH FROM TO_DATE(date_added, 'Month DD, YYYY')) AS month_num,
    TO_CHAR(TO_DATE(date_added, 'Month DD, YYYY'), 'Month')  AS month_name,
    COUNT(*)  AS titles_added,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 1)  AS pct_of_annual,
    RANK() OVER (ORDER BY COUNT(*) DESC)  AS popularity_rank
FROM netflix
WHERE date_added IS NOT NULL
GROUP BY 1, 2
ORDER BY month_num;

-- Insight:
-- Months with the highest content additions see the most subscriber browsing.
-- Scheduling a major release in a peak month maximises organic discovery.

-- TV Show Season Strategy
-- Ques 14 : Are most Netflix TV shows cancelled after 1 season,
--           or does Netflix invest in multi-season stories?

SELECT
    CASE
        WHEN CAST(SPLIT_PART(duration,' ',1) AS INT) = 1 THEN '1 Season — One and done'
        WHEN CAST(SPLIT_PART(duration,' ',1) AS INT) = 2 THEN '2 Seasons — Given a second chance'
        WHEN CAST(SPLIT_PART(duration,' ',1) AS INT) BETWEEN 3 AND 4 THEN '3–4 Seasons — Established'
        WHEN CAST(SPLIT_PART(duration,' ',1) AS INT) BETWEEN 5 AND 6 THEN '5–6 Seasons — Long-running'
        ELSE '7+ Seasons — Rare survivor'
    END AS season_tier,
    COUNT(*) AS show_count,
    ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (),1) AS pct_of_shows
FROM netflix
WHERE type='TV Show'
AND duration IS NOT NULL
GROUP BY 1
ORDER BY show_count DESC;

-- Insight:
-- If the majority of shows have only 1 season, it confirms Netflix's pattern of fast cancellations. Multi-season shows cost more but build deeper loyalty.

-- Top Directors for Potential Partnerships

-- Ques15 Improved : Director Partnership Potential (Realistic Scoring)
WITH director_stats AS (
    SELECT
        director,
        COUNT(*) AS total_titles,
        COUNT(CASE WHEN type = 'Movie' THEN 1 END) AS movies,
        COUNT(CASE WHEN type = 'TV Show' THEN 1 END) AS tv_shows,
        MIN(release_year) AS first_release,
        MAX(release_year) AS latest_release,
        MAX(release_year) - MIN(release_year) AS career_span_yrs,
        COUNT(DISTINCT listed_in) AS genre_diversity,
        COUNT(DISTINCT country) AS country_reach
    FROM netflix
    WHERE director IS NOT NULL
    GROUP BY director
    HAVING COUNT(*) >= 3
),

director_scores AS (
    SELECT
        director,
        total_titles,
        movies,
        tv_shows,
        genre_diversity,
        country_reach,
        career_span_yrs,
        first_release,
        latest_release,
        (total_titles * 4)
        + (career_span_yrs * 2)
        + (genre_diversity * 2)
        + (country_reach * 1)
        + (tv_shows * 2) AS partnership_score
    FROM director_stats
)

SELECT
    RANK() OVER (ORDER BY partnership_score DESC) AS rank,
    director,
    total_titles,
    movies,
    tv_shows,
    genre_diversity,
    country_reach,
    career_span_yrs,
    first_release,
    latest_release,
    partnership_score
FROM director_scores
ORDER BY partnership_score DESC
LIMIT 20;

-- Content Investment Efficiency by Genre

-- Ques 16 : Which genres give Netflix the most titles per year of investment?
--           Where is the commissioning budget being used most efficiently?

WITH genre_rows AS (
    SELECT
        TRIM(UNNEST(string_to_array(listed_in, ','))) AS genre,
        EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY')) AS year_added
    FROM netflix
    WHERE date_added IS NOT NULL
),
genre_stats AS (
    SELECT
        genre,
        COUNT(*)AS total_titles,
        MIN(year_added)  AS first_year,
        MAX(year_added)  AS last_year,
        MAX(year_added) - MIN(year_added) + 1 AS years_active
    FROM genre_rows
    GROUP BY genre
    HAVING COUNT(*) >= 30
)
SELECT
    genre,
    total_titles,
    first_year,
    last_year,
    years_active,
    ROUND(1.0 * total_titles / years_active, 1)   AS titles_per_year,
    CASE
        WHEN ROUND(1.0 * total_titles / years_active, 1) >= 100 THEN 'Core Genre — High ROI'
        WHEN ROUND(1.0 * total_titles / years_active, 1) >= 50  THEN 'Growing — Worth Scaling'
        ELSE'Niche — Monitor'
    END AS investment_tier
FROM genre_stats
ORDER BY titles_per_year DESC;

-- Insight:
-- Genres with a high titles-per-year ratio are Netflix's bread and butter.
-- Low-efficiency genres either need more investment or are deliberate niche plays.





