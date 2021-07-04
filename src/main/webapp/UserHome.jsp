<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.Date"%>
<%@page import="com.rahil.constants.GlobalConstants"%>
<%@page import="com.rahil.model.Login"%>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setHeader ("Expires", "0");
Login login =(Login) session.getAttribute(GlobalConstants.USER);
%> 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Hotel Ordering System</title>
	<link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="assets/mycss/navbar.css" rel="stylesheet" type="text/css" />
	<link href="assets/mycss/slideshow.css" rel="stylesheet" type="text/css" />
</head>

<body>
<div class="sidenav">
    <a href=""> <%=new Date() %></a>
    <hr color="white" />
    <% if(login.getUserName()==null)
    	{
    		response.sendRedirect("loginpage.jsp");
    		%>
	<% 
    	}else if(login.getUserName().equals("cook")){
	%>
	  <a href="AddCategory.jsp"> Add Category </a>
	  <a href="AddItem.jsp"> Add Item </a>
	  <a href="ViewOrder.jsp"> View Order </a>
	  <a href="ViewBillToCook.jsp"> View Bill </a>
	  <a href="LoginPage.jsp"> Log Out </a>
	<%
	} else{
	%>
	  <a href="ViewCategory.jsp">Place Order</a>
	  <a href="OrderStatus.jsp"> View Order Status </a>
	  <a href="ViewBill.jsp"> View Bill </a>
	  <a href="LoginPage.jsp"> Log Out </a>
	<%
	} 
	%>
</div>

<div class="main">
  <div class="container">
    <div class="row">
      <div class="col-12">
      
        <div class="slideshow-container">        
		  <div class="mySlides fade">
  			<img src="assets/images/restaurant.png" style="width:100%" />
  			<div class="text">Ambience</div>
		  </div>
		  
		  <div class="mySlides fade">
		    <img src="assets/images/food.png" style="width:100%" />
		    <div class="text">Food</div>
		  </div>
		  
		  <div class="mySlides fade">
		    <img src="assets/images/bevereges.jpg" style="width:100%" />
		    <div class="text">Bevereges</div>		    
		  </div>		  
		</div>	
			
		<br/>			
		<div style="text-align:center">
 		  <span class="dot"></span> 
  		  <span class="dot"></span> 
  		  <span class="dot"></span> 
		</div>
		
		<% 
		if(login.getUserName().equals("cook")){
		%>
			<h2>Welcome back, <%=login.getUserName() %>!</h2>
		<%
		} else{
		%>
			<h2>Welcome to The Kitchen, Table <%=login.getUserName() %>!</h2>
		<%
		} 
		%>	
				
      </div>
    </div>
  </div>
</div>
<script type="text/javascript" src="assets/myjs/slideshow.js"></script>
</body>
</html>