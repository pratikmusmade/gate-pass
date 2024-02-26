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

	<div class="container p-xl-4">
		<div class="row shadow" style="height: 300px;width: 700px; margin-left: 280px;margin-top: 20px">
			<div class="col-sm-4"></div>
			<div class="col-sm-4 mt-5 p-2">
				<form action="DB/AddBranchDB.jsp" id="addBranch">
					<h1>Add Branch</h1>
					<div class="mb-3" style="margin-left: -140px">
						<label for="exampleInput" class="form-label" >Enter Branch</label>
						<input type="text" class="form-control" id="exampleInput"
							aria-describedby="textHelp" style="width: 500px" name="branchName"  required/>
					</div>

					<button type="submit" class="btn btn-primary rounded rounded-pill px-4 mt-4"
						id="branch-submit-btn" style="margin-left: 50px">Add Branch</button>
					<button type="button" class="btn btn-danger" id="cancleBtn"
						style="display: none">Cancel</button>

				</form>
			</div>
		</div>
	</div>

	<div class="container mt-5" style="margin-right:200px">
		<div class="row ">
			<div class="col-lg-3"></div>
			<div class="col-lg-8 ">
				<h2>Branch List</h2>


				<table class="table table-striped table-hover ">
					<thead>
						<tr class="table-dark">
							<th scope="col">Sr .</th>
							<th scope="col">Branch</th>
							<th scope="col">Operation</th>
							<!-- 							<th scope="col"></th>
 -->
						</tr>
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
							<td><button type="button" class="btn btn-outline-warning rounded rounded-pill"
									onclick="updateBranch(<%=rs.getString("id")%>,'<%=rs.getString("branch_name")%>')">Update</button>
								&nbsp &nbsp
								<button type="button" class="btn btn-outline-danger rounded rounded-pill"
									onclick="delteBranch(<%=rs.getString("id")%>,'<%=rs.getString("branch_name") %> ')"
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

	<jsp:include page="../Components/Footer.jsp"></jsp:include>


	<script type="text/javascript">
	
	
	const cancelBtn = document.querySelector("#cancleBtn");
	const inputBranch = document.querySelector("#exampleInput");
	const submitBtn = document.querySelector("#branch-submit-btn");
	let requestUrl = "DB/AddBranchDB.jsp";

	
	
	cancelBtn.addEventListener("click",(e)=>{
		e.preventDefault();
		cancelBtn.style.display = "none"
		submitBtn.className = "btn btn-primary px-4"
		submitBtn.innerHTML = "Add Branch"
		requestUrl = "DB/AddBranchDB.jsp";
		inputBranch.value = ""
	})
	
	    function delteBranch(branchId,branchName){
		Swal.fire({
            icon: "warning",
			  title: "Are you sure !!?",
			  text:"DELETE (" + branchName + "Branch !!)",
			  showDenyButton: true,
			  confirmButtonText: "Yes",
			  denyButtonText: `Cancel`
			}).then((result) => {
			  if (result.isConfirmed) {
				  $.ajax({
				        url: "DB/DeleteBranch.jsp",
				        type: "POST",
				        data: {branchId},
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
	    
	    
	function updateBranch(branchId,branchName){
		submitBtn.className = "btn btn-success"
		submitBtn.innerHTML = "Update Branch"
		inputBranch.value = branchName
		cancelBtn.style.display = "inline-block"
		requestUrl = "DB/UpdateBranchDB.jsp?branchId=" + branchId;
		inputBranch.focus()
	}

      $(document).ready(function () {
    	  
        $("#addBranch").submit(function (e) {
          e.preventDefault();
          $.ajax({
            type: "POST",
            url: requestUrl,
            data: $("#addBranch").serialize(),
            success: function (response) {
            	
            	console.log(response.trim())
              if (response.trim()[0] === "1") {
                Swal.fire({
                  title: "Branch "+ response.trim().slice(1) + " Successfully",
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
