<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body style="background-image: url('../assects/images/wave.svg'); background-repeat: no-repeat; background-attachment: fixed;  
  background-size: cover">
<div class="container shadow bg-grey text-white " style="height: 400px;width: 500px; margin-left: 660px;margin-top: 190px">
<form action="Login/StudentLoginDB.jsp" class="was-validated">
  <div class="mb-2 mt-3 col-md-6  p-3">
   <h1>Login</h1>
   <div class="">
    <label for="uname" class="form-label">Username</label>
    <input type="text" class="form-control" id="uname" placeholder="Enter username" name="uname" style="width:200%;" required>
    <div class="valid-feedback">Valid.</div>
     <div class="invalid-feedback">Please fill out this field.</div>
  </div>
  </div>
  <div class="mb-2 mt-3 col-md-6  p-3">
    <label for="pwd" class="form-label">Password</label>
    <input type="password" class="form-control" id="pswd" placeholder="Enter password" style="width:200%;" name="pswd" required>
    <div class="valid-feedback">Valid.</div>
    <div class="invalid-feedback">Please fill out this field.</div>
  <button type="submit" class="btn btn-primary "style="margin-left:200px;">Submit</button>
    
  </div>
  
 
</form>









  </div>

</body>
</html>