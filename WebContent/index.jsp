<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script language=javascript src="dataone.js"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Find you a travel itinerary</title>
</head>
<meta http-equiv="content-Type" content="text/html;charset=gb2312">
<body>
Hello!你好<!-- the usual HTML way -->
 <!-- output the same thing, but using 
                                      jsp programming -->

									  
<br>

 <!-- Show html form to i) display something, ii) choose an action via a 
  | radio button -->
<!-- forms are used to collect user input 
	The default method when submitting form data is GET.
	However, when GET is used, the submitted form data will be visible in the page address field-->
<form method="post" action="show.jsp">
    <!-- note the show.jsp will be invoked when the choice is made -->
	<!-- The next lines give HTML for radio buttons being displayed -->
	<br>
	Destination
	<select name="city" size=1>
		<option value="Beijing">Beijing</option>
		<option value="Shanghai">Shanghai</option>
		<option value="Shenzhen">Shenzhen</option>
	</select>&nbsp;<br> 
	Start Date
  <input type="text" name="dateS" readOnly onClick="setDay(this);"><br/>
  End Date
  <input type="text" name="dateS" readOnly onClick="setDay(this);"><br/>
  <br>
  Attractions
  <input type="checkbox" name="history" value="1"/>History
  <input type="checkbox" name="culture" value="1"/>Culture
  <input type="checkbox" name="nature" value="1"/>Nature
  <input type="checkbox" name="amusementPark" value="1"/>AmusementPark
  <input type="checkbox" name="shopping" value="1"/>Shopping
  <input type="checkbox" name="outdoor" value="1"/>Outdoor
  <input type="checkbox" name="acitivity" value="1"/>Acitivity
  <input type="checkbox" name="other" value="1"/>Other
  <br>
  Hotel
  <input type="radio" name="hotel" checked="checked" value="luxurious"/>Luxurious(1000+)
  <input type="radio" name="hotel" value="medium"/>Medium(400-1000)
  <input type="radio" name="hotel" value="affordable"/>Affordable(400-)
  <br>
  Budget(hotel exclusive)
  
  <input type="text" name="budget" value="1000"/>
  <br>
  Schedule
  <input type="radio" name="schedule" checked="checked" value="4"/>Loose(3-4 hours)
  <input type="radio" name="schedule" value="5"/>Medium(4-5 hours)
  <input type="radio" name="schedule" value="6"/>Compact(5-6 hours)
    <!-- when the radio for bars is chosen, then 'command' will have value 
     | 'bars', in the show.jsp file, when you access request.parameters -->
  <br>
  <input type="submit" value="submit">
</form>
<br>

</body>
</html>