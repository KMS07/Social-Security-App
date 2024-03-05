<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Upload Building and Flat Details</title>
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

        input[type="text"], input[type="number"],input[type="email"],input[type="password"]{
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
		#error-message {
		    color: red;
		    text-align: center;
		    font-size: 15px;
		}
</style>
</head>
<%@ page import="java.sql.*" %>
<body>
	<div class="navbar"> 
	<header class="app-header">
	        <h2 style="color:white">Social Security Solution App</h2>
	    </header><br/>
	    <form action="administrator.jsp">
		    <input type="hidden" name="uploadform" value="true">
			<button id="upload">Upload</button>
		</form>
		<form action="administrator.jsp">
		    <input type="hidden" name="viewform" value="true">
			<button id="delete">View</button>
		</form>
		<form action="administrator.jsp">
		    <input type="hidden" name="addres" value="true">
			<button id="addresident">Add resident</button>
		</form>
		<form action="administrator.jsp">
		    <input type="hidden" name="viewres" value="true">
			<button id="viewresident">View resident</button>
		</form>
		<form id ="logout" action="logout">
		    	<button type="submit" id="logoutbutton" style="margin-left: auto;">Logout</button>
		   </form>	
	</div>
	<%if(request.getParameter("uploadform")!= null){ %>
    <div class="container" id="uploaddetails">
        <h1><u>Upload Building and Flat Details</u></h1>
        <form action="uploadbuildingflat" method="post">
	        
	        	<h2>Building details:</h2>
	            <div class="form-group">
	                <label for="buildingName">Building Id:</label>
	                <input type="number" id="bid" name="bid" min="1" required>
	            </div>
	
	            <div class="form-group">
	                <label for="nfloor">Number of floors:</label>
	                <input type="number" id="nfloor" name="nfloor" min="1" required>
	            </div>
	            
	            <div class="form-group">
	                <label for="tsqft">Total sq ft:</label>
	                <input type="text" id="tsqft" name="tsqft" min="0" required>
	            </div>
	            <div class="form-group">
	                <label for="tsqft">Number of flats:</label>
	                <input type="number" id="nof" name="nof" min = "1" required>
	            </div>
	            <input type="submit" value="Upload Details">
         </form>
            
         <form action="uploadbuildingflat" method="post">
	          <h2>Flat details:</h2>
	          <div class="form-group">
			  		<label for="buildid">Building id:</label>
			  		<input type="number" id="fbid" name="fbid" min = "1" required>
			  </div>
	
	          <div class="form-group">
	              <label for="flatno">Flat Number:</label>
	              <input type="number" id="flatno" name="flatno" min = "1" required>
	          </div>
	
	          <div class="form-group">
	              <label for="flatSize">Number of bedrooms:</label>
	              <input type="number" id="nb" name="nb" min = "1" max = "4" required>
	          </div>
	          
	          <div class="form-group">
	              Availability: <input type="radio" id="yes" name="available" value="yes"> Yes
					<input type="radio" id="no" name="available" value="no">No
			  </div>
			  
          	  <input type="submit" value="Upload Details">
        </form>
        <%
        	if(session.getAttribute("uploadmsg")!=null){
        		out.println("<p>"+session.getAttribute("uploadmsg")+"</p>");
 				session.setAttribute("uploadmsg", null);
        	}
        %>
    </div>
    <%} %>
    <%if(request.getParameter("viewform")!= null){ %>
    <div class="container">
    	<h1>Building details</h1>
    	<table>
	        <tr>
	            <th>Building ID</th>
	            <th>Number of floors</th>
	            <th>Total sq ft</th>
	            <th>Number of flats</th>
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
			String query = "select * from building_details";
			try(Connection con = DriverManager.getConnection(url,usr,password);){	
				PreparedStatement p = con.prepareStatement(query);
				ResultSet rs = p.executeQuery();
				
				while(rs.next()){
					out.println("<tr>");
					out.println("<td>"+rs.getInt(1)+"</td>");
					out.println("<td>"+rs.getInt(2)+"</td>");
					out.println("<td>"+rs.getInt(3)+"</td>");
					out.println("<td>"+rs.getString(4)+"</td>");
					out.println("</tr>");
				}
				
			}catch(SQLException e){
				System.out.println(e);
			}
	    %>
	    </table>
	    <h1>Flat details</h1>
    	<table>
	        <tr>
	            <th>Flat No</th>
	            <th>Number of bedrooms</th>
	            <th>Availability</th>
	            <th>Building_id</th>
	        </tr>
	    <%
			String query1 = "select * from flat_details";
			try(Connection con = DriverManager.getConnection(url,usr,password);){	
				PreparedStatement p = con.prepareStatement(query1);
				ResultSet rs = p.executeQuery();
				
				while(rs.next()){
					out.println("<tr>");
					out.println("<td>"+rs.getInt(1)+"</td>");
					out.println("<td>"+rs.getInt(2)+"</td>");
					out.println("<td>"+rs.getString(3)+"</td>");
					out.println("<td>"+rs.getString(4)+"</td>");
					out.println("</tr>");
				}
				
			}catch(SQLException e){
				System.out.println(e);
			}
	    %>
	    </table>
	    
		<%
			// Check if the "deletemsg" attribute is present in the session
			var deletemsg = (String) session.getAttribute("deletemsg");
			
			if (deletemsg != null) {
				out.println(deletemsg);
			    session.setAttribute("deletemsg",null);
			}
		%>
    </div>
		
	<%} %>
	<%if(request.getParameter("addres")!= null){ %>
		<div class="container">
	        <h2>Resident registration</h2>
	        <form action="newuser" onsubmit="return formValidate()" method="get" name="Form">
	            <label for="usr">Username:</label>
	            <input type="text" id="usr" name="usr" required/>
	
	            <label for="passwd">Password:</label>
	            <input type="password" id="passwd" name="passwd" required/>
	            
	            <label for="name">Name:</label>
	            <input type="text" id="name" name="name" required/>
	            
	            <label for="name">Flat Id:</label>
	            <input type="number" id="flatid" name="flatid" required/>
	            
	            <label for="email">Email address:</label>
	            <input type="email" id="email" name="email" required/>
	            
	            <label for="phoneno">Phone number:</label>
	            <input type="text" id="phoneno" name="phoneno" maxlength = "10" required/>
	            
	            <label for="address">Address:</label>
	            <input type="text" id="address" name="address" required/>
	            
	            <input type="submit" value="Submit"/>
	        </form>
	        <p id="Error" class="error-message"></p>				
	        <p id="servererrormsg" class="error-message"></p>
	        
	        <%if(session.getAttribute("newuser")!=null){
	        		out.println(session.getAttribute("newuser"));
	        		session.setAttribute("newuser",null);
	        	}
	        %>
	        
    	</div>
	<%} %>
	<%if(request.getParameter("viewres")!= null){ %>
	
		<h1>Resident details</h1>
    	<table>
	        <tr>
	            <th>Resident ID</th>
	            <th>Name</th>
	            <th>Phone No</th>
	            <th>Address</th>
	            <th>Flat ID</th>
	            <th>App username</th>
	            <th>Delete<th>
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
	    	
			String query1 = "select * from resident";
			try(Connection con = DriverManager.getConnection(url,usr,password);){	
				PreparedStatement p = con.prepareStatement(query1);
				ResultSet rs = p.executeQuery();
				
				while(rs.next()){
					out.println("<tr>");
					out.println("<td>"+rs.getInt(1)+"</td>");
					out.println("<td>"+rs.getString(2)+"</td>");
					out.println("<td>"+rs.getString(3)+"</td>");
					out.println("<td>"+rs.getString(4)+"</td>");
					out.println("<td>"+rs.getInt(5)+"</td>");
					out.println("<td>"+rs.getString(6)+"</td>");
					out.println("<td><form method='post' action='deleteresident'><input type='hidden' name='resid' value='"+rs.getInt(1)+"'><input type='submit' value='Delete'></form></td>");
					out.println("</tr>");
				}
				
			}catch(SQLException e){
				System.out.println(e);
			}
	    %>
	    </table>
		
	<%} %>
    <script>
		document.getElementById("signout").addEventListener("click", function() {
		    window.location.href = "logout.jsp";
		});
		
		function formValidate(){
			let usr = document.forms["Form"]["usr"].value;
			let passwd = document.forms["Form"]["passwd"].value;
			let phoneno = document.forms["Form"]["phoneno"].value;
			
			console.log(usr);
			console.log(passwd);
			var usernameRegex = /^[a-zA-Z][a-zA-Z0-9_-]{2,}$/;
	    	var passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
	    	var phonenoRegex = /^\d{10}$/;
	    	
	    	if (!usernameRegex.test(usr)) {
		        document.getElementById("Error").textContent = "Invalid username format it should be atleast of length 3 and start with alphabet and cannot contain special characters apart from  _ -";
		        return false;
		    }
		    else if (!passwordRegex.test(passwd)) {
		        document.getElementById("Error").textContent = "Invalid password format it should be of length atleast 8 characters with atleast 1 captial,1 lower,1 num,1 special character";
		        return false;
		    }else if(!phonenoRegex.test(phoneno)){
		        document.getElementById("Error").textContent = "Mobile number should be number of 10 digits";
		        return false;
		    }
			return true;
		}	
		document.addEventListener("DOMContentLoaded", function() {
	        var urlParams = new URLSearchParams(window.location.search);
	        if (urlParams.has('error1')) {
	            document.getElementById('servererrormsg').textContent = "Username already exists";
	        }else if(urlParams.has('error2')){
				document.getElementById('servererrormsg').textContent = "This flat is already occupied by a resident";
			}else if(urlParams.has('error3')){
				document.getElementById('servererrormsg').textContent = "This user exists and occupied this flat";
			}
    	});	
    </script>
</body>
</html>
