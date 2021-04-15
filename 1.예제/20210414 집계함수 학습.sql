
-- # GROUP BY , HAVING 절
-- 1.집계함수
SELECT
    COUNT(emp_nm) AS "총 사원 수",
    MAX(birth_de) AS "가장 어린 사원",
    MIN(birth_de) AS "가장 나이 많은 사원"
FROM tb_emp;

SELECT * FROM tb_emp;

-- COUNT(*)은 유일하게 NULL 포함
SELECT
    COUNT(*),
    COUNT(direct_manager_emp_no)
FROM tb_emp;

SELECT * FROM tb_sal_his;

-- 2.GROUP BY
-- 부서별로 가장 어린사람의 생년월일, 가장 연장자의 생년월일, 부서별 총 직원수 조회
SELECT birth_de, dept_cd FROM tb_emp;

SELECT
    dept_cd,
    count(*) AS "부서별 직원 수",
    MAX(birth_de) AS "가장 어린 사원",
    MIN(birth_de) AS "가장 나이 많은 사원"
FROM tb_emp
GROUP BY dept_cd
ORDER BY dept_cd;


-- HAVING절 : 그룹화된 결과에서 조건을 걸어서 행 수 제한
SELECT
    A.dept_cd,
    (SELECT B.dept_nm FROM tb_dept B WHERE A.dept_cd = B.dept_cd) AS dept_nm,
    count(*) AS "부서별 직원 수",
    MAX(A.birth_de) AS "가장 어린 사원",
    MIN(A.birth_de) AS "가장 나이 많은 사원"
FROM tb_emp A
GROUP BY A.dept_cd
HAVING COUNT(*) > 1
ORDER BY A.dept_cd;


-- 사원별로 급여를 제일 많이 받은 액수, 제일 적게 받은 액수, 평균 액수 조회
SELECT
    emp_no, pay_amt, pay_de
FROM tb_sal_his
ORDER BY emp_no, pay_de;


SELECT
    A.emp_no,
    (SELECT B.emp_nm FROM tb_emp B WHERE A.emp_no = B.emp_no) AS emp_nm,
    ROUND(AVG(A.pay_amt), 2) AS "평균 급여",
    MAX(A.pay_amt) AS "최고 수령액",
    MIN(A.pay_amt) AS "최저 수령액"
FROM tb_sal_his A
WHERE A.pay_de BETWEEN '20190101' AND '20191231' -- 그룹화 하기 전에 조건 부여
GROUP BY A.emp_no
HAVING AVG(A.pay_amt) >= 4700000 -- 그룹화 하고 난 후에 조건 부여
ORDER BY A.emp_no;

-- 사원별 2019년 사원번호와 사원이름, 연봉을 조회
SELECT
    A.emp_no AS 사원번호,
    (SELECT B.emp_nm FROM tb_emp B WHERE A.emp_no = B.emp_no) AS 사원이름,
    TO_CHAR(SUM(a.pay_amt), 'L999,999,999') AS "2019년 연봉"
FROM tb_sal_his A
WHERE A.pay_de BETWEEN '20190101' AND '20191231'
GROUP BY A.emp_no
HAVING SUM(A.pay_amt) >= 50000000
ORDER BY A.emp_no;


-- ORDER BY : 정렬
-- ASC : 오름차순 (기본값 생략가능) , DESC : 내림차순
-- 1. 컬럼명, 2. 컬럼순서, 3. 별칭
SELECT emp_no, emp_nm, addr
FROM tb_emp
ORDER BY emp_no DESC;

SELECT emp_no, emp_nm, addr
FROM tb_emp
ORDER BY emp_nm ASC; -- ASC 생략가능

SELECT emp_no, emp_nm, addr
FROM tb_emp
ORDER BY 1 DESC; -- 컬럼 순서

SELECT emp_no, emp_nm, addr
FROM tb_emp
ORDER BY emp_nm DESC, emp_no ASC; -- 이름으로 내림차순 정렬 후, 같은 이름에 대해서는 다시 사원번호로 오름차순 정렬

SELECT emp_no AS en, emp_nm AS em, addr
FROM tb_emp
ORDER BY em DESC; -- 별칭으로 정렬 가능

