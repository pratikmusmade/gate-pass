<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%
if(session.getAttribute("user") == null){
	  response.sendRedirect("WatchmanLogin.jsp"); 
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
<jsp:include page="../Components/WatchmanNavBar.jsp"></jsp:include>
	<div class="container mt-3">
		<div class="row m-0">
			<div class="col">
				<h1 class="text-light">Student Gate Pass</h1>
			</div>
		</div>
		<!-- View Request Model Start -->
		<button type="button" class="btn btn-primary d-none"
			data-bs-toggle="modal" data-bs-target="#studentDetailRequest"
			id="modelTriggerBtn">Launch static backdrop modal</button>

		<!-- Modal -->
		<div class="modal fade" id="studentDetailRequest"
			data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
			aria-labelledby="staticBackdropLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered modal-lg">

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
		<div class="row d-flex flex-row-reverse bd-highlight">
			<div class="col-lg-4">
				<form class="d-flex" id="filterGatePass">
					<div class="col">
						<select class="form-select" aria-label="Default select example"
						name="keyStatus">
							<option value="in-process">In-process</option>
							<option value="verified">Verified</option>
						</select>
					</div>&nbsp &nbsp &nbsp
					<div class="col">
						<button class="btn btn-primary">
							Filter <i class="bi bi-funnel-fill"></i>
						</button>
					</div>

				</form>
			</div>
		</div>
		<div class="row mt-3 d-flex justify-content-center">
			<div class="col-lg-11">
				<table class="table table-striped table-dark">
					<thead>
						<tr class="table-primary text-center">
							<th>Sr No.</th>
							<th>Student Name</th>
							<th>Image</th>
							<th>Email</th>
							<th>Request-Date</th>
							<th>status</th>
							<th>Verify Student</th>
						</tr>
					</thead>
					<tbody id="statusResponse">
					
					<%
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
							+ "request ON student.id = request.student_id " + "INNER JOIN "
							+ "gatepass ON request.id = gatepass.request_id "
							+ " where request.status <> 'rejected'";
					Connection con = ConnectionProvider.getConnection();
					PreparedStatement stmt = con.prepareStatement(sqlQuery);
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
							<td><%=studentFullName%></td>
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
								<div
									class="d-flex rounded-2 justify-content-around flex-shrink-1">
									<div>
										<input name="secrate_key" type="text" class="form-control"
											id="<%=uniqueFormId%>" placeholder="Enter Secrate OTP">
									</div>
									<div>
										<button
											onclick="setRequestIdForModel(<%=rs.getString("request_id")%>,<%=rs.getString("gatepass_id")%>,'<%=uniqueFormId%>')"
											type="submit" class="btn btn-primary mb-3">
											<i class="bi bi-person-fill-check"></i> Verify <i
												class="bi bi-key"></i>
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
						
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<jsp:include page="../Components/Footer.jsp"></jsp:include>
	<script>
	$(document).ready(function () {
        $("#filterGatePass").submit(function (e) {
          e.preventDefault();
          $.ajax({
            type: "POST",
            url: "DB/GetGatePassByStatus.jsp",
            data: $("#filterGatePass").serialize(),
            success: function (response) {
            	console.log(response.trim())
            	document.querySelector("#statusResponse").innerHTML = response.trim()
            },
          });
        });
      });
	
	
  function setRequestIdForModel(requestId, gatePassId, formId) {
	console.log(requestId,gatePassId)
    const secrate_key = document.querySelector("#" + formId).value;
	console.log(secrate_key)

	
    $.ajax({
      type: "POST",
      url: "DB/VerifyRequest.jsp",
      data: {secrate_key,gatePassId},
      success: function (response) {
        console.log(response.trim());
        if (response.trim() === "1") {
          Swal.fire({
            title: "User is Verified ",
            text: "Click OK to continue!",
            icon: "success",
          }).then((res) => {
            viewRequest(requestId,gatePassId);
          });
        } else {
          Swal.fire({
            icon: "error",
            title: "Invalid Secrate Key",
            text: response.trim().slice(1),
          });
        }
      },
    });
  }
  function viewRequest(requestId,gatePassId) {
    console.log(requestId);
    console.log(gatePassId);

    $.ajax({
      type: "POST",
      url: "DB/GatePassModelData.jsp",
      data: { request_id: requestId,gatePassId },
      success: function (response) {
        modelContainer.innerHTML = response.trim();
        document.querySelector("#modelTriggerBtn").click();
        document.querySelector("#modelGatePassId").value = gatePassId
      },
    });
  }
  function setCurrentTime(element_id) {
	  const currentTime = new Date();
	  const year = currentTime.getFullYear();
	  const month = (currentTime.getMonth() + 1).toString().padStart(2, '0');
	  const day = currentTime.getDate().toString().padStart(2, '0');
	  const hours = currentTime.getHours().toString().padStart(2, '0');
	  const minutes = currentTime.getMinutes().toString().padStart(2, '0');
	  const seconds = currentTime.getSeconds().toString().padStart(2, '0');
	  const formattedDate = year + '-' + month + '-' + day + ' ' + hours + ':' + minutes + ':' + seconds;
	  console.log(formattedDate)
	  document.querySelector("#" + element_id).value = formattedDate;
	}
  
  function sumitModelForm(event){
		console.log(event.target)

	  event.preventDefault();
	  
		   const formData = new FormData(event.target);
		    console.log([...formData.entries()]); // Logging form data	console.log(formData)
	    $.ajax({
	        type: "POST",
	        url: "DB/UpdateOutAndInTime.jsp",
	        data: formData,
	        processData: false, // Prevent jQuery from processing the data
	        contentType: false, // Set content type to false
	        success: function (response) {
	          console.log(response.trim());
	          if (response.trim() === "1") {
	            Swal.fire({
	              title: "User is Verified ",
	              text: "Click OK to continue!",
	              icon: "success",
	            }).then((res) => {
	             window.location.reload()
	            });
	          } else {
	            Swal.fire({
	              icon: "error",
	              title: "Soething Went Wrong !!",
	              text: response.trim().slice(1),
	            });
	          }
	        },
	      });
  }
</script>
</body>
</html>