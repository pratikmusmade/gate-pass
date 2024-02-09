<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%


String yearId = request.getParameter("yearId");
String yearName = request.getParameter("yearName");
Connection con = ConnectionProvider.getConnection();
String query = "UPDATE acc_year SET year_name = ? WHERE id = ?";
PreparedStatement pstm = con.prepareStatement(query);
pstm.setString(1, yearName);
pstm.setString(2, yearId);
try {
	out.print(pstm.executeUpdate() + " Updated");
} catch (Exception e) {
	e.printStackTrace();
	out.print(0);
} 
%>