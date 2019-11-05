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
<title>Edit A User</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/footer.css">
<script src="${pageContext.request.contextPath}/js/checkBox.js"></script>
</head>

<body>
	<!-- Navbar -->
	<%@ include file = "../header.jsp" %>
	<!-- Content -->
	<div class="login-main">
		<div class="form-container shadow">

			<!-- Error Message (if set) -->
			<%
				if (request.getParameter("success") != null) {
					if (request.getParameter("success").equals("false")) {
						out.println("<div style=\"text-align:center; padding-bottom:15px; margin: 5px;\" id=\"error\"><p>" + request.getParameter("error") + "</p></div>");
					}
				}
			%>

			<!-- Success Message (if set) -->
			<%
				if (request.getParameter("success") != null) {
					if (request.getParameter("success").equals("true")) {
						out.println("<div id=\"success\" style=\"text-align:center; padding-bottom:15px; margin: 5px;\"><p>User Successfully Updated</p></div>");
					}
				}
			%>

			<sql:setDataSource var="snapshot" driver="com.mysql.cj.jdbc.Driver" url="<%=LoginEnum.hostname.getValue()%>" user="<%=LoginEnum.username.getValue()%>" password="<%=LoginEnum.password.getValue()%>" />
			<sql:query dataSource="${snapshot}" var="result"> SELECT * FROM USERS WHERE USERS_ID=<%=request.getParameter("USERS_ID")%>; </sql:query>

			<form class="quiz-form" action="${pageContext.request.contextPath}/EditUser" method="post">

				<!-- Hidden input with ID# -->
				<input id="USERS_ID" type="hidden" name="USERS_ID" value="<%=request.getParameter("USERS_ID")%>"> <input id="email" name="email" type="email" placeholder="new email" value="${result.rows[0].EMAIL}" required> <input id="password" name="password" type="text" placeholder="new password" value="${result.rows[0].PASSWORD}" required>

				<!-- If user is active, mark active check box -->
				<c:if test="${result.rows[0].IS_ACTIVE}">
					<div class="padded-bottom">
						<input class="cb" type="checkbox" id="active_cb" name="active_cb" value="active_cb" onchange="checkBoxUpdate(this, 'cb')" checked> <label for="active_cb">Active</label> <input class="cb" type="checkbox" id="inactive_cb" name="inactive_cb" value="inactive_cb" onchange="checkBoxUpdate(this, 'cb')"> <label for="inactive_cb">Inactive</label>
					</div>
				</c:if>

				<!-- If user is inactive, mark inactive check box -->
				<c:if test="${!result.rows[0].IS_ACTIVE}">
					<div class="padded-bottom">
						<input class="cb" type="checkbox" id="active_cb" name="active_cb" value="active_cb" onchange="checkBoxUpdate(this, 'cb')"> <label for="active_cb">Active</label> <input class="cb" type="checkbox" id="inactive_cb" name="inactive_cb" value="inactive_cb" onchange="checkBoxUpdate(this, 'cb')" checked> <label for="inactive_cb">Inactive</label>
					</div>
				</c:if>

				<div class="padded-bottom">
					<input class="shadow-button" id="submit" type="submit" name="submit" value="UPDATE">
				</div>

				<input class="shadow-button" id="delete" onclick="return confirm('Are you sure?');" type="submit" name="submit" value="DELETE">

			</form>
		</div>
	</div>

</body>

</html>