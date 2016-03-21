<!-- 
http://stackoverflow.com/
 -->


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Baruch College</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link REL="icon" href="http://www.baruch.cuny.edu/favicon.ico">
	<link rel="stylesheet" type="text/css"
		href="http://www.baruch.cuny.edu/css/baruch_interior.css" />
	<link rel="stylesheet" type="text/css"
		href="http://www.baruch.cuny.edu/css/application.css" />
	<link href="schedule.css" rel="stylesheet" type="text/css" />
	<form method="post" action=coursedetails.jsp>
		<%
// Declare variables based on the input:
String code=null;
String semester = null;
String department = null;
String discipline = null;
String undergraduate = null;
String graduate = null;
String number = null;
String week = null;
String instructor = null;
String time = null; 
String am_pm = null; 
String timeDetail = null;

Cookie[] cookies = request.getCookies();
if (cookies != null){
	for(Cookie cookie : cookies){
		// Get value of all cookies if not null. 
		if(cookie.getName().equals("semester")) semester = cookie.getValue(); 
		if(cookie.getName().equals("department")) department = cookie.getValue(); 
		if(cookie.getName().equals("discipline")) discipline = cookie.getValue(); 
		if(cookie.getName().equals("div_undr")) undergraduate = cookie.getValue(); 
		if(cookie.getName().equals("div_grad")) graduate = cookie.getValue(); 
		if(cookie.getName().equals("number")) number = cookie.getValue(); 
		if(cookie.getName().equals("week")) week= cookie.getValue(); 
		if(cookie.getName().equals("instructor")) instructor = cookie.getValue(); 
		if(cookie.getName().equals("time")) time = cookie.getValue(); 
		if(cookie.getName().equals("am_pm")) am_pm = cookie.getValue();
		if(cookie.getName().equals("timeDetail")) timeDetail = cookie.getValue();		

	}
}


 
	


%>
		<%@ page import="java.sql.*"%>
		<%@ page import="java.text.*"%>
		<%@ page import="java.io.*"%>
		<%@ page import="java.util.*"%>
		<%@ page import=" java.util.Calendar.*"%>
		<%@page import="java.text.SimpleDateFormat"%>
