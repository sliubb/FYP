<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String un=request.getParameter("is");
		String pw=request.getParameter("password");
		try {
			ApplicationDB db = new ApplicationDB();	
			Connection conn = db.getConnection();
			
			PreparedStatement a = 
			conn.prepareStatement("select is, password from users where nameis=? and Passwordis=?");
			
			
			a.setString(1,un);
			a.setString(2, pw);
			
			ResultSet rs = a.executeQuery();
			
			while (rs.next()) {
				%>
				  <script type="text/javascript">
				  window.location.href = "index.jsp";
				  </script> 
				  <%
				
				return;
			}

			%>
			  <script type="text/javascript">
			  alert("Invalid id or Password");
			  window.location.href = "login.jsp";
			  </script>
			  <%
			return;

		} catch (Exception e) {
			out.print(e);
		}	
	%>
	
</body>
</html>