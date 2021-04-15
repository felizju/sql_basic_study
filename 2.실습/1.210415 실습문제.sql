
SELECT * FROM employees;
SELECT * FROM departments;

-- # 실습 문제
-- 1. employees, departments테이블을 INNER JOIN해서
--    first_name, department_id, department_name을 조회하세요.

SELECT
    A.first_name, A.department_id, B.department_name
FROM employees A, departments B
WHERE A.department_id = B.department_id
ORDER BY 2 DESC
;

-- 2. employees, departments테이블을 NATURAL JOIN해서
--    first_name, department_id, department_name을 조회하세요.

SELECT
    A.first_name, department_id, B.department_name
FROM employees A NATURAL JOIN departments B
ORDER BY 2 DESC
;
    -- NATURAL JOIN 되는 조건이 department_id 뿐만 아니라 manager_id도 있기때문에 데이터가 맞지 않음
    -- USING 절을 사용해야함.
    
SELECT
    A.first_name, department_id, B.department_name
FROM employees A JOIN departments B USING(department_id)
ORDER BY 2 DESC
;

-- 3. employees, departments테이블을 JOIN ON을 사용해서
--    first_name, department_id, department_name을 조회하세요.

SELECT
    A.first_name, A.department_id, B.department_name
FROM employees A
JOIN departments B
ON A.department_id = B.department_id
ORDER BY 2 DESC
;


