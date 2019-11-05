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
<title>Create A Question</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/footer.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/question.css">
<script src="${pageContext.request.contextPath}/js/checkBox.js"></script>
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
							out.println("<div style=\"padding-bottom:15px; margin: 5px\" id=\"success\">Question Successfully Created</div>");
						}
					}
				%>
				
				<!-- Form -->
				<form class="quiz-form" action="${pageContext.request.contextPath}/CreateQuestionTF" method="post" enctype="multipart/form-data">
					<textarea class="q_input_text" id="q_text" name="q_text" rows="10" cols="30" placeholder="Question text goes here..." required></textarea>
					<input class="q_input_text" id="q_category" name="q_category" type="text" placeholder="Category">
					<div class="padded-bottom">
						Answer: <input class="cb" type="checkbox" id="true_cb" name="true_cb" onchange="checkBoxUpdate(this, 'cb')"> <label for="true_cb">True</label> <input class="cb" type="checkbox" id="false_cb" name="false_cb" onchange="checkBoxUpdate(this, 'cb')"> <label for="false_cb">False</label>
					</div>
					<div class="padded-bottom">
						Attached image: <input type="file" id="q_image" name="q_image" accept="image/png, image/jpeg"> <br>
					</div>
					<input id="submit" type="submit" value="CREATE QUESTION">
				</form>
			</div>
		</div>
	</div>

</body>

</html>