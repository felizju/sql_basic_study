

-- 회원 테이블 users
CREATE TABLE users (
    user_id VARCHAR2(20) PRIMARY KEY, -- 아이디
    user_pw VARCHAR2(20) NOT NULL, -- 비밀번호
    user_email VARCHAR2(30) NOT NULL, -- 이메일
    user_nickname VARCHAR2(20) NOT NULL -- 닉네임
)

ALTER TABLE users ADD CONSTRAINT uni_user_nickname UNIQUE (user_nickname); -- 회원 닉네임 unique key 설정


-- 공지사항 테이블 notice
CREATE SEQUENCE notice_seq; -- 공지사항 seq

CREATE TABLE notice (
    notice_no NUMBER(5) PRIMARY KEY, -- 공지번호
    user_id VARCHAR2(20) NOT NULL, -- 아이디
    user_nickname VARCHAR2(20) NOT NULL, -- 닉네임
    notice_title VARCHAR2(100) NOT NULL, -- 공지제목
    notice_content VARCHAR2(2000) NOT NULL, -- 공지내용
    notice_date DATE DEFAULT SYSDATE, -- 작성일
    CONSTRAINT fk_notice_user_id FOREIGN KEY(user_id) REFERENCES users(user_id),
    CONSTRAINT fk_notice_user_nickname FOREIGN KEY(user_nickname) REFERENCES users(user_nickname)
)


-- 체크리스트 테이블 check_list
CREATE SEQUENCE check_list_seq; -- 체크리스트 seq

CREATE TABLE check_list(
    check_list_no NUMBER(5) PRIMARY KEY, -- 체크리스트 번호
    check_list_title VARCHAR2(100) NOT NULL, -- 체크리스트 제목
    check_list_content VARCHAR2(2000) NOT NULL, -- 체크리스트 내용
    check_list_date DATE DEFAULT SYSDATE, -- 체크리스트 작성일
    check_list_type VARCHAR2(10) NOT NULL, -- 체크리스트 타입
    user_id VARCHAR2(20), -- 아이디
    user_nickname VARCHAR2(20), -- 닉네임
    CONSTRAINT fk_check_list_user_id FOREIGN KEY(user_id) REFERENCES users(user_id),
    CONSTRAINT fk_check_list_user_nickname FOREIGN KEY(user_nickname) REFERENCES users(user_nickname)
)


-- 댓글 테이블 comments
CREATE SEQUENCE comments_seq; -- 댓글 seq

CREATE TABLE comments(
    comment_no NUMBER(5) PRIMARY KEY, -- 댓글 번호
    comment_content VARCHAR2(2000) NOT NULL, -- 댓글 내용
    comment_date DATE DEFAULT SYSDATE, -- 댓글 작성일
    check_list_no NUMBER(5), -- 체크리스트번호
    user_id VARCHAR2(20), -- 아이디
    user_nickname VARCHAR2(20), -- 닉네임
    CONSTRAINT fk_comment_check_list_no FOREIGN KEY(check_list_no) REFERENCES check_list(check_list_no),
    CONSTRAINT fk_comment_user_id FOREIGN KEY(user_id) REFERENCES users(user_id),
    CONSTRAINT fk_comment_user_nickname FOREIGN KEY(user_nickname) REFERENCES users(user_nickname)
)


-- 채팅룸 테이블 chat_room
CREATE SEQUENCE chat_room_seq; -- 채팅룸 seq

CREATE TABLE chat_room(
	 chat_room_no NUMBER(5) PRIMARY KEY, -- 채팅룸번호
	 chat_title VARCHAR2(100), -- 채팅룸명
	 chat_type NUMBER(1) NOT NULL, -- 채팅타입 (0 = 1:1채팅룸 / 1 = 그룹 채팅룸)
	 chat_cnt NUMBER(5) NOT NULL -- 총 인원수
)


-- 채팅멤버 테이블 chat_member
CREATE TABLE chat_member(
    chat_room_no NUMBER(5) NOT NULL, -- 채팅룸번호
    user_id VARCHAR2(20) NOT NULL, -- 아이디
    user_nickname VARCHAR2(20) NOT NULL, -- 닉네임
    chat_member_position NUMBER(1) DEFAULT 0 NOT NULL, -- 채팅멤버위치 (0 = 방에서 안나감 / 1 = 방에서 나감)
    CONSTRAINT fk_chat_member_chat_room_no FOREIGN KEY(chat_room_no) REFERENCES chat_room(chat_room_no),
    CONSTRAINT fk_chat_member_user_id FOREIGN KEY(user_id) REFERENCES users(user_id),
    CONSTRAINT fk_chat_member_user_nickname FOREIGN KEY(user_nickname) REFERENCES users(user_nickname)
)


-- 채팅내용 테이블 chat_content
CREATE SEQUENCE chat_content_seq; -- 채팅내용 seq

