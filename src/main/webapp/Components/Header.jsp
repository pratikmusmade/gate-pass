<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<!-- Navbar -->
	
	<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
    <title>Bootstrap Example</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  </head>
  <body class="p-3 m-0 border-0 bd-example m-0 border-0">

    <!-- Example Code -->
    
        
    <nav class="navbar shadow p-3 navbar-expand-lg navbar-dark bg-dark"  >
      <div class="container-fluid">
        <a class="navbar-brand" href="#">Gate Pass</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarScroll" aria-controls="navbarScroll" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarScroll">
          <ul class="navbar-nav me-auto my-2 my-lg-0 navbar-nav-scroll  nav-underline" style="--bs-scroll-height: 100px;">
            <li class="nav-item">
              <a class="nav-link " aria-current="page" href="#">Home</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">Student</a>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                Warden
              </a>
              <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="#">Add Student</a></li>
                <li><a class="dropdown-item" href="#">Add Branch</a></li>
                 <li><a class="dropdown-item" href="#">Warden list</a></li>
              
                <li><a class="dropdown-item" href="#">Add year</a></li>
              </ul>
            </li>
              <li class="nav-item dropdown">
              <a class="nav-link  disabled dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false" aria-disabled="true">
                Reactor
              </a>
              <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="#">Add Warden</a></li>
                <li><a class="dropdown-item" href="#">Add branch</a></li>
                <li><hr class="dropdown-divider">Add student</li>
                <li><a class="dropdown-item" href="#">Add year </a></li>
              </ul>
            </li>
          </ul>
          
        </div>
      </div>
    </nav>
    
      
    <!-- End Example Code -->
  </body>
</html>