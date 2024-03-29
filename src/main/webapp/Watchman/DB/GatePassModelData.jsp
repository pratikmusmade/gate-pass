<%@page import="java.sql.ResultSet"%>
<%@page import="com.gatePass.helper.ConnectionProvider"%>
<%@page import="java.sql.PreparedStatement"%>
<%
String outTime = "";
String inTime = "";

String requestId = request.getParameter("request_id");
String gatePassId = request.getParameter("gatePassId");
PreparedStatement pstm = ConnectionProvider.getConnection().prepareStatement("select * from gatepass where id = ?");
pstm.setString(1,gatePassId);
ResultSet rs = pstm.executeQuery();

while (rs.next()) {
	outTime = rs.getString("out_time");
	inTime = rs.getString("in_time");
};

outTime = (outTime == null)?"":outTime;
inTime = (inTime == null)?"":inTime;

System.out.println("gatepass --> " + gatePassId);
System.out.println("outTime --> " + outTime);
System.out.println("inTime --> " +inTime);

 pstm = ConnectionProvider.getConnection()
		.prepareStatement(" SELECT " + "s.id AS student_id, " + "s.firstName, " + "s.middleName, " + "s.lastName, "
		+ "s.enrolment_number, " + "s.address, " + "s.email, " + "s.pass, " + "s.student_image, "
		+ "b.branch_name, " + "ay.year_name, " + "r.id AS request_id, " + "r.message AS request_message, "
		+ "r.warden_id, " + "r.current_date AS request_current_date, " + "r.request_date, "
		+ "r.status AS request_status " + " FROM " + " student AS s " + " JOIN "
		+ "branch AS b ON s.branch_id = b.id " + " JOIN " + " acc_year AS ay ON s.year_id = ay.id " + " JOIN "
		+ " request AS r ON s.id = r.student_id " + " where r.id= ?");
pstm.setString(1, requestId);
rs = pstm.executeQuery();
while (rs.next()) {
	String fullName = rs.getString("firstName") + " " + rs.getString("middleName") + " " + rs.getString("lastName")
	+ " ";
%>
<div class="row g-0">
	<div class="col m-2">
		<img src="<%=rs.getString("student_image")%>"
			class="img-fluid rounded-start" alt="..."
			style="height: 90%; object-fit: cover;">
	</div>
	<div class="col-md-9">
		<div class="card-body p-1">
			<div class="container-fluid">

				<div class="row">
					<div class="col-md-6">


						<div class="input-group mb-3 border border-secondary">
							<span class="input-group-text bg-dark text-light"
								id="basic-addon1"> <strong>Name</strong>
							</span> <input readonly="readonly" value="<%=fullName%>"
								name="electionName" type="text"
								class="form-control bg-dark text-white" aria-label="Username"
								aria-describedby="basic-addon1">
						</div>
					</div>
					<div class="col-md-6">
						<div class="input-group mb-3 border border-secondary">
							<span class="input-group-text bg-dark text-light"
								id="basic-addon1"> <strong>En. No</strong>
							</span> <input readonly="readonly" name="studentName" type="text"
								id="cnadidateFullName"
								value="<%=rs.getString("enrolment_number")%>"
								class="form-control bg-dark text-white" aria-label="Username"
								aria-describedby="basic-addon1">
						</div>
					</div>
				</div>

				<div class="row">
					<div class="col">
						<div class="input-group mb-3 border border-secondary">
							<span class="input-group-text bg-dark text-light"
								id="basic-addon1"> <strong>Branch</strong>
							</span> <input readonly="readonly"
								value="<%=rs.getString("branch_name")%>" name="electionName"
								type="text" class="form-control bg-dark text-white"
								aria-label="Username" aria-describedby="basic-addon1">
						</div>
					</div>
					<div class="col">
						<div class="input-group mb-3 border border-secondary">
							<span class="input-group-text bg-dark text-light"
								id="basic-addon1"> <strong>Year</strong>
							</span> <input readonly="readonly"
								value="<%=rs.getString("year_name")%>" name="electionName"
								type="text" class="form-control bg-dark text-white"
								aria-label="Username" aria-describedby="basic-addon1">
						</div>
					</div>

				</div>
				<form method="post" onsubmit="sumitModelForm(event)">

					<div class="row">
						<div class="col">
							<div class="input-group mb-3 border border-secondary">
								<span class="input-group-text " id="basic-addon1"> <strong>Out-Time</strong>
								</span> <input name="out-time" type="text" class="form-control"
									placeholder="Out-Time" required aria-label="Username"
									aria-describedby="basic-addon1" id="out-time"
									value="<%=outTime %>"
									>
								<button onclick="setCurrentTime('out-time')" type="button"
									class="btn btn-info">
									Now&nbsp<i class="bi bi-clock-fill"></i>
								</button>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col">
							<div class="input-group mb-3 border border-secondary">
								<span class="input-group-text" id="basic-addon1"> <strong>In-Time
										&nbsp </strong>
								</span> <input name="in-time" type="text" class="form-control"
									placeholder="In-Time" aria-label="Username" id="in-time"
									aria-describedby="basic-addon1"
																		value="<%=inTime %>"
									>
								<button onclick="setCurrentTime('in-time')" type="button"
									class="btn btn-info">
									Now&nbsp<i class="bi bi-clock-fill"></i>
								</button>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-lg-6"></div>
						<div class="col-lg-6 d-flex flex-row-reverse gap-3">
							<input type="text" name="gatePassId" id="modelGatePassId" class="d-none">
							<button type="submit" class="btn btn-success border border-2">Save</button>

							<button type="button" class="btn btn-danger border border-2"
								data-bs-dismiss="modal">Cancel</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<%
}
%>

