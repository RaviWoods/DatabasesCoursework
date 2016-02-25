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
			ELSE NULL 
		END) 
	AS seventeenth,
	COUNT(
		CASE 
			WHEN EXTRACT(year FROM accession) BETWEEN 1700 AND 1800
			THEN 1
			ELSE NULL 
		END) 
	AS eighteenth,
	COUNT(
		CASE 
			WHEN EXTRACT(year FROM accession) BETWEEN 1800 AND 1900
			THEN 1
			ELSE NULL 
		END) 
	AS nineteenth,
	COUNT(
		CASE 
			WHEN (EXTRACT(year FROM accession) > '1900')
			THEN 1 
			ELSE NULL
		END) 
	AS twentieth
FROM	
	monarch 
WHERE	
	house IS NOT null
GROUP BY
	house 
ORDER BY
        house ASC;


-- Q4 returns (name,age)
SELECT 
	parent.name,
	MIN( EXTRACT(year FROM (child.dob - parent.dob)))
FROM 
	person AS parent 
	JOIN person AS child 
	ON 
		child.father = parent.name OR child.mother = parent.name
GROUP BY 
	parent.name
ORDER BY
	parent.name ASC;

-- Q5 returns (father,child,born)
SELECT 
	father.name AS father, 
	child.name AS child,
	CASE
		WHEN child.name IS NOT NULL
		THEN RANK() OVER 
			(PARTITION BY father.name ORDER BY child.dob DESC) 
		ELSE NULL
		END 
	AS born 
FROM 
	person AS father 
	LEFT JOIN person AS child 
	ON 
		father.name = child.father 
WHERE 
	father.gender = 'M' 
ORDER BY 
	father;


-- Q6 returns (monarch,prime_minister)
SELECT DISTINCT
	monarch.name AS monarch, 
	prime_minister.name AS prime_minister
FROM 
	monarch
	RIGHT JOIN prime_minister
	ON
		accession < entry
		AND
		entry < ALL(
			SELECT accession
			FROM monarch AS second_monarch
			WHERE second_monarch.accession > monarch.accession)
		AND 
		accession IS NOT NULL
ORDER BY 
	monarch ASC,
	prime_minister ASC;

`
