-- List 1: Employee Information
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	ti.from_date,
	s.salary
INTO num_titles_retiring
FROM employees as e
	INNER JOIN titles as ti
		ON (e.emp_no = ti.emp_no)
	INNER JOIN salaries as s
		ON (e.emp_no = s.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31');
	
-- Only Most Recent Titles
SELECT emp_no, first_name, last_name, from_date, title
INTO num_titles_retiring_most_recent
FROM
	(SELECT ntr.emp_no, ntr.first_name, ntr.last_name, ntr.from_date, ntr.title, 
	 ROW_NUMBER() OVER 
	(PARTITION BY (ntr.first_name, ntr.last_name) ORDER BY ntr.from_date DESC) num
	FROM num_titles_retiring AS ntr
  ) tmp
WHERE num = 1;

-- The table above should have one entry per employee, keeping their most recent title.
-- From here, I need to get a table counting the titles.

-- Who's Ready for a Mentor?
