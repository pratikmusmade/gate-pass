<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.cj.xdevapi.Statement"%>
<%@page import="java.sql.PreparedStatement"%>

<%
if(session.getAttribute("user") == null){
	  response.sendRedirect("RectorLogin.jsp"); 
}
%>
<%
String StatusId = request.getParameter("id");
String type = request.getParameter("type");
String newStatus = type.equals("pending") ? "Accepted" : "Rejected";

Connection con = ConnectionProvider.getConnection();
PreparedStatement stmt = con.prepareStatement("select * from request");

PreparedStatement ps = null;
String sql = "";
int done = 0;

if (type.equals("pending")) {
	sql = "update request set status='Accepted' where id=?";
	ps = con.prepareStatement(sql);
	ps.setString(1, StatusId);
	done = ps.executeUpdate();
} else {
	sql = "update request set status='Rejected' where id=?";
	ps = con.prepareStatement(sql);
	ps.setString(1, StatusId);
	done = ps.executeUpdate();
}
if (done > 0) {
	request.setAttribute("updatedStatus", newStatus);
	request.getRequestDispatcher("StudentRequestList.jsp").forward(request, response);
%>
<script>
	alert("Status Changed!!");
	location.href = "StudentRequestList.jsp";
</script>
<%
} else {
%>
<script>
	alert("Failed Try Again!!");
	location.href = "StudentRequestList.jsp";
</script>
<%
}
%>
