<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%
 if(session.getAttribute("wardenId") == null){
  response.sendRedirect("WardenLogin.jsp"); 
  }  
%>
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
	<jsp:include page="../Components/WardenNavBar.jsp"></jsp:include>

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
							<th>Request Date</th>
							<th>Request status</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody id="statusResponse">
						<%
						String studentId = "1";
						/* String query = "SELECT "
								+ "gatepass.id AS gatepass_id, gatepass.request_id AS gatepass_request_id, gatepass.secret_key AS gatepass_secret_key, "
								+ "gatepass.secret_key_status AS gatepass_secret_key_status, gatepass.out_time AS gatepass_out_time, gatepass.in_time AS gatepass_in_time, "
								+ "student.id AS student_id, student.firstName AS student_firstName, student.middleName AS student_middleName, "
								+ "student.lastName AS student_lastName, student.enrolment_number AS student_enrolment_number, student.address AS student_address, "
								+ "student.email AS student_email, student.pass AS student_pass, student.student_image AS student_image, "
								+ "student.branch_id AS student_branch_id, student.year_id AS student_year_id, "
								+ "request.id AS request_id, request.message AS request_message, request.student_id AS request_student_id, "
								+ "request.warden_id AS request_warden_id, request.current_date AS request_current_date, request.request_date AS request_request_date, "
								+ "request.status AS request_status " + "FROM gatepass "
								+ "INNER JOIN request ON gatepass.request_id = request.id "
								+ "INNER JOIN student ON request.student_id = student.id " + "WHERE request.student_id = ?";
						*/
						String query = "SELECT request.*, student.* " + "FROM request "
								+ "INNER JOIN student ON request.student_id = student.id";
						Connection con = ConnectionProvider.getConnection();
						PreparedStatement stmt = con.prepareStatement(query);
						ResultSet rs = stmt.executeQuery();

						int i = 1;
						while (rs.next()) {
							String studentFullName = rs.getString("firstName") + " " + rs.getString("middleName") + " "
							+ rs.getString("lastName") + " ";
							String requestId = rs.getString("request.id");
							System.out.println(requestId);
						%>
						<tr>
							<td><%=i%></td>
							<td><%=studentFullName%></td>
							<td><img src="<%=rs.getString("student_image")%>"
								class="border border-light" alt="..."
								style="height: 60px; width: 60px; border-radius: 100%"></td>
							<td><%=rs.getString("email")%></td>
							<td><%=rs.getString("request_date")%></td>
							<td><%=rs.getString("status")%></td>
							<td>
								<%
								if (rs.getString("status").equals("pending")) {
								%>
								<button class="btn btn-success px-3"
									onclick="acceptRequest(<%=requestId%>)">Accept</button>
								<button class="btn btn-danger px-3"
									onclick="rejectRequest(<%=requestId%>)">Reject</button>
								<button class="btn btn-info px-3"
									onclick="viewRequest(<%=requestId%>)">View</button>
								<%
								} else {
								%>
								<button class="btn btn-info px-3"
									onclick="viewRequest(<%=requestId%>)">View</button>
								<%
								}
								%>
							</td>
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
	 function viewRequest(requestId) {
		    console.log(requestId);

		    $.ajax({
		      type: "POST",
		      url: "DB/GetRequestDetailById.jsp",
		      data: { request_id: requestId },
		      success: function (response) {
		        modelContainer.innerHTML = response.trim();
		        document.querySelector("#modelTriggerBtn").click();
		        document.querySelector("#studentDetailRequest").value = gatePassId
		      },
		    });
		  }
	 
	 function acceptRequest(requestId) {
		  Swal.fire({
		    title: "Are you sure you want to Accept Request !!",
		    text: "Click OK to continue!",
		    icon: "warning",
            showCancelButton: true,
            cancelButtonColor: "#d33",
		  }).then((res) => {
		    if (res.isConfirmed) { // Changed 'result' to 'res'
		      $.ajax({
		        type: "POST",
		        url: "DB/AcceptRequest.jsp",
		        data: { request_id: requestId },
		        success: function (response) {
		          console.log(response.trim());
		          if (response.trim() === "1") {
		            Swal.fire({
		              title: "Request Deleted Successfully",
		              text: "Click OK to continue!",
		              icon: "success",

		            }).then((res) => {
		              window.location.reload();
		            });
		          } else {
		            Swal.fire({
		              icon: "error",
		              title: "Oops...",
		              text: "Something Went Wrong!!",
		            });
		          }
		        },
		      });
		    }
		  });
		}

	 function rejectRequest(requestId) {
		  Swal.fire({
		    title: "Are you sure you want to Reject Request !!",
		    text: "Click OK to continue!",
		    icon: "error",
           showCancelButton: true,
           cancelButtonColor: "#d33",

		  }).then((res) => {
		    if (res.isConfirmed) { // Changed 'result' to 'res'
		      $.ajax({
		        type: "POST",
		        url: "DB/RejectRequestDB.jsp",
		        data: { request_id: requestId },
		        success: function (response) {
		          console.log(response.trim());
		          if (response.trim() === "1") {
		            Swal.fire({
		              title: "Request Deleted Successfully",
		              text: "Click OK to continue!",
		              icon: "success",

		            }).then((res) => {
		              window.location.reload();
		            });
		          } else {
		            Swal.fire({
		              icon: "error",
		              title: "Oops...",
		              text: "Something Went Wrong!!",
		            });
		          }
		        },
		      });
		    }
		  });
		}
	</script>
</body>
</html>
