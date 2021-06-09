
-- ÷������ �������� ������ ���̺�
CREATE TABLE file_upload (
    file_path VARCHAR2(250),
    board_no NUMBER(10)
);

-- PK, FK ����
ALTER TABLE file_upload
    ADD CONSTRAINT pk_file_upload PRIMARY KEY (file_path);
    
ALTER TABLE file_upload
    ADD CONSTRAINT fk_file_upload_board FOREIGN KEY (board_no) REFERENCES board(board_no)
    ON DELETE CASCADE;

COMMIT;