-- 실습 종료 후 처리
DELETE FROM tb_dept 
WHERE dept_cd IN ('100014', '100015');

DELETE FROM tb_emp 
WHERE emp_no IN ('1000000041', '1000000042', '1000000043', '1000000044', '1000000045');

COMMIT;

ALTER TABLE tb_emp 
ADD CONSTRAINT fk_tb_emp01 
FOREIGN KEY (dept_cd) 
REFERENCES tb_dept (dept_cd);


-- 집합 연산자
-- ## UNION
-- 1. 합집합 연산의 의미
-- 2. 첫번째 쿼리와 두번째 쿼리의 중복 정보 한번만 보여줌
-- 3. 첫번째 쿼리 열의 개수와 타입 == 두번째 쿼리의 열수와 타입이 동일해야함.

SELECT
    emp_no, emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION
SELECT
    emp_no, emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19700101' AND '19791231';

-- 중복 정보 한번만 보여줌
SELECT
    emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION
SELECT
    emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19700101' AND '19791231';


-- ## UNION ALL
-- 1. UNION과 같이 두 테이블로 수직으로 합쳐서 보여줌
-- 2. UNION과 달리 중복된 데이터도 한번 더 보여줌
-- 3. 자동 정렬 기능을 지원하지 않아 성능상 유리함

SELECT
    emp_no, emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION ALL
SELECT
    emp_no, emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19700101' AND '19791231';

-- 중복 정보 모두 보여줌
SELECT
    emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19600101' AND '19691231'
UNION ALL
SELECT
    emp_nm, birth_de
FROM tb_emp
WHERE birth_de BETWEEN '19700101' AND '19791231';


-- ## INTERSECT
-- 1. 첫번재 쿼리와 두번째 쿼리에서 중복된 행만을 출력함
-- 2. 교집합의 의미

SELECT
    A.emp_no, A.emp_nm, A.addr,
    B.certi_cd, C.certi_nm
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
JOIN tb_certi C
ON B.certi_cd = C.certi_cd
WHERE C.certi_nm = 'SQLD'
INTERSECT
SELECT
    A.emp_no, A.emp_nm, A.addr,
    B.certi_cd, C.certi_nm
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
JOIN tb_certi C
ON B.certi_cd = C.certi_cd
WHERE A.addr LIKE '%용인%';

-- 조건 2개 걸면 같음
SELECT
    A.emp_no, A.emp_nm, A.addr,
    B.certi_cd, C.certi_nm
FROM tb_emp A
JOIN tb_emp_certi B
ON A.emp_no = B.emp_no
JOIN tb_certi C
ON B.certi_cd = C.certi_cd
WHERE C.certi_nm = 'SQLD'
    AND A.addr LIKE '%용인%';


-- ## EXCEPT/MINUS
-- 1. 두번째 쿼리에는 없고 첫번째 쿼리에만 있는 데이터 보여줌
-- 2. 차집합의 개념

SELECT 
    emp_no, emp_nm, sex_cd, dept_cd
FROM tb_emp
MINUS
SELECT 
    emp_no, emp_nm, sex_cd, dept_cd
FROM tb_emp
WHERE dept_cd = '100001'
MINUS
SELECT 
    emp_no, emp_nm, sex_cd, dept_cd
FROM tb_emp
WHERE dept_cd = '100003'
MINUS
SELECT 
    emp_no, emp_nm, sex_cd, dept_cd
FROM tb_emp
WHERE sex_cd = '1';

-- 계층형 질의
SELECT 
    LEVEL AS LVL,
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "조직인원",
    A.dept_cd,
    B.dept_nm,
    A.emp_no,
    A.direct_manager_emp_no,
    CONNECT_BY_ISLEAF -- 너.. 잎사귀야..?
--    CONNECT_BY_ISCYCLE
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
START WITH A.direct_manager_emp_no IS NULL -- 시작할 지점 : NULL값인 김회장부터
CONNECT BY PRIOR A.emp_no = A.direct_manager_emp_no; -- PRIOR가 자식쪽에 붙어있다면 순방향


SELECT 
    LEVEL AS LVL,
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "조직인원",
    A.dept_cd,
    B.dept_nm,
    A.emp_no,
    A.direct_manager_emp_no
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
START WITH A.direct_manager_emp_no = '1000000037' -- 시작할 지점 : 37번 김혜수부터
CONNECT BY A.emp_no = PRIOR A.direct_manager_emp_no; -- PRIOR가 부모쪽에 붙어있다면 역방향







