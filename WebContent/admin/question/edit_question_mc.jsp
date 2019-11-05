<%@ page language="java" contentType="text/html;" pageEncoding="UTF-8"%>
<%@page import="java.io.*,java.util.*,java.sql.*"%>
<%@page import="javax.servlet.http.*,javax.servlet.*"%>
<%@page import="edu.albany.csi418.session.LoginEnum"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<!DOCTYPE html>
<html>

<head>
<meta content="text/html;" charset="UTF-8">
<title>Edit A Question</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/footer.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/question.css">
</head>

<body>
	<!-- Navbar -->
	<%@ include file = "../header.jsp" %>

	<!-- Content -->
	<div class="main-container">
		<div class="main shadow">
			<div class="form-container-question">
			
				<!-- Error Message (if set) -->
				<%
					if (request.getParameter("success") != null) {
						if (request.getParameter("success").equals("false")) {
							out.println("<div style=\"padding-bottom:15px; margin: 5px\" id=\"error\"><p>" + request.getParameter("error") + "</p></div>");
						}
					}
				%>
				
				<!-- Success Message (if set) -->
				<%
					if (request.getParameter("success") != null) {
						if (request.getParameter("success").equals("true")) {
							out.println("<div style=\"padding-bottom:15px; margin: 5px\" id=\"success\">Question Successfully Updated</div>");
						}
					}
				%>
				
				<!-- Form -->
				<sql:setDataSource var="snapshot" driver="com.mysql.cj.jdbc.Driver" url="<%=LoginEnum.hostname.getValue()%>" user="<%=LoginEnum.username.getValue()%>" password="<%=LoginEnum.password.getValue()%>" />
				<sql:query dataSource="${snapshot}" var="result"> SELECT * FROM QUESTION Q INNER JOIN QUESTION_ANSWER QA ON Q.QUESTION_ID = QA.QUESTION_ID INNER JOIN ANSWER A ON QA.ANSWER_ID = A.ANSWER_ID WHERE Q.QUESTION_ID=<%=request.getParameter("QUESTION_ID")%>; </sql:query>

				<form class="quiz-form" action="${pageContext.request.contextPath}/EditQuestionMC" method="post" enctype="multipart/form-data">

					<!-- Hidden input with ID# -->
					<input id="QUESTION_ID" type="hidden" name="QUESTION_ID" value="<%=request.getParameter("QUESTION_ID")%>">

					<textarea class="q_input_text" id="q_text" name="q_text" rows="10" cols="30" placeholder="Question text goes here..." required>${result.rows[0].TEXT}</textarea>
					<input class="q_input_text" id="q_category" name="q_category" type="text" placeholder="Category" value="${result.rows[0].CATEGORY}"> <input class="q_input_text" id="q_a1" name="q_a1" type="text" placeholder="Answer #1" required value="${result.rows[0].ANSWER}"> <input class="q_input_text" id="q_a2" name="q_a2" type="text" placeholder="Answer #2" required value="${result.rows[1].ANSWER}"> <input class="q_input_text" id="q_a3" name="q_a3" type="text"
						placeholder="Answer #3" required value="${result.rows[2].ANSWER}"> <input class="q_input_text" id="q_a4" name="q_a4" type="text" placeholder="Answer #4" required value="${result.rows[3].ANSWER}"> <input class="q_input_text" id="q_a5" name="q_a5" type="text" placeholder="Answer #5" value="${result.rows[4].ANSWER}"> <input class="q_input_text" id="q_a6" name="q_a6" type="text" placeholder="Answer #6" value="${result.rows[5].ANSWER}">

					<c:forEach begin="1" end="6" varStatus="loop">
    					<c:if test="${result.rows[loop.index-1].IS_CORRECT_ANSWER}">
	   						<div class="padded-bottom">
								Correct Answer #: <input id="q_correct_answer" type="number" name="q_correct_answer" min="1" max="6" value="${loop.index}" required>
							</div>
					    </c:if>
					</c:forEach>

					<div class="padded-bottom">
						Attached image: <output name="image">${result.rows[0].IMAGE_NAME}</output>
						<input type="file" id="q_image" name="q_image" accept="image/png, image/jpeg">
					</div>
					
					<div class="padded-bottom">
						<input class="shadow-button" id="submit" type="submit" name="submit" value="UPDATE">
					</div>

					<input class="shadow-button" id="delete" onclick="return confirm('Are you sure?');" type="submit" name="submit" value="DELETE">
				</form>
			</div>
		</div>
	</div>

</body>

</html>