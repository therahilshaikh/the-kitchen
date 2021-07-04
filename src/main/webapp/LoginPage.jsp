<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setHeader ("Expires", "0"); //prevents caching at the proxy server
%> 
<%@page import="com.rahil.constants.GlobalConstants"%>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>Login</title>
	<link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
</head>

<body>
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark justify-content-between">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" href="index.html">Home</a>
    	</li>
        <li class="nav-item">
          <a class="nav-link disabled">Login</a>
    	</li>
    	<!-- <li class="nav-item">
      	  <a class="nav-link disabled">Table Login</a>
    	</li> -->
  	  </ul>
  	  <ul class="navbar-nav ml-auto">
    	<li class="nav-item">
      	  <a class="nav-link" href="ContactUs.html">Contact Us</a>
    	</li>
  	  </ul>
    </nav>
    
    <div class="container">
  	  <div class="row">
  	  
    	<div class="col-12">
	  	  <center>  
	    	<img src="assets/images/logo_1.png" style="max-width: 100%" />		    
	    	<h1>Login Page</h1>  	
	  	    <br/> 
		    <br/>     		    
	  	  </center>
		</div>				
	
		<div class="col-12">
		  <form action="control?action=login" method="post">
		    <%
			  if (!GlobalConstants.MESSAGE.equals("") && GlobalConstants.MESSAGE != null) {
				  out.write("<h3>" + GlobalConstants.MESSAGE + "</h3>");
				  GlobalConstants.MESSAGE = "";
			  }
		    %>
  		    <div class="form-group">
    		  <label for="username">User Name:</label>
    		  <input type="text" class="form-control" name="userName" id="userName" />
            </div>
  		    <div class="form-group">
    		  <label for="pwd">Password:</label>
    		  <input type="password" class="form-control" name="pass" id="pass" />
  		    </div>
  		    <button type="submit" class="btn btn-primary">Login</button>
		  </form>
	    </div> 	
	    	  	
  	  </div>
	</div>    
	
</body>
</html>