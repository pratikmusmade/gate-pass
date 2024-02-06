<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.mysql.cj.xdevapi.Statement"%>
<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Bootstrap demo</title>
<jsp:include page="../Components/Header.jsp"></jsp:include>
</head>
<body>
	<jsp:include page="../Components/NavBar.jsp"></jsp:include>

	<div class="container">
		<div class="row">
			<div class="col-sm-2"></div>
			<div class="col-sm-8 mt-5 p-2">
				<form action="DB/AddBranchDB.jsp" id="addClass">
					<h1>Add Class</h1>
					<div class="mb-3">
						<label for="exampleInput" class="form-label">Enter Class</label>
						<input type="text" class="form-control" id="exampleInput"
							aria-describedby="textHelp" name="className" />
					</div>

					<button type="submit" class="btn btn-primary px-4">Submit</button>
				</form>
			</div>
		</div>
	</div>

	<div class="container mt-5">
		<div class="row">
			<div class="col-lg-2"></div>
			<div class="col-lg-8">
				<h2>Branch List</h2>
				<table class="table">
					<thead>
						<tr>
							<th scope="col">Sr .</th>
							<th scope="col">Class</th>

						</tr>
					</thead>
					<tbody>
						<%
						Connection con = ConnectionProvider.getConnection();
						PreparedStatement stmt = con.prepareStatement("select * from acc_year");
						ResultSet rs = stmt.executeQuery();
						while (rs.next()) {
						%>
						<tr>
							<th scope="row"><%=rs.getString("id")%></th>
							<td><%=rs.getString("year_name")%></td>
						</tr>

						<%
						}
						%>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.1/dist/sweetalert2.all.min.js"></script>

	<script type="text/javascript">
      $(document).ready(function () {
        $("#addClass").submit(function (e) {
          e.preventDefault();
          $.ajax({
            type: "POST",
            url: "DB/AddYearDB.jsp",
            data: $("#addClass").serialize(),
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

	<jsp:include page="../Components/Footer.jsp"></jsp:include>
</body>
</html>
