<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.text.SimpleDateFormat,java.util.Date" %>

<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Home</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
	<link rel="shortcut icon" href="favicon.ico">

	<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700,300' rel='stylesheet' type='text/css'>
	<!-- Animate.css -->
	<link rel="stylesheet" href="css/animate.css">
	<!-- Icomoon Icon Fonts-->
	<link rel="stylesheet" href="css/icomoon.css">
	<!-- Bootstrap  -->
	<link rel="stylesheet" href="css/bootstrap.css">
	<!-- Superfish -->
	<link rel="stylesheet" href="css/superfish.css">
	<!-- Magnific Popup -->
	<link rel="stylesheet" href="css/magnific-popup.css">
	<!-- Date Picker -->
	<link rel="stylesheet" href="css/bootstrap-datepicker.min.css">
	<!-- CS Select -->
	<link rel="stylesheet" href="css/cs-select.css">
	<link rel="stylesheet" href="css/cs-skin-border.css">
	
	<link rel="stylesheet" href="css/style.css">
	<link rel="stylesheet" href="layui/css/layui.css">


	<!-- Modernizr JS -->
	<script src="js/modernizr-2.6.2.min.js"></script>
	<!-- FOR IE9 below -->
	<!--[if lt IE 9]>
	<script src="js/respond.min.js"></script>
	<![endif]-->
	<style type="text/css"> 
	html{height:100%} 
	body{height:100%;margin:0px;padding:0px} 
	#milkMap{height:600px;width:1200px;border:1px solid blue;} 
	#all{
	width: 800px;
	height: 450px;
	border: 1px solid green;
	position:absolute;
    top:50%;
    left:50%;
    margin:-225px 0 0 -400px;
	}	
	</style>
	</head>
	<body>

		<div id="fh5co-wrapper">
		<div id="fh5co-page">

		<header id="fh5co-header-section" class="sticky-banner">
			<div class="container">
				<div class="nav-header">
					<a href="#" class="js-fh5co-nav-toggle fh5co-nav-toggle dark"><i></i></a>
					<h1 id="fh5co-logo"><a href="#"><i class="icon-airplane"></i>Travel</a></h1>
					<!-- START #fh5co-menu-wrap -->
					<nav id="fh5co-menu-wrap" role="navigation">
						<ul class="sf-menu" id="fh5co-primary-menu">
							<li class="active"><a href="index.jsp">Home</a></li>
							<li><a href="login.jsp">Login</a></li>
							<li><a href="contact.jsp">Contact</a></li>
						</ul>
					</nav>
				</div>
			</div>
		</header>
		<%
	try {
		//TSPData.initialization();
		//设置转换的日期格式
        SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
		int totaldays = 1;
        //开始时间
        Date startDate = new Date();
      	//结束时间
		Date endDate = new Date();
        if(request.getParameter("start")!=null){
        	//System.out.println(request.getParameter("start"));        
        	startDate = sdf.parse(request.getParameter("start"));
        	//System.out.println(startDate);
            if(request.getParameter("end")!=null){
            	//System.out.println(request.getParameter("end"));
            	
            	endDate = sdf.parse(request.getParameter("end"));
            	//System.out.println(endDate);
            	totaldays = (int)((endDate.getTime() - startDate.getTime())/(60*60*24*1000));
            	if(totaldays <= 0){
            		totaldays = 1;
            	}else{
            		totaldays++;
            	}
            }
        }
       
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
        		if(forDays[m][n]!=null){
        			System.out.println(forDays[m][n].name);
        		}
        			//
        	}
        	
        	System.out.println(" ");
        }
	%>
		<!-- end:header-top -->
	<div class="layui-tab" lay-filter="outNav">
  		<ul class="layui-tab-title">
    		<li class="layui-this">Day 1</li>
    		<%for(int t = 2; t<= totaldays;t++){%>
    		<li>Day <%= t%></li>
    		<%} %>
  		</ul>
  		<div class="layui-tab-content">
    		<div class="layui-tab-item layui-show">
    			<%for (int p=0;p<tt.schel;p++) {
    				if(forDays[0][p]!=null){%>
    					<div class="row">
							<div class="col-md-8 col-md-offset-2 text-center heading-section animate-box">
            					<p> <%= forDays[0][p].name %>(price: <%=forDays[0][p].price %> RMB; suggested time: <%= forDays[0][p].duration%> hours)</p>
            				</div>
            			</div>
            		<%}
            		}%>   			
    		</div>
    		<%for(int t = 1; t< totaldays;t++){%>
    		<div class="layui-tab-item">
				<% for (int y=0;y<tt.schel;y++){
						if(forDays[t][y]!=null){%>
							<div class="row">
								<div class="col-md-8 col-md-offset-2 text-center heading-section animate-box">
            						<p> <%= forDays[t][y].name %>( price: <%=forDays[t][y].price %> RMB; suggested time: <%= forDays[t][y].duration%> hours)</p>
            					</div>
            				</div>
            		<%} }%> 
			</div>
				<%}%>
  		</div>
	</div>
	<div class="row">
		<div class="col-md-8 col-md-offset-2 text-center heading-section animate-box">
			<p>Map</p>
			<p> </p>
		</div>
	</div>
	        <div class="tabulation animate-box">								
							<div id="milkMap" onload="run();"></div>
			</div>
		<div id="fh5co-tours" class="fh5co-section-gray">
			<div class="container">
				<div class="row">
					<div class="col-md-8 col-md-offset-2 text-center heading-section animate-box">
						<h3>Hot Tours</h3>
						<p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts.</p>
					</div>
				</div>
				<div class="row">
					<div class="col-md-4 col-sm-6 fh5co-tours animate-box" data-animate-effect="fadeIn">
						<div><img src="images/place-1.jpg" class="img-responsive">
							<div class="desc">
								<span></span>
								<h3>New York</h3>
								</div>
						</div>
					</div>
					<div class="col-md-4 col-sm-6 fh5co-tours animate-box" data-animate-effect="fadeIn">
						<div><img src="images/place-2.jpg" class="img-responsive">
							<div class="desc">
								<span></span>
								<h3>Philippines</h3>
							</div>
						</div>
					</div>
					<div class="col-md-4 col-sm-6 fh5co-tours animate-box" data-animate-effect="fadeIn">
						<div><img src="images/place-3.jpg" alt="Free HTML5 Website Template by " class="img-responsive">
							<div class="desc">
								<span></span>
								<h3>Hong Kong</h3>
								
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div id="fh5co-features">
			<div class="container">
				<div class="row">
					<div class="col-md-4 animate-box">

						<div class="feature-left">
							<span class="icon">
								<i class="icon-hotairballoon"></i>
							</span>
							<div class="feature-copy">
								<h3>Family Travel</h3>
								<p>Caravans, or with friends or family travel, walked into the suburbs seaside, rural crop, forest lake, park valley.</p>
							</div>
						</div>

					</div>

					<div class="col-md-4 animate-box">
						<div class="feature-left">
							<span class="icon">
								<i class="icon-search"></i>
							</span>
							<div class="feature-copy">
								<h3>Travel Plans</h3>
								<p>Do you think you will alter your travel plans?.</p>
							</div>
						</div>
					</div>
					<div class="col-md-4 animate-box">
						<div class="feature-left">
							<span class="icon">
								<i class="icon-wallet"></i>
							</span>
							<div class="feature-copy">
								<h3>Honeymoon</h3>
								<p>Reminiscing about, say, that romantic Paris honeymoon might land you thinking about the snotty bellhop at the overpriced hotel where you stayed.</p>
								
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-4 animate-box">

						<div class="feature-left">
							<span class="icon">
								<i class="icon-wine"></i>
							</span>
							<div class="feature-copy">
								<h3>Business Travel</h3>
								<p>A hot trend in the revved-up economy of the past, combining business travel with family or leisure pursuits has fallen sharply.</p>
							</div>
						</div>

					</div>

					<div class="col-md-4 animate-box">
						<div class="feature-left">
							<span class="icon">
								<i class="icon-genius"></i>
							</span>
							<div class="feature-copy">
								<h3>Solo Travel</h3>
								<p>Dining alone may well be one the most awkward times of solo travel but like anything the more you do it the more you get used to it.</p>
								
							</div>
						</div>

					</div>
					<div class="col-md-4 animate-box">
						<div class="feature-left">
							<span class="icon">
								<i class="icon-chat"></i>
							</span>
							<div class="feature-copy">
								<h3>Explorer</h3>
								<p>The great 19th century explorer John Muir once said: “Only by going alone in silence, without baggage, can one truly get into the heart of the wilderness.</p>
							
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		
		<div id="fh5co-destination">
			<div class="tour-fluid">
				<div class="row">
					<div class="col-md-12">
						<ul id="fh5co-destination-list" class="animate-box">
							<li class="one-forth text-center" style="background-image: url(images/place-1.jpg); ">
								<a>
									<div class="case-studies-summary">
										<h2>Los Angeles</h2>
									</div>
								</a>
							</li>
							<li class="one-forth text-center" style="background-image: url(images/place-2.jpg); ">
								<a href="#">
									<div class="case-studies-summary">
										<h2>Hongkong</h2>
									</div>
								</a>
							</li>
							<li class="one-forth text-center" style="background-image: url(images/place-3.jpg); ">
								<a>
									<div class="case-studies-summary">
										<h2>Italy</h2>
									</div>
								</a>
							</li>
							<li class="one-forth text-center" style="background-image: url(images/place-4.jpg); ">
								<a>
									<div class="case-studies-summary">
										<h2>Philippines</h2>
									</div>
								</a>
							</li>

							<li class="one-forth text-center" style="background-image: url(images/place-5.jpg); ">
								<a>
									<div class="case-studies-summary">
										<h2>Japan</h2>
									</div>
								</a>
							</li>
							<li class="one-half text-center">
								<div class="title-bg">
									<div class="case-studies-summary">
										<h2>Most Popular Destinations</h2>
										
									</div>
								</div>
							</li>
							<li class="one-forth text-center" style="background-image: url(images/place-6.jpg); ">
								<a >
									<div class="case-studies-summary">
										<h2>Paris</h2>
									</div>
								</a>
							</li>
							<li class="one-forth text-center" style="background-image: url(images/place-7.jpg); ">
								<a >
									<div class="case-studies-summary">
										<h2>Singapore</h2>
									</div>
								</a>
							</li>
							<li class="one-forth text-center" style="background-image: url(images/place-8.jpg); ">
								<a >
									<div class="case-studies-summary">
										<h2>Madagascar</h2>
									</div>
								</a>
							</li>
							<li class="one-forth text-center" style="background-image: url(images/place-9.jpg); ">
								<a>
									<div class="case-studies-summary">
										<h2>Egypt</h2>
									</div>
								</a>
							</li>
							<li class="one-forth text-center" style="background-image: url(images/place-10.jpg); ">
								<a>
									<div class="case-studies-summary">
										<h2>Indonesia</h2>
									</div>
								</a>
							</li>
						</ul>		
					</div>
				</div>
			</div>
		</div>

		
		
	</div>
	</div>
	
	<!-- END fh5co-page -->

	<!-- END fh5co-wrapper -->
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.2"></script>
	<script type="text/javascript">
	
		var map = new BMap.Map("milkMap");  
		map.centerAndZoom(new BMap.Point(116.404, 39.915), 13);  
		map.enableScrollWheelZoom(true);     //开启鼠标滚轮缩放
		map.addControl(new BMap.NavigationControl());               // 添加平移缩放控件  
		map.addControl(new BMap.ScaleControl());                    // 添加比例尺控件  
		map.addControl(new BMap.OverviewMapControl());              //添加缩略地图控件  
      	<%for(int b = 0; b < tt.schel; b++){
      		if(forDays[0][b]!=null){%>
      		var myP<%=b%> = new BMap.Point(<%=forDays[0][b].position.get("lat")%>,<%=forDays[0][b].position.get("lng")%>);
      		<%}}%>
      	/*	
		var myP1 = new BMap.Point(117.26542,39.112487);    //起点-互助西里
		var myP2 = new BMap.Point(117.213246,39.096892);    //终点-文化中心  
		var myP3 = new BMap.Point(117.174799,39.105852);    //终点-南开大学  
      	*/
		window.onload = function (){  
			map.clearOverlays(); 
			//清除地图上所有的覆盖物  
			var driving = new BMap.DrivingRoute(map);//创建驾车实例 
			<%for(int v = 0; v <tt.schel-1;v++){%>
			driving.search(myP<%=v%>, myP<%=v+1%>);
			<%}%>
			/*
			driving.search(myP1, myP2);                 //第一个驾车搜索  
			driving.search(myP2, myP3);  //第二个驾车搜索 
			*/ 
			driving.setSearchCompleteCallback(function(){  
				var pts = driving.getResults().getPlan(0).getRoute(0).getPath();    //通过驾车实例，获得一系列点的数组  
      
				var polyline = new BMap.Polyline(pts);       
				map.addOverlay(polyline); 
				<%for(int v = 0; v <tt.schel-1;v++){%>
				var m = new BMap.Marker(myP<%=v%>);
				map.addOverlay(m);
				var lab = new BMap.Label("Point<%=v%>",{position:myP<%=v%>});
				map.addOverlay(lab);
				<%}%>
              /*
				var m1 = new BMap.Marker(myP1);         //创建3个marker  
				var m2 = new BMap.Marker(myP2);  
				var m3 = new BMap.Marker(myP3);  
				map.addOverlay(m1);  
				map.addOverlay(m2);  
				map.addOverlay(m3);  
              
				var lab1 = new BMap.Label("起点",{position:myP1});        //创建3个label  
				var lab2 = new BMap.Label("途径点",{position:myP2});  
				var lab3 = new BMap.Label("终点",{position:myP3});     
				map.addOverlay(lab1);  
				map.addOverlay(lab2);  
				map.addOverlay(lab3);  
              */
				setTimeout(function(){  
					map.setViewport([<%for(int v = 0; v <tt.schel;v++){%>myP<%=v%>
					<%if(v != tt.schel -1){%>,<%}}%>]);          //调整到最佳视野  
				},1000);  
              
			});  
		}

	</script>
	<!-- jQuery -->


	<script src="js/jquery.min.js"></script>
	<!-- jQuery Easing -->
	<script src="js/jquery.easing.1.3.js"></script>
	<!-- Bootstrap -->
	<script src="js/bootstrap.min.js"></script>
	<!-- Waypoints -->
	<script src="js/jquery.waypoints.min.js"></script>
	<script src="js/sticky.js"></script>

	<!-- Stellar -->
	<script src="js/jquery.stellar.min.js"></script>
	<!-- Superfish -->
	<script src="js/hoverIntent.js"></script>
	<script src="js/superfish.js"></script>
	<!-- Magnific Popup -->
	<script src="js/jquery.magnific-popup.min.js"></script>
	<script src="js/magnific-popup-options.js"></script>
	<!-- Date Picker -->
	<script src="js/bootstrap-datepicker.min.js"></script>
	<!-- CS Select -->
	<script src="js/classie.js"></script>
	<script src="js/selectFx.js"></script>
	
	<!-- Main JS -->
	<script src="js/main.js"></script>
	<script src="layui/layui.js"></script>
	
	<script>
		layui.use('element', function(){
	 	var element = layui.element;
	 	element.init();
	  //…
		});
	</script>
			<%} catch (Exception e) {
			out.print(e);
		}%>
	</body>
</html>
