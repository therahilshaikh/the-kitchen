<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.Date"%>
<%@page import="com.rahil.model.OrderDetails"%>
<%@page import="com.rahil.constants.GlobalConstants"%>
<%@page import="com.rahil.model.OrderMaster.OrderStatus"%>
<%@page import="com.rahil.model.OrderMaster.OrderStatus"%>
<%@page import="com.rahil.model.OrderMaster"%>
<%@page import="com.rahil.dao.CookServices"%>
<%@page import="java.util.ArrayList"%>
<%
ArrayList<OrderDetails> orders = null;
if(request.getParameter("orderId") != null )
	orders = new CookServices().getAllItems(Integer.parseInt(request.getParameter("orderId")));

response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setHeader ("Expires", "0"); 
%>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<meta http-equiv="refresh" content="4" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Oredered Items</title>
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
        <h1>Ordered Items</h1>  
        <br/>
        		
		<table class="table table-striped table-hover">
        <%
		    if (!GlobalConstants.MESSAGE.equals("") && GlobalConstants.MESSAGE != null) {
		        out.write("<h3>" + GlobalConstants.MESSAGE + " </h3>");
			    GlobalConstants.MESSAGE = "";
		    }        	
        	if(orders.size()!=0 && orders!=null) {
		%>
				<tr>
				  <th>Serial Number</th>
				  <th>Table Number</th>
				  <th>Order ID</th>
				  <th>Item Name</th>
				  <th>Quantity</th>
				  <th>Actual Status</th>
				</tr>
		<% 
				for(int i=0; i<orders.size(); i++){
					OrderDetails om = orders.get(i);
		%>
					<form action="cook?action=updateItemtatus" method="post">
				    	<tr>
					 	 <td><%=i+1 %></td>
					  	<td><%=om.getTableNo() %></td>
					  	<td><%=om.getId() %> 
					    	<input type="hidden" name="orderId" value="<%= om.getId()%>" /> 
					    	<input type="hidden" name="itemId" value="<%=om.getItemId() %>" />
					  	</td>
					  	<td><%=om.getItemName() %></td>
					  	<td><%=om.getQnt() %></td>
					  	<td><%=om.getOrderStat().name() %></td>
						</tr>
					</form>
		<%
				}
			}else{
		%>
				<tr>
					<td>Their no Orders Available</td>
				</tr>
		<%
			}
		%>
		</table>
		<br/>
	    <a href="OrderStatus.jsp"><button class="btn btn-danger" />Go Back</button></a>	
      </div>
    </div>
  </div>
</div>
</body>
</html>