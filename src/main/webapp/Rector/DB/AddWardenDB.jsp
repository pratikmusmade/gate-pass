<%@page import="com.gatePass.helper.QueriesProvider"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
String path = "/Users/snehajature/git/gate-passProject/src/main/webapp/assects/images";
String query = QueriesProvider.insertIntoWarden;
System.out.print(query);
MultipartRequest m = new MultipartRequest(request, path, 1024 * 1024 * 1024);
Connection con = ConnectionProvider.getConnection();

String student_img = "../assects/images/" + m.getFilesystemName("wardenImage");
String firstName = m.getParameter("firstName");
String middleName = m.getParameter("middleName");
String lastName = m.getParameter("lastName");
String email = m.getParameter("email");
String yearId = m.getParameter("yearId");
String branchId = m.getParameter("branchId");
String address = m.getParameter("address");
String phoneNumber = m.getParameter("phoneNumber");
String phoneNo = m.getParameter("phoneNumber");
String password = m.getParameter("password");

System.out.println(password);
PreparedStatement pstmt = con.prepareStatement(query);
pstmt.setString(1, firstName);
pstmt.setString(2, middleName);
pstmt.setString(3, lastName);
pstmt.setString(4, address);
pstmt.setString(5, email);
pstmt.setString(6, password);
pstmt.setString(7, phoneNo);
pstmt.setString(8, student_img);
pstmt.setString(9, "unavailable");

pstmt.setString(10, branchId);
pstmt.setString(11, yearId);

out.print(pstmt.executeUpdate());
%>