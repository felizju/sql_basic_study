
-- DML : ������ ���۾�
-- SELECT, INSERT, DELETE, UPDATE
-- ������ �߰�
INSERT INTO
    board (bno, title, content, writer, reg_date)
VALUES
    (1, '����', '���볻��', '�迬��', SYSDATE);
    
COMMIT;

SELECT * FROM board;


INSERT INTO
    board (bno, content, writer, reg_date)
VALUES
    (2, '����2����2', '�Ѹ�', SYSDATE);
    
    
INSERT INTO
    board (bno, title, writer, reg_date)
VALUES
    (2, '����', '�Ѹ�', SYSDATE);
    
    
COMMIT;

SELECT * FROM board;

INSERT INTO
    board
VALUES
    (3, '����', '���볻�볻��', '�Ѹ�', SYSDATE);
    
    
-- PK�� �ߺ��� �����͸� ������ �� ����.
INSERT INTO
    board (bno, title, writer, reg_date)
VALUES
    (4, '����', '��浿', SYSDATE);    
    

-- ������ ����
UPDATE board
SET writer = '������'
WHERE bno = 3;

COMMIT;

UPDATE board
SET writer = '�����',
    content = '��ο� �¹���'
WHERE bno = 3;


SELECT * FROM board;

-- UPDATE������ WHERE ���� ������ ���
-- ��� ����Ǳ� ������ �����ؾ���.
UPDATE board
SET title ='�޷�';

COMMIT;

SELECT * FROM board;

-- ������ ����
DELETE FROM board
WHERE bno=4;


-- ��ü ������ ����
-- 1. WHERE���� ������ DELETE�� (ROLLBACK ���� / ���̺� ���� ���� �ȵ� /  �����͸� ����)
    -- ������ ������. ROLLBACK ������!!!!!
    DELETE FROM board;
    ROLLBACK;
    
-- 2. TRUNCATE DDL�� ����� ��� (ROLLBACK �Ұ��� / ���̺� ���� ���� �ȵ� /  �����͸� ����)
    -- FK ���� ����
    ALTER TABLE REPLY 
    DROP CONSTRAINT fk_reply_bno;
    
    TRUNCATE TABLE board;
    ROLLBACK;
    
-- 3. DROP TABLE DDL�� ����� ��� (ROLLBACK �Ұ��� / ���̺� ���� ��ü�� ����)
    DROP TABLE board;
    ROLLBACK;

SELECT * FROM board;



