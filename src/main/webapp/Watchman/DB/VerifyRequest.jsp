<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
String secrate_key = request.getParameter("secrate_key");
String gatePassId = request.getParameter("gatePassId");

String sql = "SELECT COUNT(*) AS count_matches FROM gatepass WHERE secret_key = ? and id = ?";
Connection con = ConnectionProvider.getConnection();
PreparedStatement stmt = con.prepareStatement(sql);
stmt.setString(1, secrate_key);
stmt.setString(2, gatePassId);

ResultSet resultSet = stmt.executeQuery();
if (resultSet.next()) {
	int countMatches = resultSet.getInt("count_matches");
	if (countMatches > 0) {
		out.println("1");
		stmt = con.prepareStatement("update gatepass set secret_key_status='verified' where id = ?");
		stmt.setString(1, gatePassId);
		stmt.executeUpdate();
	} else {
		out.println("0");
	}
}
%>