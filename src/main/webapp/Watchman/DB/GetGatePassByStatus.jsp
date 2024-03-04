<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%
String keyStatus = request.getParameter("keyStatus");
String sqlQuery = "SELECT " + "student.id AS student_id, " + "student.firstName AS student_firstName, "
		+ "student.middleName AS student_middleName, " + "student.lastName AS student_lastName, "
		+ "student.enrolment_number AS student_enrolment_number, " + "student.address AS student_address, "
		+ "student.email AS student_email, " + "student.pass AS student_pass, "
		+ "student.student_image AS student_image, " + "student.branch_id AS student_branch_id, "
		+ "student.year_id AS student_year_id, " + "request.id AS request_id, " + "request.message AS request_message, "
		+ "request.student_id AS request_student_id, " + "request.warden_id AS request_warden_id, "
		+ "request.current_date AS request_current_date, " + "request.request_date AS request_request_date, "
		+ "request.status AS request_status, " + "gatepass.id AS gatepass_id, "
		+ "gatepass.request_id AS gatepass_request_id, " + "gatepass.secret_key AS gatepass_secret_key, "
		+ "gatepass.secret_key_status AS gatepass_secret_key_status, " + "gatepass.out_time AS gatepass_out_time, "
		+ "gatepass.in_time AS gatepass_in_time " + "FROM " + "student " + "INNER JOIN "
		+ "request ON student.id = request.student_id " + "INNER JOIN " + "gatepass ON request.id = gatepass.request_id "
		+ "where request.status <> 'rejected' and gatepass.secret_key_status = ?";
Connection con = ConnectionProvider.getConnection();
PreparedStatement stmt = con.prepareStatement(sqlQuery);
stmt.setString(1,keyStatus);
ResultSet rs = stmt.executeQuery();

int i = 1;
while (rs.next()) {
	String studentFullName = rs.getString("student_firstName") + " " + rs.getString("student_middleName") + " "
	+ rs.getString("student_lastName");
	String status = rs.getString("gatepass_secret_key_status");
	String uniqueFormId = "verifySecrateKey" + i;
%>
<tr>
	<td><%=i%></td>
	<td><%=rs.getString("student_firstName")%> <%=rs.getString("student_middleName")%>
		<%=rs.getString("student_lastName")%></td>
	<td><img src="<%=rs.getString("student_image")%>"
		class="border border-light" alt="..."
		style="height: 60px; width: 60px; border-radius: 100%"></td>
	<td><%=rs.getString("student_email")%></td>
	<td><%=rs.getString("request_request_date")%></td>
	<td><%=status%></td>
	<td class="px-0">
		<%
		if (status.equals("in-process")) {
		%>
		<div class="d-flex rounded-2 justify-content-around flex-shrink-1">
			<div>
				<input name="secrate_key" type="text" class="form-control"
					id="<%=uniqueFormId%>" placeholder="Enter Secrate OTP">
			</div>
			<div>
				<button
					onclick="setRequestIdForModel(<%=rs.getString("request_id")%>,<%=rs.getString("gatepass_id")%>,'<%=uniqueFormId%>')"
					type="submit" class="btn btn-primary mb-3">
					<i class="bi bi-person-fill-check"></i> Verify <i class="bi bi-key"></i>
				</button>
			</div>
		</div> <%
 } else {
 %>
		<button
			onclick="viewRequest(<%=rs.getString("request_id")%>,<%=rs.getString("gatepass_id")%>)"
			type="submit" class="btn btn-info mb-3">
			<i class="bi bi-file-earmark-fill"></i>Update
		</button> <%
 }
 %>
	</td>
</tr>
<%
i++;
}
%>
