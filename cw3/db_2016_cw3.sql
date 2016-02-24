-- Q1 returns (first_name)
SELECT DISTINCT 
	SUBSTRING(name FROM 1 FOR position(' ' IN name) - 1) AS first_name
FROM 
	person
WHERE	name LIKE '% %'
UNION
SELECT DISTINCT 
	name
FROM	
	person
WHERE 	
	name NOT LIKE '% %'
ORDER BY
	first_name ASC;

-- Q2 returns (born_in,popularity)
SELECT 
	born_in,
	COUNT(born_in) AS popularity
FROM
	person
GROUP BY 
	born_in
ORDER BY	
	popularity DESC;

-- Q3 returns (house,seventeenth,eighteenth,nineteenth,twentieth)
SELECT
	house,
	COUNT(
		CASE 
			WHEN EXTRACT(year FROM accession) BETWEEN 1600 AND 1700
			THEN 1 
			ELSE 0 
		END) 
	AS seventeenth,
	(CASE
                WHEN EXTRACT(year FROM accession) BETWEEN 1700 AND 1800
                THEN 1
                ELSE 0
        END) AS eighteenth,
	(CASE
                WHEN EXTRACT(year FROM accession) BETWEEN 1800 AND 1900
                THEN 1
                ELSE 0
        END) AS nineteenth,
	(CASE
                WHEN EXTRACT(year FROM accession) BETWEEN 1900 AND 2000
                THEN 1
                ELSE 0
        END) AS twentieth
FROM	
	monarch 
WHERE	
	house IS NOT null
GROUP BY
	house, accession 
ORDER BY
        house ASC;


-- Q4 returns (name,age)

;

-- Q5 returns (father,child,born)

;

-- Q6 returns (monarch,prime_minister)

;

