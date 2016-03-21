
<%
if(request.getSession().getAttribute("user")==null){// if user is null- erro massage- prevent a sneaky user to access 

	response.sendRedirect("loginerror.jsp");
	
}
String a;
a=request.getParameter("user");


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

<center>
<h1>You have successfully updated the semester schedule</h1>
</center>


<p align="left">
	 <b>
	 
	 <a href="logout.jsp"><font size="5">Log out</font></a> </b>&nbsp;<br>

<br>
</p>
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
		// 3. Establish the connection
  conn = DriverManager.getConnection(url, myusername,mypassword);       
	      // 4. Create a statement object
	      Statement stmt = conn.createStatement();

	      // 5. Execute a query
	      
	      //the rest of the code was copied from your code oracleDB_JSP in hello project
	      ResultSet rs = stmt.executeQuery("SELECT SEMESTER ,SEMESTER_NAME, START_DATE, END_DATE FROM SEMESTER_SR");

	      
	      //Print start of table and column headers
	     out.println("<TABLE CELLSPACING=\"0\" CELLPADDING=\"3\" BORDER=\"1\">");
	     out.println("<TR><TH>SEMESTER</TH><TH>SEMESTER_NAME</TH><TH>START_DATE</TH><TH>END_DATE</TH></TR>");

	      // 6. Process result
	      //column names and Data types has to match Db columns
	      while(rs.next())
	      {
	         out.println("<TR>");
	         
	         out.println("<TD>" + rs.getString("SEMESTER") + "</TD>");
	         out.println("<TD>" + rs.getString("SEMESTER_NAME") + "</TD>");
	         out.println("<TD>" + rs.getString("START_DATE").replace("00:00:00.0"," ")+ "</TD>");
	         out.println("<TD>" + rs.getString("END_DATE").replace("00:00:00.0"," ") + "</TD>");
	        
	      
	         out.println("</TR>");
	      }
	
	      out.println("</TABLE>");
	     
	  
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

</center>
</div>
</div>
</body>
</html>
