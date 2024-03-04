<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
String requestId = request.getParameter("requestId");
String sql = "DELETE FROM request WHERE id = ?";
Connection conn = ConnectionProvider.getConnection();
PreparedStatement pstmt = conn.prepareStatement(sql);
pstmt.setString(1, requestId);
out.print(pstmt.executeUpdate());
%>