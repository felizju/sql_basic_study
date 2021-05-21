
select * from board;

-- amt : 한 페이지에 보여줄 게시물 수
-- page : 페이지 넘버

SELECT 
    board_no, writer, title, content
FROM (SELECT  /* +INDEX DESC(board pk_board) */
            rownum rn, board_no, writer, title, content
        FROM board 
        WHERE rownum <= 20) /* page*amt */
WHERE rn > 10 /*(page-1)*amt */
;
