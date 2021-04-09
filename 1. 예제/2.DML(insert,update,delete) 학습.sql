
-- DML : 데이터 조작어
-- SELECT, INSERT, DELETE, UPDATE
-- 데이터 추가
INSERT INTO
    board (bno, title, content, writer, reg_date)
VALUES
    (1, '하이', '내용내용', '김연주', SYSDATE);
    
COMMIT;

SELECT * FROM board;


INSERT INTO
    board (bno, content, writer, reg_date)
VALUES
    (2, '내용2내용2', '둘리', SYSDATE);
    
    
INSERT INTO
    board (bno, title, writer, reg_date)
VALUES
    (2, '제목', '둘리', SYSDATE);
    
    
COMMIT;

SELECT * FROM board;

INSERT INTO
    board
VALUES
    (3, '제목', '내용내용내용', '둘리', SYSDATE);
    
    
-- PK는 중복된 데이터를 저장할 수 없음.
INSERT INTO
    board (bno, title, writer, reg_date)
VALUES
    (4, '제목', '고길동', SYSDATE);    
    

-- 데이터 수정
UPDATE board
SET writer = '수정자'
WHERE bno = 3;

COMMIT;

UPDATE board
SET writer = '도우너',
    content = '헬로우 굿바이'
WHERE bno = 3;


SELECT * FROM board;

-- UPDATE절에서 WHERE 조건 생략될 경우
-- 모두 변경되기 때문에 조심해야함.
UPDATE board
SET title ='메롱';

COMMIT;

SELECT * FROM board;

-- 데이터 삭제
DELETE FROM board
WHERE bno=4;


-- 전체 데이터 삭제
-- 1. WHERE절을 생략한 DELETE절 (ROLLBACK 가능 / 테이블 구조 삭제 안됨 /  데이터만 삭제)
    -- 데이터 삭제됨. ROLLBACK 가능함!!!!!
    DELETE FROM board;
    ROLLBACK;
    
-- 2. TRUNCATE DDL을 사용한 방법 (ROLLBACK 불가능 / 테이블 구조 삭제 안됨 /  데이터만 삭제)
    -- FK 설정 해제
    ALTER TABLE REPLY 
    DROP CONSTRAINT fk_reply_bno;
    
    TRUNCATE TABLE board;
    ROLLBACK;
    
-- 3. DROP TABLE DDL을 사용한 방법 (ROLLBACK 불가능 / 테이블 구조 자체가 삭제)
    DROP TABLE board;
    ROLLBACK;

SELECT * FROM board;



