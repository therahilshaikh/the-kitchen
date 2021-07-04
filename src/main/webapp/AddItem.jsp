<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.Date"%>
<%@page import="com.rahil.constants.GlobalConstants"%>
<%@page import="com.rahil.model.Category"%>
<%@page import="com.rahil.dao.CookServices"%>
<%@page import="java.util.ArrayList"%>
<%
	ArrayList<Category> cats = new CookServices().getAllCategorys();
	response.setHeader("Cache-Control","no-store");
	response.setHeader("Pragma","no-cache");
	response.setHeader ("Expires", "0"); 
%>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Add Item</title>
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
        <h1>Add Item</h1>  
        <br/>
        <form action="cook?action=addItem" method="post">
          <%
		    if (!GlobalConstants.MESSAGE.equals("") && GlobalConstants.MESSAGE != null) {
		        out.write("<h3>" + GlobalConstants.MESSAGE + " </h3>");
			    GlobalConstants.MESSAGE = "";
		    }
		  %>
		  <div class="form-group">
    	    <label for="item">Item Name:</label>
    		<input type="text" class="form-control" name="itemName" size="22" />
          </div>
          <div class="form-group">
    	    <label for="category">Category:</label>
    	    <select class="form-control" style="size: 30" name="categoryId">
    	      <option disabled selected value>-- Select --</option>
    	      <%
    	        if(cats!=null && cats.size()!=0){ 
					for(int i=0; i<cats.size(); i++){
						Category cat = cats.get(i);
			  %>
			  			<option value="<%=cat.getId() %>"> <%=cat.getCategoryName() %> </option>
			 <%
			 		}
				} 
			 %>
    	    </select>
          </div>
          <div class="form-group">
    	    <label for="quantity">Quantity:</label>
    		<input type="number" class="form-control" name="qnt" size="30" />
          </div>
          <div class="form-group">
    	    <label for="cost">Cost:</label>
    		<input type="number" class="form-control" name="cost" size="22" />
          </div>
  		  <button type="submit" class="btn btn-primary">Add item to the Category</button>
        </form>	
        			
      </div>
    </div>
  </div>
</div>	
</body>
</html>