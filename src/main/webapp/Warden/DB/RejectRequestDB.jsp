<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.security.SecureRandom"%>
<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@page import="com.gatePass.helper.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
String requestId = request.getParameter("request_id");
String queryStatusChange = "update request set status = ? where id = ?";
PreparedStatement pstm2 = ConnectionProvider.getConnection().prepareStatement(queryStatusChange);
pstm2.setString(1, "rejected");
pstm2.setString(2, requestId);
out.print(pstm2.executeUpdate());
%>