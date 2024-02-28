<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student Request List</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

</head>
<body>

	<jsp:include page="../Components/Header.jsp"></jsp:include>


	<div class="container mt-3">
		<h2>Sneha</h2>
		<p>Student Request Table</p>

	</div>
	<br>
	<br>
	<table class="table table-striped">
		<thead>
			<tr>
				<th>Sr No.</th>
				<th>Student Name</th>
				<th>Date</th>
				<th>Message</th>
				<th>Request Status</th>
			</tr>
		</thead>
		<tbody>
			<%
			Connection con = ConnectionProvider.getConnection();
			PreparedStatement stmt = con.prepareStatement("select * from request where status = 'Accepted'");
			ResultSet rs = stmt.executeQuery();

			int i = 1;
			while (rs.next()) {
			%>
			<tr>
				<td><%=i%></td>
				<td><%=rs.getString("student_id")%></td>
				<td><%=rs.getString("request_date")%></td>
				<td><%=rs.getString("message")%></td>
				
				<td><a><%=rs.getString("status")%></a></td>
			</tr>
			<%
			i++;
			}
			%>
		</tbody>
	</table>
</body>
</html>