</head>
<body>
	<div id="wrapper">
		<div id="banner">
			<a href="http://www.baruch.cuny.edu"><img
				src="http://www.baruch.cuny.edu/images/logo_baruch.gif"
				alt="Baruch College" name="logo" width="201" height="68" border="0"
				id="logo" /></a>
		</div>
		<div id="main">
			<!--BODY Include ENDS -->

			<p>Search results are based on the following keywords:</p>
			<table id="criteria"
				summary="This table contains the search criteria. Results are listed in next table.">
				<tr>
					<td><strong>Semester</strong> <% out.println(semester); %></td>
					<td><strong>Days</strong>: <%if(week.equals("null")){ out.println("");}else out.println(week); %></td>
				</tr>
				<tr>
					<td><strong>Department</strong> <%if(department.equals("null")){ out.println("");}else out.println(department); %></td>
					
					
					<td><strong>Time</strong>: <% out.println(timeDetail + " " );
					if (time.equals("null"))
							{out.println(" ");}
					if (!time.equals("null")){out.println(time + ":00" + " " + am_pm);} %></td>
					
					
					
					
				</tr>
				<tr>
					<td><strong>Discipline</strong>: <%if(discipline.equals("null")){ out.println("");}else out.println(discipline); %></td>
					<td><strong>Course number</strong>: <% out.println(number); %></td>
				</tr>
				<tr>
					<td><strong>Division</strong>: <% 
					 if("null".equals(undergraduate) &&  "null".equals(graduate))
				  	 { out.println("Undergraduate and Graduate");
				  	 }
				  	 if("null".equals(undergraduate) &&  !"null".equals(graduate))
				  	 { out.println("Undergraduate");}
				  	 if("null".equals(graduate) && !"null".equals(undergraduate))
				  	 { out.println("Graduate");}
					 %></td>
					<td><strong>Instructor</strong>: <%if(instructor.equals("null")){ out.println("");}else out.println(instructor); %></td>
				</tr>
			</table>
			<%
			Connection conn = null;	 
				   String driver = "oracle.jdbc.OracleDriver";
				   // Load the driver
				   Class.forName(driver);
				   // Define the connection URL
				   String url = "jdbc:oracle:thin:@localhost:1521:XE"; //orcl is the SID
				   String myusername = "hello"; // Your DB login ID
				   String mypassword = "hello"; //Your Db pass
				   // Establish the connection
		  		   conn = DriverManager.getConnection(url, myusername,mypassword);			
			Statement statement = (Statement) conn.createStatement();
  			
  String Queryy="SELECT DISTINCT CRS_SEC, CRS_INDEX, SEMESTER_SR.SEMESTER, CRS_SEC_SR.DISC, CRS_SEC_SR.RM, CRS_SEC_SR.MEETING_DAYS, CRS_SEC_SR.START_TIME, CRS_SEC_SR.STOP_TIME, CRS_SEC_SR.INSTRUCTOR_LNAME,  CRS_SEC_SR.START_DATE,CRS_SEC_SR.END_DATE,CRS_SEC_SR.AM_PM,  CRS_SEC_SR.CRS_NUM, CRS_SEC_SR.BUILDING, CRS_SEC_SR.RM, CRS_SEC_SR.SEATS_AVAIL, DEPT_SR.DEPT_NAME, CRS_COMMENTS_SR.CRS_COMMENTS1 FROM CRS_SEC_SR  INNER JOIN SEMESTER_SR ON CRS_SEC_SR.SEMESTER = SEMESTER_SR.SEMESTER INNER JOIN DISCIPLINE_SR ON CRS_SEC_SR.DISC =  DISCIPLINE_SR.DISC_ABBREVIATION INNER JOIN DEPT_SR ON  DISCIPLINE_SR.DEPT_ID = DEPT_SR.DEPT_ID INNER JOIN COURSE_SR ON DISCIPLINE_SR.DISC_ABBREVIATION = COURSE_SR.DISCIPLINE  INNER JOIN CRS_COMMENTS_SR ON CRS_SEC_SR.CRS_CD = CRS_COMMENTS_SR.CRS_CD where SEMESTER_SR.SEMESTER= '" + semester + "' ";
  			
  	if(!"null".equals(department))
  	{ Queryy+="and DEPT_SR.DEPT_NAME like '%"+ department + "%'";
  		} 
  	if(!"null".equals(discipline))
  	{ Queryy+="and CRS_SEC_SR.DISC= '"+ discipline + "'";}

  	if(!"".equals(number))
  	{ Queryy+="and CRS_SEC_SR.CRS_NUM='" + number +"'";}

  	 if(!"".equals(instructor))
  		
  	{
  		String upper=instructor.toUpperCase();//to upper case
  		String lower=instructor.toLowerCase();//lower case
  		String firstLetter = instructor.substring(0,1).toUpperCase();//first letter caps and the rest lower case
  		String restLetters = instructor.substring(1).toLowerCase();
  		String name= firstLetter + restLetters;

  		 Queryy += "and( CRS_SEC_SR.INSTRUCTOR_LNAME='" + upper + "'or CRS_SEC_SR.INSTRUCTOR_LNAME='" + instructor+"' or CRS_SEC_SR.INSTRUCTOR_LNAME='" + name+"'  or CRS_SEC_SR.INSTRUCTOR_LNAME='" + lower+"')";
  		 
  	}
  	
  	if(!"null".equals(week))
 	 { Queryy+="and CRS_SEC_SR.MEETING_DAYS='" + week + "'";}
 	 

  	if("u".equals(undergraduate) &&  "g".equals(graduate))
	 { Queryy+="and( CRS_SEC_SR.D_E_G='D' or CRS_SEC_SR.D_E_G='G')";
	
	 
	 }

	else if( "g".equals(graduate))
	 { Queryy+="and CRS_SEC_SR.D_E_G='G'";
	}

	else if("u".equals(undergraduate))
	 { Queryy+="and CRS_SEC_SR.D_E_G='D'";
	}
 	  

 	if(!"null".equals(time) && !"null".equals(timeDetail))
  	{
  		if (timeDetail.equals("before"))
  		{	
  		 if (am_pm.equals("AM"))
  			{			 
  			Queryy+="and START_TIME < '" + time +"' AND START_TIME !='00:00' and AM_PM ='AM'";		
		 }	 
  		 else
  		 {
  			 if(time.equals("12")) 
				 {
			Queryy+="and START_TIME !='00:00' and AM_PM ='AM'";	
				 } 
  			 else 
  			 {
  				Queryy+="and(START_TIME >'12' or ( START_TIME >'01:00'  and  START_TIME <'" + time +"'  )and START_TIME !='00:00') or (am_pm='AM' AND START_TIME !='00:00')";
  			 } 
  		 }
  		}
  		if (timeDetail.equals("around"))
  		{   			
  			if(time.equals("01") &&  am_pm.equals("PM"))	  			
  			{	  			  			
  				Queryy+="and substr(start_time,0,2) = '12' or start_time <'02' and START_TIME !='00:00' and am_pm='PM'"; 	  					  				
  			} 			
  			else if(time.equals("01") && am_pm.equals("AM")) 			
  			{	  		  			
  				Queryy+="and  START_TIME >'12:00'  and  START_TIME <'02:00' and START_TIME !='00:00' and AM_PM ='AM'"; 					
  			}	
  			else if(time.equals("12") && am_pm.equals("PM"))	  			
  			{	  		  			
  				Queryy+="and substr(start_time,0,2) = '11' or start_time <'01' and am_pm='PM' and START_TIME !='00:00'"; 					
  			}	
  			else if(time.equals("11"))	  			
  			{			
  				Queryy+="and  START_TIME >'10:00'  and AM_PM ='AM'";
  			}
  			else if (time.equals("02")  ||  time.equals("03") ||  time.equals("04") ||  time.equals("05")  ||  time.equals("06") ||  time.equals("07") ||  time.equals("08"))
  			{
  			int a=Integer.parseInt(time)+1;
  			int b=Integer.parseInt(time)-1;
  			String  after=Integer.toString(a);
  			String  before=Integer.toString(b);
  			Queryy+="and START_TIME >'0" + before +"' and  START_TIME <'0" + after+"' and AM_PM ='" + am_pm +"'";
  			}			
  			else if (time.equals("09")  ||  time.equals("10"))
  			{
  			int a=Integer.parseInt(time)+1;
  			int b=Integer.parseInt(time)-1;
  			String  after=Integer.toString(a);
  			String  before=Integer.toString(b);
  			Queryy+="and START_TIME >'0" + before +"' and  START_TIME <'" + after+"' and AM_PM ='" + am_pm +"'";
  		    }
  			else if (time.equals("12") &&  am_pm.equals("AM"))
  			{  			
  			int a=Integer.parseInt(time)+1;
  			int b=Integer.parseInt(time)-1;
  			String  after=Integer.toString(a);
  			String  before=Integer.toString(b);
  			Queryy+="and START_TIME >'12" + before +"' and  START_TIME <'12" + after+"' and AM_PM ='" + am_pm +"'";  			
  			}
  		} 		
  		// For after: 
  		if (timeDetail.equals ("after")) 			
  		{
  			if(time.equals("12"))
  			{	  				
  				Queryy+="and START_TIME >'12:00' and CRS_SEC_SR.AM_PM ='" + am_pm +"'";
  			}
			else if (am_pm.equals("PM")){	  
  				Queryy += "and substr(start_time,0,2) >= '"+time+"' and substr(start_time,0,2) < '12' and am_pm = 'PM'";	  			
  			}
			else if (am_pm.equals("AM") &&  (time != "01" ||  time !="02" ||  time !="03" ||  time !="04" || time !="05")){	  
  				Queryy += "and substr(start_time,0,2) >= '"+time+"'";	  			
  			}
			else if (am_pm.equals("AM") &&  (time == "01" ||  time =="02" ||  time =="03" ||  time =="04" || time =="05")){	  
  				Queryy += "and substr(start_time,0,2) = '00'";	  			
  			}
  		}		
  	}
  					 
  	ResultSet res = statement.executeQuery(Queryy);
		%>
			<font color="red">
				<p>Due to the dynamic nature of the registration process, not
					all courses listed as open will have space for new registrants.</p>
				<p>
					The Current date and time =
					<%=new java.util.Date()%></p>
				<p>
					The database was last updated
					<%   				
					Statement upd = (Statement) conn.createStatement();
		  			String updQuery = "SELECT UPDATE_TIME FROM UPDATE_TIME_SR WHERE semester='"+semester+ "'";					
					ResultSet resy = upd.executeQuery(updQuery);
					while(resy.next())
					{
					  out.println(resy.getString(1));
					}
					%>
				</p>
				<table style="color: black" id="results"
					summary="This table contains the search results for schedule of classes.">
					<caption>Schedule of Classes Search Results</caption>
					<thead>
						<tr>
							<th scope="col">Course</th>
							<th scope="col">Code</th>
							<th scope="col">Section</th>
							<th scope="col">Day &amp; Time</th>
							<th scope="col">Dates</th>
							<th scope="col">Bldg &amp; Rm</th>
							<th scope="col">Instructor</th>
							<th scope="col">Seats Avail</th>
							<th scope="col">Comments</th>
						</tr>
					</thead>
					<tbody>
						<% 
