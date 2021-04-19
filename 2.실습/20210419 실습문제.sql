
-- # ������ ���� �߰� ����

SELECT employee_id, first_name, manager_id
FROM employees;

SELECT 
    employee_id,
    LPAD(' ', 4*(LEVEL-1)) || first_name || ' ' || last_name AS "NAME",
    LEVEL -- LEVEL
FROM employees
START WITH manager_id IS NULL -- START WITH: ������
CONNECT BY PRIOR employee_id = manager_id -- CONNECT BY: PRIOR �ڽ�=�θ� (������)
ORDER SIBLINGS BY first_name ASC; -- ORDER SIBLINGS BY: ���������� ���� ����



-- # �ǽ�����
-- 1. employees ���̺��� �Ի���(hire_date)�� 04���̰ų� 
--    �μ���ȣ(department_id)�� 20���� ����� ������̵�(employee_id)�� �̸�(first_name)�� ��ȸ�ϼ���.
--    UNION�� ����� ��!
SELECT
    employee_id, first_name
FROM employees
WHERE hire_date BETWEEN '20040101' AND '20041231'
UNION
SELECT
    employee_id, first_name
FROM employees
WHERE department_id = '20';


-- 2. employees ���̺��� �Ի���(hire_date)�� 04���̰�
--    �μ���ȣ(department_id)�� 20���� ����� ������̵�(employee_id)�� �̸�(first_name)�� ��ȸ�ϼ���.
--    INTERSECT�� ����� ��!
SELECT
    employee_id, first_name
FROM employees
WHERE hire_date BETWEEN '20040101' AND '20041231'
INTERSECT
SELECT
    employee_id, first_name
FROM employees
WHERE department_id = '20';

-- 3. employees ���̺��� �Ի���(hire_date)�� 04�⿡ �Ի��Ͽ�����
--    �μ���ȣ(department_id)�� 20���� �ƴ� ����� ������̵�(employee_id)�� �̸�(first_name)�� ��ȸ�ϼ���.
--    MINUS�� ����� ��!
SELECT
    employee_id, first_name
FROM employees
WHERE hire_date BETWEEN '20040101' AND '20041231'
MINUS
SELECT
    employee_id, first_name
FROM employees
WHERE department_id = '20';
