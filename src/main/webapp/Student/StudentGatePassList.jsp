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
							<th>Secrate-Key</th>
						</tr>
					</thead>
					<tbody id="statusResponse">
						<%
						String studentId = (String) session.getAttribute("studentId");
						Connection con = ConnectionProvider.getConnection();
						String query = "SELECT gatepass.*, request.*, student.* " + "FROM gatepass "
								+ "INNER JOIN request ON gatepass.request_id = request.id "
								+ "INNER JOIN student ON request.student_id = student.id " + "WHERE request.student_id = ?";
						PreparedStatement stmt = con.prepareStatement(query);
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
							<td><a><%=rs.getString("secret_key_status")%></a></td>
							<td>
								<%=rs.getString("secret_key") %>
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