<!-- 
http://stackoverflow.com/
 -->



<%@ page import="java.sql.*"%>
<%
	Connection conn = null;
	try {

		String driver = "oracle.jdbc.OracleDriver";
		// 1. Load the driver
		Class.forName(driver);

		// 2. Define the connection URL
		String url = "jdbc:oracle:thin:@localhost:1521:XE"; //orcl is the SID
		String myusername = "hello"; // Your DB login ID
		String mypassword = "hello"; //Your Db pass

		// 3. Establish the connection
		conn = DriverManager.getConnection(url, myusername, mypassword);
		// 4. Create a statement object
%>
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
			<form method="post" action="PassParameters">
				<div align="center">
				    <h3 style="color:red">ERROR! TRY AGAIN!</h3>
					<p>Enter the professor's name, discipline, course number and/or
						days you wish to search. Select a semester and at least one other
						search criteria; Dept, Discipline, Course number, Day, Time or
						Instructor.</p>
					<table id="search"
						summary="This table contains search options for the schedule of classes.">
						<caption>
							<b>Schedule of Classes Search&nbsp;</b>	
							<tbody>
								<tr>
							<!-- We queried the database to provide us with the information for all the drop down tables in the search. -->
									<th><label for="semester">Semester:</label></th>
									<td><select id="semester" name="semester">
											<%
												Statement stmtt = conn.createStatement();
													ResultSet resu = stmtt.executeQuery("SELECT SEMESTER FROM SEMESTER_SR");
											%>

											<%
												while (resu.next()) {
											%>
											<option><%=resu.getString(1)%> </option>
											<%
												}
											%>
									</select></td>
								</tr>
								<tr>
									<th>Dept:</th>
									<%
										Statement stmt = conn.createStatement();
											ResultSet res = stmt.executeQuery("SELECT DEPT_NAME FROM DEPT_SR");
									%>
									<td><select name="department" size="1">
											<option value="null">Select All</option>
											<%
												while (res.next()) {
											%>
											<option><%=res.getString(1)%></option>
											<%
												}
											%>
									</select></td>
								</tr>


								<tr>
									<!--  Discipline Search -->
									<th>Discipline:</th>
									<%
										Statement stat = conn.createStatement();
											ResultSet rs = stat.executeQuery("SELECT DISC_ABBREVIATION FROM DISCIPLINE_SR");
									%>
									<td><select name="discipline" size="1">
											<option value="null">Select All</option>
											<%
												while (rs.next()) {
											%>
											<option><%=rs.getString(1)%></option>
											<%
												}
											%>
									</select></td>
								</tr>
								<tr>
								<!--  Undergraduate and graduate we utilized the "u" and "g"-->
									<th>Division</th>
									<td><label for="undergraduate">Undergraduate </label><input
										type="checkbox" id="div_undr" value="u" name="div_undr"
										checked> <br> <label for="graduate">Graduate</label><input
										type="checkbox" id="div_grad" value="g" name="div_grad"
										checked></td>
								</tr>
								<tr>
									<th><label for="number">Course number:</label></th>
									<td><input id="number" value="" size="10" name="number"
										maxlength="5" type="text"></td>
								</tr>
								<tr>
									<th><label for="days">Days:</label></th>
									<td><select id="days" name="week">
											<option value="null">Select All</option>
											<option value="M">Mon</option>
											<option value="T">Tue</option>
											<option value="W">Wed</option>
											<option value="TH">Thr</option>
											<option value="F">Fri</option>
											<option value="S">Sat</option>
											<option value="SU">Sun</option>
											<option value="MW">Mon-Wed</option>
											<option value="TTH">Tue-Thr</option>
											<option value="TTHF">Tue-Thr-Fri</option>
											<option value="ONLINE">Online</option>
											<option value="HTBA">HTBA</option>
									</select></td>
								</tr>
								<tr>
									<th><label for="time">Time:</label></th>
									<td><select name="timeDetail">
											<option value=" ">Select All</option>
											<option value="before">before</option>
											<option value="after">after</option>
											<option value="around">around</option>
									</select> <select name="time">
											<option value="null">Select All</option>
											<option value="01">1:00</option>
											<option value="02">2:00</option>
											<option value="03">3:00</option>
											<option value="04">4:00</option>
											<option value="05">5:00</option>
											<option value="06">6:00</option>
											<option value="07">7:00</option>
											<option value="08">8:00</option>
											<option value="09">9:00</option>
											<option value="10">10:00</option>
											<option value="11">11:00</option>
											<option value="12">12:00</option>
									</select> <select name="am_pm">
											<option value="AM">AM</option>
											<option value="PM">PM</option>
									</select></td>
								</tr>
								</select>
								</td>
								</tr>
								<tr>
									<th><label for="instructor">Instructor:</label></th>
									<td><input id="instructor" value="" size="30"
										name="instructor" maxlength="20" type="text"></td>
								</tr>
								</script>
								</tr>
							</tbody>
					</table>
				</div>
				<p align="center">
					<Input type="hidden" name="session" value=""> <input
						value="Search for Classes" type="submit">
				</p>
			</form>
		</div>
	</div>
</body>
</html>
<%
	} catch (SQLException e) {
		// Do exception catch such as if connection is not made or
		// query is not set up properly
		out.println("SQLException: " + e.getMessage() + "<BR>");
		while ((e = e.getNextException()) != null)
			out.println(e.getMessage() + "<BR>");
	} catch (ClassNotFoundException e) {
		out.println("ClassNotFoundException: " + e.getMessage() + "<BR>");
	} finally {
		// 7. Close connection; Clean up resources
		if (conn != null) {
			try {
				conn.close();
			} catch (Exception ignored) {
			}
		}
	}
%>
</html>


