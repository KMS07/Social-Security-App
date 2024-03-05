import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
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
import java.util.Random;

@jakarta.servlet.annotation.WebServlet("/addrv")
public class addrv extends HttpServlet{
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
		int n = 4; 
        long min = (long) Math.pow(10, n - 1);
        long max = (long) Math.pow(10, n) - 1;  

        // Generating a random value 
        Random random = new Random();
        long randomValue = min + (Math.abs(random.nextLong())) % (max - min + 1);
        
        // Visitor details
        String visitorname = request.getParameter("visitorName");
        String visitorphoneno = request.getParameter("visitorpno");
        String address = request.getParameter("address");
        String type = request.getParameter("visittype");
        String query = "insert into regular_visitor values(?,?,?,?,?)";
		try(Connection con = DriverManager.getConnection(url,usr,password);){
			try(PreparedStatement p = con.prepareStatement(query);){
				p.setString(1,visitorname);
				p.setString(2, address);
				p.setString(3, type);
				p.setInt(4, (int)randomValue);
				p.setString(5,visitorphoneno);
				p.executeUpdate();
				session.setAttribute("seccode","Your security code is"+(int)randomValue);
				response.sendRedirect("supervisor.jsp?visitorform=true&newVisitor=true");
			}catch(SQLException e) {
				System.out.println(e);
				session.setAttribute("seccode","An error occured. Please enter the details again");
				response.sendRedirect("supervisor.jsp?visitorform=true&newVisitor=true");
			}
		}catch(SQLException e) {
			System.out.println(e);
			response.sendRedirect("supervisor.jsp?visitorform=true&newVisitor=true");
		}
	}
}
