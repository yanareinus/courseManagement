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
<%
String a;
a=request.getParameter("coded");
System.out.println("code is"+a);
String semester = null;
String department = null;
String discipline = null;
String undergraduate = null;
String graduate = null;
String number = null;
String week = null;
String instructor = null;

Cookie[] cookies = request.getCookies();
if (cookies != null){
	for(Cookie cookie : cookies){
		if(cookie.getName().equals("semester")) semester = cookie.getValue(); 
		if(cookie.getName().equals("department")) department = cookie.getValue(); 
		if(cookie.getName().equals("discipline")) discipline = cookie.getValue(); 
		if(cookie.getName().equals("div_undr")) undergraduate = cookie.getValue(); 
		if(cookie.getName().equals("div_grad")) graduate = cookie.getValue(); 
		if(cookie.getName().equals("number")) number = cookie.getValue(); 
		if(cookie.getName().equals("week")) week= cookie.getValue(); 
		if(cookie.getName().equals("instructor")) instructor = cookie.getValue(); 		
	}
	
System.out.println("course number is"+number);
}


%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>
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
			<%	
			Connection conn = null;			 
				   String driver = "oracle.jdbc.OracleDriver";
				   // 1. Load the driver
				   Class.forName(driver);
				   // 2. Define the connection URL
				   String url = "jdbc:oracle:thin:@localhost:1521:XE"; //orcl is the SID
				   String myusername = "hello"; // Your DB login ID
				   String mypassword = "hello"; //Your Db pass				   
				   // 3. Establish the connection
		  		   conn = DriverManager.getConnection(url, myusername,mypassword);		
				   Statement statement = (Statement) conn.createStatement();			
  String Queryy="SELECT CRS_SEC_SR.DISC, CRS_SEC_SR.CRS_NUM, CRS_INDEX, SEMESTER_SR.SEMESTER, COURSE_SR.TITLE,CRS_SEC_SR.CRS_CD, CRS_SEC_SR.CRS_SEC, DEPT_SR.DEPT_NAME, COURSE_SR.LEVEL_DIV,CRS_SEC_SR.START_DATE,CRS_SEC_SR.END_DATE,CRS_SEC_SR.SEATS_AVAIL,CRS_SEC_SR.MEETING_DAYS, CRS_SEC_SR.START_TIME, CRS_SEC_SR.STOP_TIME,CRS_SEC_SR.AM_PM, CRS_SEC_SR.BUILDING,CRS_SEC_SR.RM, CRS_SEC_SR.INSTRUCTOR_LNAME, COURSE_SR.CREDITHOUR, COURSE_SR.DESCRIPTION,CRS_COMMENTS_SR.CRS_COMMENTS1, COURSE_SR.PREREQ FROM CRS_SEC_SR INNER JOIN SEMESTER_SR ON CRS_SEC_SR.SEMESTER = SEMESTER_SR.SEMESTER INNER JOIN CRS_COMMENTS_SR ON CRS_SEC_SR.CRS_CD = CRS_COMMENTS_SR.CRS_CD INNER JOIN COURSE_SR ON CRS_SEC_SR.CRS_NUM = COURSE_SR.COURSENUMBER INNER JOIN DISCIPLINE_SR ON DISCIPLINE_SR.DISC_ABBREVIATION = CRS_SEC_SR.DISC INNER JOIN DEPT_SR ON DEPT_SR.DEPT_ID = DISCIPLINE_SR.DEPT_ID  where CRS_INDEX= '"+ a + "'";
  	PreparedStatement statementYH = conn.prepareStatement(Queryy);
  	statementYH.setMaxRows(1);
  	ResultSet res = statementYH.executeQuery(Queryy);
  	out.println("<TABLE CELLSPACING=\"0\" CELLPADDING=\"10\" BORDER=\"0\">");
    %> 
     <table id="details" summary="This table contains details about each course.">
