<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<% 
   String message = request.getParameter("EnterMessage");
   String date = request.getParameter("dateInput");
  
   System.out.println(message);
   System.out.println(date);
   
    Connection con = ConnectionProvider.getConnection();
    
    PreparedStatement ps = con.prepareStatement("insert into request (message , request_date) values (?,?)");
    ps.setString(1, message);
    ps.setString(2, date);
    
    ps.executeUpdate();
    
    
%>