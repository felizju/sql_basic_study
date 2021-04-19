
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








