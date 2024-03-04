<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@page import="java.sql.*"%>
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
<body style="background-image: url('../assects/images/circle.svg')"
	style="background-repeat:norepeat">


<jsp:include page="../Components/RectorNavBar.jsp"></jsp:include>
		<div class="container">
			<div class="row justify-content-center">

				<div
					class="col-sm-8 mt-3 p-2 pt-0 border border-dark border-2 rounded alert-secondary">
					<form class="p-3 border-2  rounded" action="DB/AddBranchDB.jsp"
						id="addClass">
						
						<div class="mb-3">
							<label for="exampleInput"
								class="form-label w-100 h1 bg-dark text-white p-2 rounded-3">Add
								Year</label> <input type="text" class="form-control" id="exampleInput"
								aria-describedby="textHelp" name="yearName" required />
						</div>
						<button type="submit" class="btn btn-primary px-4"
							id="year-submit-btn">Submit</button>
						<button type="button" class="btn btn-danger" id="cancleBtn"
							style="display: none">Cancel</button>
					</form>
				</div>

			</div>
		</div>

		<div class="container mt-4">
			<div class="row justify-content-center">

				<div class="col-lg-8 shadow">
					<h2 class="text-white">Year List</h2>
					<table class="table table-bordered table-info table-striped">
						<thead>
							<tr class="table-dark">
								<th scope="col">Sr .</th>
								<th scope="col">Class</th>
								<th scope="col" style="vertical-align: bottom;">Operation</th>

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
								<td><button type="button" class="btn btn-warning"
										onclick="updateYear(<%=rs.getString("id")%>,'<%=rs.getString("year_name")%>')">Update</button>
									&nbsp &nbsp
									<button type="button" class="btn btn-danger"
										onclick="deleteYear(<%=rs.getString("id")%>,'<%=rs.getString("year_name")%>')"
										id="deleteBranch">Delete</button></td>
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
	
	
	
	const cancelBtn = document.querySelector("#cancleBtn");
	const inputYear = document.querySelector("#exampleInput");
	const submitBtn = document.querySelector("#year-submit-btn");
	let requestUrl = "DB/AddYearDB.jsp";
	
	cancelBtn.addEventListener("click",(e)=>{
		e.preventDefault();
		cancelBtn.style.display = "none"
		submitBtn.className = "btn btn-primary px-4"
		submitBtn.innerHTML = "Add Year"
		requestUrl = "DB/AddYearDB.jsp";
		inputYear.value = ""
	})	
	
	function updateYear(yearId,yearName){
		submitBtn.className = "btn btn-success"
		submitBtn.innerHTML = "Update Year"
		inputYear.value = yearName
		cancelBtn.style.display = "inline-block"
		requestUrl = "DB/UpdateYearDB.jsp?yearId=" + yearId;
		inputYear.focus()
	}
	
      $(document).ready(function () {
        $("#addClass").submit(function (e) {
          e.preventDefault();
          $.ajax({
            type: "POST",
            url: requestUrl,
            data: $("#addClass").serialize(),
            success: function (response) {
            	console.log(" ==> ",response.trim())
              if (response.trim()[0] === "1") {
                Swal.fire({
                  title: "Year "+ response.trim().slice(1) + " Successfully",
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
      
      
      
	    function deleteYear(yearId,yearName){
			Swal.fire({
	            icon: "warning",
				  title: "Are you sure !!?",
				  text:"DELETE (" + yearName + "Branch !!)",
				  showDenyButton: true,
				  confirmButtonText: "Yes",
				  denyButtonText: `Cancel`
				}).then((result) => {
				  if (result.isConfirmed) {
					  $.ajax({
					        url: "DB/DeleteYear.jsp",
					        type: "POST",
					        data: {yearId},
					        success: function(response) {
					              if (response.trim() === "1") {
					                  Swal.fire({
					                    title: "Branch Deleted Successfully",
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
					        error: function(xhr, status, error) {
					          console.log("Error:", error);
					        }
					      });
				  } else if (result.isDenied) {
				    Swal.fire("Branch Not Deleted", "", "info");
				  }
				});
		}
      
    </script>

	<jsp:include page="../Components/Footer.jsp"></jsp:include>
</body>
</html>
