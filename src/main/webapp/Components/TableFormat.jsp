<%@page import="com.gatePass.helper.QueriesProvider"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.mysql.cj.xdevapi.PreparableStatement"%>
<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%
Connection con = ConnectionProvider.getConnection();

int yearId = Integer.parseInt(request.getParameter("year_id"));
int branchId = Integer.parseInt(request.getParameter("branch_id"));
String whereClause = "";
System.out.println(yearId + " " + branchId);
boolean isDataPrinted = false;

if (yearId != 0 && branchId != 0) {
	whereClause = " where branch.id=" + branchId + " and acc_year.id =" + yearId;
} else if (yearId != 0 || branchId != 0) {
	whereClause = "where ";
	whereClause += (yearId != 0) ? ("acc_year.id =" + yearId) : ("");
	whereClause += (branchId != 0) ? ("branch.id =" + branchId) : ("");
}
whereClause += " order by id";

System.out.println(whereClause);
String query = QueriesProvider.queryForStudentInfo;
query += whereClause;
System.out.println(" Query ==> " + query);

PreparedStatement pstm = con.prepareStatement(query);

ResultSet rs = pstm.executeQuery();
while (rs.next()) {
	isDataPrinted = true;
%>
<tr>
	<th scope="row"><%=rs.getString("id")%></th>
	<td><img src="<%=rs.getString("student_image")%>"
		class="img-thumbnail" alt="..."
		style="height: 50px; width: 50px; border-radius: 100%"></td>
	<td><%=rs.getString("firstName") + " " + rs.getString("middleName") + " " + rs.getString("lastName") + " "%></td>
	<td><%=rs.getString("enrolment_number")%></td>

	<td><%=rs.getString("email")%></td>
	<td><%=rs.getString("branch_name")%></td>
	<td><%=rs.getString("year_name")%></td>
	<td><a type="button" class="btn btn-outline-warning"
		href="UpdateStudent.jsp?studentId=<%=rs.getString("id")%>">Update</a>
	</td>
	<td><a type="button" class="btn btn-outline-danger"
		href="DB/DeleteStudentDB.jsp?studentId=<%=rs.getString("id")%>">Delete</a>
	</td>
</tr>
<%
}

if (!isDataPrinted) out.print("0");
%>

