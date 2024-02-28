<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.mysql.cj.xdevapi.Statement"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Bootstrap demo</title>
<jsp:include page="../Components/Header.jsp"></jsp:include>
</head>
<body style="background-image: url('../assects/images/circle.svg')"
	style="background-repeat:norepeat">
	<%
	Connection con = ConnectionProvider.getConnection();
	PreparedStatement pstm;
	ResultSet rs;
	%>
	<div class="container mt-4">
		<div class="row shadow bg-dark text-white  p-3"
			style="margin-right: 200px; margin-left: 200px">
			<div class="col-lg-2"></div>
			<div class="col-lg-8">
				<h1>Add Student</h1>



				<form class="row g-3" novalidate method="post" name="myForm" id="addWaredn"
					enctype="multipart/form-data">
					<div class="col-md-4">
						<label for="validationServer01" class="form-label">First

							name</label> <input type="text" class="form-control"
							id="validationServer01" name="firstName"  onblur="validate(event,'fname-validation')" required />
							<small
								class="text-danger" id="fname-validation"></small>
					</div>
					<div class="col-md-4">
						<label for="validationServer02" class="form-label">Middle
							name</label> <input type="text" class="form-control" id="validationServer02" name="middleName"
				onblur="validate(event,'midName-validation')" required /> <small
							class="text-danger" id="midName-validation"></small>
												</div>

					<div class="col-md-4">
						<label for="validationServer03" class="form-label">Last
							name</label> <input type="text" class="form-control "
							id="validationServer03" name="lastName"
							onblur="validate(event,'lastName-validation')" required /> <small
							class="text-danger" id="lastName-validation"></small>
										</div>

					<div class="col-md-6">
						<label for="validationServer04" class="form-label">Enrollment
							Number</label> <input type="number" class="form-control "
							id="validationServer04" name="enrollmentNumber"
							onblur="validate(event,'enrollmentNumber-validation')" required />
						<small class="text-danger" id="enrollmentNumber-validation"></small>
						</div>

					<div class="col-md-3">
						<label for="validationServer05" class="form-label">Year</label> <select
							class="form-select " id="validationServer05"
							aria-describedby="validationServer05Feedback" name="yearId"
							onblur="validate(event,'year-validation')" required>
													<option selected disabled value="">Select Year</option>
							<%
							pstm = con.prepareStatement("select * from acc_year");
							rs = pstm.executeQuery();
							while (rs.next()) {
							%>
							<option value="<%=rs.getString("id")%>"><%=rs.getString("year_name")%></option>
							<%
							}
							%>
						</select>
						<div id="validationServer05Feedback" class="invalid-feedback">
							Please select a valid Year.</div>
						<small class="text-danger" id="year-validation"></small>
						
					</div>

					<div class="col-md-3">
						<label for="validationServer06" class="form-label">Branch</label>
						<select class="form-select " id="validationServer06"
							aria-describedby="validationServer06Feedback" name="branchId"
							onblur="validate(event,'branch-validation')" required>
													<option selected disabled value="">Select Branch</option>
							<%
							pstm = con.prepareStatement("select * from branch");
							rs = pstm.executeQuery();
							while (rs.next()) {
							%>
							<option value="<%=rs.getString("id")%>"><%=rs.getString("branch_name")%></option>
							<%
							}
							%>
						</select> <small class="text-danger" id="branch-validation"></small>
					</div>
						

					<div class="col-md-6">
						<label for="validationServer07" class="form-label">Phone
							Number</label> <input type="number" class="form-control"
							id="validationServer07" name="phoneNumber"
							onblur="validate(event,'phone-validation')" required /> <small
							class="text-danger" id="phone-validation"></small>
											</div>


					<div class="col-md-6">
						<label for="validationServer08" class="form-label">Student
							Image</label> <input type="file" class="form-control "
							id="validationServer08" name="studentImage"
							onblur="validate(event,'studImg-validation')" required /> <small
							class="text-danger" id="studImg-validation"></small>
									</div>



					<div class="col-md-6">
						<label for="validationEmail" class="form-label">Email</label> <input
							type="email" class="form-control " id="validationEmail"
							aria-describedby="validationServer03Feedback" name="email"
							onblur="validate(event,'email-validation')" required /> <small
							<div id="validationServer03Feedback" class="invalid-feedback">
					Please provide valid email-id.</div>
							class="text-danger" id="email-validation"></small>

													</div>


					<div class="col-md-6" style="margin-left:140px">
						<label for="validationPassword" class="form-label">Password</label>
						<input type="password" class="form-control "
							id="validationPassword"
							aria-describedby="validationServer03Feedback" name="password"
							onblur="validate(event,'password-validation')" required />
						<div id="validationServer03Feedback" class="invalid-feedback">
						</div>
						<small class="text-danger" id="password-validation"></small>
								</div>

					<div class="col-md-6" style="margin-left:140px">
						<label for="floatingTextarea" class="form-label">Enter
							Address</label>
						<div class="form-floating">
							<textarea class="form-control "
								placeholder="Leave a comment here" id="floatingTextarea"
								name="address" onblur="validate(event,'address-validation')"></textarea>
						</div>
						<small class="text-danger" id="address-validation"></small>
					</div>

					<div class="col-12 mt-3"style="margin-left:140px">
						<button class="btn btn-primary" type="submit">Submit form</button>
					</div>

				</form>
			</div>
		</div>
	</div>
	<jsp:include page="../Components/Footer.jsp"></jsp:include>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#addWaredn").submit(function(event) {
				event.preventDefault();
				let f = new FormData($(this)[0]);

				$.ajax({
					type : "POST",
					enctype : "multipaet/form-data",
					url : "DB/AddStudentDB.jsp",
					data : f,
					processData : false,
					contentType : false,
					cache : false,
					success : function(response) {
						if (response.trim() === "1") {
							Swal.fire({
								title : "Student Added Successfully",
								text : "Click ok to continue !",
								icon : "success"
							}).then(()=>{
				                  window.location.reload();
							});
						}else{
							Swal.fire({
								  title: "Something went wrong !!",
								  text: "Click ok to continue ",
								  icon: "error"
								});
						}
					},
				});
			});
		});
		
		
		
		const firstName = document.myForm.firstName
	    const middleName = document.myForm.middleName
	    const lastName= document.myForm.lastName
	    const enrollmentNumber= document.myForm.enrollmentNumber
	    const yearId = document.myForm.yearId
	   const branchId = document.myForm.branchId
	    const phoneNumber = document.myForm.phoneNumber
	    const studentImage = document.myForm.studentImage
	    const email = document.myForm.email
	    const password =document.myForm.password
	    const address = document.myForm.address
	    const nameRegex = /^[a-zA-Z]+$/;
	  	const emailRegex = /@/;
	  const	phoneNumberRegex = /^\d{10}$/



