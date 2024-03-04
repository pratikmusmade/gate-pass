<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
 if(session.getAttribute("studentId") == null){
  response.sendRedirect("StudentLogin.jsp"); 
  }  
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<jsp:include page="../Components/Header.jsp"></jsp:include>

</head>
<body style="background-image: url('../assects/images/circle.svg')"
	style="background-repeat:norepeat">
	<jsp:include page="../Components/StudentNavBar.jsp"></jsp:include>

	<div class="container">
		<h1 class="p-2 rounded-3 text-white fw-bold">Request List</h1>
		<div class="row mt-5">
			<div class="col-lg-1"></div>

			<div class="col-lg-10">
				<table
					class="table table-bordered table-dark table-striped border border-light rounded">
					<thead>
						<tr class="table-info">
							<th>Sr No.</th>
							<th>Student Name</th>
							<th>Date</th>
							<th>Message</th>
							<th id="statusToggleColumn">Status Action</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody id="statusResponse">
						<%
						String studentId = (String) session.getAttribute("studentId");
						Connection con = ConnectionProvider.getConnection();
						String sqlQuery = "SELECT " + "   s.id AS student_id, " + "   s.firstName, " + "   s.middleName, " + "   s.lastName, "
								+ "   s.enrolment_number, " + "   s.address, " + "   s.email, " + "   r.id AS request_id, " + "   r.message, "
								+ "   r.warden_id, " + "   r.current_date, " + "   r.request_date, " + "   r.status " + "FROM "
								+ "   student s " + "JOIN " + "   request r ON s.id = r.student_id " + "WHERE " + "   r.student_id = ?";
						PreparedStatement stmt = con.prepareStatement(sqlQuery);
						stmt.setString(1, studentId);
						ResultSet rs = stmt.executeQuery();

						int i = 1;
						while (rs.next()) {
							String fullName = rs.getString("firstName") + " " + rs.getString("middleName") + " " + rs.getString("lastName")
							+ " ";
						%>
						<tr>
							<td><%=i%></td>
							<td><%=fullName%></td>
							<td><%=rs.getString("request_date")%></td>
							<td><%=rs.getString("message")%></td>

							<td><a><%=rs.getString("status")%></a></td>
							<td class="text-center">
								<%
							if (rs.getString("status").equals("pending")) {
							%>
								<button type="button" class="btn btn-danger px-4"
									onclick="deleteRequest(<%=rs.getString("request_id")%>)">Delete</button>

								<%
								} else {
								%>
								<button class="btn btn-danger px-4" type="button"
									disabled="disabled">Delete</button> <%
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
	<script type="text/javascript">
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
	</script>
</body>
</html>