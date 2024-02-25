<%@page import="com.mysql.cj.xdevapi.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.awt.image.RescaleOp"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>




<%
  Connection con = ConnectionProvider.getConnection();  
  PreparedStatement ps = null;
  ResultSet rs = null;

  String email = request.getParameter("uname");
  String password = request.getParameter("pswd");
  
  String query = "SELECT * FROM student WHERE email = ? AND pass = ?";

  ps = con.prepareStatement(query);
  
  ps.setString(1, email);
  ps.setString(2, password);
  
  rs = ps.executeQuery();
  
  if(rs.next()){
	  
	  session.setAttribute("studentsession",rs.getString("firstName")+" "+rs.getString("lastName"));
	  response.sendRedirect("../Student_Warden_Request.jsp");
  }
  
  
  
%>