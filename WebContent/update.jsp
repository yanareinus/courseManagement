<%@ page import="java.sql.*"%>
<%@ page import="java.text.*"%>

<%
String semester = request.getParameter("semester") ;

//String Date to Util Date- was copied from the code you provided
String startDateStr = request.getParameter("startDate");
java.util.Date startDate = new SimpleDateFormat("yyyy-MM-dd").parse(startDateStr);
String endDateStr = request.getParameter("endDate");
java.util.Date endDate = new SimpleDateFormat("yyyy-MM-dd").parse(endDateStr);



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
   
   
   String updateString = "UPDATE SEMESTER_SR SET START_DATE=?,END_DATE=? WHERE SEMESTER_NAME=?";//http://www.codejava.net/java-se/jdbc/jdbc-tutorial-sql-insert-select-update-and-delete-examples
     
   PreparedStatement stmt = conn.prepareStatement(updateString);
   stmt.setDate (1, new java.sql.Date(startDate.getTime()));
   stmt.setDate(2, new java.sql.Date(endDate.getTime()));
   stmt.setString(3, semester);
   //step 5
   stmt.executeUpdate();
   conn.commit();
   
   //redirected to the display.jsp
   String redirectURL = "display1.jsp";//http://stackoverflow.com/questions/4967482/redirect-pages-in-jsp
   response.sendRedirect(redirectURL);
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