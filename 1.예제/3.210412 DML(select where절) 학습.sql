
-- SELECT 기본
SELECT 
    certi_cd,
    certi_nm
FROM tb_certi;


-- (*) 모든 열 조회
SELECT 
    *
FROM tb_certi;


-- DISTINCT 중복 값 제외 조회
    -- SELECT (ALL) 생략되어있음
SELECT  ALL
    issue_insti_nm
FROM tb_certi;

SELECT  DISTINCT
    issue_insti_nm
FROM tb_certi;


-- 별칭 지정
    -- ALIAS (AS)
    -- 띄어쓰기 없으면 "" 생략 가능
SELECT
    certi_cd as "자격증코드",
    certi_nm as "자격증이름",
    issue_insti_nm as "발급기관명"
FROM tb_certi;


-- 결합연산자(||)을 통한 컬럼데이터 결합
SELECT
    certi_nm || '(' || certi_cd || ') - ' || issue_insti_nm AS "자격증 정보"
FROM tb_certi;


-- 더미 테이블(DUAL) : 단순 연산결과를 조회하고 싶을 때 사용
SELECT
    (3+7)*5/10 AS "연산결과"
FROM DUAL;


-- # WHERE절 : 조회 결과 행을 제한하는 조건절
SELECT * FROM tb_emp;

SELECT
    emp_nm, addr, tel_no
FROM tb_emp
WHERE sex_cd = 2;


-- PK로 데이터를 조회하면 무조건 단일행이 조회됨
SELECT
    emp_no, emp_nm, addr
FROM tb_emp
WHERE emp_no = 1000000001;


-- 비교연산자 (=, <> != , < , > , <= , >=)
-- SQL비교연산자 (BETWEEN-AND, IN, LIKE, IS NULL)
SELECT
    emp_no, emp_nm, birth_de, tel_no
FROM tb_emp
WHERE birth_de >= '19900101' AND birth_de <= '19991231' ;

-- BETWEEN 연산자
SELECT
    emp_no, emp_nm, birth_de, tel_no
FROM tb_emp
WHERE birth_de BETWEEN 19900101 AND 19991231;

SELECT
    emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = '100001' OR dept_cd = '100006';

-- IN 연산자 
SELECT
    emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd IN(100001, 100006);

-- NOT IN 연산자 
SELECT
    emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd NOT IN(100001, 100006);

-- LIKE 연산자
    -- 와일드카드 매핑   % : 1글자 이상포함
    --                 _ : 딱 1글자 포함
SELECT
    emp_no, emp_nm
FROM tb_emp
WHERE emp_nm LIKE '이%';

SELECT
    emp_no, emp_nm
FROM tb_emp
WHERE emp_nm LIKE '%심';

SELECT
    emp_no, emp_nm
FROM tb_emp
WHERE emp_nm LIKE '이__';


-- 성씨가 김씨이면서 부서가 100003, 100004, 100006번 중에 하나이면서, 90년대 생인 사원의 사번, 이름, 생일, 부서코드 조회
SELECT
    emp_no, emp_nm, birth_de, dept_cd
FROM tb_emp
WHERE emp_nm LIKE '김%'
    AND dept_cd IN (100003, 100004, 100006)
    AND birth_de BETWEEN '19900101' AND '19991231';


-- NULL값 조회 : IS NULL
SELECT
    emp_no, emp_nm, direct_manager_emp_no
FROM tb_emp
WHERE direct_manager_emp_no IS NULL; -- NULL은 IS로만 비교 가능


-- NULL 아닌 값 조회 : IS NOT NULL
SELECT
    emp_no, emp_nm, direct_manager_emp_no
FROM tb_emp
WHERE direct_manager_emp_no IS NOT NULL;

-- AND와 OR의 우선순위
SELECT
    emp_no, emp_nm, addr, dept_cd
FROM tb_emp
WHERE emp_nm LIKE '이%'
    AND dept_cd IN(100004, 100006)
    AND (addr LIKE '%수원%' OR addr LIKE '%성남%');

SELECT
    emp_no, emp_nm, addr, dept_cd
FROM tb_emp
WHERE emp_nm LIKE '이%'
    AND dept_cd IN(100004, 100006)
    AND NOT(addr LIKE '%수원%' OR addr LIKE '%성남%');

-- 부정 비교연산자 : NOT <> != ^=
SELECT
    emp_no, emp_nm, sex_cd, dept_cd
FROM tb_emp
WHERE emp_nm LIKE '이%'
    AND dept_cd IN(100004, 100006)
    AND sex_cd <> 1;












