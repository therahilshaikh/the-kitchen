<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.Date"%>
<%@page import="com.rahil.constants.GlobalConstants"%>
<%@page import="com.rahil.model.OrderMaster.OrderStatus"%>
<%@page import="com.rahil.model.OrderMaster.OrderStatus"%>
<%@page import="com.rahil.model.OrderMaster"%>
<%@page import="com.rahil.dao.CookServices"%>
<%@page import="java.util.ArrayList"%>
<%
	ArrayList<OrderMaster> orders = new CookServices().getAllOrders();
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setHeader ("Expires", "0"); 
%>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<meta http-equiv="refresh" content="4" />
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>View Order</title>
	<link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="assets/mycss/navbar.css" rel="stylesheet" type="text/css" />
</head>

<body>
<div class="sidenav">
    <a href="UserHome.jsp"> <%=new Date() %></a>
    <hr color="white" />
	<a href="AddCategory.jsp"> Add Category </a>
	<a href="AddItem.jsp"> Add Item </a>
	<a href="ViewOrder.jsp"> View Order </a>
	<a href="ViewBillToCook.jsp"> View Bill </a>
	<a href="LoginPage.jsp"> Log Out </a>
</div>

<div class="main">
  <div class="container">
    <div class="row">
      <div class="col-12">  
              
        <br/>  
        <h1>View Order</h1>  
        <br/>
        
        <table class="table table-striped table-hover">
        <%
		    if (!GlobalConstants.MESSAGE.equals("") && GlobalConstants.MESSAGE != null) {
		        out.write("<h3>" + GlobalConstants.MESSAGE + " </h3>");
			    GlobalConstants.MESSAGE = "";
		    }
		%>
		<% 
		  if(orders.size()!=0 && orders!=null){
		%>
			<tr>
				<th>Serial Number</th>
				<th>Table No</th>
				<th>Name</th>
				<th>Actual Status</th>
				<th>Status</th>
				<th>Action</th>
			</tr>
		<% 
		    for(int i=0; i<orders.size(); i++){
		        OrderMaster om = orders.get(i);
		%>
			    <form action="cook?action=updateOStatus" method="post">
			      <tr>
			        <td><%=i+1 %> <input type="hidden" name="orderId" value="<%= om.getId()%>" /></td>
		            <td><%=om.getTableNo() %></td>
				    <td><a href="ViewOrderedItems.jsp?orderId=<%=om.getId() %>"><%=om.getOrderName() %></a></td>
				    <td><%=om.getOrderStat().name() %></td>
				    <td>
				      <select name="status" class="form-control">
				        <option disabled selected value>-- Select --</option>
		<% 
		                for(OrderStatus os : OrderStatus.values()){ 
		%>
		  			 	 <option><%=os.name() %></option>
		<%
				  		}
		%>
				      </select>
			        </td>
			        <td><button type="submit" class="btn btn-info" />Update Status</button></td>
		          </tr>
		      </form>
		<%
		  }
		} else {
		%>
			<tr>
				<td>There is no order available</td>
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