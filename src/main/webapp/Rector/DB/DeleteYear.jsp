<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%

Connection con = ConnectionProvider.getConnection();
String yearId = request.getParameter("yearId");
String query = "DELETE FROM acc_year WHERE id=?";
PreparedStatement pstm = con.prepareStatement(query);
pstm.setString(1, yearId);
try {
	out.print(pstm.executeUpdate());
} catch (Exception e) {
	e.printStackTrace();
	out.print(0);
} 

%>