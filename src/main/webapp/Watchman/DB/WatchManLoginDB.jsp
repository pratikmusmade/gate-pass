<%
String userName = request.getParameter("userName");
String password = request.getParameter("password");
String logoutRequest = request.getParameter("logoutRequest");
userName = (userName != null) ? userName : "";
password = (password != null) ? password : "";
logoutRequest = (logoutRequest != null) ? logoutRequest : "";

if (logoutRequest.equals("1")) {
	out.print("1");
	out.print("Logout Successful");
	session.removeAttribute("user");
} else {
	if (userName.equals("watch") && password.equals("Watch@123")) {
		out.print("1");
		session.setAttribute("user", userName);
	} else {
		out.print("0");
	}
}
%>