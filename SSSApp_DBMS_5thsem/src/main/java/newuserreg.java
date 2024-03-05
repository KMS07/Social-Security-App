
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.util.logging.Level;
import java.util.logging.Logger;


import java.util.Properties;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Scanner;
import java.time.LocalDate;
import java.io.*;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@jakarta.servlet.annotation.WebServlet("/newuser")
public class newuserreg extends HttpServlet {
	private static final long serialVersionUID = 1L;
    static int numofusers = 2;
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Database details;
    	String url = "jdbc:mysql://localhost:3306/sss_app?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
		String usr = "root";
		String password = "root";
		
		HttpSession session = request.getSession();
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		try(Connection con = DriverManager.getConnection(url,usr,password);){
			String template = "INSERT INTO users VALUES(?, ?, ?,?)";
			String template2 = "INSERT INTO resident(Name,PhoneNo,Address,flat_id,app_username) VALUES(?,?,?,?,?)";
			String template3 = "select * from resident where flat_id = ?";
			String updateflat = "update flat_details set Availability = 'no' where flat_no = ?";
			String checkavailability = "select * from flat_details where flat_no = ?";
				try (PreparedStatement inserter1 = con.prepareStatement(template);PreparedStatement inserter2 = con.prepareStatement(template2);
						PreparedStatement select = con.prepareStatement(template3);) {
					
					select.setInt(1, Integer.parseInt(request.getParameter("flatid")));
					ResultSet rs = select.executeQuery();
					
					PreparedStatement check = con.prepareStatement(checkavailability);
					check.setInt(1, Integer.parseInt(request.getParameter("flatid")));
					ResultSet rs1 = check.executeQuery();
					
					
					if(rs1.next() && rs1.getString(3).equals("yes")) {
						if(!rs.next()) {
							numofusers++;
							inserter1.setInt(1, numofusers);
				            inserter1.setString(2, request.getParameter("usr"));
				            inserter1.setString(3,request.getParameter("passwd"));
				            inserter1.setString(4,"Resident");
			                inserter1.executeUpdate();
			                
				            inserter2.setString(1, request.getParameter("name"));
				            inserter2.setString(2,request.getParameter("phoneno"));
				            inserter2.setString(3,request.getParameter("address"));
				            inserter2.setString(4,request.getParameter("flatid"));
				            inserter2.setString(5, request.getParameter("usr"));
			                inserter2.executeUpdate();
			                
			                //Update flat availability
			                PreparedStatement update = con.prepareStatement(updateflat);
							update.setInt(1, Integer.parseInt(request.getParameter("flatid")));
							update.executeUpdate();
							
							
			                session.setAttribute("newuser","Successfully registered");
			                response.sendRedirect("administrator.jsp?addres=true");
						}else {
							session.setAttribute("newuser","This flat is already occupied!!");
			                response.sendRedirect("administrator.jsp?addres=true");
						}
					}else{
						session.setAttribute("newuser","This flat is not available yet");
						response.sendRedirect("administrator.jsp?addres=true");
					}
	                
	            }catch (SQLException e) {
	            	handleSQLException(e, response,request);
	            }
		}catch(SQLException ef) {
			ef.printStackTrace();
		}
	}
	private void handleSQLException(SQLException e, HttpServletResponse response,HttpServletRequest request) throws IOException {
		String sqlState = e.getSQLState();
		if (sqlState != null && sqlState.startsWith("23")) {
	        if (e.getMessage().toLowerCase().contains("foreign key") && !(e.getMessage().toLowerCase().contains("primary key"))) {
	            // only foreign key constraint violation
	            response.sendRedirect("administrator.jsp?addres=true&error2=true");
	        } else if(e.getMessage().toLowerCase().contains("primary key") && !(e.getMessage().toLowerCase().contains("foreign key"))){
	            // only pk constraint violation
	            response.sendRedirect("administrator.jsp?addres=true&error1=true");
	        }else {
	        	response.sendRedirect("administrator.jsp?addres=true&error3=true");
	        }
	    }
        //for logging to the terminal
        e.printStackTrace();
    }

}
