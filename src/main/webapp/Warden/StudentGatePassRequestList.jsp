<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student Request List</title>
<jsp:include page="../Components/Header.jsp"></jsp:include>
</head>
<body style="background-image: url('../assects/images/circle.svg')"
	style="background-repeat:norepeat">
	<%
	String modelRequestId = "";
	%>
	<jsp:include page="../Components/NavBar.jsp"></jsp:include>

	<div class="container mt-3">
		<div class="row m-0">
			<h1 class="text-light">Student Gate Pass Request</h1>
		</div>

		<!-- View Request Model Start -->
		<button type="button" class="btn btn-primary d-none"
			data-bs-toggle="modal" data-bs-target="#studentDetailRequest"
			id="modelTriggerBtn">Launch static backdrop modal</button>

		<!-- Modal -->
		<div class="modal fade" id="studentDetailRequest"
			data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
			aria-labelledby="staticBackdropLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered modal-xl">

				<div class="modal-content ">
					<h2 class="px-3 pt-3 alert-info m-0">Gate Pass Request</h2>
					<div class="modal-body alert-info rounded-3">
						<div class="card text-white p-2 bg-secondary">
							<div class="row g-0" id="modelContainer"></div>
						</div>
					</div>

				</div>
			</div>
		</div>
		<!-- 		View Request Model End   -->
		<div class="row d-flex flex-row-reverse m-0">

			<div class=""></div>


		</div>
		<div class="row mt-3">
			<div class="col-lg-12">
				<table class="table table-striped table-dark">
					<thead>
						<tr class="table-primary">
							<th>Sr No.</th>
							<th>Student Name</th>
							<th>Image</th>
							<th>Email</th>
							<th>Gate-pass Date</th>
							<th>Gate-pass status</th>
							<th>Secret Key </th>
						</tr>
					</thead>
					<tbody id="statusResponse">
						<%
						String studentId = "1";
						String query = "SELECT "
							    + "gatepass.id AS gatepass_id, gatepass.request_id AS gatepass_request_id, gatepass.secret_key AS gatepass_secret_key, "
							    + "gatepass.secret_key_status AS gatepass_secret_key_status, gatepass.out_time AS gatepass_out_time, gatepass.in_time AS gatepass_in_time, "
							    + "student.id AS student_id, student.firstName AS student_firstName, student.middleName AS student_middleName, "
							    + "student.lastName AS student_lastName, student.enrolment_number AS student_enrolment_number, student.address AS student_address, "
							    + "student.email AS student_email, student.pass AS student_pass, student.student_image AS student_image, "
							    + "student.branch_id AS student_branch_id, student.year_id AS student_year_id, "
							    + "request.id AS request_id, request.message AS request_message, request.student_id AS request_student_id, "
							    + "request.warden_id AS request_warden_id, request.current_date AS request_current_date, request.request_date AS request_request_date, "
							    + "request.status AS request_status "
							    + "FROM gatepass "
							    + "INNER JOIN request ON gatepass.request_id = request.id "
							    + "INNER JOIN student ON request.student_id = student.id "
							    + "WHERE request.student_id = ?";


						Connection con = ConnectionProvider.getConnection();
						PreparedStatement stmt = con.prepareStatement(query);
						stmt.setString(1, studentId);
						ResultSet rs = stmt.executeQuery();

						int i = 1;
						while (rs.next()) {
							String studentFullName = rs.getString("student_firstName") + " " + rs.getString("student_middleName") + " "
							+ rs.getString("student_lastName") + " ";
						%>
						<tr>
							<td><%=i%></td>
							<td><%=studentFullName%></td>
							<td><img src="<%=rs.getString("student_image")%>"
								class="border border-light" alt="..."
								style="height: 60px; width: 60px; border-radius: 100%"></td>
							<td><%=rs.getString("student_email")%></td>
							<td><%=rs.getString("request_request_date")%></td>
							<td><%=rs.getString("gatepass_secret_key_status")%></td>
							<td><%=rs.getString("gatepass_secret_key")%></td>

						</tr>
						<%
						i++;
						}
						%>
					</tbody>
				</table>
			</div>
		</div>



	</div>
	<jsp:include page="../Components/Footer.jsp"></jsp:include>

	<script>
	
	
	</script>

</body>
</html>
