
select * from board;

-- amt : �� �������� ������ �Խù� ��
-- page : ������ �ѹ�

SELECT 
    board_no, writer, title, content
FROM (SELECT  /* +INDEX DESC(board pk_board) */
            rownum rn, board_no, writer, title, content
        FROM board 
        WHERE rownum <= 20) /* page*amt */
WHERE rn > 10 /*(page-1)*amt */
;
