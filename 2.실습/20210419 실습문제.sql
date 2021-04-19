
-- # 계층형 쿼리 추가 예제

SELECT employee_id, first_name, manager_id
FROM employees;

SELECT 
    employee_id,
    LPAD(' ', 4*(LEVEL-1)) || first_name || ' ' || last_name AS "NAME",
    LEVEL -- LEVEL
FROM employees
START WITH manager_id IS NULL -- START WITH: 시작점
CONNECT BY PRIOR employee_id = manager_id -- CONNECT BY: PRIOR 자식=부모 (순방향)
ORDER SIBLINGS BY first_name ASC; -- ORDER SIBLINGS BY: 형제노드사이 정렬 설정



-- # 실습문제
-- 1. employees 테이블에서 입사일(hire_date)가 04년이거나 
--    부서번호(department_id)가 20번인 사람의 사원아이디(employee_id)와 이름(first_name)을 조회하세요.
--    UNION을 사용할 것!
SELECT
    employee_id, first_name
FROM employees
WHERE hire_date BETWEEN '20040101' AND '20041231'
UNION
SELECT
    employee_id, first_name
FROM employees
WHERE department_id = '20';


-- 2. employees 테이블에서 입사일(hire_date)가 04년이고
--    부서번호(department_id)가 20번인 사람의 사원아이디(employee_id)와 이름(first_name)을 조회하세요.
--    INTERSECT을 사용할 것!
SELECT
    employee_id, first_name
FROM employees
WHERE hire_date BETWEEN '20040101' AND '20041231'
INTERSECT
SELECT
    employee_id, first_name
FROM employees
WHERE department_id = '20';

-- 3. employees 테이블에서 입사일(hire_date)가 04년에 입사하였지만
--    부서번호(department_id)가 20번이 아닌 사람의 사원아이디(employee_id)와 이름(first_name)을 조회하세요.
--    MINUS을 사용할 것!
SELECT
    employee_id, first_name
FROM employees
WHERE hire_date BETWEEN '20040101' AND '20041231'
MINUS
SELECT
    employee_id, first_name
FROM employees
WHERE department_id = '20';
