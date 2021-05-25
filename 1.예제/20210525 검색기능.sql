SELECT
    *
    FROM board
WHERE content LIKE '%2%'; -- ¹®ÀÚ¿­

    
SELECT
    board_no, writer, title, content, view_cnt
FROM
    (SELECT  /* +INDEX DESC(board pk_board) */
        rownum rn, board_no, writer, title, content, view_cnt
        FROM board
    WHERE 
        title LIKE '%20%' AND   -- (title : type, '%20%' : keyword)
        rownum <= 10) -- page * amount
WHERE rn > 0; -- page * amount
