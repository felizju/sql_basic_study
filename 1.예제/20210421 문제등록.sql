
-- 문제 98번

CREATE TABLE 회원_98 (
    회원ID VARCHAR2(255) PRIMARY KEY,
    회원명 VARCHAR2(255)
);

CREATE TABLE 메일발송_98 (
    이벤트ID VARCHAR2(255),
    회원ID VARCHAR2(255),
    발송일시 VARCHAR2(255)
);

CREATE TABLE 이벤트_98 (
    이벤트ID VARCHAR2(255) PRIMARY KEY,
    이벤트명 VARCHAR2(255),
    시작일자 VARCHAR2(255)
);

INSERT INTO 회원_98 VALUES ('aaa', '김철수');
INSERT INTO 회원_98 VALUES ('bbb', '박영희');
INSERT INTO 회원_98 VALUES ('ccc', '고길동');
INSERT INTO 회원_98 VALUES ('ddd', '김수희');

INSERT INTO 이벤트_98 VALUES ('001', '1주년이벤트', '20140901');
INSERT INTO 이벤트_98 VALUES ('002', '고객감사이벤트', '20141002');
INSERT INTO 이벤트_98 VALUES ('003', '커피쿠폰이벤트', '20141014');


INSERT INTO 메일발송_98 VALUES ('001', 'aaa', '20140902');
INSERT INTO 메일발송_98 VALUES ('001', 'bbb', '20140902');
INSERT INTO 메일발송_98 VALUES ('001', 'ccc', '20140902');
INSERT INTO 메일발송_98 VALUES ('002', 'aaa', '20141002');
INSERT INTO 메일발송_98 VALUES ('002', 'bbb', '20141002');
INSERT INTO 메일발송_98 VALUES ('002', 'ccc', '20141002');
INSERT INTO 메일발송_98 VALUES ('002', 'ddd', '20141002');
INSERT INTO 메일발송_98 VALUES ('003', 'aaa', '20141017');
INSERT INTO 메일발송_98 VALUES ('003', 'bbb', '20141017');
INSERT INTO 메일발송_98 VALUES ('003', 'ccc', '20141017');


SELECT 
    A.회원ID, A.회원명
FROM 회원_98 A
WHERE EXISTS (
                SELECT 'X' FROM 이벤트_98 B, 메일발송_98 C
                WHERE B.시작일자 >= '20141001' 
                    AND B.이벤트ID = C.이벤트ID 
                    AND A.회원ID = C.회원ID
                HAVING COUNT(*) < (SELECT COUNT(*) FROM 이벤트_98 WHERE 시작일자 >= '20141001')
            );
            
            
            
-- 문제 101번
CREATE TABLE 품질평가항목_101 (
    평가항목ID CHAR(7) PRIMARY KEY,
    평가항목명 VARCHAR2(50)
);

CREATE TABLE 평가대상상품_101 (
    상품ID CHAR(7) PRIMARY KEY,
    상품명 VARCHAR2(50)
);

CREATE TABLE 평가결과_101 (
    상품ID CHAR(7),
    평가회차 NUMBER,
    평가항목ID CHAR(7),
    평가등급 CHAR(1),
    평가일자 CHAR(8),
    CONSTRAINT 평가결과_101_PK PRIMARY KEY (상품ID, 평가회차, 평가항목ID)
);

INSERT INTO 품질평가항목_101 VALUES ('100001', '강의자료');
INSERT INTO 품질평가항목_101 VALUES ('100002', '강사설명');

INSERT INTO 평가대상상품_101 VALUES ('100001', '스프링프레임워크');
INSERT INTO 평가대상상품_101 VALUES ('100002', '자바스크립트');

INSERT INTO 평가결과_101 VALUES ('100001', 1, '100001', 'S', '20210317');
INSERT INTO 평가결과_101 VALUES ('100001', 2, '100001', 'A', '20210317');
INSERT INTO 평가결과_101 VALUES ('100001', 3, '100001', 'B', '20210317');
INSERT INTO 평가결과_101 VALUES ('100001', 1, '100002', 'B', '20210317');
INSERT INTO 평가결과_101 VALUES ('100001', 2, '100002', 'A', '20210317');

INSERT INTO 평가결과_101 VALUES ('100002', 1, '100001', 'S', '20210317');
INSERT INTO 평가결과_101 VALUES ('100002', 2, '100001', 'A', '20210317');
INSERT INTO 평가결과_101 VALUES ('100002', 3, '100001', 'B', '20210317');
INSERT INTO 평가결과_101 VALUES ('100002', 1, '100002', 'B', '20210317');
INSERT INTO 평가결과_101 VALUES ('100002', 2, '100002', 'A', '20210317');
INSERT INTO 평가결과_101 VALUES ('100002', 3, '100002', 'S', '20210317');
INSERT INTO 평가결과_101 VALUES ('100002', 4, '100002', 'C', '20210317');



SELECT * FROM 평가결과_101;
            
            
-- 1번 : 전체상품 중에 평가회차 수가 가장 높은 상품의 정보 조회
SELECT
    B.상품ID, B.상품명, C.평가항목ID, C.평가항목명,
    A.평가회차, A.평가등급, A.평가일자
FROM 평가결과_101 A, 평가대상상품_101 B, 품질평가항목_101 C
     --, (SELECT MAX(평가회차) AS 평가회차 FROM 평가결과_101) D
WHERE A.상품ID = B.상품ID
    AND A.평가항목ID = C.평가항목ID
    --AND A.평가회차 = D.평가회차
;

-- 2번 : 정답
SELECT
    B.상품ID, B.상품명, C.평가항목ID, C.평가항목명,
    A.평가회차, A.평가등급, A.평가일자
FROM 평가결과_101 A, 평가대상상품_101 B, 품질평가항목_101 C
WHERE A.상품ID = B.상품ID
    AND A.평가항목ID = C.평가항목ID
    AND A.평가회차 = (
                    SELECT MAX(X.평가회차) 
                    FROM 평가결과_101 X 
                    WHERE X.상품ID = B.상품ID
                        AND X.평가항목ID = C.평가항목ID
                    )
;

            
-- 3번 : 평가등급이 가장 높은회차의 등급이 나옴
SELECT
    B.상품ID, B.상품명, C.평가항목ID, C.평가항목명,
    MAX(A.평가회차) AS 평가회차, 
    MAX(A.평가등급) AS 평가등급,
    MAX(A.평가일자) AS 평가일자
FROM 평가결과_101 A, 평가대상상품_101 B, 품질평가항목_101 C
WHERE A.상품ID = B.상품ID
    AND A.평가항목ID = C.평가항목ID
GROUP BY B.상품ID, B.상품명, C.평가항목ID, C.평가항목명
;

-- 4번 : 평가등급이 가장 높은회차의 등급이 나옴
SELECT
   B.상품ID, B.상품명, C.평가항목ID, C.평가항목명,
    A.평가회차, A.평가등급, A.평가일자
FROM (
        SELECT  상품ID, 평가항목ID, 
                MAX(평가회차) AS 평가회차,
                MAX(평가등급) AS 평가등급, 
                MAX(평가일자) AS 평가일자
        FROM 평가결과_101 
        GROUP BY 상품ID, 평가항목ID
      ) A,
    평가대상상품_101 B, 품질평가항목_101 C
WHERE A.상품ID = B.상품ID
    AND A.평가항목ID = C.평가항목ID
;
            
            
            
            
            
            




            