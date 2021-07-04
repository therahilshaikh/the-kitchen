<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.Date"%>
<%@page import="com.rahil.model.Login"%>
<%@page import="com.rahil.model.OrderMaster"%>
<%@page import="com.rahil.model.Item"%>
<%@page import="com.rahil.model.Category"%>
<%@page import="com.rahil.dao.UserService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.rahil.constants.GlobalConstants"%>
<%
	ArrayList<Item> cats = null;
	Login login = (Login) session.getAttribute(GlobalConstants.USER); 
	if (request.getParameter("catId") != null)
		cats = new UserService().getAllItems(Integer.parseInt(request.getParameter("catId")));
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setHeader ("Expires", "0"); 
%>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Items</title>
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
        <h1>Category Items</h1>  
        <br/>      
        <%
		    if (!GlobalConstants.MESSAGE.equals("") && GlobalConstants.MESSAGE != null) {
		        out.write("<h3>" + GlobalConstants.MESSAGE + " </h3>");
			    GlobalConstants.MESSAGE = "";
		    }
		%>
		<form action="cook?action=makeOrder" method="post">
		  <table class="table table-striped table-hover">
			  <tr>
				<th>Serial Number</th>
				<th>Name</th>
				<th>Quantity</th>
				<th>Cost</th>
				<th>Order Quantity</th>
				<th>Action</th>
			  </tr>
		<% 
			if(cats!=null && cats.size()!=0){
				for(int i=0; i<cats.size(); i++){
					Item cat = cats.get(i);
		%>
						<tr>
						  <td><%=i + 1%></td>
							<input type="hidden" name="catId" value="<%= request.getParameter("catId")%>" />
							<input type="hidden" name="status" value="<%=OrderMaster.OrderStatus.JUST_ORDERED.name() %>" />
							<td><%=cat.getItemName()%></td>
							<td><%= cat.getQnt() %></td>
							<td><%=cat.getCost() %></td>
							<td><input type="number" name="orderQnt" value="0" class="form-control"/></td>
							<td><input type="checkbox" name="ItemId" value="<%= cat.getId()%>" /></td>
						</tr>
		<%
				}
			} 
		%>
			</table>    	
			<br/>
			<div class="form-group">
    		  <label for="orderName">Order Name:</label>
    		  <input type="text" class="form-control" name="orderName" id="orderName" value="" />
    		  <input type="hidden" name="tableNo" value="<%=Integer.parseInt(login.getUserName()) %>" /> 
            </div>
            <button type="submit" class="btn btn-primary" />Order Now!</button>
		  </form>
		  <br/>
	      <a href="ViewCategory.jsp"><button class="btn btn-danger" />Go Back</button></a>	
      </div>
    </div>
  </div>
</div>
</body>
</html>