<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%
String branchId = request.getParameter("branchId");
String branchName = request.getParameter("branchName");
Connection con = ConnectionProvider.getConnection();
String query = "UPDATE branch SET branch_name = ? WHERE id = ?";
PreparedStatement pstm = con.prepareStatement(query);
pstm.setString(1, branchName);
pstm.setString(2, branchId);
try {
	out.print(pstm.executeUpdate()+" Updated");
} catch (Exception e) {
	e.printStackTrace();
	out.print(0);
}
%>
