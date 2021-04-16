
-- OUTER JOIN �߰� ����
SELECT * FROM job_history ORDER BY employee_id; -- ���� ���� �̷�

-- ��� ��� ���� ��ȸ�� �ǵ� Ȥ�� ���� �����̷��� �ִٸ� �ش� ������ ���� ����ʹ�

-- ���� ���� �̷��� 1���̶� �ִ� ������� ��ȸ
SELECT
    E.employee_id, E.first_name, E.hire_date, E.job_id AS "current_job_id",
    j.start_date, j.end_date, j.job_id AS "last_job_id", j.department_id
FROM employees E
JOIN job_history J
ON E.employee_id = J.employee_id
ORDER BY J.employee_id
;

SELECT
    E.employee_id, E.first_name, E.hire_date, E.job_id AS "current_job_id",
    j.start_date, j.end_date, j.job_id AS "last_job_id", j.department_id
FROM employees E
LEFT OUTER JOIN job_history J
ON E.employee_id = J.employee_id
ORDER BY J.employee_id
;


-- �ǽ����� (JOIN)
-- 1. �����ȣ�� 103���� ����� �̸�(employee_name)�� �Ŵ��� �̸�(manager_name)�� ����ϼ���.
-- SELF JOIN
SELECT
    A.first_name AS "��� �̸�",
    B.first_name AS "�Ŵ��� �̸�"
FROM employees A
JOIN employees B
ON A.manager_id = B.employee_id
WHERE A.employee_id = '103'
ORDER BY A.employee_id
;

-- 2. ��� ����� first_name�� department_name, 
--    street_address + ',' + city + ',' + state_province�� address��� alias�� ��ȸ�ϼ���.
-- employees, departments, locations 3�� ����
SELECT
    A.first_name,
    B.department_name,
    C.street_address || ', ' || C.city || ', ' || C.state_province AS address
FROM employees A
JOIN departments B
ON A.department_id = B.department_id
JOIN locations C
ON B.location_id = C.location_id
;


-- 3. 103�� ����� first_name�� department_name, 
--    street_address + ',' + city + ',' + state_province�� address��� alias�� 
--    �����Ͽ� ��ȸ�ϼ���.
SELECT
    A.first_name,
    B.department_name,
    C.street_address || ',' || C.city || ',' || C.state_province AS address
FROM employees A
JOIN departments B
ON A.department_id = B.department_id
JOIN locations C
ON B.location_id = C.location_id
WHERE A.employee_id = '103'
;

-- 4. �μ� �̸��� IT�� �����ϴ� ����� first_name�� department_name, 
--    street_address + ',' + city + ',' + state_province�� address��� alias�� 
--    �����Ͽ� ��ȸ�ϼ���.
SELECT
    A.first_name,
    B.department_name,
    C.street_address || ',' || C.city || ',' || C.state_province AS address
FROM employees A
JOIN departments B
ON A.department_id = B.department_id
JOIN locations C
ON B.location_id = C.location_id
WHERE B.department_name LIKE 'IT%'
;

-- 5. jobs���̺��� ��� ���� id(job_id)�� ������(job_title)�� ��ȸ�ϴµ� 
--    ���� �������� �̷��� �ִٸ� �ش� �̷� ���� 
-- (start_date, end_date, job_id, employee_id, first_name, department_id, department_name)
--    �� �Բ� ��ȸ�ϼ���.
SELECT
    A.job_id, A.job_title,
    B.start_date, B.end_date, B.job_id, C.employee_id, C.first_name, C.department_id, D.department_name
FROM jobs A
LEFT OUTER JOIN job_history B
ON A.job_id = B.job_id
LEFT OUTER JOIN employees C
ON B.employee_id = C.employee_id
LEFT OUTER JOIN departments D
ON C.department_id = D.department_id
;





