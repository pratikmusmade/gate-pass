<nav class="navbar shadow p-2 navbar-expand-lg navbar-dark bg-dark">
	<div class="container-fluid">
		<a class="navbar-brand" href="#">Gate Pass</a>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse"
			data-bs-target="#navbarScroll" aria-controls="navbarScroll"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarScroll">
			<ul
				class="navbar-nav me-auto my-2 my-lg-0 navbar-nav-scroll  nav-underline"
				style="--bs-scroll-height: 100px;">
				<li class="nav-item"><a class="nav-link " aria-current="page"
					href="SendGatePassRequest.jsp">Send-Request</a></li>
				<li class="nav-item"><a class="nav-link"
					href="StudentGatePassList.jsp">GatePass</a></li>
				<li class="nav-item"><a class="nav-link"
					href="StudentSentRequestList.jsp">Request-List </a></li>
			</ul>

		</div>
		<button class="btn btn-outline-danger border-2 " onclick="logout()">
			<span class="fw-bolder text-white">Logout</span> <span
				class=" px-1 rounded text-white"> <i
				class="bi bi-box-arrow-right"></i>
			</span>
		</button>
	</div>
</nav>
<script type="text/javascript">
	function logout(){
		Swal.fire({
			  title: "Are you sure ?",
			  text: "That you want to logout?",
			  icon: "question",
			  showCancelButton: true,
			  cancelButtonColor: "#d33",
			}).then((res)=>{
				if(res.isConfirmed){
					      $.ajax({
					        type: "POST",
					        url: "DB/StudentLoginDB.jsp",
					        data:{logoutRequest:1},
					        success: function (response) { 
					        	console.log(response.trim())
					        	
					        if (response.trim()[0] === "1") {
                Swal.fire({
                  title: response.trim().slice(1),
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
					        }
					      });
				}
			});
	}
</script>