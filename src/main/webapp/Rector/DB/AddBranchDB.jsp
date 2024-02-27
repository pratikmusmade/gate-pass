x`
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%
String branchName = request.getParameter("branchName");
Connection con = ConnectionProvider.getConnection();

String query = "insert into branch(branch_name) values(?)";
PreparedStatement pstm = con.prepareStatement(query);
pstm.setString(1, branchName);

try {
	out.print(pstm.executeUpdate()+" Added");
} catch (Exception e) {
	e.printStackTrace();
	out.print(0);
}
%>
