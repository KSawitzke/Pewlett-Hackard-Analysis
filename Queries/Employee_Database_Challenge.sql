-- DELIVERABLE 1

-- Create retirement_titles table from retirement eligible employees + title
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
-- INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
	ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (r.emp_no) r.emp_no,
	r.first_name,
	r.last_name,
	r.title
-- INTO unique_titles
FROM retirement_titles as r
WHERE r.to_date = ('9999-01-01')
ORDER BY r.emp_no, r.to_date DESC;
-- Note the alias for retirement_titles isn't required here

-- Count total number of retiring by title
SELECT COUNT(title), title
-- INTO retiring_titles
FROM unique_titles
GROUP BY(title)
ORDER BY COUNT(title) DESC

-- DELIVERABLE 2

-- Create the mentorship eligibility table
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	d.from_date,
	d.to_date,
	t.title
-- INTO mentorship_eligibility
FROM employees as e
	INNER JOIN dept_emp as d
		ON (e.emp_no = d.emp_no)
	INNER JOIN titles as t
		ON (e.emp_no = t.emp_no)
WHERE (d.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no