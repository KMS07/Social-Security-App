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

@jakarta.servlet.annotation.WebServlet("/deleteresident")
public class deleteresident extends HttpServlet{
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Database details;
    	String url = "jdbc:mysql://localhost:3306/sss_app?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
		String usr = "root";
		String password = "root";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		int res_id = Integer.parseInt(request.getParameter("resid"));
		String deleteres_query = "delete from resident where res_id = ?";
		String deleteusr_query = "delete from users where username = ?";
		String update_available = "update flat_details set Availability = 'yes' where flat_no = ?";
		String extract_usrname = "select app_username,flat_id from resident where res_id = ?";
		try(Connection con = DriverManager.getConnection(url,usr,password);){
			PreparedStatement p = con.prepareStatement(extract_usrname);
			p.setInt(1, res_id);
			ResultSet rs = p.executeQuery();
			
			rs.next();
			
			String username = rs.getString(1);
			int flatid = rs.getInt(2);
			
			PreparedStatement p1 = con.prepareStatement(deleteres_query);
			p1.setInt(1,res_id);
			p1.executeUpdate();
			
			PreparedStatement p2 = con.prepareStatement(deleteusr_query);
			p2.setString(1, username);
			p2.executeUpdate();
			
			PreparedStatement p3 = con.prepareStatement(update_available);
			p3.setInt(1,flatid);
			p3.executeUpdate();
			
			response.sendRedirect("administrator.jsp?viewres=true");
			
		}catch(SQLException e) {
			System.out.println(e);
		}
	}

}
