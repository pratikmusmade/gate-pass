<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<style type="text/css">
body {
	width: 100vw;
	height: 100vh;
	display: flex;
	align-items: center;
}
</style>
</head>
<body
	style="background-image: url('../assects/images/wave.svg'); background-repeat: no-repeat; background-attachment: fixed; background-size: cover">
	<div class="container ">
		<div class="row">
			<div class="col-lg-5"></div>
			<div class="col-lg-6 shadow bg-grey text-white px-3">
				<form id="adminLoginForm" autocomplete="off">
					<h1 class="text-center">Watchman Login</h1>
					<div id="invalid-credentials-alert-box"></div>

					<div class="mb-3">
						<label for="exampleInputEmail1" class="form-label">User
							Name</label> <input type="text" class="form-control"
							id="exampleInputEmail1" name="userName" required="required">
					</div>
					<div class="mb-3">
						<label for="exampleInputPassword1" class="form-label">Password</label>
						<input type="password" class="form-control"
							id="exampleInputPassword1" name="password" required="required">
					</div>
					<div class="d-flex justify-content-center mb-3 mt-3">
						<button type="submit" class="btn btn-info px-5">Login</button>
					</div>
				</form>
			</div>

		</div>

	</div>
	<jsp:include page="../Components/Footer.jsp"></jsp:include>
	<script type="text/javascript">

const alertBox= document.querySelector("#invalid-credentials-alert-box");
console.log(alertBox);
const alerBoxCode = `
	<div class="alert alert-danger alert-dismissible fade show"
	role="alert">
	<i class="bi bi-exclamation-octagon-fill"></i>
	<strong>Invalid Credentials!</strong> Your User-Name or Password is <strong>Incorrect !!!</strong>
	<button type="button" class="btn-close" data-bs-dismiss="alert"
		aria-label="Close"></button>
</div>`
$(document).ready(function () {
  
$("#adminLoginForm").submit(function (e) {
  e.preventDefault();
  $.ajax({
    type: "POST",
    url: "DB/WatchManLoginDB.jsp",
    data: $("#adminLoginForm").serialize(),
    success: function (response) {        	
      if (response.trim()[0] === "1") {
        Swal.fire({
          title: "Login Successful",
          text: "Click OK to continue!",
          icon: "success",
        }).then((res) => {
          window.location = "ApprovedGatePassList.jsp";
        });
      } else {
    	  alertBox.innerHTML = alerBoxCode
      }
    },
  });
});
});

</script>
</body>
</html>