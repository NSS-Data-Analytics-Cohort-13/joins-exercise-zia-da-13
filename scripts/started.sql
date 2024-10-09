select *
FRom revenue;
select *
FRom specs;

select *
FRom rating;

select *
FRom distributors;
-- 1. Give the name, release year, and worldwide gross of the lowest grossing movie?
SELECT  s.film_title,
        s.release_year,
		MIN(r.worldwide_gross)
		FROM specs AS s

		INNER JOIN revenue AS r

		ON s.movie_id = r.movie_id
	   GROUP BY s.film_title,s.release_year
		ORDER BY MIN(r.worldwide_gross) ASC
	
		LIMIT 1;

-- 2. What year has the highest average imdb rating?		

 SELECT s.release_year AS release_year,
        AVG(r.imdb_rating) AS average_imbd_rating
		FROM specs AS s
		INNER JOIN rating AS r
		on s.movie_id = r.movie_id
		GROUP BY release_year
		ORDER BY average_imbd_rating DESC
		LIMIT 1;

-- 3. What is the highest grossing G-rated movie? Which company distributed it?	

 SELECT specs.film_title,
        specs.mpaa_rating,
		distributors.company_name,
		revenue.worldwide_gross
		FROM specs
INNER JOIN distributors
On specs.domestic_distributor_id = distributors.distributor_id
INNER JOIN revenue
ON specs.movie_id = revenue.movie_id
WHERE specs.mpaa_rating = 'G' 
ORDER BY revenue.worldwide_gross DESC;

-- 4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies 
-- table. Your result set should include all of the distributors, whether or not they have any movies in the movies table?

		
 SELECT 
       d.company_name,
	  
	   COUNT(s.movie_id) AS movie_count 
FROM  distributors AS d   

	  LEFT JOIN specs AS s
	  ON d.distributor_id = s.domestic_distributor_id
	  
	  GROUP BY d.company_name;
-- 5. Write a query that returns the five distributors with the highest average movie budget?
 SELECT d.company_name ,
        AVG(r.film_budget) AS avg_budget
       
		FROM distributors AS d
		INNER JOIN specs AS s 
		ON d.distributor_id = s.domestic_distributor_id
		INNER JOIN revenue as r  
		ON r.movie_id = s.movie_id 
		
		GROUP BY d.company_name
		ORDER BY avg_budget 
		 
		LIMIT 5;
-- 6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?
		SELECT s.film_title,
		       d.company_name,
			   r.imdb_rating
			   FROM specs AS s
			   INNER JOIN distributors AS d
			   ON s.domestic_distributor_id= d.distributor_id
			   INNER JOIN rating AS r
			   USING (movie_id)
			   WHERE d.headquarters NOT LIKE '%CA'
			   ORDER BY r.imdb_rating DESC;
-- 7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?			   ORDER BY rating.imdb_rating DESC;

			   SELECT 
			   CASE 
			   WHEN  length_in_min < 120 THEN 'under_2_hours'
			   WHEN  length_in_min > 120 THEN 'over_2_hours'
			   END AS under_over_2_hours ,
			   ROUND (AVG(imdb_rating),2)
			   FROM specs 
			   INNER JOIN rating
			   ON specs.movie_id = rating.movie_id 
			   GROUP BY under_over_2_hours;