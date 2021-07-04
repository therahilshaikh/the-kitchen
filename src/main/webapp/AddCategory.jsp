<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.Date"%>
<%@page import="com.rahil.constants.GlobalConstants"%>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setHeader ("Expires", "0"); 
%> 
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Add Category</title>
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
        <h1>Add Category</h1>  
        <br/>
        <form action="cook?action=addCategory" method="post">
          <%
		    if (!GlobalConstants.MESSAGE.equals("") && GlobalConstants.MESSAGE != null) {
		        out.write("<h3>" + GlobalConstants.MESSAGE + " </h3>");
			    GlobalConstants.MESSAGE = "";
		    }
		  %>
		  <div class="form-group">
    	    <label for="category">Category Name:</label>
    		<input type="text" class="form-control" name="cate" />
          </div>
  		  <button type="submit" class="btn btn-primary">Add category to the Menu</button>
        </form>	
        			
      </div>
    </div>
  </div>
</div>
</body>
</html>