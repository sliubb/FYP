<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.SimpleDateFormat,java.util.Date" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>t</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the HelloWorld.jsp
		String nation = request.getParameter("nationality");
		String last = request.getParameter("lastname");
		String first = request.getParameter("firstname");
		String name = request.getParameter("username");
		String email = request.getParameter("email");
		float s = Float.valueOf(request.getParameter("ssn"));
		int ssn = Math.round(s);
		float p = Float.valueOf(request.getParameter("phonenumber"));
		int phone = Math.round(p);
		String address = request.getParameter("address");
		String password = request.getParameter("password");
		String birthday = request.getParameter("birthday");
		SimpleDateFormat sp = new SimpleDateFormat("yyyy-MM-dd");
		java.util.Date d = sp.parse(birthday);
		java.sql.Date sqlDate = new java.sql.Date(d.getTime());
		//Make an insert statement for the Sells table:
		String insert = "INSERT INTO End_Users(Account_No, Nationality,Last_name, Passwordis, Username,SSN,First_name,Birthday,Email,Address,Phone_Number)"
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);
		String insert1 ="insert into Buyer(Account_No)"+"values(?)";
		PreparedStatement ps1 = con.prepareStatement(insert1);
		ps1.setInt(1,ssn);
		ps1.executeUpdate();
		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setInt(1, ssn);
		ps.setString(2, nation);
		ps.setString(3, last);
		ps.setString(4, password);
		ps.setString(5, name);
		ps.setInt(6, ssn);
		ps.setString(7, first);
		ps.setDate(8, sqlDate);
		ps.setString(9, email);
		ps.setString(10, address);
		ps.setInt(11, phone);
		//Run the query against the DB
		ps.executeUpdate();

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		%>
		<script type="text/javascript">
	    alert("Succeed!");
	    window.location.href = "index.jsp";
		</script> 
		<% 
		
	} catch (Exception ex) {
		%>
		<script type="text/javascript">
	    alert("Invaild input!");
	    window.location.href = "newAccount.jsp";
		</script> 
		<% 
	}
%>
</body>
</html>