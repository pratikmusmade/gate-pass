<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.cj.xdevapi.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%
 if(session.getAttribute("studentId") == null){
  response.sendRedirect("StudentLogin.jsp"); 
  }  
%>
<%
String studentId = (String) session.getAttribute("studentId");
String wardenId = (String) session.getAttribute("wardenId");
System.out.println("Student Id " + studentId);
System.out.println("Warden Id " + wardenId);
String wardenFullName = "";
String studetntFullName = "";
ResultSet rs;
String query = " select firstName, middleName, lastName from student where id=" + studentId;
String query1 = " select firstName, middleName, lastName from warden where id=" + wardenId;
Connection con = ConnectionProvider.getConnection();
PreparedStatement pstm = con.prepareStatement(query);
rs = pstm.executeQuery();
while (rs.next()) {
	studetntFullName += rs.getString("firstName") + rs.getString("middleName") + rs.getString("lastName");
}
pstm = con.prepareStatement(query1);
rs = pstm.executeQuery();

while (rs.next()) {
	wardenFullName += rs.getString("firstName") + rs.getString("middleName") + rs.getString("lastName");
}
%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../Components/Header.jsp"></jsp:include>
</head>
<body style="background-image: url('../assects/images/circle.svg')"
	style="background-repeat:norepeat">

	<jsp:include page="../Components/StudentNavBar.jsp"></jsp:include>

	<div class="container mt-1">

		<div class="row">

			<div class="col-lg-1"></div>
			<div class="col-lg-10">
				<h1 class="p-2 rounded-3 text-white fw-bold">Gate Pass Request</h1>
				<form action="DB/GatePassRequestDB.jsp" id="gatePassRequest"
					class="row g-3 m-2 px-4 pb-4 border border-dark border-2 bg-dark text-white rounded">
					<div class="col-md-4">
						<div class="mb-3 mt-1">
							<label for="student_Name" class="form-label">Student Name</label>
							<input type="text" class="form-control" id="student_id"
								value="<%=studetntFullName%>" placeholder="student_id"
								name="student_id" readonly required>
						</div>
					</div>
					<div class="col-md-4">
						<div class="mb-3 mt-1">
							<label for="student_Name" class="form-label">Warden Name</label>
							<input type="text" class="form-control" id="warden_id"
								value="<%=wardenFullName%>" placeholder="warden_ id"
								name="warden_id" readonly required>
						</div>
					</div>

					<div class="col-md-4">
						<div class="mb-3 mt-1">
							<label for="dateInput" class="form-label">Date</label> <input
								type="date" id="dateInput" name="dateInput" class="form-control"
								required>
							
						</div>
					</div>
					<div class="mb-1">
						<label for="comment" class="form-label">Message</label>
						<textarea class="form-control" rows="5" 
							name="EnterMessage" required></textarea>


					</div>

					<input type="hidden" id="student_Id" name="student_Id"
						value="<%=studentId%>"> <input type="hidden"
						id="warden_Id" name="warden_Id" value="<%=wardenId%>">
					<div class="mb-1 text-center">
						<button type="submit" class="btn btn-success fw-bold px-4 py-2">Send
							Request</button>
					</div>
				</form>
			</div>
		</div>

		<div class="row mt-5">
			<div class="col-lg-1"></div>
			<div class="col-lg-10">
				<h1 class="text-white fw-bold">Sent Requests</h1>
				<table
					class="table table-bordered table-dark table-striped border border-light rounded">
					<thead>
						<tr class="table-info">
							<th>Sr</th>
							<th>Rector Name</th>
							<th>Request Date</th>
							<th>Request Status</th>
							<th class="text-center">Action</th>
						</tr>
					</thead>
					<tbody id="statusResponse">
						<%
						PreparedStatement stmt = con.prepareStatement("select * from request where student_id = ? and status='pending'");
						stmt.setString(1, studentId);
						rs = stmt.executeQuery();

						int i = 1;
						while (rs.next()) {
							String status = rs.getString("status");
						%>
						<tr>
							<td><%=i%></td>
							<td><%=rs.getString("student_id")%></td>
							<td><%=rs.getString("request_date")%></td>
							<td><%=status%></td>
							<td class="text-center">
								<button type="button" class="btn btn-danger px-4"
								onclick="deleteRequest(<%=rs.getString("id") %>)"
								>Delete</button>
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
	<script type="text/javascript">
    $(document).ready(function () {
  	  
        $("#gatePassRequest").submit(function (e) {
          e.preventDefault();
          $.ajax({
            type: "POST",
            url: "DB/GatePassRequestDB.jsp",
            data: $("#gatePassRequest").serialize(),
            success: function (response) {
            	console.log(response.trim())
              if (response.trim()[0] === "1") {
                Swal.fire({
                  title: "Request Sent Successfully",
                  text: "Click OK to continue!",
                  icon: "success",
                }).then((res) => {
                  window.location.reload();
                });
              } else {
                Swal.fire({
                  icon: "error",
                  title: "Oops...",
                  text: response.trim().slice(1),
                });
              }
            },
          });
        });
      });
    
    function deleteRequest(requestId){
        $.ajax({
            type: "POST",
            url: "DB/DeleteRequest.jsp",
            data: {requestId},
            success: function (response) {
            	console.log(response.trim())
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
    
    var today = new Date().toISOString().split('T')[0];
    document.getElementById("dateInput").setAttribute("min", today);
	</script>

</body>
</html>