while(res.next())
{
	// Display the input of the user on the top then display all classes that fit the criteria: 
   out.println("<TR>"); 
   out.println("<TD> <a href=\"coursedetails.jsp?coded=" +  res.getString("CRS_INDEX") + "\">" + res.getString("DISC") +" "+res.getString("CRS_NUM") + "</a>");
   out.println("<TD>" +  res.getString("CRS_INDEX")+"</TD>" ); 
   out.println("<TD>" + res.getString("CRS_SEC")   + "</TD>");
   out.println("<TD>" + res.getString("MEETING_DAYS") +" , "+ res.getString("START_TIME").replace("ON:LI", " Online ")+ "-"+ res.getString("STOP_TIME") + res.getString("AM_PM")+"</TD>");//day and time
   out.println("<TD>" + res.getString("START_DATE").replace("00:00:00.0","") + " - "+ res.getString("END_DATE").replace("00:00:00.0","")+"</TD>");//sates
      
   if(res.getString("BUILDING")==null)//building
	 { 
	 out.println("<TD>" + "TBA" + "</TD>");
	 }
 else out.println("<TD>" + res.getString("BUILDING") + " " + res.getString("RM") + "</TD>");
   out.println("<TD>" + res.getString("INSTRUCTOR_LNAME") + "</TD>"); 
   if(res.getString("SEATS_AVAIL").equals("0"))    
	 { 
	 out.println("<TD>" + "No seats available" + "</TD>");
	 }
 else out.println("<TD>" + res.getString("SEATS_AVAIL") + "</TD>");
   
   if(res.getString("crs_comments1")==null)//comments
	 { 
  	 out.println("<TD>" + "No comment" + "</TD>");
	 }
   else out.println("<TD>" + res.getString("crs_comments1") + "</TD>");
   %>
						<%
   out.println("</TR>");
}
%>
					</tbody>
				</table>
			</font>
		</div>
	</div>
	</div>
</body>
</html>
