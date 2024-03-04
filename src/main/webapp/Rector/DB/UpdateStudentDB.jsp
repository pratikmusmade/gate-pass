<%@page import="com.gatePass.helper.QueriesProvider"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
String query = "";
String studentId = request.getParameter("studentId");
String path = "C://Users//prati//eclipse-workspace//GatePass//src//main//webapp//assects//images";
MultipartRequest m = new MultipartRequest(request, path, 1024 * 1024 * 1024);
String filePath = m.getFilesystemName("studentImage");
query = QueriesProvider.queryForUpdatingStudent;
if(filePath != null){
	query += ",student_image = ?";
}
query+=" where id=" +studentId;
System.out.print(query);
System.out.println(m.getFilesystemName("studentImage"));

Connection con = ConnectionProvider.getConnection();

System.out.println("File Input ==> " + request.getParameter("fileInput"));
String student_img = "../assects/images/" + m.getFilesystemName("studentImage");
String firstName = m.getParameter("firstName");
String middleName = m.getParameter("middleName");
String lastName = m.getParameter("lastName");
String email = m.getParameter("email");
String yearId = m.getParameter("yearId");
System.out.println("Year id ==>> " + yearId); 
String branchId = m.getParameter("branchId");
String address = m.getParameter("address");
String phoneNumber = m.getParameter("phoneNumber");
String enrollNo = m.getParameter("enrollmentNumber");
String password = m.getParameter("password");

PreparedStatement pstmt = con.prepareStatement(query );
pstmt.setString(1, firstName);
pstmt.setString(2, middleName);
pstmt.setString(3, lastName);
pstmt.setString(4, enrollNo);
pstmt.setString(5, address);
pstmt.setString(6, email);
pstmt.setString(7, password);
pstmt.setString(8, branchId);
pstmt.setString(9, yearId);
if(filePath != null){
	pstmt.setString(10, student_img);
}

out.print(pstmt.executeUpdate());  
%>