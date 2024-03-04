<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
String path = "C://Users//prati//eclipse-workspace//GatePass//src//main//webapp//assects//images";

MultipartRequest m = new MultipartRequest(request, path, 1024 * 1024 * 1024);

String outTime = m.getParameter("out-time");
String inTime = m.getParameter("in-time");
String gatePassId = m.getParameter("gatePassId");

System.out.println(outTime);
System.out.println(inTime);
System.out.println(gatePassId);

String query = "UPDATE gatepass SET "; 

query += (!outTime.isEmpty())? "out_time ='" + outTime +"' " : "";
query += (!outTime.isEmpty() && !inTime.isEmpty())? ","  : "";
query += (!inTime.isEmpty())? "in_time ='" + inTime + "' ": "";
query += "WHERE id = ?";
System.out.println(query);
PreparedStatement pstm1 = ConnectionProvider.getConnection().prepareStatement(query);

pstm1.setString(1, gatePassId);

out.print(pstm1.executeUpdate());

%>