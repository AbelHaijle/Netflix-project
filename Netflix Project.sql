--list the top 10 movies with the highest average rating

select top 10 TITLE, avg(IMDB_SCORE) as avg_rating
from ['Netflix Data$']
where IMDB_SCORE is not null 
group by TITLE
order by avg_rating desc

--calculate the percentage of movie that belong to each genre in the database

select GENRE, count(*) as movie_count,(count(*)*100.0)/(select count(*) from ['Netflix Data$']) as percentage
from ['Netflix Data$']
group by GENRE
order by Percentage desc
 
 --rank the movie and tv series on the basis of their imbd score

 select TITLE, IMDB_SCORE, rank() over (order by IMDB_SCORE desc) as Rnk
 from ['Netflix Data$']
 where IMDB_SCORE is not null

 --find which country have the highest & lowest movies make
 
 select PRODUCTION_COUNTRIES, max(tv_series_count) as max_tv_series_count, min(tv_series_count) as min_tv_series_count
 from(
 select PRODUCTION_COUNTRIES, count(*) as tv_series_count
 from ['Netflix Data$']
 group by PRODUCTION_COUNTRIES
 ) as tv_series_count

 --find the average rating for the movie that belongs to multiple genres

 select genre, avg(IMDB_SCORE) as avg_rating
 from ['Netflix Data$']
 where IMDB_SCORE is not null 
 group by genre
 order by avg_rating desc
 
 --categories the genre on the according to age_certification

 select case 
       when AGE_CERTIFICATION <= 'pg' then 'Children'
       when AGE_CERTIFICATION <= 'PG-13' then 'teen'
	   when AGE_CERTIFICATION in('R', 'TV-MA') then 'Adult'
	   else 'unknown'
	   end as Age_category, GENRE, count(*) as Genre_count
 from ['Netflix Data$']
 group by AGE_CERTIFICATION, genre

 --find the 2nd highest movie that are made in the year 2022

 select  TITLE, RELEASE_YEAR, IMDB_SCORE
 from ['Netflix Data$']
 where RELEASE_YEAR = '2022'
 order by IMDB_SCORE desc