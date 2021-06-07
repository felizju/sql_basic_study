

-- ȸ�� ���̺� users
CREATE TABLE users (
    user_id VARCHAR2(20) PRIMARY KEY, -- ���̵�
    user_pw VARCHAR2(20) NOT NULL, -- ��й�ȣ
    user_email VARCHAR2(30) NOT NULL, -- �̸���
    user_nickname VARCHAR2(20) NOT NULL -- �г���
)

ALTER TABLE users ADD CONSTRAINT uni_user_nickname UNIQUE (user_nickname); -- ȸ�� �г��� unique key ����


-- �������� ���̺� notice
CREATE SEQUENCE notice_seq; -- �������� seq

CREATE TABLE notice (
    notice_no NUMBER(5) PRIMARY KEY, -- ������ȣ
    user_id VARCHAR2(20) NOT NULL, -- ���̵�
    user_nickname VARCHAR2(20) NOT NULL, -- �г���
    notice_title VARCHAR2(100) NOT NULL, -- ��������
    notice_content VARCHAR2(2000) NOT NULL, -- ��������
    notice_date DATE DEFAULT SYSDATE, -- �ۼ���
    CONSTRAINT fk_notice_user_id FOREIGN KEY(user_id) REFERENCES users(user_id),
    CONSTRAINT fk_notice_user_nickname FOREIGN KEY(user_nickname) REFERENCES users(user_nickname)
)


-- üũ����Ʈ ���̺� check_list
CREATE SEQUENCE check_list_seq; -- üũ����Ʈ seq

CREATE TABLE check_list(
    check_list_no NUMBER(5) PRIMARY KEY, -- üũ����Ʈ ��ȣ
    check_list_title VARCHAR2(100) NOT NULL, -- üũ����Ʈ ����
    check_list_content VARCHAR2(2000) NOT NULL, -- üũ����Ʈ ����
    check_list_date DATE DEFAULT SYSDATE, -- üũ����Ʈ �ۼ���
    check_list_type VARCHAR2(10) NOT NULL, -- üũ����Ʈ Ÿ��
    user_id VARCHAR2(20), -- ���̵�
    user_nickname VARCHAR2(20), -- �г���
    CONSTRAINT fk_check_list_user_id FOREIGN KEY(user_id) REFERENCES users(user_id),
    CONSTRAINT fk_check_list_user_nickname FOREIGN KEY(user_nickname) REFERENCES users(user_nickname)
)


-- ��� ���̺� comments
CREATE SEQUENCE comments_seq; -- ��� seq

CREATE TABLE comments(
    comment_no NUMBER(5) PRIMARY KEY, -- ��� ��ȣ
    comment_content VARCHAR2(2000) NOT NULL, -- ��� ����
    comment_date DATE DEFAULT SYSDATE, -- ��� �ۼ���
    check_list_no NUMBER(5), -- üũ����Ʈ��ȣ
    user_id VARCHAR2(20), -- ���̵�
    user_nickname VARCHAR2(20), -- �г���
    CONSTRAINT fk_comment_check_list_no FOREIGN KEY(check_list_no) REFERENCES check_list(check_list_no),
    CONSTRAINT fk_comment_user_id FOREIGN KEY(user_id) REFERENCES users(user_id),
    CONSTRAINT fk_comment_user_nickname FOREIGN KEY(user_nickname) REFERENCES users(user_nickname)
)


-- ä�÷� ���̺� chat_room
CREATE SEQUENCE chat_room_seq; -- ä�÷� seq

CREATE TABLE chat_room(
	 chat_room_no NUMBER(5) PRIMARY KEY, -- ä�÷��ȣ
	 chat_title VARCHAR2(100), -- ä�÷��
	 chat_type NUMBER(1) NOT NULL, -- ä��Ÿ�� (0 = 1:1ä�÷� / 1 = �׷� ä�÷�)
	 chat_cnt NUMBER(5) NOT NULL -- �� �ο���
)


-- ä�ø�� ���̺� chat_member
CREATE TABLE chat_member(
    chat_room_no NUMBER(5) NOT NULL, -- ä�÷��ȣ
    user_id VARCHAR2(20) NOT NULL, -- ���̵�
    user_nickname VARCHAR2(20) NOT NULL, -- �г���
    chat_member_position NUMBER(1) DEFAULT 0 NOT NULL, -- ä�ø����ġ (0 = �濡�� �ȳ��� / 1 = �濡�� ����)
    CONSTRAINT fk_chat_member_chat_room_no FOREIGN KEY(chat_room_no) REFERENCES chat_room(chat_room_no),
    CONSTRAINT fk_chat_member_user_id FOREIGN KEY(user_id) REFERENCES users(user_id),
    CONSTRAINT fk_chat_member_user_nickname FOREIGN KEY(user_nickname) REFERENCES users(user_nickname)
)


-- ä�ó��� ���̺� chat_content
CREATE SEQUENCE chat_content_seq; -- ä�ó��� seq

