<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=utf-8"%>

<html>
<style>
	#ex1 {
	  border-color: #000000;
	  border-style: solid; 
   	  border-width: 3px; /*상하・좌우*/
	  border-radius: 30px;
	  width: 500px;
	  height: 500px;
	  display: table-cell;
	  vertical-align: middle;
	  text-align:center;
	}
	
</style>
<head>
	<title>Home</title>
</head>
<body>
	<h1>
		Hello world!  
	</h1>
	<div>
	  <div id='ex1'>
	  <div>
	  	<span>Login</span> 
	  </div>
	  	<input type ="text" name = "st_id">
	  </div>
	</div>
	<P>  The time on the server is ${serverTime}. </P>
</body>
</html>
