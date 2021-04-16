
-- OUTER JOIN 추가 예제
SELECT * FROM job_history ORDER BY employee_id; -- 직무 변동 이력

-- 모든 사원 정보 조회할 건데 혹시 직무 변동이력이 있다면 해당 내역도 같이 보고싶다

-- 직무 변동 이력이 1번이라도 있던 사원들을 조회
SELECT
    E.employee_id, E.first_name, E.hire_date, E.job_id AS "current_job_id",
    j.start_date, j.end_date, j.job_id AS "last_job_id", j.department_id
FROM employees E
JOIN job_history J
ON E.employee_id = J.employee_id
ORDER BY J.employee_id
;

SELECT
    E.employee_id, E.first_name, E.hire_date, E.job_id AS "current_job_id",
    j.start_date, j.end_date, j.job_id AS "last_job_id", j.department_id
FROM employees E
LEFT OUTER JOIN job_history J
ON E.employee_id = J.employee_id
ORDER BY J.employee_id
;


-- 실습문제 (JOIN)
-- 1. 사원번호가 103번인 사원의 이름(employee_name)과 매니저 이름(manager_name)을 출력하세요.
-- SELF JOIN
SELECT
    A.first_name AS "사원 이름",
    B.first_name AS "매니저 이름"
FROM employees A
JOIN employees B
ON A.manager_id = B.employee_id
WHERE A.employee_id = '103'
ORDER BY A.employee_id
;

-- 2. 모든 사원의 first_name과 department_name, 
--    street_address + ',' + city + ',' + state_province를 address라는 alias로 조회하세요.
-- employees, departments, locations 3개 조인
SELECT
    A.first_name,
    B.department_name,
    C.street_address || ', ' || C.city || ', ' || C.state_province AS address
FROM employees A
JOIN departments B
ON A.department_id = B.department_id
JOIN locations C
ON B.location_id = C.location_id
;


-- 3. 103번 사원의 first_name과 department_name, 
--    street_address + ',' + city + ',' + state_province를 address라는 alias로 
--    지정하여 조회하세요.
SELECT
    A.first_name,
    B.department_name,
    C.street_address || ',' || C.city || ',' || C.state_province AS address
FROM employees A
JOIN departments B
ON A.department_id = B.department_id
JOIN locations C
ON B.location_id = C.location_id
WHERE A.employee_id = '103'
;

-- 4. 부서 이름이 IT로 시작하는 사원의 first_name과 department_name, 
--    street_address + ',' + city + ',' + state_province를 address라는 alias로 
--    지정하여 조회하세요.
SELECT
    A.first_name,
    B.department_name,
    C.street_address || ',' || C.city || ',' || C.state_province AS address
FROM employees A
JOIN departments B
ON A.department_id = B.department_id
JOIN locations C
ON B.location_id = C.location_id
WHERE B.department_name LIKE 'IT%'
;

-- 5. jobs테이블에서 모든 직무 id(job_id)와 직무명(job_title)을 조회하는데 
--    만약 직무변동 이력이 있다면 해당 이력 정보 
-- (start_date, end_date, job_id, employee_id, first_name, department_id, department_name)
--    도 함께 조회하세요.
SELECT
    A.job_id, A.job_title,
    B.start_date, B.end_date, B.job_id, C.employee_id, C.first_name, C.department_id, D.department_name
FROM jobs A
LEFT OUTER JOIN job_history B
ON A.job_id = B.job_id
LEFT OUTER JOIN employees C
ON B.employee_id = C.employee_id
LEFT OUTER JOIN departments D
ON C.department_id = D.department_id
;





