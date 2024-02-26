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
<title>Insert title here</title>
</head>
<body>


<table class="table table-striped">
		
		<tbody>
			<%
			Connection con = ConnectionProvider.getConnection();
			PreparedStatement stmt = con.prepareStatement("select * from request where status = ?");
			stmt.setString(1,request.getParameter("type"));
			ResultSet rs = stmt.executeQuery();

			int i = 1;
			while (rs.next()) {
			%>
			<tr>
				<td><%=i%></td>
				<td><%=rs.getString("student_id")%></td>
				<td><%=rs.getString("request_date")%></td>
				<td><%=rs.getString("message")%></td>
				<%if(request.getParameter("type").equals("pending")){ %>
				<td><a type="button" class="btn btn-success"
					href="updateRequestStatus.jsp?id=<%=rs.getString("id")%>&type=pending">Accept</a>
					<a type="button" class="btn btn-danger"
					href="updateRequestStatus.jsp?id=<%=rs.getString("id")%>&type=rejected">Reject</a>
				</td>
				
				<%} %>
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