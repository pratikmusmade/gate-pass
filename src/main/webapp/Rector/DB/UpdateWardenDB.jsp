<%@page import="com.gatePass.helper.QueriesProvider"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
String query = "";
String wardenId = request.getParameter("wardenId");
String path = "C://Users//prati//eclipse-workspace//GatePass//src//main//webapp//assects//images";
MultipartRequest m = new MultipartRequest(request, path, 1024 * 1024 * 1024);
String filePath = m.getFilesystemName("wardenImage");
System.out.println(filePath);
query = QueriesProvider.updateWardenQuery;

if(filePath != null){
	query += ",warden_image = ?";
}

query+=" where id= " + wardenId;
System.out.println(query);
System.out.println( "Image name => " +m.getFilesystemName("wardenImage"));

Connection con = ConnectionProvider.getConnection();

System.out.println("File Input ==> " + request.getParameter("wardenImage"));
String warden_image = "../assects/images/" + m.getFilesystemName("studentImage");
String firstName = m.getParameter("firstName");
String middleName = m.getParameter("middleName");
String lastName = m.getParameter("lastName");
String email = m.getParameter("email");
String yearId = m.getParameter("yearId");
System.out.println("Year id ==>> " + yearId); 
String branchId = m.getParameter("branchId");
String address = m.getParameter("address");
String phoneNumber = m.getParameter("phoneNumber");
String wardenStatus = m.getParameter("wardenStatus");
String password = m.getParameter("password");

PreparedStatement pstmt = con.prepareStatement(query );

pstmt.setString(1, firstName);
pstmt.setString(2, middleName);
pstmt.setString(3, lastName);
pstmt.setString(4, address);
pstmt.setString(5, email);
pstmt.setString(6, password);
pstmt.setString(7, phoneNumber);
pstmt.setString(8, wardenStatus);

pstmt.setString(9, branchId);
pstmt.setString(10, yearId);

if(filePath != null){
	pstmt.setString(11, warden_image);
}

out.print(pstmt.executeUpdate());  
%>