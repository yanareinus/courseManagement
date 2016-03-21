/*
 
Student Name: Yael Yana Reinus   
Assignment # 4  
Class: CIS 4160
Features Included:

-servlet for validation- using session.
 
 */


package Verification;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/verificationServlet")
public class verificationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Connect to the database:
		Connection conn = null;
		try {

			String driver = "oracle.jdbc.OracleDriver";
			// 1. Load the driver
			Class.forName(driver);

			// 2. Define the connection URL
			String url = "jdbc:oracle:thin:@localhost:1521:XE"; // orcl is the
																// SID
			String myusername = "hello"; // Your DB login ID
			String mypassword = "hello"; // Your Db pass

			// 3. Establish the connection
			conn = DriverManager.getConnection(url, myusername, mypassword);

			String pass = request.getParameter("password");
			String user = request.getParameter("userId");

			if (request.getSession().getAttribute("user") == null) {//if user is null it checks in the  database if user exists
				
				//Query
				String Query = "SELECT * FROM admin_user_sr WHERE password=? AND user_name=?";

				PreparedStatement stmt = conn.prepareStatement(Query);
				stmt.setString(1, pass);
				stmt.setString(2, user);

				ResultSet res = stmt.executeQuery();//Execute a query

				//if result is found- redirect to the next page

				if (res.next()) {
					request.getSession().setAttribute("user", user);//save user in session
					response.sendRedirect("DropDownMenu.jsp");
					
				} else {
					response.sendRedirect("loginerror.jsp");
				}
			} else

				response.sendRedirect("DropDownMenu.jsp");// go to the next page if user exists
			
			
		} catch (SQLException e) {
			// Do exception catch such as if connection is not made or
			// query is not set up properly
			System.out.println("SQLException: " + e.getMessage());
			while ((e = e.getNextException()) != null)
				System.out.println(e.getMessage());
		} catch (ClassNotFoundException e) {
			System.out.println("ClassNotFoundException: " + e.getMessage());
		} finally {
			// 7. Close connection; Clean up resources
			if (conn != null) {
				try {
					conn.close();
				} catch (Exception ignored) {
				}
			}
		}

	}

}
