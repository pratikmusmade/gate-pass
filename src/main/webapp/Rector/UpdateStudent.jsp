<%@page import="com.gatePass.helper.QueriesProvider"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.cj.xdevapi.Statement"%>
<%@page import="java.sql.PreparedStatement"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>Bootstrap demo</title>
<jsp:include page="../Components/Header.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="../Components/NavBar.jsp"></jsp:include>

	<div class="container pt-3">
		<div class="row">
			<div class="col-lg-2"></div>
			<div class="col-lg-8">
				<h1>Update Student</h1>
				<%
				
				String studentId = request.getParameter("studentId");
				Connection con = ConnectionProvider.getConnection();
				String query = QueriesProvider.queryForStudentInfoWithBranchAndYearId + "where student.id = " + studentId;
				PreparedStatement pstm = con.prepareStatement(query);
				ResultSet rs = pstm.executeQuery();
				PreparedStatement pstm2;
				ResultSet rs2;
				
				while (rs.next()) {
					System.out.println("hh");
					
				%>
				<form class="row g-3" novalidate method="post" id="updateStudent"
					enctype="multipart/form-data">

					<div class="col-md-4">
						<label for="validationServer01" class="form-label">First
							name</label> <input type="text" class="form-control is-valid"
							id="validationServer01" name="firstName"
							value="<%=rs.getString("firstName")%>" required />
						<div class="valid-feedback">Looks good!</div>
					</div>
					<div class="col-md-4">
						<label for="validationServer02" class="form-label">Middle
							name</label> <input type="text" class="form-control is-valid"
							id="validationServer02" name="middleName"
							value="<%=rs.getString("middleName")%>" required />
						<div class="valid-feedback">Looks good!</div>
					</div>

					<div class="col-md-4">
						<label for="validationServer03" class="form-label">Last
							name</label> <input type="text" class="form-control is-valid"
							id="validationServer03" name="lastName"
							value="<%=rs.getString("lastName")%>" required />
						<div class="valid-feedback">Looks good!</div>
					</div>

					<div class="col-md-6">
						<label for="validationServer04" class="form-label">Enrollment
							Number</label> <input type="number" class="form-control is-valid"
							id="validationServer04" name="enrollmentNumber"
							value="<%=rs.getString("enrolment_number")%>" required />
						<div class="valid-feedback">Looks good!</div>
					</div>

					<div class="col-md-3">
						<label for="validationServer05" class="form-label">Year</label> <select
							class="form-select is-invalid" id="validationServer05"
							aria-describedby="validationServer05Feedback" name="yearId"
							required>
							<option selected value="<%=rs.getString("year_id")%>"><%=rs.getString("year_name")%></option>
							<%
							System.out.print("select * from acc_year where id <>" + rs.getString("year_id"));

							pstm2 = con.prepareStatement("select * from acc_year where acc_year.id <> " + rs.getString("year_id"));
							rs2 = pstm2.executeQuery();
							while (rs2.next()) {
							%>
							<option value="<%=rs2.getString("id")%>">
								<%=rs2.getString("year_name")%></option>
							<%
							}
							%>
						</select>
						<div id="validationServer05Feedback" class="invalid-feedback">
							Please select a valid state.</div>
					</div>

					<div class="col-md-3">
						<label for="validationServer06" class="form-label">Branch</label>
						<select class="form-select is-invalid" id="validationServer06"
							aria-describedby="validationServer06Feedback" name="branchId"
							required>
							<option selected value="<%=rs.getString("branch_id")%>"><%=rs.getString("branch_name")%></option>
							<%
							pstm2 = con.prepareStatement("select * from branch where id <>" + rs.getString("branch_id"));
							rs2 = pstm2.executeQuery();
							while (rs2.next()) {
							%>
							<option value="<%=rs2.getString("id")%>"><%=rs2.getString("branch_name")%></option>
							<%
							}
							%>
						</select>
						<div id="validationServer06Feedback" class="invalid-feedback">
							Please select a valid state.</div>
					</div>



					<div class="col-md-6">
						<label for="validationServer07" class="form-label">Phone
							Number</label> <input type="number" class="form-control is-valid"
							id="validationServer07" name="phoneNumber" required />
						<div class="valid-feedback">Looks good!</div>
					</div>



					<div class="col-md-1">
						<label for="validationServer08" class="form-label"> Image</label>
						<img src="<%=rs.getString("student_image")%>"
							class="img-thumbnail m-0 p-0" alt="...">
					</div>
					<div class="col-md-4">
						<label for="validationServer08" class="form-label">
							Student Image</label> <input type="file" class="form-control is-valid"
							id="validationServer08" name="studentImage" required />
						<div class="valid-feedback">Looks good!</div>
					</div>



					<div class="col-md-6">
						<label for="validationEmail" class="form-label">Email</label> <input
							type="email" class="form-control is-invalid" id="validationEmail"
							aria-describedby="validationServer03Feedback" name="email"
							value="<%=rs.getString("email")%>" required />
						<div id="validationServer03Feedback" class="invalid-feedback">
							Please provide a valid email.</div>
					</div>


					<div class="col-md-6">
						<label for="validationPassword" class="form-label">Password</label>
						<input type="password" class="form-control is-invalid"
							id="validationPassword" value="<%=rs.getString("pass")%>"
							aria-describedby="validationServer03Feedback" name="password"
							required />
						<div id="validationServer03Feedback" class="invalid-feedback">
							Please provide a valid password.</div>
					</div>

					<div class="col-md-6">
						<label for="floatingTextarea" class="form-label">Enter
							Address</label>
						<div class="form-floating">
							<textarea class="form-control is-valid"
								placeholder="Leave a comment here" id="floatingTextarea"
								name="address">
								<%=rs.getString("address")%>
								</textarea>
						</div>
						<div class="valid-feedback">Looks good!</div>
					</div>

					<div class="col-12">
						<button class="btn btn-primary" type="submit">Update</button>
					</div>

				</form>
				<%
				}
				%>

			</div>
		</div>
	</div>
	<jsp:include page="../Components/Footer.jsp"></jsp:include>
	<script type="text/javascript">
	
		$(document).ready(function() {
			$("#updateStudent").submit(function(event) {
				event.preventDefault();
				let f = new FormData($(this)[0]);
				
				 $.ajax({
				 type : "POST",
				 enctype : "multipaet/form-data",
				 url :"DB/UpdateStudentDB.jsp?studentId=<%=studentId%>",
				 data : f,
				 processData : false,
				 contentType : false,
				 cache : false,
				 success : function(response) {
					 console.log(response.trim())
				 if (response.trim() === "1") {
					 
				 Swal.fire({
				 title : "Student Added Successfully",
				 text : "Click ok to continue !",
				 icon : "success"
				 }).then(()=>{
				 window.location.reload();
				 });
				 }else{
				 Swal.fire({
				 title: "Something went wrong !!",
				 text: "Click ok to continue ",
				 icon: "error"
				 });
				 }
				 },
				 }); 
			});
		});
		
	</script>
</body>
</html>
