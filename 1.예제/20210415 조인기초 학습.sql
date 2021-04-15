

-- SELECT �ۼ� ����
    -- SELECT [DISTINCT] { ���̸� .... } 
    -- FROM  ���̺� �Ǵ� �� �̸�
    -- JOIN  ���̺� �Ǵ� �� �̸�
    -- ON    ���� ����
    -- WHERE ��ȸ ����
    -- GROUP BY  ���� �׷�ȭ
    -- HAVING    �׷�ȭ ����
    -- ORDER BY  ������ �� [ASC | DESC];


-- JOIN ����    
SELECT
    emp_no, emp_nm, A.dept_cd, dept_nm
FROM tb_emp A, tb_dept B
WHERE A.dept_cd = B.dept_cd;


SELECT
    dept_cd, dept_nm
FROM tb_dept;


-- �ڰ��� ���� ���̺�
SELECT * FROM tb_certi;
-- ȸ���� ����� �ڰ��� ���� ���̺�
SELECT * FROM tb_emp_certi;


-- �����ȣ, �����, ����ڰ��� �ڵ��ȣ
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
-- 1. 2�� �̻��� ���̺��� ����� �÷��� ���� �������� ���յǴ� ���α��
-- 2. WHERE���� ���� �÷����� �������(=)�� ���� ���ε�

SELECT
    E.emp_no, E.emp_nm, E.addr, E.dept_cd, D.dept_nm
FROM tb_emp E, tb_dept D
WHERE E.dept_cd = D.dept_cd
AND E.addr LIKE '%����%'
ORDER BY E.emp_no;


-- ## NATURAL JOIN
-- 1. ������ �̸��� ���� �÷��� ���� �ڵ� �����ϴ� ���
-- 2. ��, �ڵ����� 2�� �̻��� ���̺��� ���� �̸��� ���� �÷��� ã�� INNER ������ ������
-- 3. �� �� ���εǴ� ���� �̸��� �÷��� ������ Ÿ���� ���ƾ� �ϸ�, ALIAS�� ���̺���� ���� �� ����
-- 4. SELECT * ������ ����ϸ�, ���� �÷����� �ڵ� �����ϸ�, ������տ��� �ѹ��� ǥ���

SELECT 
    E.emp_no, E.emp_nm, E.addr, dept_cd, D.dept_nm -- dept_cd���� ���̺� ��Ī�� ������ �ʾƾ��� (���� �̸� �ڵ� ����)
FROM tb_emp E NATURAL JOIN tb_dept D;

SELECT 
    *
FROM tb_emp E NATURAL JOIN tb_dept D;



-- ## USING�� JOIN
-- 1. NATURAL JOIN������ �ڵ����� �̸��� ��ġ�ϴ� ��� �÷��� ���� ������ �Ͼ����, USING�� ����ϸ� ���ϴ� �÷��� ���ؼ��� ���������� ������ ������
-- 2. USING�������� ���� �÷��� ���� ALIAS�� ���̺���� ���� �� ����

SELECT
    E.emp_no, E.emp_nm, E.addr, dept_cd, D.dept_nm
FROM tb_emp E JOIN tb_dept D USING (dept_cd);



-- ## JOIN ON��
-- 1. ���� ���� ������(ON��)�� �Ϲ� ���� ������(WHERE��)�� �и��ؼ� �ۼ��ϴ� ���
-- 2. ON���� ����ϸ� JOIN���Ŀ� �� �����̳� ���������� ���� �߰� ������ �� �� ����

SELECT
    E.emp_no, E.emp_nm, E.addr, E.dept_cd, D.dept_nm
FROM tb_emp E 
JOIN tb_dept D -- JOIN �տ� (INNER)����
ON E.dept_cd = D.dept_cd
WHERE E.addr LIKE '%����%'
ORDER BY E.emp_no;





