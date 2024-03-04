<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%
if(session.getAttribute("user") == null){
	  response.sendRedirect("RectorLogin.jsp"); 
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student Request List</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

</head>
<body>

	<jsp:include page="../Components/Header.jsp"></jsp:include>


	<div class="container mt-3">
		<h2>Sneha</h2>
		<p>Student Request Table</p>


		<form method="post" id="filter-form">
		

					<div class="col-lg-3 " style="float: right;margin-right: 80px">

						<select class="form-select" aria-label="Default select example"
							id="SelectedStatus">
							<option selected value="0">--- Select Request Status ---</option>
							<%
							Connection con1 = ConnectionProvider.getConnection();
							PreparedStatement pstm = con1.prepareStatement("SELECT DISTINCT status FROM request");

							ResultSet rs1 = pstm.executeQuery();
							while (rs1.next()) {
							%>
							<option value="<%=rs1.getString("status")%>"><%=rs1.getString("status")%></option>
							<%
							}
							%>
						</select>
						
					</div>
				
					
		</form>
	</div>
	<br>
	<br>
	<table class="table table-striped">
		<thead>
			<tr>
				<th>Sr No.</th>
				<th>Student Name</th>
				<th>Date</th>
				<th>Message</th>
				<th>Status Update</th>
			</tr>
		</thead>
		<tbody  id="statusResponse">
			<%
			Connection con = ConnectionProvider.getConnection();
			PreparedStatement stmt = con.prepareStatement("select * from request");
			ResultSet rs = stmt.executeQuery();

			int i = 1;
			while (rs.next()) {
			%>
			<tr>
				<td><%=i%></td>
				<td><%=rs.getString("student_id")%></td>
				<td><%=rs.getString("request_date")%></td>
				<td><%=rs.getString("message")%></td>
				
				<td><a><%=rs.getString("status")%></a></td>
			</tr>
			<%
			i++;
			}
			%>
		</tbody>
	</table>
	
 <script>
		$(document).ready(function() {
			$('#SelectedStatus').change(function() {
				var selectedStatus = $(this).val();
						
				$.ajax(
							{
							url:"StudentRequestDataRector.jsp",
							type:"get",
							data:"type="+$(this).val(),
							success:function(r){
								if(r.trim()!="")
									{
									
									
									$("#statusResponse").html(r);
									}
									
							}
						
						});
			});
		});
	</script> 
</body>
</html>
