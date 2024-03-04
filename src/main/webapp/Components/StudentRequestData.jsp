<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
			<%
			String status = request.getParameter("requestStatus");
			String andClause = (!status.equals("0"))? "and status= '" + status +"'" : "";
			boolean isDataPrinted = false;

			System.out.println(status);
			Connection con = ConnectionProvider.getConnection();
			System.out.println("select * from student,request where student.id = request.student_id " + andClause);
			PreparedStatement stmt = con.prepareStatement("select * from student,request where student.id = request.student_id " + andClause);
			ResultSet rs = stmt.executeQuery();

			int i = 1;
			while (rs.next()) {
				isDataPrinted = true;
				String studentFullName = rs.getString("firstName") + " " + rs.getString("middleName") + " "
				+ rs.getString("lastName") + " ";
			%>
			<tr class="">
				<td><%=i%></td>
				<td><%=studentFullName%></td>
				<td><img src="<%=rs.getString("student_image")%>"
					class="border border-light" alt="..."
					style="height: 60px; width: 60px; border-radius: 100%"></td>
				<td><%=rs.getString("email")%></td>
				<td><%=rs.getString("request_date")%></td>
				<td><%=rs.getString("status")%></td>
				<td><button onclick='acceptRequest(<%=rs.getString("id")%>)'
						type="button" class="btn btn-success">Accept</button>
					<button onclick='rejectRequest(<%=rs.getString("id")%>)'
						type="button" class="btn btn-danger">Reject</button>
					<button type="button" class="btn btn-info"
						onclick="viewRequest(<%=rs.getString("id")%>)">View
						Request</button></td>
			</tr>
			<%
			i++;
			}
			if (!isDataPrinted)
				out.print("0");
			%>
