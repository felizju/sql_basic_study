
-- # GROUP BY , HAVING ��
-- 1.�����Լ�
SELECT
    COUNT(emp_nm) AS "�� ��� ��",
    MAX(birth_de) AS "���� � ���",
    MIN(birth_de) AS "���� ���� ���� ���"
FROM tb_emp;

SELECT * FROM tb_emp;

-- COUNT(*)�� �����ϰ� NULL ����
SELECT
    COUNT(*),
    COUNT(direct_manager_emp_no)
FROM tb_emp;

SELECT * FROM tb_sal_his;

-- 2.GROUP BY
-- �μ����� ���� ������ �������, ���� �������� �������, �μ��� �� ������ ��ȸ
SELECT birth_de, dept_cd FROM tb_emp;

SELECT
    dept_cd,
    count(*) AS "�μ��� ���� ��",
    MAX(birth_de) AS "���� � ���",
    MIN(birth_de) AS "���� ���� ���� ���"
FROM tb_emp
GROUP BY dept_cd
ORDER BY dept_cd;


-- HAVING�� : �׷�ȭ�� ������� ������ �ɾ �� �� ����
SELECT
    A.dept_cd,
    (SELECT B.dept_nm FROM tb_dept B WHERE A.dept_cd = B.dept_cd) AS dept_nm,
    count(*) AS "�μ��� ���� ��",
    MAX(A.birth_de) AS "���� � ���",
    MIN(A.birth_de) AS "���� ���� ���� ���"
FROM tb_emp A
GROUP BY A.dept_cd
HAVING COUNT(*) > 1
ORDER BY A.dept_cd;


-- ������� �޿��� ���� ���� ���� �׼�, ���� ���� ���� �׼�, ��� �׼� ��ȸ
SELECT
    emp_no, pay_amt, pay_de
FROM tb_sal_his
ORDER BY emp_no, pay_de;


SELECT
    A.emp_no,
    (SELECT B.emp_nm FROM tb_emp B WHERE A.emp_no = B.emp_no) AS emp_nm,
    ROUND(AVG(A.pay_amt), 2) AS "��� �޿�",
    MAX(A.pay_amt) AS "�ְ� ���ɾ�",
    MIN(A.pay_amt) AS "���� ���ɾ�"
FROM tb_sal_his A
WHERE A.pay_de BETWEEN '20190101' AND '20191231' -- �׷�ȭ �ϱ� ���� ���� �ο�
GROUP BY A.emp_no
HAVING AVG(A.pay_amt) >= 4700000 -- �׷�ȭ �ϰ� �� �Ŀ� ���� �ο�
ORDER BY A.emp_no;

-- ����� 2019�� �����ȣ�� ����̸�, ������ ��ȸ
SELECT
    A.emp_no AS �����ȣ,
    (SELECT B.emp_nm FROM tb_emp B WHERE A.emp_no = B.emp_no) AS ����̸�,
    TO_CHAR(SUM(a.pay_amt), 'L999,999,999') AS "2019�� ����"
FROM tb_sal_his A
WHERE A.pay_de BETWEEN '20190101' AND '20191231'
GROUP BY A.emp_no
HAVING SUM(A.pay_amt) >= 50000000
ORDER BY A.emp_no;


-- ORDER BY : ����
-- ASC : �������� (�⺻�� ��������) , DESC : ��������
-- 1. �÷���, 2. �÷�����, 3. ��Ī
SELECT emp_no, emp_nm, addr
FROM tb_emp
ORDER BY emp_no DESC;

SELECT emp_no, emp_nm, addr
FROM tb_emp
ORDER BY emp_nm ASC; -- ASC ��������

SELECT emp_no, emp_nm, addr
FROM tb_emp
ORDER BY 1 DESC; -- �÷� ����

SELECT emp_no, emp_nm, addr
FROM tb_emp
ORDER BY emp_nm DESC, emp_no ASC; -- �̸����� �������� ���� ��, ���� �̸��� ���ؼ��� �ٽ� �����ȣ�� �������� ����

SELECT emp_no AS en, emp_nm AS em, addr
FROM tb_emp
ORDER BY em DESC; -- ��Ī���� ���� ����

