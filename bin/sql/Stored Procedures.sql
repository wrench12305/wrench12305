USE QUIZ;

DELIMITER // 

CREATE PROCEDURE SELECT_MC_QUESTION(QUESTION_ID_ARG INT UNSIGNED)
BEGIN
	SELECT * FROM QUESTION Q INNER JOIN QUESTION_ANSWER QA ON Q.QUESTION_ID = QA.QUESTION_ID INNER JOIN ANSWER A ON QA.ANSWER_ID = A.ANSWER_ID WHERE Q.QUESTION_ID=QUESTION_ID_ARG;
END //

DELIMITER ;