CREATE TABLE chat_content(
	 chat_content_no NUMBER(5) PRIMARY KEY, -- �޽�����ȣ
     chat_room_no NUMBER(5) NOT NULL, -- ä�÷��ȣ
	 chat_content_msg VARCHAR2(2000) NOT NULL, -- ä�ó��� �޽���
     user_id VARCHAR2(20) NOT NULL, -- ���̵�
     user_nickname VARCHAR2(20) NOT NULL, -- �г���
	 chat_read_cnt NUMBER(5) NOT NULL, -- ���� ���� ��� ��
     chat_content_date DATE DEFAULT SYSDATE, -- �ۼ���
     CONSTRAINT fk_chat_content_chat_room_no FOREIGN KEY(chat_room_no) REFERENCES chat_room(chat_room_no),
     CONSTRAINT fk_chat_content_user_id FOREIGN KEY(user_id) REFERENCES users(user_id),
     CONSTRAINT fk_chat_content_user_nickname FOREIGN KEY(user_nickname) REFERENCES users(user_nickname)
)


-- �޽���(ä�ó���) ���� ���� ���̺� chat_read
CREATE SEQUENCE chat_read_seq; -- �޽���(ä�ó���) ���� ���� seq

CREATE TABLE chat_read(
	 chat_read_no number(5) PRIMARY KEY, -- �޽����������� ��ȣ
	 chat_content_no number(5) NOT NULL, -- ä�ó��� ��ȣ
     chat_room_no NUMBER(5) NOT NULL, -- ä�÷� ��ȣ
     user_id VARCHAR2(20) NOT NULL, -- ���̵�
     user_nickname VARCHAR2(20) NOT NULL, -- �г���
	 chat_read_type NUMBER(1)  DEFAULT 0 NOT NULL, -- �޽��� ���� ���� (0 = �������� , 1 = ����)
     CONSTRAINT fk_chat_read_chat_content_no FOREIGN KEY(chat_content_no) REFERENCES chat_content(chat_content_no),
     CONSTRAINT fk_chat_read_chat_room_no FOREIGN KEY(chat_room_no) REFERENCES chat_room(chat_room_no),
     CONSTRAINT fk_chat_read_user_id FOREIGN KEY(user_id) REFERENCES users(user_id),
     CONSTRAINT fk_chat_read_user_nickname FOREIGN KEY(user_nickname) REFERENCES users(user_nickname)
)


-- �׷� ���̺� rt_group
CREATE SEQUENCE rt_group_seq; -- �׷� seq

CREATE TABLE rt_group(
    rt_group_no NUMBER(5) PRIMARY KEY, -- �׷� ��ȣ
    rt_group_name VARCHAR2(20) NOT NULL, -- �׷��
    user_id VARCHAR2(20) NOT NULL, -- ���̵�
    user_nickname VARCHAR2(20) NOT NULL, -- �г���
    CONSTRAINT fk_rt_group_user_id FOREIGN KEY(user_id) REFERENCES users(user_id),
    CONSTRAINT fk_rt_group_user_nickname FOREIGN KEY(user_nickname) REFERENCES users(user_nickname)
)



-- �˶� ���̺� push_alarm
CREATE SEQUENCE push_alarm_seq; -- �˶� seq

CREATE TABLE push_alarm(
    push_alarm_no NUMBER(5) PRIMARY KEY, -- �˶� ��ȣ
    push_alarm_date DATE DEFAULT SYSDATE, -- �˶� ����
    push_alarm_category VARCHAR2(20) NOT NULL, -- �˶� ī�װ�
    push_alarm_read_type NUMBER(1) DEFAULT 0 NOT NULL, -- �˶� ���� ����
    push_alarm_content VARCHAR2(1000) NOT NULL, -- �˶� ���� 
    send_user_id VARCHAR2(20) NOT NULL, -- ������ ���̵�
    send_user_nickname VARCHAR2(20) NOT NULL, -- ������ �г���
    receive_user_id VARCHAR2(20) NOT NULL, -- �޴��� ���̵�
    receive_user_nickname VARCHAR2(20) NOT NULL, -- �޴��� �г���
    CONSTRAINT fk_push_alarm_send_id FOREIGN KEY(send_user_id) REFERENCES users(user_id),
    CONSTRAINT fk_push_alarm_send_nickname FOREIGN KEY(send_user_nickname) REFERENCES users(user_nickname),
    CONSTRAINT fk_push_alarm_receive_id FOREIGN KEY(receive_user_id) REFERENCES users(user_id),
    CONSTRAINT fk_push_alarm_receive_nickname FOREIGN KEY(receive_user_nickname) REFERENCES users(user_nickname)
)


-- Ķ���� ���̺� calender
CREATE SEQUENCE calender_seq; -- Ķ���� seq

CREATE TABLE calender(
    calender_no NUMBER(5) PRIMARY KEY, -- Ķ���� ��ȣ
    calender_begin_date DATE, -- ��������
    calender_end_date DATE, -- ��������
    calender_title VARCHAR2(100) NOT NULL, -- ���� ����
    calender_content VARCHAR2(2000), -- ���� ����
    user_id VARCHAR2(20) NOT NULL, -- ���̵�
    user_nickname VARCHAR2(20) NOT NULL, -- �г���
    CONSTRAINT fk_calender_user_id FOREIGN KEY(user_id) REFERENCES users(user_id),
    CONSTRAINT fk_calender_user_nickname FOREIGN KEY(user_nickname) REFERENCES users(user_nickname)
)


COMMIT;