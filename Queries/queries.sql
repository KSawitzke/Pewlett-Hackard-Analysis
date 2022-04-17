
-- Retirement Eligibility
SELECT COUNT(first_name) --, last_name, birth_date
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT first_name, last_name, birth_date
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

SELECT first_name, last_name, birth_date
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

SELECT first_name, last_name, birth_date
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info

--DROP TABLE retirement_info

-- Joining departments and dept_manager tables
SELECT d.dept_name,
	dm.emp_no,
	dm.from_date,
	dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;

-- Joining retirement_info and dept_emp tables
SELECT r.emp_no,
	r.first_name,
	r.last_name,
	d.to_date
INTO current_emp
FROM retirement_info as r
LEFT JOIN dept_emp as d
ON r.emp_no = d.emp_no
WHERE d.to_date = ('9999-01-01');

-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO emp_per_dept
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT * FROM salaries
ORDER BY to_date DESC;

SELECT e.emp_no,
    e.first_name,
	e.last_name,
    e.gender,
    s.salary,
    de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	AND (de.to_date = '9999-01-01');
	
SELECT m.dept_no,
	d.dept_name,
	m.emp_no,
	c.first_name,
	c.last_name,
	m.from_date,
	m.to_date
INTO manager_info
FROM dept_manager as m
INNER JOIN departments as d
	ON (m.dept_no = d.dept_no)
INNER JOIN current_emp as c
	ON (m.emp_no = c.emp_no);

SELECT c.emp_no,
	c.first_name,
	c.last_name,
	d.dept_name
-- INTO dept_info
FROM current_emp as c
INNER JOIN dept_emp as de
	ON (c.emp_no = de.emp_no)
INNER JOIN departments as d
	ON (de.dept_no = d.dept_no)
	
-- Skill drill - Only Sales employees
SELECT c.emp_no,
	c.first_name,
	c.last_name,
	d.dept_name
FROM current_emp as c
INNER JOIN dept_emp as de
	ON (c.emp_no = de.emp_no)
INNER JOIN departments as d
	ON (de.dept_no = d.dept_no)
WHERE (d.dept_name = 'Sales')

-- Skill drill - Sales and Development employees
SELECT c.emp_no,
	c.first_name,
	c.last_name,
	d.dept_name
FROM current_emp as c
INNER JOIN dept_emp as de
	ON (c.emp_no = de.emp_no)
INNER JOIN departments as d
	ON (de.dept_no = d.dept_no)
WHERE d.dept_name IN ('Sales','Development')
