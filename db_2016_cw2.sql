-- Q1 returns (name,name,born_in)
PRINT 'Q1';
SELECT		person_a.name, person_b.name, person_a.born_in
FROM		person AS person_c
JOIN		person AS person_a
ON		person_a.name = person_c.father
JOIN		person AS person_b
ON 		person_b.name = person_c.mother
AND		person_b.born_in = person_a.born_in;


-- Q2 returns (name)
PRINT 'Q2';
SELECT	      name
FROM	      monarch
WHERE	      coronation IS null;

-- Q3 returns (name,father,mother)

; 

-- Q4 returns (name)

;

-- Q5 returns (name)

;

-- Q6 returns (house,name,accession)

;

