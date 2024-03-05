<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Resident login</title>
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
		  color: #333; /* Your chosen font color */
		  text-align: center; /* Center-align the text */
		  text-transform: uppercase; /* Transform the text to uppercase (optional) */
		  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2); /* Add a subtle text shadow (optional) */
		  letter-spacing: 2px; /* Adjust the letter spacing (optional) */
		  margin: 20px 0; /* Add margin to control spacing around the heading (optional) */
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

        input[type="text"], input[type="number"] {
            width: 100%;
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
            border: 1px solid #ddd;
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
        form[id="logout"]{
        	float:right;
        }
        .app-header {
    background-color: #2c3e50;
    color: white;
    padding: 20px 0;
    text-align: center;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);}
        
</style>
</head>
<%@ page import="java.sql.*" %>
<body>
	<div class="navbar">
		<header class="app-header">
		        <h2 style="color:white">Social Security Solution App</h2>
		    </header><br/>
	    	<form action="resident.jsp">
	    		<input type="hidden" name="homepage" value="true">
		    	<button type="submit" id="home">Home</button>
		    </form>
		    <form action="resident.jsp">
		    	<input type="hidden" name="vrequest" value="true">
		    	<button type="submit" id="ventry">Visitor requests</button>
		    </form>
		    <form action="resident.jsp">
		    	<input type="hidden" name="mpay" value="true">
		    	<button type="submit" id="maintainpay">Maintenance pay</button>
		    </form>
		    
		    <form id ="logout" action="logout">
		    	<button type="submit" id="logoutbutton" style="margin-left: auto;">Logout</button>
		    </form>
	    </div><br/><br/>
	    
	  <%if (request.getParameter("homepage")!= null){ %>
	  	<div class="container">
	  	
	  		<h2> Your Details</h2>
	  		<% 
		    	String url = "jdbc:mysql://localhost:3306/sss_app?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
		        String user = "root";
		        String password = "root";
		        
		        try {
					Class.forName("com.mysql.cj.jdbc.Driver");
				} catch (ClassNotFoundException e) {
					e.printStackTrace();
				}
				
		        String query = "select * from resident where res_id = ?";
		        try(Connection con = DriverManager.getConnection(url, user, password);){
		        	PreparedStatement p = con.prepareStatement(query);
		        	p.setInt(1,(int)session.getAttribute("residentid"));
		        	ResultSet rs = p.executeQuery();
		        	
		        	rs.next();
		     	%>
		        	Name: <%= rs.getString(2) %><br/>
		        	Phone number: <%= rs.getString(3) %> <br/>
		        	Address: <%= rs.getString(4) %><br/>
		        	Flat id: <%= rs.getInt(5) %>
		        <%
		        }catch(SQLException e){
		        	System.out.println(e);
		        }
		       %>
	  	</div>
	  <%}else if(request.getParameter("vrequest")!= null){ %>
	  
	  	<table>
	  	<tr><th>Visitor Name</th>
	  		<th>Visitor Phone Number </th>
	  		<th></th>
	  		<th></th>
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
			String query = "select vname,vphoneno from visit_requests where resident_id = ?";

			try(Connection con = DriverManager.getConnection(url,usr,password);){
				PreparedStatement p = con.prepareStatement(query);
				p.setInt(1,(int)session.getAttribute("residentid"));
				ResultSet rs = p.executeQuery();
				while(rs.next()){
		%>
			<tr>
				<td><%= rs.getString(1) %></td>
				<td><%= rs.getString(2) %></td>
				<td><form action="reqapproval" method="post"><input type='hidden' name="vphoneno" value=<%= rs.getString(2) %>><input type='submit' name="approve" value='Approve'></form></td>
				<td><form action="reqapproval" method="post"><input type='hidden' name="vphoneno" value=<%= rs.getString(2) %>><input type='submit' name="deny" value='Deny'></form></td>
			</tr>
			
		<% }	
			}catch(SQLException e){
				System.out.println(e);
			}
  		%>
	  		</table>
	  <%}else if(request.getParameter("mpay")!= null){%>
	    	<table>
					<tr>
						<th>Due amount</th>
						<th>Payment</th>
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
				
		        String query = "select r.flat_id,amount,due from (resident as r INNER JOIN maintenance_details as m on m.flat_id = r.flat_id) where due = 'Yes' and res_id = ?";
		        try(Connection con = DriverManager.getConnection(url, user, password);){
		        	PreparedStatement p =con.prepareStatement(query);
		        	p.setInt(1,(int)session.getAttribute("residentid"));
		        	ResultSet rs = p.executeQuery();
		        	while(rs.next()){	
		      %>
		      		<tr>
		      				<td><%= rs.getString(2) %></td>
							<td><form action="apppay" method = "post"><input type="hidden" name="flatid" value="<%= rs.getString(1) %>"><input type="number" style="width:50%"name="amount" min="0" required/> <input type="submit" value="Pay"></form></td>
					</tr>
		      <% 
		        	}
		        }catch(SQLException e){
		        	System.out.println(e);
		        }
	    	  %>
	    	</table>
	    	<%
			        if(session.getAttribute("apppaymsg")!=null ){
	        			out.println(session.getAttribute("apppaymsg"));
	        			session.setAttribute("apppaymsg",null);
	        		}
		        %>
	  <%} %>
	  
	  
</body>
</html>