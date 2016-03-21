/*
http://stackoverflow.com/
*/


package PassParameters;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/PassParameters")
public class PassParameters extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Connection conn = null;
		try {

			String driver = "oracle.jdbc.OracleDriver";
			// Load the driver
			Class.forName(driver);

			// Define the connection URL
			String url = "jdbc:oracle:thin:@localhost:1521:XE"; // orcl is the
																// SID
			String myusername = "hello"; // Your DB login ID
			String mypassword = "hello"; // Your Db pass

			// Establish the connection
			conn = DriverManager.getConnection(url, myusername, mypassword);
			// Request all parameters that the user input:
			String code = request.getParameter("CRS_INDEX");
			String semester = request.getParameter("semester");
			String department = request.getParameter("department");
			String discipline = request.getParameter("discipline");
			String undergraduate = request.getParameter("div_undr");
			String graduate = request.getParameter("div_grad");
			String number = request.getParameter("number");
			String week = request.getParameter("week");
			String time = request.getParameter("time");
			String instructor = request.getParameter("instructor");
			String timeDetail = request.getParameter("timeDetail");
			String am_pm = request.getParameter("am_pm");
			System.out.println(instructor);
			
			
			 
			
		  
		  	
		  

			// Create statement for query:
			Statement statement = (Statement) conn.createStatement();
			
		
			// We created a string called Query which selects all necessary
			// fields from the database. We include all inner joins needed to
			// link the tables.
			// Then we added if statements to take into account what the user
			// inputs. If the input is null, the string is not added.
			String Query = "SELECT DISTINCT CRS_INDEX, CRS_SEC_SR.AM_PM, CRS_SEC_SR.D_E_G, SEMESTER_SR.SEMESTER, CRS_SEC_SR.DISC, CRS_SEC_SR.MEETING_DAYS, CRS_SEC_SR.START_TIME, CRS_SEC_SR.STOP_TIME,CRS_SEC_SR.INSTRUCTOR_LNAME, CRS_SEC_SR.START_DATE,CRS_SEC_SR.END_DATE,CRS_SEC_SR.AM_PM, CRS_SEC_SR.CRS_NUM, CRS_SEC_SR.BUILDING, CRS_SEC_SR.RM, CRS_SEC_SR.SEATS_AVAIL, DEPT_SR.DEPT_NAME FROM CRS_SEC_SR INNER JOIN SEMESTER_SR ON CRS_SEC_SR.SEMESTER = SEMESTER_SR.SEMESTER INNER JOIN DISCIPLINE_SR ON CRS_SEC_SR.DISC = DISCIPLINE_SR.DISC_ABBREVIATION INNER JOIN DEPT_SR ON DISCIPLINE_SR.DEPT_ID = DEPT_SR.DEPT_ID INNER JOIN COURSE_SR ON DISCIPLINE_SR.DISC_ABBREVIATION = COURSE_SR.DISCIPLINE where SEMESTER_SR.SEMESTER= '"
					+ semester + "' ";
			if (!"null".equals(department))
			{
				Query += "and DEPT_SR.DEPT_NAME like '%" + department + "%'";
			}
			if (!"null".equals(discipline)) {
				Query += "and CRS_SEC_SR.DISC= '" + discipline + "'";
			}

			if (!"".equals(number)) {
				Query += "and CRS_SEC_SR.CRS_NUM='" + number + "'";
			}
			// For the time, we divided into three parts: before, after, and around and then performed separate if statements on each.
			if (!"null".equals(time) && !"null".equals(timeDetail)) {
				// For before: 
				if (timeDetail.equals("before")) {
					if (am_pm.equals("AM"))
					{
						Query += "and START_TIME < '" + time + "' AND START_TIME !='00:00' and AM_PM ='AM'";
					}
					else
					{
						if (time.equals("12"))
						{
							Query += "and START_TIME !='00:00' and AM_PM ='AM'";
						}
						else {
							Query += "and(START_TIME >'12' or ( START_TIME >'01:00'  and  START_TIME <'" + time
									+ "' )and START_TIME !='00:00') or (am_pm='AM' AND START_TIME !='00:00')";
						}
					}
				}
				// For around: 
				if (timeDetail.equals("around")) {
					if (time.equals("01") && am_pm.equals("PM"))
					{
						Query += "and substr(start_time,0,2) = '12' or start_time <'02' and am_pm='PM'";
					}
					else if (time.equals("01") && am_pm.equals("AM"))
					{
						Query += "and  START_TIME >'12:00'  and  START_TIME <'02:00' and AM_PM ='AM'";
					} else if (time.equals("12") && am_pm.equals("PM"))
					{
						Query += "and substr(start_time,0,2) = '11' or start_time <'01' and am_pm='PM'";
					} else if (time.equals("11"))
					{
						Query += "and  START_TIME >'10:00'  and AM_PM ='AM'";					
					}
					else if (time.equals("02") || time.equals("03") || time.equals("04") || time.equals("05")
							|| time.equals("06") || time.equals("07") || time.equals("08")) 
					{
						int a = Integer.parseInt(time) + 1;
						int b = Integer.parseInt(time) - 1;
						String after = Integer.toString(a);
						String before = Integer.toString(b);
						Query += "and START_TIME >'0" + before + "' and  START_TIME <'0" + after + "' and AM_PM ='"+ am_pm + "'";
					}
					else if (time.equals("09") || time.equals("10")) {
						int a = Integer.parseInt(time) + 1;
						int b = Integer.parseInt(time) - 1;
						String after = Integer.toString(a);
						String before = Integer.toString(b);
						Query += "and START_TIME >'0" + before + "' and  START_TIME <'" + after + "' and AM_PM ='" + am_pm + "'";
						System.out.println("Around" + time + am_pm + "selected.");
					}
					else if (time.equals("12") && am_pm.equals("AM")) {
						int a = Integer.parseInt(time) + 1;
						int b = Integer.parseInt(time) - 1;
						String after = Integer.toString(a);
						String before = Integer.toString(b);
						Query += "and START_TIME >'12" + before + "' and  START_TIME <'12" + after + "' and AM_PM ='"
								+ am_pm + "'";
					}
				}
				// For after: 
				if (timeDetail.equals("after")) {
					if (time.equals("12")) {
						Query += "and START_TIME >'12:00' and CRS_SEC_SR.AM_PM ='" + am_pm + "'";
					} else if (am_pm.equals("PM")) {
						Query += "and substr(start_time,0,2) >= '" + time
								+ "' and substr(start_time,0,2) < '12' and am_pm = 'PM'";
					} else if (am_pm.equals("AM")
							&& (time != "01" || time != "02" || time != "03" || time != "04" || time != "05")) {
						Query += "and substr(start_time,0,2) >= '" + time + "'";
					} else if (am_pm.equals("AM")
							&& (time == "01" || time == "02" || time == "03" || time == "04" || time == "05")) {
						Query += "and substr(start_time,0,2) = '00'";
					}
				}
			}
			
			if (!"".equals(instructor)) {
				String upper=instructor.toUpperCase();//to upper case
				String lower=instructor.toLowerCase();//lower case
				String firstLetter = instructor.substring(0,1).toUpperCase();//first letter caps and the rest lower case
				String restLetters = instructor.substring(1).toLowerCase();
				String name= firstLetter + restLetters;
		  		 Query += "and( CRS_SEC_SR.INSTRUCTOR_LNAME='" + upper + "'or CRS_SEC_SR.INSTRUCTOR_LNAME='" + instructor+"' or CRS_SEC_SR.INSTRUCTOR_LNAME='" + name+"'  or CRS_SEC_SR.INSTRUCTOR_LNAME='" + lower+"')";
			}

			
			
			
			
			if (!"null".equals(week)) {
				Query += "and CRS_SEC_SR.MEETING_DAYS='" + week + "'";
			}

			if("u".equals(undergraduate) &&  "g".equals(graduate))
		 	 { Query+="and( CRS_SEC_SR.D_E_G='D' or CRS_SEC_SR.D_E_G='G')";
		 	
		 	 
		 	 }

			else if( "g".equals(graduate))
		 	 { Query+="and CRS_SEC_SR.D_E_G='G'";
		 }

			else if("u".equals(undergraduate))
		 	 { Query+="and CRS_SEC_SR.D_E_G='D'";
		 	}
		 	
			// Now that we have all inputs, we finally execute the query 
			ResultSet res = statement.executeQuery(Query);

			if (res.next()) {
				// Parameter Cookies
				Cookie codeCookie = new Cookie("CRS_INDEX", code);
				//We created the cookies for all inputs:
				Cookie semesterCookie = new Cookie("semester", semester);
				Cookie departmentCookie = new Cookie("department", department);
				Cookie disciplineCookie = new Cookie("discipline", discipline);
				Cookie div_undrCookie = new Cookie("div_undr", undergraduate);
				Cookie div_gradCookie = new Cookie("div_grad", graduate);
				Cookie numberCookie = new Cookie("number", number);
				Cookie weekCookie = new Cookie("week", week);
				Cookie instructorCookie = new Cookie("instructor", instructor);
				Cookie timeCookie = new Cookie("time", time);
				Cookie am_pmCookie = new Cookie("am_pm", am_pm);
				Cookie timeDetailCookie = new Cookie("timeDetail", timeDetail);

				// Setting the cookie to expire in 30 minutes.
				codeCookie.setMaxAge(30 * 60);
				semesterCookie.setMaxAge(30 * 60);
				departmentCookie.setMaxAge(30 * 60);
				disciplineCookie.setMaxAge(30 * 60);
				div_undrCookie.setMaxAge(30 * 60);
				div_gradCookie.setMaxAge(30 * 60);
				numberCookie.setMaxAge(30 * 60);
				weekCookie.setMaxAge(30 * 60);
				instructorCookie.setMaxAge(30 * 60);
				timeCookie.setMaxAge(30 * 60);
				am_pmCookie.setMaxAge(30 * 60);
				timeDetailCookie.setMaxAge(30 * 60);
				
				// Adding the cookies: 
				response.addCookie(codeCookie);
				response.addCookie(semesterCookie);
				response.addCookie(departmentCookie);
				response.addCookie(disciplineCookie);
				response.addCookie(div_undrCookie);
				response.addCookie(div_gradCookie);
				response.addCookie(numberCookie);
				response.addCookie(weekCookie);
				response.addCookie(instructorCookie);
				response.addCookie(timeCookie);
				response.addCookie(am_pmCookie);
				response.addCookie(timeDetailCookie);
				
				
				response.sendRedirect("searchresults.jsp");
			} else {

				response.sendRedirect("searcherror.jsp");
			}

		} catch (SQLException e) {
			// Do exception catch such as if connection is not made or
			// query is not set up properly
			System.out.println("SQLException: " + e.getMessage());
			while ((e = e.getNextException()) != null)
				System.out.println(e.getMessage());
		} catch (ClassNotFoundException e) {
			System.out.println("ClassNotFoundException: " + e.getMessage());
		} finally {
			// Close connection; Clean up resources
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception ignored) {
				}
			}
		}
	}
}
