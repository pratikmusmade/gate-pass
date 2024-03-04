<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%


String message = request.getParameter("EnterMessage");
String date = request.getParameter("dateInput");
String studentId = request.getParameter("student_Id");
String wardenId = request.getParameter("warden_Id");

System.out.println(message);
System.out.println(date);

System.out.println(studentId);
System.out.println(wardenId);

String sql = "SELECT student_id, status FROM request WHERE student_id = ? AND status = 'pending'";
Connection con = ConnectionProvider.getConnection();
PreparedStatement ps = con.prepareStatement(sql);
ps.setString(1, studentId);
ResultSet rs = ps.executeQuery();
if (rs.next()) {
	out.print("0");
	out.print("You previous request is still pending");
} else {
 ps = con.prepareStatement(
		"insert into request(message, student_id, warden_id, request_date) values (?,?,?,?)");
ps.setString(1, message);
ps.setString(2, studentId);
ps.setString(3, wardenId);
ps.setString(4, date);	

out.print(ps.executeUpdate());
}
%>