<caption>
Schedule of Classes Course Details 
</caption>  
<% 

	
// This displays the details of the course that was selected: This is based on the course index. 
    	while (res.next()) 
    	{

        	 out.println("<TH>Semester: </TH>");  
             out.println("<TD>" + res.getString("SEMESTER") + "</TD>"); 
             out.println("<TR>"); 
             
             out.println("<TH>Course - Title: </TH>");  
             out.println("<TD>" + res.getString("DISC") + " " + res.getString("CRS_NUM") + "-  " + res.getString("TITLE") + "</TD>");
             out.println("<TR>"); 
            
             out.println("<TR>"); 
        	 out.println("<TH>Code: </TH>");  
             out.println("<TD>" + res.getString("crs_cd") + "</TD>");
             out.println("<TR>"); 
                        
             out.println("<TH>Section: </TH>");  
             out.println("<TD>" + res.getString("crs_sec") + "</TD>");  
             out.println("<TR>"); 
             
             out.println("<TH>Department: </TH>");  
             out.println("<TD>" + res.getString("dept_name") + "</TD>");
             out.println("<TR>");
                      
             out.println("<TH>Division: </TH>");  
             out.println("<TD>" + res.getString("level_div") + "</TD>");
             out.println("<TR>"); 
             
             out.println("<TH>Dates: </TH>");  
             out.println("<TD>" + res.getString("start_date").replace("00:00:00.0","") + " - "+ res.getString("END_DATE").replace("00:00:00.0","") +"</TD>");
             out.println("<TR>"); 
             
             out.println("<TH>Seats Available: </TH>"); 
             if(res.getString("SEATS_AVAIL").equals("0")  )   
            	   
        	 { 
        	 out.println("<TD>" + "No seats available" + "</TD>");
        	 }
         else out.println("<TD>" + res.getString("SEATS_AVAIL") + "</TD>");          
             out.println("</TR>"); 
                                    
             Statement miya = conn.createStatement();
             String meetingDaysQuery = "SELECT MEETING_DAYS, START_TIME, STOP_TIME, AM_PM, BUILDING, RM, INSTRUCTOR_LNAME FROM CRS_SEC_SR WHERE  CRS_NUM = '"  + res.getString("CRS_NUM") + "'";
             ResultSet rest = miya.executeQuery(meetingDaysQuery);
         	 miya.setMaxRows(5);
 
         	 int count = 0; 
         	 
             while (rest.next()){
            	 count++; 
            	 
            	 out.println("<TH><b>Meeting " + count + "- Day &amp; Time, Buildign &amp; Room, Instructor:</b></TH>"); 
            	 if(rest.getString("MEETING_DAYS").equals("HTBA"))
            	 { out.println("<TD>" + rest.getString("MEETING_DAYS") +","+ rest.getString("INSTRUCTOR_LNAME")+"</TD>");
                 out.println("</TR>");}
            	 else out.println("<TD>" + rest.getString("MEETING_DAYS") +","+ rest.getString("START_TIME")+ rest.getString("AM_PM")+ "-"+ rest.getString("STOP_TIME") + rest.getString("AM_PM")+ "," +  rest.getString("BUILDING")+"," +rest.getString("RM")+ ","+ rest.getString("INSTRUCTOR_LNAME") +"</TD>");
                 out.println("</TR>"); 
             }
            
             out.println("<TH>Credit Hours: </TH>");  
             out.println("<TD>" + res.getString("credithour") + "</TD>");
             out.println("<TR>"); 
             
             out.println("<TH> Description: </TH>");  
             out.println("<TD>" + res.getString("Description") + "</TD>");
             out.println("</TR>"); 
             
             out.println("<TH> Course Comments: </TH>");  
             if(res.getString("crs_comments1")==null)//if no comments
            	 out.println("<TD>" + "No Comment" + "</TD>");
            else out.println("<TD>" + res.getString("crs_comments1") + "</TD>");
             out.println("</TR>"); 
             
             out.println("<TH> Pre-requisite: </TH>");  
             out.println("<TD>" + res.getString("prereq") + "</TD>");
             
             out.println("</TR>"); 
    	}
 
     out.println("</TABLE>");

	

     conn.close(); 
     %> 
     
</div>
</div>
</body>
</html>
<!--FOOT Include Ends   WE NEED TO CLOSE CONNECTIONS!!!!!!!!-->   


</html>
<!--FOOT Include Ends -->

