
SELECT * FROM employees;
SELECT * FROM departments;

-- # �ǽ� ����
-- 1. employees, departments���̺��� INNER JOIN�ؼ�
--    first_name, department_id, department_name�� ��ȸ�ϼ���.

SELECT
    A.first_name, A.department_id, B.department_name
FROM employees A, departments B
WHERE A.department_id = B.department_id
ORDER BY 2 DESC
;

-- 2. employees, departments���̺��� NATURAL JOIN�ؼ�
--    first_name, department_id, department_name�� ��ȸ�ϼ���.

SELECT
    A.first_name, department_id, B.department_name
FROM employees A NATURAL JOIN departments B
ORDER BY 2 DESC
;
    -- NATURAL JOIN �Ǵ� ������ department_id �Ӹ� �ƴ϶� manager_id�� �ֱ⶧���� �����Ͱ� ���� ����
    -- USING ���� ����ؾ���.
    
SELECT
    A.first_name, department_id, B.department_name
FROM employees A JOIN departments B USING(department_id)
ORDER BY 2 DESC
;

-- 3. employees, departments���̺��� JOIN ON�� ����ؼ�
--    first_name, department_id, department_name�� ��ȸ�ϼ���.

SELECT
    A.first_name, A.department_id, B.department_name
FROM employees A
JOIN departments B
ON A.department_id = B.department_id
ORDER BY 2 DESC
;


