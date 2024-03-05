<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Supervisor</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Roboto+Slab&display=swap" rel="stylesheet">
<style>
	.navbar {
	    display: flex;
	    align-items: center;
	    gap: 20px;
	    text-align: center;
	    justify-content: space-between;
	    background-color: #2c3e50; 
	    padding: 10px; 
	}
	body {
            font-family: 'Roboto Slab', serif;
            background-color: #f2f2f2;
        }
        h1 {
		  font-size: 36px; /* Adjust the font size to your preference */
		  font-weight: bold;
		  color: #333; 
		  text-align: center;
		  text-transform: uppercase; 
		  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2); 
		  letter-spacing: 2px; 
		  margin: 20px 0; 
		}
		
		h2{
		  font-size: 30px; /* Adjust the font size to your preference */
		  font-weight: bold;
		  color: #333; 
		  text-align: center;
		  text-transform: uppercase; 
		  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2); 
		  letter-spacing: 2px; 
		  margin: 20px 0; 
		
		
		}

        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
        }

        form {
            margin-top: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            font-weight: bold;
        }

        input[type="text"], input[type="number"]{
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        input[type="date"]{
        	width: 50%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }
        .form-group input[type="radio"] {
		    display: inline-block;
		    margin-right: 10px; 
		}
		table {
            border-collapse: collapse;
            width: 80%;
            margin: 20px auto;
        }
        th, td {
            border: 4px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #ffcc00;
        }
        
        button {
		  background-color: #4CAF50;
		  border: none;
		  color: white;
		  padding: 10px 20px; 
		  border-radius: 6px; 
		  font-size: 16px; 
		  cursor: pointer; 
		  transition: background-color 0.3s ease;
		  box-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2); 
		  text-transform: uppercase; 
		  letter-spacing: 1px; 
		  outline: none; 
		  &:hover {
		    background-color: #45A945; 
		  }
		}
       	button:hover {
            background-color: #45a049;
        }
        .navbar button{
        	background-color: #4CAF50;
            color: white;
            padding: 20px 40px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            &:hover {
		    background-color: #45A945; 
		  }
        }
        button[id="notifybutton"]{
        	background-color: #4CAF50;
            color: white;
            padding: 8px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .app-header {
    background-color: #2c3e50;
    color: white;
    padding: 20px 0;
    text-align: center;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    width: 100%;
}
</style>
</head>
<%@ page import="java.sql.*" %>
<body>
	<div class = "navbar">
		<header class="app-header">
	        <h2 style="color:white">Social Security Solution App</h2>
	    </header><br/>
		<form action="supervisor.jsp">
		    <input type="hidden" name="visitorform" value="true">
		    <input type="hidden" name="newVisitor" value="true">
		    <button type="submit">Visitor</button>
		</form>
		<form action="supervisor.jsp">
		    <input type="hidden" name="staffform" value="true">
		    <input type="hidden" name="newstaff" value="true">
		    <button type="submit">Staff</button>
		</form>
		<form action="supervisor.jsp">
		    <input type="hidden" name="maintenance" value="true">
		    <input type="hidden" name="mupload" value="true">
		    <button type="submit">Maintenance</button>
		</form>
		<form id ="logout" action="logout">
		    	<button type="submit" id="logoutbutton" style="margin-left: auto;">Logout</button>
		   </form>
	</div><br/><br/>
	<%
    	if (request.getParameter("visitorform") != null) {
	%>
	    <!-- HTML content for the Visitor section -->
	    <h1><u>Visitor Section</u></h1><br/>
	    <div style="display:flex;gap:20px">
	    	<form action="supervisor.jsp">
	    		<input type="hidden" name="visitorform" value="true">
	    		<input type="hidden" name="newVisitor" value="true">
		    	<button type="submit" id="newvisitor">New visitor entry</button>
		    </form>
		    <form action="supervisor.jsp">
		    	<input type="hidden" name="visitorform" value="true">
		    	<input type="hidden" name="rvEntry" value="true">
		    	<button type="submit" id="rventry">Regular visitor entry check</button>
		    </form>
		    <form action="supervisor.jsp">
		    	<input type="hidden" name="visitorform" value="true">
		    	<input type="hidden" name="nvEntry" value="true">
		    	<button type="submit" id="nvrequests">Normal visitor requests</button>
		    </form>
		    <form action="supervisor.jsp">
		    	<input type="hidden" name="visitorform" value="true">
		    	<input type="hidden" name="checkedrv" value="true">
		    	<button type="submit" id="nvrequests">Checked in regular visitors</button>
		    </form>
		    <form action="supervisor.jsp">
		    	<input type="hidden" name="visitorform" value="true">
		    	<input type="hidden" name="reqapprv" value="true">
		    	<button type="submit" id="nvrequests">Normal visitors approvals</button>
		    </form>
		    <form action="supervisor.jsp">
		    	<input type="hidden" name="visitorform" value="true">
		    	<input type="hidden" name="regvis" value="true">
		    	<button type="submit" id="nvrequests">Regular visitors</button>
		    </form>
		    <form action="supervisor.jsp">
		    	<input type="hidden" name="visitorform" value="true">
		    	<input type="hidden" name="rvcio" value="true">
		    	<button type="submit" id="nvrequests">RV check in out</button>
		    </form>
	    </div><br/><br/>
	    <%if (request.getParameter("newVisitor") != null){ %>
		    <div id="newVisitorContent" class ="container">
		    	<h2>Normal Visitor</h2>
		        <form id="nvForm" method="post" action="searchresident">
		            <input type="text" name="resname" placeholder="Resident Name" required/>
		            <input type="text" name="resphoneno" placeholder="Resident Phone No" required/>
		            <input type="text" name="visitorName" placeholder="Visitor Name" required/>
		            <input type="text" name="visitorpno" placeholder="Vistor Phone No" required/>
		            
		            <input type="submit" >
		        </form><br/><br/>
		        <button id="notifybutton">Notify details</button>
		        <div id="notifytable" >
		        	<% 
		        		
		        		if(session.getAttribute("searchresident")!=null ){
		        			out.println(session.getAttribute("searchresident"));
		        			session.setAttribute("searchresident",null);
		        		}
		        	%>
		        </div>
		        
		        <% 
		        		
		        		if(session.getAttribute("notifyresident")!=null ){
		        			out.println(session.getAttribute("notifyresident"));
		        			session.setAttribute("notifyresident",null);
		        		}
		        %>
		        
		        
		        <h2>Add Regular Visitor</h2>
		        <form id="rvForm" action="addrv" method="post">
		            <input type="text" name="visitorName" placeholder="Visitor Name" required/>
		            <input type="text" name="visitorpno" placeholder="Vistor Phone No" required/>
		            <input type="text" name="address" placeholder="Visitor Address" required/>
		            <input type="text" name="visittype" placeholder="Purpose of visit" required/>
		            <input type="submit">
		        </form><br/><br/>
		        <%
			        if(session.getAttribute("seccode")!=null ){
	        			out.println(session.getAttribute("seccode"));
	        			session.setAttribute("seccode",null);
	        		}
		        %>
		    </div>
	    <% } %>
	    <%if (request.getParameter("rvEntry") != null){ %>
		    <div id="rventryContent" >
		        <form action="rventrysearch" method="post">
		        	Enter the security code:<input type="number" style="width:20%"name="seccode" required/>
		        	<input type="submit" value="Search">
		        </form>
		    </div><br/><br/>
		    <%
			        if(session.getAttribute("searchres")!=null ){
	        			out.println(session.getAttribute("searchres"));
	        		}
		        %>
		        <%
			        if(session.getAttribute("CHECK-MSG")!=null ){
	        			out.println(session.getAttribute("CHECK-MSG"));
	        			session.setAttribute("searchres",null);
	        			session.setAttribute("CHECK-MSG",null);
	        		}
		        %>
	    <% } %>
	    <%if (request.getParameter("nvEntry") != null){ %>
		    <div id="nvrequestsContent" >
		    	<table>
						<tr><th>Visitor Name</th>
							<th>Visitor Phone no</th>
							<th>Resident Name</th>
							<th>Resident Phone No</th>
							<th>Approval Status</th>
						</tr>
		        <%
			        String url = "jdbc:mysql://localhost:3306/sss_app?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
					String usr = "root";
					String password = "root";
					try {
						Class.forName("com.mysql.cj.jdbc.Driver");
					} catch (ClassNotFoundException e) {
						e.printStackTrace();
					}
					String query = "SELECT * FROM visit_requests";
					try(Connection con = DriverManager.getConnection(url,usr,password);){
						PreparedStatement p = con.prepareStatement(query);
						ResultSet rs = p.executeQuery();
						while(rs.next()){
				%>
							<tr><td><%= rs.getString(3) %></td>
							<td><%= rs.getString(4) %></td>
							<td><%= rs.getString(1) %></td>
							<td><%= rs.getString(2) %></td>
							<td><%= rs.getString(5) %></td></tr>
				<%
						}
					}catch(SQLException e){
						System.out.println(e);
					}
		        %>
		        </table>
		    </div>
		    
	    <% } %>
	    <%if (request.getParameter("checkedrv") != null){ %>
	    	<table>
						<tr><th>Visitor Name</th>
							<th>Visitor Phone no</th>
							<th>Checked in time</th>
						</tr>
		        <%
			        String url = "jdbc:mysql://localhost:3306/sss_app?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
					String usr = "root";
					String password = "root";
					try {
						Class.forName("com.mysql.cj.jdbc.Driver");
					} catch (ClassNotFoundException e) {
						e.printStackTrace();
					}
					String query = "SELECT distinct seccode,checkin_time FROM rvcheck_req where checkout_time is null";
					try(Connection con = DriverManager.getConnection(url,usr,password);){
						PreparedStatement p = con.prepareStatement(query);
						ResultSet rs = p.executeQuery();
						String visitorq = "select * from regular_visitor where sec_code = ?";
						while(rs.next()){
							PreparedStatement p1 = con.prepareStatement(visitorq);
							p1.setInt(1,rs.getInt(1));
							ResultSet rs1 = p1.executeQuery();
							rs1.next();
				%>
							<tr><td><%= rs1.getString(1) %></td>
							<td><%= rs1.getString(5) %></td>
							<td><%= rs.getTime(2) %></td>
							</tr>
				<%
						}
					}catch(SQLException e){
						System.out.println(e);
					}
		        %>
		        </table>
	    	
	    <%} %>
	    <% if(request.getParameter("reqapprv") != null){ %>
	    	<table>
						<tr><th>Visitor Name</th>
							<th>Visitor Phone no</th>
							<th>Resident Name</th>
							<th>Resident Phone No</th>
							<th>Approval Status</th>
							<th>Approval Time</th>
						</tr>
		        <%
			        String url = "jdbc:mysql://localhost:3306/sss_app?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
					String usr = "root";
					String password = "root";
					try {
						Class.forName("com.mysql.cj.jdbc.Driver");
					} catch (ClassNotFoundException e) {
						e.printStackTrace();
					}
					String query = "SELECT * FROM approved_requests order by resident_approvaltime desc";
					try(Connection con = DriverManager.getConnection(url,usr,password);){
						PreparedStatement p = con.prepareStatement(query);
						ResultSet rs = p.executeQuery();
						while(rs.next()){
				%>
							<tr><td><%= rs.getString(3) %></td>
							<td><%= rs.getString(4) %></td>
							<td><%= rs.getString(1) %></td>
							<td><%= rs.getString(2) %></td>
							<td><%= rs.getString(6) %></td>
							<td><%= rs.getTime(7) %></td>
							</tr>
				<%
						}
					}catch(SQLException e){
						System.out.println(e);
					}
		        %>
		        </table>
	    	
	    <%} %>
	    <%if(request.getParameter("regvis") != null){%>
	    	<table>
						<tr><th>Visitor Name</th>
							<th>Visitor Address</th>
							<th>Visitor Phone No</th>
							<th>Visitor type</th>
							<th>Security code</th>
						</tr>
		        <%
			        String url = "jdbc:mysql://localhost:3306/sss_app?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
					String usr = "root";
					String password = "root";
					try {
						Class.forName("com.mysql.cj.jdbc.Driver");
					} catch (ClassNotFoundException e) {
						e.printStackTrace();
					}
					String query = "SELECT * FROM regular_visitor";
					try(Connection con = DriverManager.getConnection(url,usr,password);){
						PreparedStatement p = con.prepareStatement(query);
						ResultSet rs = p.executeQuery();
						while(rs.next()){
				%>
							<tr><td><%= rs.getString(1) %></td>
							<td><%= rs.getString(2) %></td>
							<td><%= rs.getString(5) %></td>
							<td><%= rs.getString(3) %></td>
							<td><%= rs.getInt(4) %></td>
							</tr>
				<%
						}
					}catch(SQLException e){
						System.out.println(e);
					}
		        %>
		        </table>
	    <%} %>
	    <%if(request.getParameter("rvcio") != null){%>
	    	<table>
						<tr><th>Security code</th>
							<th>Check in time</th>
							<th>Check out time</th>
						</tr>
		        <%
			        String url = "jdbc:mysql://localhost:3306/sss_app?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
					String usr = "root";
					String password = "root";
					try {
						Class.forName("com.mysql.cj.jdbc.Driver");
					} catch (ClassNotFoundException e) {
						e.printStackTrace();
					}
					String query = "SELECT * FROM rvcheck_req";
					try(Connection con = DriverManager.getConnection(url,usr,password);){
						PreparedStatement p = con.prepareStatement(query);
						ResultSet rs = p.executeQuery();
						while(rs.next()){
				%>
							<tr><td><%= rs.getInt(1) %></td>
							<td><%= rs.getTime(2) %></td>
							<td><%= rs.getTime(3) %></td>
							</tr>
				<%
						}
					}catch(SQLException e){
						System.out.println(e);
					}
		        %>
		        </table>
	    <%} %>
	    
	    
	<% } else if (request.getParameter("staffform") != null) {%>
	   	<h1><u>Staff Section</u></h1><br/>
	    <div style="display:flex;gap:20px">
	    	<form action="supervisor.jsp">
	    		<input type="hidden" name="staffform" value="true">
	    		<input type="hidden" name="newstaff" value="true">
		    	<button type="submit" id="newvisitor">Upload staff</button>
		    </form>
		    <form action="supervisor.jsp">
		    	<input type="hidden" name="staffform" value="true">
		    	<input type="hidden" name="viewstaff" value="true">
		    	<button type="submit" id="rventry">View staff</button>
		    </form>
		    <form action="supervisor.jsp">
		    	<input type="hidden" name="staffform" value="true">
		    	<input type="hidden" name="updatestaff" value="true">
		    	<button type="submit" id="nvrequests">Update staff</button>
		    </form>
	    </div><br/><br/>
	    <%if(request.getParameter("newstaff") != null){%>
	    	<div class ="container">
	    		<h2>Upload Staff</h2>
	    		<form method="post" action="uploadstaff" >
		            <input type="text" name="staffname" placeholder="Staff Name" required/>
		            <input type="number" name="staffsal" placeholder="Staff Salary" min="0" required/>
		            <input type="text" name="worktype" placeholder="Work Type" required/>
		            Staff join date: <input type="date" name="joindate" id="joindate" placeholder="Staff join date" required/><br/>
		            <input type="submit" onclick="return validateJoinDate()">
		        </form><br/><br/>
		        <%
			        if(session.getAttribute("uploadmsg")!=null ){
	        			out.println(session.getAttribute("uploadmsg"));
	        			session.setAttribute("uploadmsg",null);
	        		}
		        %>
	    	</div>
	    <%} %>
	    <% if(request.getParameter("viewstaff") != null){%>
	    	<table>
						<tr>
							<th>Staff id</th>
							<th>Staff Name</th>
							<th>Staff salary</th>
							<th>Work Type</th>
							<th>Join date</th>
							<th>Staff delete </th>
						</tr>
	    	<% 
		    	String url = "jdbc:mysql://localhost:3306/sss_app?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
		        String user = "root";
		        String password = "root";
		        
		        try {
					Class.forName("com.mysql.cj.jdbc.Driver");
				} catch (ClassNotFoundException e) {
					e.printStackTrace();
				}
				
		        String query = "select * from staff_details";
		        try(Connection con = DriverManager.getConnection(url, user, password);){
		        	PreparedStatement p =con.prepareStatement(query);
		        	ResultSet rs = p.executeQuery();
		        	while(rs.next()){	
		      %>
		      		<tr>
		      				<td><%= rs.getInt(5) %></td>
		      				<td><%= rs.getString(1) %></td>
							<td><%= rs.getString(2) %></td>
							<td><%= rs.getString(3) %></td>
							<td><%= rs.getDate(4)%></td>
							<td><form action='staffdelete' method='post'><input type='hidden' name="staffid" value="<%= rs.getInt(5)%>"><input type="submit" value="delete"></form></td>
							</tr>
		      <% 
		        	}
		        }catch(SQLException e){
		        	System.out.println(e);
		        }
	    	  %>
	    	</table>
	    	
	    <%} %>
	    <%if(request.getParameter("updatestaff") != null){%>
	    	<div class="container">
	    		<h2>Update staff details</h2>
	    		<form action="updatestaff" method="post">
	    			<input type="number" name="staffid" placeholder="Enter staff id" min = "1" required/>
					<input type="number" name="salupd" placeholder="Enter salary" min="0" required/>
					<input type="submit" value="Upload"/>
	    		</form>
	    		<%
			        if(session.getAttribute("updatemsg")!=null ){
	        			out.println(session.getAttribute("updatemsg"));
	        			session.setAttribute("updatemsg",null);
	        		}
		        %>
	    	</div>
	    <%} %>
	<%
	    }else if(request.getParameter("maintenance") != null){
	%>
		<h1><u> Maintenance section </u></h1>
		<div style="display:flex;gap:20px">
	    	<form action="supervisor.jsp">
	    		<input type="hidden" name="maintenance" value="true">
	    		<input type="hidden" name="mupload" value="true">
		    	<button type="submit" id="newvisitor">Upload </button>
		    </form>
		    <form action="supervisor.jsp">
		    	<input type="hidden" name="maintenance" value="true">
		    	<input type="hidden" name="mdue" value="true">
		    	<button type="submit" id="rventry">View dues</button>
		    </form>
		    <form action="supervisor.jsp">
		    	<input type="hidden" name="maintenance" value="true">
		    	<input type="hidden" name="mupdate" value="true">
		    	<button type="submit" id="nvrequests">Payment of dues</button>
		    </form>
	    </div><br/><br/>
	    <%if(request.getParameter("mupload") != null){%>
	    	<div class ="container">
	    		<h2>Upload maintenance details</h2>
	    		<form method="post" action="mupload">
		            <input type="number" name="flatid" placeholder="Flat id:" min="1" required/>
		            <input type="number" name="amount" placeholder="Amount" min="0" required/><br/>
		            <input type="submit" >
		        </form><br/><br/>
		        <%
			        if(session.getAttribute("muploadmsg")!=null ){
	        			out.println(session.getAttribute("muploadmsg"));
	        			session.setAttribute("muploadmsg",null);
	        		}
		        %>
	    	</div>
	    <%} %>
	    <%if(request.getParameter("mdue") != null){%>
	    	<table>
						<tr>
							<th>Flat id</th>
							<th>Due amount</th>
						</tr>
	    	<% 
		    	String url = "jdbc:mysql://localhost:3306/sss_app?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
		        String user = "root";
		        String password = "root";
		        
		        try {
					Class.forName("com.mysql.cj.jdbc.Driver");
				} catch (ClassNotFoundException e) {
					e.printStackTrace();
				}
				
		        String query = "select * from maintenance_details where due = 'Yes'";
		        try(Connection con = DriverManager.getConnection(url, user, password);){
		        	PreparedStatement p =con.prepareStatement(query);
		        	ResultSet rs = p.executeQuery();
		        	while(rs.next()){	
		      %>
		      		<tr>
		      				<td><%= rs.getString(1) %></td>
							<td><%= rs.getString(2) %></td>
					</tr>
		      <% 
		        	}
		        }catch(SQLException e){
		        	System.out.println(e);
		        }
	    	  %>
	    	</table>
	    	
	    <%} %>
	    <%if(request.getParameter("mupdate") != null){%>
	    	<div class ="container">
	    		<h2>Maintenance payment</h2>
	    		<form method="post" action="mupdate">
		            <input type="number" name="flatid" placeholder="Flat id:" min="1" required/>
		            <input type="number" name="amount" placeholder="Amount" min="0" required/><br/>
		            <div class="form-group">
			            Mode of payment:  
			            <input type="radio" id="creditCard" name="paymentMethod" value="creditCard" required/> Credit Card
					    <input type="radio" id="debitCard" name="paymentMethod" value="debitCard" required/> Debit Card
					    <input type="radio" id="paypal" name="paymentMethod" value="UPI" required/> UPI
					    <input type="radio" id="cash" name="paymentMethod" value="cash" required/> Cash
				    </div>
		            <input type="submit" value="Pay" >
		            
		        </form><br/><br/>
		        <%
			        if(session.getAttribute("mupdatemsg")!=null ){
	        			out.println(session.getAttribute("mupdatemsg"));
	        			session.setAttribute("mupdatemsg",null);
	        		}
		        %>
	    	</div>
	    	
		<%} %>
	<%} %>
	
	<script>
		/* var notifybutton = document.getElementById("notifybutton");
		var notifytable = document.getElementById("notifytable");
		notifybutton.addEventListener("click", function() {
		    toggleVisibility1(notifytable);
		});

		function toggleVisibility1(content) {
		    if (content.style.display === "none" || content.style.display === "") {
		        content.style.display = "block";
		    }
		} */
		function validateJoinDate() {
		    var joinDateInput = document.getElementById("joindate");
		    var selectedDate = new Date(joinDateInput.value);
		    var currentDate = new Date();

		    if (selectedDate > currentDate) {
		    	console.log("yes");
		        alert("Join date cannot be a future date");
		        return false; 
		    }
		    return true;
		}
	</script>
</body>
</html>