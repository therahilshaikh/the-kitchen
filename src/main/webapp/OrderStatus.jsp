<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.awt.print.Book"%>
<%-- <%@page import="com.sun.org.apache.xerces.internal.impl.xpath.regex.ParseException"%> --%>
<%@page import="java.util.Date"%>
<%@page import="com.rahil.model.Login"%>
<%@page import="com.rahil.model.OrderMaster.OrderStatus"%>
<%@page import="com.rahil.dao.CookServices"%>
<%@page import="com.rahil.model.OrderMaster"%>
<%@page import="com.rahil.model.Item"%>
<%@page import="com.rahil.model.Category"%>
<%@page import="com.rahil.dao.UserService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.rahil.constants.GlobalConstants"%>
<%! 
boolean isLastOrderDeliverd = Boolean.FALSE;
boolean isLongTime = Boolean.FALSE;
%>

<%
Login l = (Login) session.getAttribute(GlobalConstants.USER);
ArrayList<OrderMaster> orders = new UserService().getAllOrders(Integer.parseInt(l.getUserName()));

if(isLastOrderDeliverd){	
	if(session.getAttribute("isLastOrdered") == null && session.getAttribute("time" ) == null){
		session.setAttribute("time", new Date());
		System.out.println("session set");
	}	
}

if(session.getAttribute("isLastOrdered") != null && session.getAttribute("time") != null){		
	Date date = (Date) session.getAttribute("time");
	Date update = new Date();	
	long diff = date.getTime() - update.getTime();	 
	long diffSeconds = diff / 1000 % 60;
	long diffMinutes = diff / (60 * 1000) % 60;
	long diffHours = diff / (60 * 60 * 1000) % 24;
	long diffDays = diff / (24 * 60 * 60 * 1000);
	if(diffHours >= -1){
		isLongTime = Boolean.TRUE;
	}
}else{ 
	System.out.println("some values are null");
	session.setAttribute("time", null);
	session.setAttribute("isLastOrdered", null);
}	

response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setHeader ("Expires", "0"); 
%>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<meta content="5" http-equiv="refresh" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Order Status</title>
	<link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="assets/mycss/navbar.css" rel="stylesheet" type="text/css" />
</head>

<body>
<div class="sidenav">
    <a href="UserHome.jsp"> <%=new Date() %></a>
    <hr color="white" />
	<a href="ViewCategory.jsp"> Place Order </a>
	<a href="OrderStatus.jsp"> View Order Status </a>
	<a href="ViewBill.jsp"> View Bill </a>
	<a href="LoginPage.jsp"> Log Out </a>
</div>

<div class="main">
  <div class="container">
    <div class="row">
      <div class="col-12">  
              
        <br/>  
        <h1>Order Status</h1>  
        <br/>
        		
		<table class="table table-striped table-hover">
        <%
		    if (!GlobalConstants.MESSAGE.equals("") && GlobalConstants.MESSAGE != null) {
		        out.write("<h3>" + GlobalConstants.MESSAGE + " </h3>");
			    GlobalConstants.MESSAGE = "";
		    }
        	if(isLongTime){
        %>
				<span style="text-decoration:blink; font-size:large; color:red"> Your time is over! You have free this table for other customers. </span>
		<%
			}
        	if(orders.size() != 0 && orders != null) {
		%>
			<tr>
				<th>Serial Number</th>
				<th>Table Number</th>
				<th>Name</th>
				<th>Status</th>
			</tr>
		<% 
			for(int i=0; i<orders.size(); i++){
				OrderMaster om = orders.get(i);
		%>
				<tr>
				  <td><%=i+1 %> <input type="hidden" name="orderId" value="<%= om.getId()%>" /></td>
				  <td><%=om.getTableNo() %></td>
				  <td><a href="ViewOrderedItemsList.jsp?orderId=<%=om.getId() %>"><%=om.getOrderName() %></a></td>
				  <td><%=om.getOrderStat().name() %></td>
		<%
				if(om.getOrderStat().name().equals(OrderMaster.OrderStatus.DELIVERED.name())){
		        	isLastOrderDeliverd = Boolean.TRUE;
		   		}else{
		   	    	isLastOrderDeliverd = Boolean.FALSE;
		   		}
			}
		%>
				</tr>
		<%
			}else{
		%>
			<tr>
			  <td>There are no orders available.</td>
			</tr>
		<%
			} 
		%>						
		</table>		
      </div>
    </div>
  </div>
</div>
</body>
</html>