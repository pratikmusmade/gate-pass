<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.cj.xdevapi.Statement"%>
<%@page import="java.sql.PreparedStatement"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>

</head>
<body>

	<jsp:include page="../Components/Header.jsp"></jsp:include>
	<jsp:include page="../Components/NavBar.jsp"></jsp:include>


	<div class="container mt-3" style="margin-left: 350px;">
		<h3>Form Validation</h3>


		<form action="DB/RequestStudentDB.jsp" class="was-validated">
			<div class="mb-3 mt-3 col-md-6">
				<label for="student_Name" class="form-label">Student Name</label> <input
					type="text" class="form-control" id="student_id"
					placeholder="student_id" name="student_id" readonly required>
			</div>
			<div class="mb-3 mt-3 col-md-6">
				<label for="student_Name" class="form-label">Warden Name</label> <input
					type="text" class="form-control" id="warden_id"
					placeholder="warden_ id" name="warden_id" readonly required>
			</div>

			<div class="mb-3 mt-3 col-md-6">
				<label for="dateInput" class="form-label">Date</label> <input type="date"
					id="dateInput" name="dateInput" class="form-control" required>
<div class="valid-feedback">Valid.</div>
				<div class="invalid-feedback">Please fill out this field.</div>

			</div>




			<div class="mb-3 col-md-6">
				<label for="comment" class="form-label">Message</label>
				<textarea class="form-control" rows="5" id="EnterMessage"
					name="EnterMessage" required></textarea>
				<div class="valid-feedback">Valid.</div>
				<div class="invalid-feedback">Please fill out this field.</div>

			</div>

			<input type="hidden" id="student_Id" name="student_Id"> <input
				type="hidden" id="warden_Id" name="warden_Id">

			<button type="submit" class="btn btn-primary">Submit</button>
		</form>
	</div>


</body>
</html>
