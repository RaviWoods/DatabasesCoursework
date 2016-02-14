-- Q1 returns (name,name,born_in)
SELECT		person_a.name, person_b.name, person_a.born_in
FROM		person AS person_c
JOIN		person AS person_a
ON		person_a.name = person_c.father
JOIN		person AS person_b
ON 		person_b.name = person_c.mother
AND		person_b.born_in = person_a.born_in;


-- Q2 returns (name)
SELECT	      name
FROM	      monarch
WHERE	      coronation IS null
ORDER BY      name;

-- Q3 returns (name,father,mother)

; 

-- Q4 returns (name)
SELECT		name
FROM   		monarch
UNION
SELECT		name
FROM		prime_minister
ORDER BY	name;

-- Q5 returns (name)

;

-- Q6 returns (house,name,accession)

SELECT 	      *
FROM   	      monarch AS first_monarch
WHERE	      accession<ALL (SELECT accession
	      		     FROM   monarch 
			     WHERE monarch.house = first_monarch.house
			     AND first_monarch.name <> monarch.name)
AND	      first_monarch.house IS NOT null;

