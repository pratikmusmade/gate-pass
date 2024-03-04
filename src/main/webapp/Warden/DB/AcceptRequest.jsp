<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.security.SecureRandom"%>
<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@page import="com.gatePass.helper.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
//Generate OTP Code
int OTP_LENGTH = 5;
String ALLOWED_CHARACTERS = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
StringBuilder otp = new StringBuilder(OTP_LENGTH);
SecureRandom random = new SecureRandom();
for (int i = 0; i < OTP_LENGTH; i++) {
	int randomIndex = random.nextInt(ALLOWED_CHARACTERS.length());
	otp.append(ALLOWED_CHARACTERS.charAt(randomIndex));
}

String requestId = request.getParameter("request_id");
String secrateKey = otp.toString();

System.out.print(requestId + " " + secrateKey);
String queryStatusChange = "update request set status = ? where id = ?";
String query = "insert into gatepass(request_id,secret_key) values(?,?)";
PreparedStatement pstm1 = ConnectionProvider.getConnection().prepareStatement(query);
pstm1.setString(1, requestId);
pstm1.setString(2, secrateKey);
PreparedStatement pstm2 = ConnectionProvider.getConnection().prepareStatement(queryStatusChange);
pstm2.setString(1, "accepted");
pstm2.setString(2, requestId);
pstm2.executeUpdate();
out.print(pstm1.executeUpdate());
%>