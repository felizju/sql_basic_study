
-- # ��������
-- ## ������ ��������

-- �����ȣ�� 1000000005 ���� ����� ���� �μ��� ��� �������
SELECT 
    emp_no, emp_nm, dept_cd
FROM tb_emp
WHERE dept_cd = (
                SELECT dept_cd
                FROM tb_emp
                WHERE emp_no = '1000000005'
);

-- 2020�� 5�� 25�Ͽ� ���� �޿��� ȸ�� 20200525 ��ü ��� �޿����� ���� ������� ���� ��ȸ
SELECT
    A.emp_no, A.emp_nm, B.pay_de, B.pay_amt
FROM tb_emp A
JOIN tb_sal_his B
ON A.emp_no = B.emp_no
WHERE B.pay_de = '20200525'
AND B.pay_amt >= (
                SELECT AVG(pay_amt)
                FROM tb_sal_his
                WHERE pay_de = '20200525'
);


-- ## ���� �� ��������
-- �������� ��ȸ �Ǽ��� ���� ���� ��
-- ������ ������ : in any, exists

-- �ѱ������ͺ��̽���������� �߱��� �ڰ����� ������ �ִ� �����ȣ�� ���� �ڰ��� ������ ��ȸ
SELECT
    A.emp_no, B.emp_nm, COUNT(A.certi_cd)
FROM tb_emp_certi A
JOIN tb_emp B
ON A.emp_no = B.emp_no
WHERE A.certi_cd IN (SELECT
                     A.certi_cd
                    FROM tb_certi
                    WHERE issue_insti_nm = '�ѱ������ͺ��̽������') -- IN(10001,10002,10003,10004,10005)�� ���� / �Ѱ� Ȥ�� �ټ� / ��Ī �ֱ�
GROUP BY A.emp_no, B.emp_nm
ORDER BY A.emp_no;

-- ## ���� �÷� ��������
-- �μ����� 2�� �̻��� �μ� �߿��� �� �μ��� ���� ���� ���� ����� ������ ��ȸ

SELECT
    A.emp_no, A.emp_nm, B.dept_cd, B.dept_nm, A.birth_de
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
WHERE (A.dept_cd, A.birth_de) IN (
                                    SELECT 
                                        E.dept_cd, MIN(E.birth_de)
                                    FROM tb_emp E
                                    GROUP BY E.dept_cd
                                    HAVING COUNT(*) >= 2
                                    -- ORDER BY�� ���������� �ۼ��� �� ����
                                )
ORDER BY A.emp_no; -- ORDER BY ���������� �ۼ�

-- ���ǿ� �´� ����� �ִ��� ����
-- �ǹ̾��� �����ͷ� ��ȸ 'A' or 1
SELECT
    'A'
FROM tb_emp
WHERE addr LIKE '%����%';

-- �ּҰ� ������ �������� �μ������� ��ȸ *****
SELECT
    A.dept_cd, A.dept_nm
FROM tb_dept A
WHERE EXISTS (
                SELECT 1
                FROM tb_emp K
                WHERE K.addr LIKE '%����%'
                AND A.dept_cd = K.dept_cd
                -- �� ���������� �ƴ� ���������� ���� �Ŵ���..?
                -- ������ �� �� �Ǵ��� �𸣰�...��....
            )
;

-- ## ��Į�� �������� (SELECT���� ���� ��������)
SELECT
    A.emp_no, A.emp_nm, A.dept_cd,
    (SELECT B.dept_nm FROM tb_dept B WHERE A.dept_cd = B.dept_cd) AS dept_nm
FROM tb_emp A
;

-- �ѱ������ͺ��̽���������� �߱��� �ڰ����� ���� �ִ� ����� ������ ��ȸ
SELECT
    A.emp_no,
    (SELECT B.emp_nm FROM tb_emp B WHERE A.emp_no = B.emp_no) AS emp_nm,
    A.certi_cd,
    (SELECT C.certi_nm FROM tb_certi C WHERE A.certi_cd = C.certi_cd) AS certi_nm
FROM tb_emp_certi A
WHERE A.certi_cd IN (
                    SELECT certi_cd
                    FROM tb_certi
                    WHERE issue_insti_nm = '�ѱ������ͺ��̽������'
                    )
;

-- # �ζ��� �� (FROM ���� ����ϴ� ��������)
SELECT *
FROM(
        SELECT ROWNUM rn, emp_no, emp_nm, addr
        FROM tb_emp
        WHERE ROWNUM <= 10
        ) A
WHERE A.addr LIKE '%����%'
--WHERE rn > 0 -- ����¡����
;

-- ## ������ �������� ������
-- 1. IN: ����� ����� ������ Ȯ��
-- 2. ANY, SOME: ���� ���������� ���� ���ϵ� �� ��ϰ� ���ϴµ� �ϳ��� �����ϸ� ��.
-- 3. ALL: ���� ���������� ���� ���ϵ� �� ��ϰ� ���ϴµ� ��� ���� �����ؾ� ��.
-- 4. EXISTS: ����� �����ϴ� ���� �����ϴ����� ���θ� Ȯ��

-- IN�����ڿ� =ANY �����ڴ� ������

SELECT
    emp_nm, addr, dept_cd
FROM tb_emp
WHERE dept_cd = ANY (
                    SELECT dept_cd
                    FROM tb_emp
                    WHERE emp_nm = '�̰���'
                )
;


















































