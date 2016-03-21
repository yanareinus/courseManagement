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
<div id="wrapper">

<!-- banner -->
<div id="banner"><a href="http://www.baruch.cuny.edu"><img src="http://www.baruch.cuny.edu/images/logo_baruch.gif" alt="Baruch College" name="logo" width="201" height="68" border="0" id="logo" /></a></div>
<!-- /banner -->
<!-- main -->
<div id="main">
<BODY BGCOLOR="white">
	<!-- <center>  -->
	
	
	
	<H1>
			<font color="red">ERROR! Please try logging in again.</font>
		</H1>
	<div style="text-align:center">

	
		<H2>Please Enter your User ID and Password</H2>
		<br>
		<!--  servlet for validation with user id,  -->
		<FORM name= "login" method="post" ACTION="verificationServlet">	
			
			User ID: <INPUT TYPE="TEXT" NAME="userId" VALUE="">
			<p>
		   Password: <INPUT TYPE="password" NAME="password" VALUE="">
			<p>
				<label>Department ID: <select name="deptId">
						<option selected="selected">Select Dept</option>
						<option value="1">Registrar</option>
						<option value="2">BCTC</option>
						<option value="3">Zicklin</option>
				</select>
				</label>	
			<P>
			<Input type ="hidden" name="session" value="" > 
				<INPUT TYPE="SUBMIT" value="Log In">
				<!-- Press this button to submit form -->
			
		</FORM>
		</div>
</div>
</div>
</body>
</html>

