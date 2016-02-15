-- Q1 returns (name,name,born_in)
SELECT DISTINCT	
	person_a.name, 
	person_b.name, 
	person_a.born_in
FROM		
	person AS person_c
	JOIN	person AS person_a
		ON		person_a.name = person_c.father
	JOIN	person AS person_b
		ON 		person_b.name = person_c.mother
		AND		person_b.born_in = person_a.born_in;


-- Q2 returns (name)
SELECT	      
	name
FROM	      
	monarch
WHERE
	coronation IS null
	AND	  house IS NOT null
ORDER BY      
	name ASC;

-- Q3 returns (name,father,mother)
SELECT	
	person_c.name,person_b.name,person_a.name 
FROM	      
	person AS person_c
	JOIN	      
		person AS person_a
		ON	      
			(
				person_c.dod < person_a.dod
	      	OR
				(
					person_c.dod IS NOT null
				AND
					person_a.dod IS null
	      		)
			)
		AND	       
			person_c.mother = person_a.name
	JOIN	       
		person AS person_b
		ON	       
			(
				person_c.dod < person_b.dod	
			OR
				( 
			  		person_c.dod IS NOT null 
				AND 
					person_b.dod IS null
				)
			)
		AND 			
			person_c.father = person_b.name
ORDER BY		
	person_c.name ASC;

-- Q4 returns (name)
SELECT		
	name
FROM   		
	monarch
WHERE		
	house IS NOT null
UNION
SELECT		
	name
FROM		
	prime_minister
ORDER BY	
	name ASC;

-- Q5 returns (name)
SELECT	      
	name
FROM	      
	monarch AS abd_monarch 
	NATURAL JOIN person
WHERE
	(
		dod>SOME 
			(
			SELECT 
				accession
			FROM   
				monarch
			WHERE  
				abd_monarch.accession<monarch.accession
			)
	OR
		(
			dod IS null
		AND
			accession<SOME 
				(
				SELECT 
					accession
			    FROM 
			    	monarch
				)
		)
	) 
AND	      
	house IS NOT null
ORDER BY      
	name ASC;

-- Q6 returns (house,name,accession)
SELECT 	      
	house, name, accession
FROM   	      
	monarch AS first_monarch
WHERE
	accession<ALL 
		(
		SELECT 
			accession
		FROM   
			monarch 
		WHERE 
				monarch.house = first_monarch.house
			AND 
				first_monarch.name <> monarch.name
		)
	AND	      
		house IS NOT null
ORDER BY      
	accession ASC;
