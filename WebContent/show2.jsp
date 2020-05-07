<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
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
			int schedule  = 0;
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
				//TSPData.setSchedule(Integer.parseInt(request.getParameter("schedule")));
				//out.print(Integer.parseInt(request.getParameter("schedule")));
				schedule = Integer.parseInt(request.getParameter("schedule"));
			}
			User tt = new User(schedule, maxprice, nature, history, culture, outdoor, amusementPark, shopping, acitivity, other);
			//out.println(tt.activity);
			/*
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
			*/
			int num = 0;
			entity = entity + "Attr";
			String sql = "SELECT COUNT(*) as totalCount FROM "+entity;
	        String sqlString = "SELECT * FROM " +entity+ " order by popularity desc, price";
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			ResultSet count = stmt.executeQuery(sql);
			if(count.next()) { 
				  num = count.getInt("totalCount"); 
				}
			//out.println(num);
			Attraction[] attrList = new Attraction[num];
			ResultSet rs = stmt.executeQuery(sqlString);
			
			//out.print(data1.getNum());
			/*
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
	        */
	        int i  = 0;
            while(rs.next()){
                // 通过字段检索
                int id  = rs.getInt("id");
                String name = rs.getString("name");
                int duration=rs.getInt("duration");
            	int price=rs.getInt("price");
            	int starttime=rs.getInt("startTime");
            	int endtime=rs.getInt("endTime");
            	double popularity=rs.getDouble("popularity");
            	int natur=rs.getInt("nature");
            	int histor=rs.getInt("history");
            	int cultur=rs.getInt("culture");
            	int outdoo=rs.getInt("outdoor");
            	int amuse=rs.getInt("amusementPark");
            	int shoppin=rs.getInt("shopping");
            	int activity=rs.getInt("acitivity");
            	int othe=rs.getInt("other");
    
                // 输出数据
            	Attraction temp = new Attraction(id,name,duration,price,starttime,endtime,popularity,natur,histor,cultur,outdoo,amuse,shoppin,activity,othe);
            	attrList[i] = temp;
            	//out.println(temp.name);
                i++;
            }
	        db.closeConnection(con);

			//long  startTime = System.currentTimeMillis(); 
	        int totaldays = 5;
	        //User tt = new User(2,1000,1,0,0,1,1,1,0,0);
	        
	        int totalattr = tt.schel*totaldays;
	        //out.println(totalattr);
	        long startst = System.currentTimeMillis();
	        for(int j=0;j<num;j++) {
	        	double score = 0;
	        	double pop;
	        	//if(attrList[j].popularity-1<0.001) {
	        	//	pop= 0;
	        	//}
	        	//else {
	        		//pop=Math.pow(attrList[j].popularity,0.2);
	        	pop = attrList[j].popularity;
	        	//}
	        	score = Math.pow(pop,0.2)*1.25+0.5*Math.pow((attrList[j].nature*tt.nature+attrList[j].history*tt.history+attrList[j].culture*tt.culture+attrList[j].outdoor*tt.outdoor+attrList[j].amuse*tt.amuse+attrList[j].shopping*tt.shopping+attrList[j].activity*tt.activity+attrList[j].other*tt.other),0.5);
	        	attrList[j].score=score;
	        	//out.println(score);
	        }
	        Arrays.sort(attrList);
	        //for(int j=0;j<totalattr;j++) {
	        	//System.out.println(attrList[j].name);
	        //}
	        //获取坐标
	        for(int j=0;j<totalattr;j++) {
	        	
	        	//out.println(j);
	        	attrList[j].position= GetPosition.getLngAndLat("北京市"+attrList[j].name);
	        	//out.println(attrList[j].name+' '+attrList[j].position.get("lat"));
	        }
	        
	        //将景点分天数
	        Attraction[] chosenList = new Attraction[totalattr];
	        for(int j=0;j<totalattr;j++) {
	        	chosenList[j] = new Attraction(attrList[j]);
	        }
	        
	        //将第一个景点作为起点，早上出发时间为8点
	        Attraction[][] forDays = new Attraction[totaldays][tt.schel];
	        int curr = 0;
	        int n = 0;
	        int m = 0;
	        //while(checkAllVisited(chosenList)==false) {
	        while(m<totaldays) {
	        	n = 0;
	        	int currHour = 8;
	        	while(n<tt.schel) {
	        		chosenList[curr].visited=true;
	        		forDays[m][n]=chosenList[curr];
	        		currHour +=chosenList[curr].duration;
	        		//if(currHour>20) {
	        		//	break;
	        		//}
	        		int bestweight = 1000;
	        		int travelling =0;
	        		for(int j=0;j<totalattr;j++) {
	        			if(chosenList[j].visited) continue;
	        			else {
	        				int travellingTime= GetPosition.getDrive(chosenList[curr].position.get("lng").toString(), chosenList[curr].position.get("lat").toString(), chosenList[j].position.get("lng").toString(), chosenList[j].position.get("lat").toString());
	        				int weight = travellingTime/60/60+currHour-chosenList[j].duration;
	        				if(bestweight>weight) {
	        					bestweight = weight;
	        					travelling = travellingTime;
	        					curr = j;
	        				}
	        			}
	        		}
	        		
	        		//System.out.println(forDays[m][n].name);
	        		n++;
	        		
	        		currHour+=travelling/60/60;
	        		if(currHour>24) {
	        			break;
	        		}
	        	}
	        	//System.out.println(" ");
	        	m++;
	        }
	        
	        for(m=0;m<totaldays;m++) {
	        	for (n=0;n<tt.schel;n++) {
	        		if(forDays[m][n]!=null)
	        			out.println(forDays[m][n].name);
	        	}
	        	
	        	out.println("<br>");
	        }
			/*
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
			*/
		} catch (Exception e) {
			out.print(e);
		}
	%>

</body>
</html>