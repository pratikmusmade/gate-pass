<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.cj.xdevapi.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%/* if(session.getAttribute("studentsession") == null){
  System.out.print("Null hghf");
  response.sendRedirect("StudentLogin.jsp"); */
%>

 <%
/*  }  */
 
 %>
<%
	String studentId = "1";
	String wardenId = "1";
	String wardenFullName = "";
	String studetntFullName = "";
	ResultSet rs ;
	String query = " select firstName, middleName, lastName from student where id=" + studentId;
	String query1 = " select firstName, middleName, lastName from warden where id=" + wardenId;
	Connection con = ConnectionProvider.getConnection();
	PreparedStatement pstm = con.prepareStatement(query);
	rs = pstm.executeQuery();
	while(rs.next()){
		studetntFullName += rs.getString("firstName") + rs.getString("middleName") + rs.getString("lastName");
	}
	pstm = con.prepareStatement(query1);
	rs = pstm.executeQuery();

	while(rs.next()){
		wardenFullName += rs.getString("firstName") + rs.getString("middleName") + rs.getString("lastName");
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>

</head>
<body>

	<jsp:include page="../Components/Header.jsp"></jsp:include>


	<div class="container mt-3" style="margin-left: 350px;">
		<h3>Form Validation</h3>


		<form action="DB/RequestStudentDB.jsp" class="was-validated">
			<div class="mb-3 mt-3 col-md-6">
				<label for="student_Name" class="form-label">Student Name</label> <input
					type="text" class="form-control" id="student_id" 
					value="<%=studetntFullName %>"
					placeholder="student_id" name="student_id" readonly required>
			</div>
			<div class="mb-3 mt-3 col-md-6">
				<label for="student_Name" class="form-label">Warden Name</label> <input
					type="text" class="form-control" id="warden_id"
					value="<%=wardenFullName %>"
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
