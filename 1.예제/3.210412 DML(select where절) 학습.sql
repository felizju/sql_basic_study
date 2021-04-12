
-- SELECT �⺻
SELECT 
    certi_cd,
    certi_nm
FROM tb_certi;


-- (*) ��� �� ��ȸ
SELECT 
    *
FROM tb_certi;


-- DISTINCT �ߺ� �� ���� ��ȸ
    -- SELECT (ALL) �����Ǿ�����
SELECT  ALL
    issue_insti_nm
FROM tb_certi;

SELECT  DISTINCT
    issue_insti_nm
FROM tb_certi;


-- ��Ī ����
    -- ALIAS (AS)
    -- ���� ������ "" ���� ����
SELECT
    certi_cd as "�ڰ����ڵ�",
    certi_nm as "�ڰ����̸�",
    issue_insti_nm as "�߱ޱ����"
FROM tb_certi;


-- ���տ�����(||)�� ���� �÷������� ����
SELECT
    certi_nm || '(' || certi_cd || ') - ' || issue_insti_nm AS "�ڰ��� ����"
FROM tb_certi;


-- ���� ���̺�(DUAL) : �ܼ� �������� ��ȸ�ϰ� ���� �� ���
SELECT
    (3+7)*5/10 AS "������"
FROM DUAL;


-- # WHERE�� : ��ȸ ��� ���� �����ϴ� ������
SELECT * FROM tb_emp;

SELECT
    emp_nm, addr, tel_no
FROM tb_emp
WHERE sex_cd = 2;


-- PK�� �����͸� ��ȸ�ϸ� ������ �������� ��ȸ��
SELECT
    emp_no, emp_nm, addr
FROM tb_emp
WHERE emp_no = 1000000001;


-- �񱳿����� (=, <> != , < , > , <= , >=)
-- SQL�񱳿����� (BETWEEN-AND, IN, LIKE, IS NULL)
SELECT
    emp_no, emp_nm, birth_de, tel_no
FROM tb_emp
WHERE birth_de >= '19900101' AND birth_de <= '19991231' ;

-- BETWEEN ������
SELECT
    emp_no, emp_nm, birth_de, tel_no
FROM tb_emp
WHERE birth_de BETWEEN 19900101 AND 19991231;

SELECT
    emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = '100001' OR dept_cd = '100006';

-- IN ������ 
SELECT
    emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd IN(100001, 100006);

-- NOT IN ������ 
SELECT
    emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd NOT IN(100001, 100006);

-- LIKE ������
    -- ���ϵ�ī�� ����   % : 1���� �̻�����
    --                 _ : �� 1���� ����
SELECT
    emp_no, emp_nm
FROM tb_emp
WHERE emp_nm LIKE '��%';

SELECT
    emp_no, emp_nm
FROM tb_emp
WHERE emp_nm LIKE '%��';

SELECT
    emp_no, emp_nm
FROM tb_emp
WHERE emp_nm LIKE '��__';


-- ������ �达�̸鼭 �μ��� 100003, 100004, 100006�� �߿� �ϳ��̸鼭, 90��� ���� ����� ���, �̸�, ����, �μ��ڵ� ��ȸ
SELECT
    emp_no, emp_nm, birth_de, dept_cd
FROM tb_emp
WHERE emp_nm LIKE '��%'
    AND dept_cd IN (100003, 100004, 100006)
    AND birth_de BETWEEN '19900101' AND '19991231';


-- NULL�� ��ȸ : IS NULL
SELECT
    emp_no, emp_nm, direct_manager_emp_no
FROM tb_emp
WHERE direct_manager_emp_no IS NULL; -- NULL�� IS�θ� �� ����


-- NULL �ƴ� �� ��ȸ : IS NOT NULL
SELECT
    emp_no, emp_nm, direct_manager_emp_no
FROM tb_emp
WHERE direct_manager_emp_no IS NOT NULL;

-- AND�� OR�� �켱����
SELECT
    emp_no, emp_nm, addr, dept_cd
FROM tb_emp
WHERE emp_nm LIKE '��%'
    AND dept_cd IN(100004, 100006)
    AND (addr LIKE '%����%' OR addr LIKE '%����%');

SELECT
    emp_no, emp_nm, addr, dept_cd
FROM tb_emp
WHERE emp_nm LIKE '��%'
    AND dept_cd IN(100004, 100006)
    AND NOT(addr LIKE '%����%' OR addr LIKE '%����%');

-- ���� �񱳿����� : NOT <> != ^=
SELECT
    emp_no, emp_nm, sex_cd, dept_cd
FROM tb_emp
WHERE emp_nm LIKE '��%'
    AND dept_cd IN(100004, 100006)
    AND sex_cd <> 1;












