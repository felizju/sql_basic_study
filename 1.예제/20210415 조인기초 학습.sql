

-- SELECT 작성 순서
    -- SELECT [DISTINCT] { 열이름 .... } 
    -- FROM  테이블 또는 뷰 이름
    -- JOIN  테이블 또는 뷰 이름
    -- ON    조인 조건
    -- WHERE 조회 조건
    -- GROUP BY  열을 그룹화
    -- HAVING    그룹화 조건
    -- ORDER BY  정렬할 열 [ASC | DESC];


-- JOIN 기초    
SELECT
    emp_no, emp_nm, A.dept_cd, dept_nm
FROM tb_emp A, tb_dept B
WHERE A.dept_cd = B.dept_cd;


SELECT
    dept_cd, dept_nm
FROM tb_dept;


-- 자격증 정보 테이블
SELECT * FROM tb_certi;
-- 회원이 취득한 자격증 정보 테이블
SELECT * FROM tb_emp_certi;


-- 사원번호, 사원명, 취득자격증 코드번호
SELECT * FROM tb_emp;
SELECT * FROM tb_emp_certi;
SELECT * FROM tb_certi;


SELECT 
    A.emp_no, A.emp_nm, D.dept_nm, B.acqu_de, B.certi_cd, C.certi_nm
FROM tb_emp A , tb_emp_certi B, tb_certi C, tb_dept D
WHERE A.emp_no = B.emp_no
AND B.certi_cd = C.certi_cd
AND A.dept_cd = D.dept_cd;



-- ## INNER JOIN
-- 1. 2개 이상의 테이블이 공통된 컬럼에 의해 논리적으로 결합되는 조인기법
-- 2. WHERE절에 사용된 컬럼들이 동등연산자(=)에 의해 조인됨

SELECT
    E.emp_no, E.emp_nm, E.addr, E.dept_cd, D.dept_nm
FROM tb_emp E, tb_dept D
WHERE E.dept_cd = D.dept_cd
AND E.addr LIKE '%용인%'
ORDER BY E.emp_no;


-- ## NATURAL JOIN
-- 1. 동일한 이름을 갖는 컬럼에 대해 자동 조인하는 기법
-- 2. 즉, 자동으로 2개 이상의 테이블에서 같은 이름을 가진 컬럼을 찾아 INNER 조인을 수행함
-- 3. 이 때 조인되는 동일 이름의 컬럼은 데이터 타입이 같아야 하며, ALIAS나 테이블명을 붙일 수 없음
-- 4. SELECT * 문법을 사용하면, 공통 컬럼으로 자동 조인하며, 결과집합에서 한번만 표기됨

SELECT 
    E.emp_no, E.emp_nm, E.addr, dept_cd, D.dept_nm -- dept_cd에는 테이블 별칭을 붙이지 않아야함 (같은 이름 자동 조인)
FROM tb_emp E NATURAL JOIN tb_dept D;

SELECT 
    *
FROM tb_emp E NATURAL JOIN tb_dept D;



-- ## USING절 JOIN
-- 1. NATURAL JOIN에서는 자동으로 이름이 일치하는 모든 컬럼에 대해 조인이 일어나지만, USING을 사용하면 원하는 컬럼에 대해서만 선택적으로 조인이 가능함
-- 2. USING절에서도 조인 컬럼에 대해 ALIAS나 테이블명을 붙일 수 없음

SELECT
    E.emp_no, E.emp_nm, E.addr, dept_cd, D.dept_nm
FROM tb_emp E JOIN tb_dept D USING (dept_cd);



-- ## JOIN ON절
-- 1. 조인 조건 서술부(ON절)와 일반 조건 서술부(WHERE절)을 분리해서 작성하는 방법
-- 2. ON절을 사용하면 JOIN이후에 논리 연산이나 서브쿼리와 같은 추가 서술을 할 수 있음

SELECT
    E.emp_no, E.emp_nm, E.addr, E.dept_cd, D.dept_nm
FROM tb_emp E 
JOIN tb_dept D -- JOIN 앞에 (INNER)생략
ON E.dept_cd = D.dept_cd
WHERE E.addr LIKE '%용인%'
ORDER BY E.emp_no;





