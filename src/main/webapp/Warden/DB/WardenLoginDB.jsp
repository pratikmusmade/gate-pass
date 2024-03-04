<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.cj.xdevapi.Result"%>
<%@page import="java.sql.PreparedStatement"%>
<%
System.out.println("Hello");
String dbEmail = "";
String dbpass = "";
String wardenId = "";
String email = request.getParameter("email");
String password = request.getParameter("password");

System.out.println("Password " + password);
System.out.println("Enrollment " + email);
String logoutRequest = request.getParameter("logoutRequest");

logoutRequest = (logoutRequest != null) ? logoutRequest : "";
email = (email != null) ? email : "";
password = (password != null) ? password : "";

String query = "select id,email,pass,branch_id from warden where email = ?";
PreparedStatement pst = ConnectionProvider.getConnection().prepareStatement(query);
pst.setString(1, email);
ResultSet rs = pst.executeQuery();
while (rs.next()) {
	dbpass = rs.getString("pass");
	dbEmail = rs.getString("email");
	wardenId = rs.getString("id");
	
}
System.out.println("shann " + dbEmail.isEmpty());
System.out.println("adiii " + password.equals(dbpass));
if (logoutRequest.equals("1")) {
	out.print("1");
	out.print("Logout Successful");
	session.removeAttribute("wardenId");
} else {
	if (dbEmail.isEmpty()) {
		out.print("0");
	} else if (!password.equals(dbpass)) {
		out.print("0");

	} else {
		
		session.setAttribute("wardenId", wardenId);
		out.print("1");


	}
}
%>