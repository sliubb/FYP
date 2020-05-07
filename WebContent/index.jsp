<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!--  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script language=javascript src="dataone.js"></script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Find you a travel itinerary</title>
</head>
<meta http-equiv="content-Type" content="text/html;charset=gb2312">
<body>
Hello!你好
 									  
<br>

<form method="post" action="show.jsp">
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
  <br>
  <input type="submit" value="submit">
</form>
<br>

</body>
</html>
-->

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
	
	<!-- Modernizr JS -->
	<script src="js/modernizr-2.6.2.min.js"></script>
	<!-- FOR IE9 below -->
	<!--[if lt IE 9]>
	<script src="js/respond.min.js"></script>
	<![endif]-->

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

		<!-- end:header-top -->
		<div class="fh5co-hero">
			<div class="fh5co-overlay"></div>
			<div class="fh5co-cover" data-stellar-background-ratio="0.5" style="background-image: url(images/cover_bg_1.jpg);">
				<div class="desc">
					<div class="container">
						<div class="row">
							<div class="col-sm-5 col-md-5">
								<div class="tabulation animate-box">

								  <!-- Nav tabs -->
								   <ul class="nav nav-tabs" role="tablist">
								      <li role="presentation" class="active">
								      	<a href="index.jsp" aria-controls="flights" role="tab" data-toggle="tab">Personal Interest</a>
								      </li>
								   </ul>

								   <!-- Tab panes -->
								   
									<div class="tab-content">
									 <div role="tabpanel" class="tab-pane active" id="flights">
									 
										
											<form method="post" action="show.jsp">
											<div class="row">
											<div class="col-xxs-12 col-xs-6 mt">
												<div class="input-field">
													<label for="from">Destination</label>
														<select name="city" class="cs-select cs-skin-border">
															<option value="Beijing">Beijing</option>
															<option value="Shanghai">Shanghai</option>
															<option value="Shenzhen">Shenzhen</option>
														</select>
												</div>
											</div>
											</div>
											<div class="row">										
											<div class="col-xxs-12 col-xs-6 mt alternate">
												<div class="input-field">
													<label for="date-start">Start Date</label>
													<input type="text" class="form-control" name="start" id ="date-start" placeholder="mm/dd/yyyy"/>
												</div>
											</div>
											<div class="col-xxs-12 col-xs-6 mt alternate">
												<div class="input-field">
													<label for="date-end">End Date</label>
													<input type="text" class="form-control" name="end" id ="date-end" placeholder="mm/dd/yyyy"/>
												</div>
											</div>
											</div>
											<div class="row">
											<div class="col-sm-12 mt">
												<section>
													<label for="class">Attractions</label>
													<br>
														<input type="checkbox" name="history" value="1" /><a>History</a>
  														<input type="checkbox" name="culture" value="1"/><a>Culture</a>
  														<input type="checkbox" name="nature" value="1"/><a>Nature</a>
  														<input type="checkbox" name="amusementPark" value="1"/><a>AmusementPark</a>
  														<br>
  														<input type="checkbox" name="shopping" value="1"/><a>Shopping</a>
  														<input type="checkbox" name="outdoor" value="1"/><a>Outdoor</a>
  														<input type="checkbox" name="acitivity" value="1"/><a>Acitivity</a>
  														<input type="checkbox" name="other" value="1"/><a>Other</a>
												</section>
											</div>
											</div>
											<div class="row">
											<div class="col-xxs-12 col-xs-6 mt">
												<section>
													<label for="class">Budget</label>
													<input class="form-control" type="text" name="budget" value="1000"/>
												</section>
											</div>
										
											<div class="col-xxs-12 col-xs-6 mt">
												<section>
													<label for="class">Schedule(attractions/day)</label>
													<select class="cs-select cs-skin-border" name="schedule">
					
														<option value="3">Loose(2-3)</option>
														<option value="4">Medium(4)</option>
														<option value="5">Compact(5)</option>
													</select>
												</section>
											</div>
											</div>
											<div class="col-xs-12">
												<input type="submit" class="btn btn-primary btn-block" value="Search Itinerary">
											</div>
											
											</form>
										</div>
									 </div>
									</div>
								</div>
							
							<div class="desc2 animate-box">
								<div class="col-sm-7 col-sm-push-1 col-md-7 col-md-push-1">
									<p>Travel Itinerary</p>
									<h2>Flexible And Personal</h2>
									<span class="price">Free</span>
									<!-- <p><a class="btn btn-primary btn-lg" href="#">Get Started</a></p> -->
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

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
	</body>
</html>

