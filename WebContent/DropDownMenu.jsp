
<%
if(request.getSession().getAttribute("user")==null){// if user is null- erro massage- prevent a sneaky user to access 

	response.sendRedirect("loginerror.jsp");
	
}

%>


<%@ page import="java.sql.*" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<title>Baruch College</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link REL="icon" href="http://www.baruch.cuny.edu/favicon.ico">
<link rel="stylesheet" type="text/css" href="http://www.baruch.cuny.edu/css/baruch_interior.css" />
<link rel="stylesheet" type="text/css" href="http://www.baruch.cuny.edu/css/application.css" />
<link href="schedule.css" rel="stylesheet" type="text/css" />
<!--HEAD Include Ends -->
<!--body.html include Goes Here -->
<!--BODY Include Begins -->
</head>

<body>
<!-- wrapper -->
<div id="wrapper">

<!-- banner -->
<div id="banner"><a href="http://www.baruch.cuny.edu"><img src="http://www.baruch.cuny.edu/images/logo_baruch.gif" alt="Baruch College" name="logo" width="201" height="68" border="0" id="logo" /></a></div>
<!-- /banner -->
<!-- main -->
<div id="main">
<!--BODY Include ENDS -->
<!--body.html include Goes Here -->
<center>
<h1>Welcome to Update Baruch Course Schedule</h1>
</center>


<br>

<FORM ACTION="update.jsp" >
  
	

<center>

	  <%


	  Connection conn = null;
	   try
	   {

		   String driver = "oracle.jdbc.OracleDriver";
		   // 1. Load the driver
		   Class.forName(driver);

		   // 2. Define the connection URL
		   String url = "jdbc:oracle:thin:@localhost:1521:XE"; //orcl is the SID
		   String myusername = "hello"; // Your DB login ID
		   String mypassword = "hello"; //Your Db pass

		   
		// 3. Establish the connection
  conn = DriverManager.getConnection(url, myusername,mypassword);
	      // 4. Create a statement object
	      Statement stmt = conn.createStatement();

	      // 5. Execute a query

	      ResultSet rs = stmt.executeQuery("SELECT SEMESTER_NAME FROM SEMESTER_SR");
// DropDownMenue

	      %>
	      
	       <label>Semester:</label>
	          <select name="semester">
	          <option selected="selected">Semester Select</option>
	
        
         <%
	      while (rs.next()){
	          %>
	          <option><%= rs.getString(1)%></option>
	          <%
	          }

	          %>

<%

	   }

	   catch(SQLException e)
	   {
	      // Do exception catch such as if connection is not made or
	      // query is not set up properly
	      out.println("SQLException: " + e.getMessage() + "<BR>");
	      while((e = e.getNextException()) != null)
	         out.println(e.getMessage() + "<BR>");
	   }
	   catch(ClassNotFoundException e)
	   {
	      out.println("ClassNotFoundException: " + e.getMessage() + "<BR>");
	   }
	   finally
	   {
	// 7. Close connection; Clean up resources
	      if(conn != null)
	      {
	         try
	         {
	            conn.close();
	         }
	         catch (Exception ignored) {}
	      }
	   }

	   %>
   </select>
  </label>&nbsp;&nbsp;
  Start Date:
  <INPUT TYPE="TEXT" NAME="startDate" placeholder="YYYY-MM-DD" VALUE="">&nbsp;&nbsp;&nbsp;
  End Date:</B>
  <INPUT TYPE="TEXT" NAME="endDate"placeholder="YYYY-MM-DD" VALUE=""><br><br><br>
  <INPUT TYPE="SUBMIT" value="Update Schedule"> <!-- Press this button to submit form -->
  
  <p align="left">
	 <b>	 
	 <a href="logout.jsp"><font size="5">Log out</font></a> </b>&nbsp;<br>
<br>
</p>

</center>
</div>
</div>
</body>
</html>