function validate(event,targetedValue){
 
 
 if(event.target.value){
	 
 		if(targetedValue === "email-validation")
		{
 			
 			
			 if(emailRegex.test(event.target.value)){
				 
	 	     	    valid(targetedValue)
		 	 }else{
		 		 
				 	invalid(targetedValue,"Email must contain @ ")
				  }
		 }else if(targetedValue === "fname-validation")
		{
			 if(nameRegex.test(event.target.value)){
	 	     	    valid(targetedValue)
		 	 }else{ 
				 	invalid(targetedValue,"conatins only characters")
				  }
		 }else if(targetedValue === "midName-validation")
		{
			 if(nameRegex.test(event.target.value)){
	 	     	    valid(targetedValue)
		 	 }else{ 
				 	invalid(targetedValue,"conatin only characters")
				  }
		 }else if(targetedValue === "lastName-validation")
		{
			 if(nameRegex.test(event.target.value)){
	 	     	    valid(targetedValue)
		 	 }else{ 
				 	invalid(targetedValue,"conatin only characters")
				  }
		 }else if(targetedValue === "phone-validation")
		{
			 if(phoneNumberRegex.test(event.target.value)){
	 	     	    valid(targetedValue)
		 	 }else{ 
				 	invalid(targetedValue,"number should have 10 digit")
				  }
		 }else if(targetedValue === "password-validation")
		   {
			 const passwordInput = event.target.value
			 const minLength = 8;
			 const hasUppercase = /[A-Z]/.test(passwordInput);
			 const hasLowercase = /[a-z]/.test(passwordInput);
	 	   	 const hasNumber = /\d/.test(passwordInput);
			 const hasSpecialChar = /[!@#$%^&*(),.?:{}|<>]/.test(passwordInput);

			 if ((passwordInput.length >= minLength && hasUppercase && hasLowercase && hasNumber && hasSpecialChar)) {
	 	     	    valid(targetedValue)
		 	 }else{ 
				 	invalid(targetedValue,"Password must contain '0-9' , alphabets , '!@#$%^&*()'")
				  }
		 }else{
			 valid(targetedValue)
		 }
 		
 
 } else{
	 invalid(targetedValue,"invalid")
 }

}




function invalid(targetedValue,msg){
 
 event.target.classList.remove("is-valid")
event.target.classList.add("is-invalid")
document.getElementById(targetedValue).innerHTML=msg
 }


function valid(targetedValue){

 event.target.classList.remove("is-invalid")
event.target.classList.add("is-valid")
document.getElementById(targetedValue).innerHTML=""
}


	
	
	

		
		
		
	</script>
</body>
</html>
