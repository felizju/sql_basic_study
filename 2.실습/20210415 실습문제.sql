
-- # 실습 문제
-- 1. employees, departments테이블을 INNER JOIN해서
--    first_name, department_id, department_name을 조회하세요.

SELECT
    A.first_name, A.department_id, B.department_name
FROM employees A, departments B
WHERE A.department_id = B.department_id
;

-- 2. employees, departments테이블을 NATURAL JOIN해서
--    first_name, department_id, department_name을 조회하세요.

SELECT
    A.first_name, department_id, B.department_name
FROM employees A NATURAL JOIN departments B
;


-- 3. employees, departments테이블을 JOIN ON을 사용해서
--    first_name, department_id, department_name을 조회하세요.

SELECT
    A.first_name, A.department_id, B.department_name
FROM employees A
JOIN departments B
ON A.department_id = B.department_id
;
