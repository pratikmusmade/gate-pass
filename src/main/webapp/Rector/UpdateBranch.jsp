<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.mysql.cj.xdevapi.Statement"%>
<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
if(session.getAttribute("user") == null){
	  response.sendRedirect("RectorLogin.jsp"); 
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Bootstrap demo</title>
<jsp:include page="../Components/Header.jsp"></jsp:include>
</head>
<body>

	<div class="container">
		<div class="row">
			<div class="col-sm-2"></div>
			<div class="col-sm-8 mt-5 p-2">
				<form action="DB/AddBranchDB.jsp" id="addBranch">
					<h1>Add Branch</h1>
					<div class="mb-3">
						<label for="exampleInput" class="form-label">Enter Branch</label>
						<input type="text" class="form-control" id="exampleInput"
							aria-describedby="textHelp" name="branchName" required/>
					</div>

					<button type="submit" class="btn btn-primary px-4">Submit</button>
				</form>
			</div>
		</div>
	</div>

	<div class="container mt-5">
		<div class="row">
			<div class="col-lg-3"></div>
			<div class="col-lg-6">
				<h2>Branch List</h2>
				
				
				<table class="table  table-bordered">
					<thead>
						<tr>
							<th scope="col">Sr .</th>
							<th scope="col">Branch</th>
							<th scope="col">Operation</th>
<!-- 							<th scope="col"></th>
 -->						</tr>
					</thead>
					<tbody>
						<%
						Connection con = ConnectionProvider.getConnection();
						PreparedStatement stmt = con.prepareStatement("select * from branch");
						ResultSet rs = stmt.executeQuery();
						while (rs.next()) {
						%>
						<tr>
							<th scope="row"><%=rs.getString("id")%></th>
							<td><%=rs.getString("branch_name")%></td>
							<td><a type="button" class="btn btn-outline-warning"
									href="UpdateBranch.jsp?wardenId=<%=rs.getString("id")%>">Update</a>
							&nbsp &nbsp<a type="button" class="btn btn-outline-danger  "
									href="DeleteBranch.jsp?wardenId=<%=rs.getString("id")%>">Delete</a>
							
							</td>
						</tr>

						<%
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
        $("#addBranch").submit(function (e) {
          e.preventDefault();
          $.ajax({
            type: "POST",
            url: "DB/AddBranchDB.jsp",
            data: $("#addBranch").serialize(),
            success: function (response) {
              if (response.trim() === "1") {
                Swal.fire({
                  title: "Branch Added Successfully",
                  text: "Click OK to continue!",
                  icon: "success",
                }).then((res) => {
                  window.location.reload();
                });
              } else {
                Swal.fire({
                  icon: "error",
                  title: "Oops...",
                  text: "Something went wrong!",
                });
              }
            },
          });
        });
      });
    </script>

</body>
</html>
