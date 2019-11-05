<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="java.io.*,java.util.*,java.sql.*"%>
<%@page import="javax.servlet.http.*,javax.servlet.*"%>
<%@page import="edu.albany.csi418.session.LoginEnum"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<!DOCTYPE html>
<html>

<head>
<meta content="text/html;" charset="UTF-8">
<title>User Management</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/favicon.ico" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/login.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/footer.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/filter.js"></script>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css">
</head>

<body>
	<!-- Navbar -->
	<%@ include file = "../header.jsp" %>

	<!-- Content -->
	<div class="main-container" style="max-width: 1000px;">
		<div class="main shadow" style="padding: 0;">

			<!-- Message (if set) -->
			<%
				if (request.getParameter("message") != null) {
					out.println("<div style=\"padding-top: 5px; margin: 5px; text-align: center;\" id=\"success\"><p>"
							+ request.getParameter("message") + "</p></div>");
				}
			%>

			<div class="filter-box">
				<i class="fas fa-search filter-icon"></i> <input class="table-filter" type="text" id="filter" onkeyup="filterTable('filter', 'table')" placeholder="Filter the below table by user email or active status...">
			</div>

			<!-- Connect to DB and select all users -->
			<sql:setDataSource var="snapshot" driver="com.mysql.cj.jdbc.Driver" url="<%=LoginEnum.hostname.getValue()%>" user="<%=LoginEnum.username.getValue()%>" password="<%=LoginEnum.password.getValue()%>" />
			<sql:query dataSource="${snapshot}" var="result"> SELECT * from USERS; </sql:query>

			<!-- Print table of all users -->
			<table id="table" class="table" style="width: 100%;">
				<tr>
					<th>User ID</th>
					<th>Email</th>
					<th>Active</th>
					<th>Password</th>
					<th></th>
				</tr>

				<c:forEach var="row" items="${result.rows}">
					<tr>
						<td><c:out value="${row.USERS_ID}" /></td>
						<td><c:out value="${row.EMAIL}" /></td>
						<td><c:out value="${row.IS_ACTIVE}" /></td>
						<td><c:out value="${row.PASSWORD}" /></td>
						<td><a class="link-style" href="${pageContext.request.contextPath}/admin/user/edit_user.jsp?USERS_ID=<c:out value="${row.USERS_ID}"/>">edit</a></td>
					</tr>
				</c:forEach>

				<tr>
					<td></td>
					<td><a class="link-style" href="${pageContext.request.contextPath}/admin/user/create_user.jsp">create new user</a></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</table>
		</div>
	</div>

</body>

</html>