CREATE TABLE chat_content(
	 chat_content_no NUMBER(5) PRIMARY KEY, -- 메시지번호
     chat_room_no NUMBER(5) NOT NULL, -- 채팅룸번호
	 chat_content_msg VARCHAR2(2000) NOT NULL, -- 채팅내용 메시지
     user_id VARCHAR2(20) NOT NULL, -- 아이디
     user_nickname VARCHAR2(20) NOT NULL, -- 닉네임
	 chat_read_cnt NUMBER(5) NOT NULL, -- 현재 읽은 사람 수
     chat_content_date DATE DEFAULT SYSDATE, -- 작성일
     CONSTRAINT fk_chat_content_chat_room_no FOREIGN KEY(chat_room_no) REFERENCES chat_room(chat_room_no),
     CONSTRAINT fk_chat_content_user_id FOREIGN KEY(user_id) REFERENCES users(user_id),
     CONSTRAINT fk_chat_content_user_nickname FOREIGN KEY(user_nickname) REFERENCES users(user_nickname)
)


-- 메시지(채팅내용) 읽음 여부 테이블 chat_read
CREATE SEQUENCE chat_read_seq; -- 메시지(채팅내용) 읽음 여부 seq

CREATE TABLE chat_read(
	 chat_read_no number(5) PRIMARY KEY, -- 메시지읽음여부 번호
	 chat_content_no number(5) NOT NULL, -- 채팅내용 번호
     chat_room_no NUMBER(5) NOT NULL, -- 채팅룸 번호
     user_id VARCHAR2(20) NOT NULL, -- 아이디
     user_nickname VARCHAR2(20) NOT NULL, -- 닉네임
	 chat_read_type NUMBER(1)  DEFAULT 0 NOT NULL, -- 메시지 읽음 여부 (0 = 읽지않음 , 1 = 읽음)
     CONSTRAINT fk_chat_read_chat_content_no FOREIGN KEY(chat_content_no) REFERENCES chat_content(chat_content_no),
     CONSTRAINT fk_chat_read_chat_room_no FOREIGN KEY(chat_room_no) REFERENCES chat_room(chat_room_no),
     CONSTRAINT fk_chat_read_user_id FOREIGN KEY(user_id) REFERENCES users(user_id),
     CONSTRAINT fk_chat_read_user_nickname FOREIGN KEY(user_nickname) REFERENCES users(user_nickname)
)


-- 그룹 테이블 rt_group
CREATE SEQUENCE rt_group_seq; -- 그룹 seq

CREATE TABLE rt_group(
    rt_group_no NUMBER(5) PRIMARY KEY, -- 그룹 번호
    rt_group_name VARCHAR2(20) NOT NULL, -- 그룹명
    user_id VARCHAR2(20) NOT NULL, -- 아이디
    user_nickname VARCHAR2(20) NOT NULL, -- 닉네임
    CONSTRAINT fk_rt_group_user_id FOREIGN KEY(user_id) REFERENCES users(user_id),
    CONSTRAINT fk_rt_group_user_nickname FOREIGN KEY(user_nickname) REFERENCES users(user_nickname)
)



-- 알람 테이블 push_alarm
CREATE SEQUENCE push_alarm_seq; -- 알람 seq

CREATE TABLE push_alarm(
    push_alarm_no NUMBER(5) PRIMARY KEY, -- 알람 번호
    push_alarm_date DATE DEFAULT SYSDATE, -- 알람 일자
    push_alarm_category VARCHAR2(20) NOT NULL, -- 알람 카테고리
    push_alarm_read_type NUMBER(1) DEFAULT 0 NOT NULL, -- 알람 읽음 여부
    push_alarm_content VARCHAR2(1000) NOT NULL, -- 알람 내용 
    send_user_id VARCHAR2(20) NOT NULL, -- 보낸이 아이디
    send_user_nickname VARCHAR2(20) NOT NULL, -- 보낸이 닉네임
    receive_user_id VARCHAR2(20) NOT NULL, -- 받는이 아이디
    receive_user_nickname VARCHAR2(20) NOT NULL, -- 받는이 닉네임
    CONSTRAINT fk_push_alarm_send_id FOREIGN KEY(send_user_id) REFERENCES users(user_id),
    CONSTRAINT fk_push_alarm_send_nickname FOREIGN KEY(send_user_nickname) REFERENCES users(user_nickname),
    CONSTRAINT fk_push_alarm_receive_id FOREIGN KEY(receive_user_id) REFERENCES users(user_id),
    CONSTRAINT fk_push_alarm_receive_nickname FOREIGN KEY(receive_user_nickname) REFERENCES users(user_nickname)
)


-- 캘린더 테이블 calender
CREATE SEQUENCE calender_seq; -- 캘린더 seq

CREATE TABLE calender(
    calender_no NUMBER(5) PRIMARY KEY, -- 캘린더 번호
    calender_begin_date DATE, -- 시작일자
    calender_end_date DATE, -- 종료일자
    calender_title VARCHAR2(100) NOT NULL, -- 일정 제목
    calender_content VARCHAR2(2000), -- 일정 내용
    user_id VARCHAR2(20) NOT NULL, -- 아이디
    user_nickname VARCHAR2(20) NOT NULL, -- 닉네임
    CONSTRAINT fk_calender_user_id FOREIGN KEY(user_id) REFERENCES users(user_id),
    CONSTRAINT fk_calender_user_nickname FOREIGN KEY(user_nickname) REFERENCES users(user_nickname)
)


COMMIT;