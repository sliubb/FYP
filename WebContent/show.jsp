<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Here is your iterinary</title>
</head>
<body>
	<%
	    
		try {
			TSPData.initialization();
			String entity = request.getParameter("city");
			int history = 0;
			int culture = 0;
			int amusementPark = 0;
			int acitivity = 0;
			int outdoor = 0;
			int other = 0;
			int shopping = 0;
			int nature = 0;
			int minprice = Integer.parseInt(request.getParameter("budget"))/2;
			int maxprice = Integer.parseInt(request.getParameter("budget"));
			if(request.getParameter("history")!=null){
				history = 1;
			}
			if(request.getParameter("nature")!=null){
				nature = 1;
			}
			if(request.getParameter("culture")!=null){
				culture = 1;
			}
			if(request.getParameter("amusementPark")!=null){
				amusementPark = 1;
			}
			if(request.getParameter("acitivity")!=null){
				acitivity = 1;
			}
			if(request.getParameter("outdoor")!=null){
				outdoor = 1;
			}
			if(request.getParameter("other")!=null){
				other = 1;
			}
			if(request.getParameter("shopping")!=null){
				shopping = 1;
			}
			if(request.getParameter("schedule")!=null){
				TSPData.setSchedule(Integer.parseInt(request.getParameter("schedule")));
				//out.print(Integer.parseInt(request.getParameter("schedule")));
			}
			
			TSPData.setAcitivity(acitivity);
			TSPData.setAmusementPark(amusementPark);
			TSPData.setCulture(culture);
			TSPData.setHistory(history);
			TSPData.setNature(nature);
			TSPData.setOther(other);
			TSPData.setOutdoor(outdoor);
			TSPData.setShopping(shopping);
			TSPData.setMinPrice(minprice);
			TSPData.setMax(maxprice);
			entity = entity + "Attr";
	        String sqlString = "SELECT * FROM " +entity+ " order by popularity desc, price";
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			ResultSet rSet = stmt.executeQuery(sqlString);
			
			//out.print(data1.getNum());
	        while (rSet.next()) {
	        	//out.println(rSet.getString("name"));
	        	City newCity = new City();
	        	newCity.setAcitivity(rSet.getInt("acitivity"));
	        	//out.println(rSet.getInt("acitivity"));
	        	newCity.setAmusementPark(rSet.getInt("amusementPark"));
	        	newCity.setCulture(rSet.getInt("culture"));
	        	newCity.setDuration(rSet.getInt("duration"));
	        	newCity.setEndTime(rSet.getInt("endTime"));
	        	newCity.setHistory(rSet.getInt("history"));
	        	newCity.setName(rSet.getString("name"));
	        	newCity.setNature(rSet.getInt("nature"));
	        	newCity.setOther(rSet.getInt("other"));
	        	newCity.setOutdoor(rSet.getInt("outdoor"));
	        	newCity.setPopularity(rSet.getFloat("popularity"));
	 			newCity.setShopping(rSet.getInt("shopping"));
	 			newCity.setStartTime(rSet.getInt("startTime"));
	 			TSPData.addCity(newCity);
	 			//out.print(data1.getNum());
	        }
	        
	        db.closeConnection(con);

			long  startTime = System.currentTimeMillis(); 
			GeneticAlgorithm GA=new GeneticAlgorithm();
			
			//创建初始种群
			SpeciesPopulation speciesPopulation = new SpeciesPopulation();

			//开始遗传算法（选择算子、交叉算子、变异算子）
			SpeciesIndividual bestRate= GA.run(speciesPopulation);

			//打印路径与最短距离
			//bestRate.printRate();
			long endTime = System.currentTimeMillis();
			System.out.println("best: " + bestRate.calBest());
			System.out.println("avg: " + bestRate.calAvg());
			System.out.println("time：" + (endTime - startTime) + "ms");
			out.print("Recommended itinerary：");
			for(int i=0; i< bestRate.genes.length;i++) {
			if(bestRate.genes[i] == 1) {
				out.print("<br>");
				out.print(TSPData.citys.get(i).getName());
				out.print(TSPData.citys.get(i).getDuration());
			}
		}
	        /*
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			//String entity = request.getParameter("command");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT * FROM " + entity;
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			//Make an HTML table to show the results in:
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("name");
			out.print("</td>");
			//make a column
			out.print("<td>");
			//depending on the radio button selection make a column header for Manufacturer if the beers table was selected and Address if the bars table was selected
			if (entity.equals("beers"))
				out.print("manf");
			else
				out.print("addr");
			out.print("</td>");
			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out current bar or beer name:
				out.print(result.getString("name"));
				out.print("</td>");
				out.print("<td>");
				//Print out current bar/beer additional info: Manf or Address
				if (entity.equals("beers"))
					out.print(result.getString("manf"));
				else
					out.print(result.getString("addr"));
				out.print("</td>");
				out.print("</tr>");

			}
			out.print("</table>");

			//close the connection.
			db.closeConnection(con);
			*/
		} catch (Exception e) {
			out.print(e);
		}
	%>

</body>
</html>