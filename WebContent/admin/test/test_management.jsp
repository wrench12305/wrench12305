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
<title>Test List</title>
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
					out.println("<div style=\"margin: 5px; text-align: center;\" id=\"success\"><p>"
							+ request.getParameter("message") + "</p></div>");
				}
			%>

			<!-- Connect to DB and select all tests -->
			<sql:setDataSource var="snapshot" driver="com.mysql.cj.jdbc.Driver" url="<%=LoginEnum.hostname.getValue()%>" user="<%=LoginEnum.username.getValue()%>" password="<%=LoginEnum.password.getValue()%>" />
			<sql:query dataSource="${snapshot}" var="result"> SELECT * FROM TEST T INNER JOIN ADMINISTRATOR A ON T.ADMIN_ID = A.ADMIN_ID;</sql:query>

			<div class="filter-box">
				<i class="fas fa-search filter-icon"></i> <input class="table-filter" type="text" id="filter1" onkeyup="filterTable('filter1', 'table1')" placeholder="Filter the below table by test name or admin email...">
			</div>

			<!-- Print table of all users -->
			<table id="table1" class="table" style="width: 100%; margin-bottom:50px;">
				<tr>
					<th>Test ID</th>
					<th>Test Name</th>
					<th>Admin</th>
					<th>Due Date</th>
					<th></th>
					<th></th>
				</tr>

				<c:forEach var="row" items="${result.rows}">
					<tr>
						<td><c:out value="${row.TEST_ID}" /></td>
						<td><c:out value="${row.TITLE}" /></td>
						<td><c:out value="${row.EMAIL}" /></td>
						<td><c:out value="${row.TEST_DUE}" /></td>
						<td><a class="link-style" href="${pageContext.request.contextPath}/admin/test/invite_users.jsp?TEST_ID=<c:out value="${row.TEST_ID}"/>">invite_user(s)</a></td>
						<td><a class="link-style" href="${pageContext.request.contextPath}/admin/test/edit_test.jsp?TEST_ID=<c:out value="${row.TEST_ID}"/>">edit</a></td>
					</tr>
				</c:forEach>

				<tr>
					<td></td>
					<td><a class="link-style" href="${pageContext.request.contextPath}/admin/test/create_test.jsp">create new test</a></td>
					<td></td>
					<td></td>
					<td></td>
					<th></th>
				</tr>
			</table>
		</div>
	</div>

</body>

</html>