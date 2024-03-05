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

@jakarta.servlet.annotation.WebServlet("/notifyrequest")
public class notifyresident extends HttpServlet{
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Database details;
    	String url = "jdbc:mysql://localhost:3306/sss_app?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
		String usr = "root";
		String password = "root";
		
		HttpSession session = request.getSession();
		
		String vname = (String)request.getParameter("vname");
		String vphoneno = (String)request.getParameter("vpno");
		int resident_id = 	Integer.parseInt(request.getParameter("resid"));
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		String query1 = "SELECT * FROM visit_requests WHERE vphoneno = ?";
		String query2 = "INSERT INTO visit_requests values(?,?,?,?,?,?)";
		String query3 = "SELECT * FROM resident where res_id = ?";
		try(Connection con = DriverManager.getConnection(url,usr,password);){
			PreparedStatement p1 = con.prepareStatement(query1);
			p1.setString(1, vphoneno);
			ResultSet rs = p1.executeQuery();
			PreparedStatement p2 = con.prepareStatement(query2);
			PreparedStatement p3 = con.prepareStatement(query3);
			if(!rs.next()) {
				p3.setInt(1, resident_id);
				ResultSet rs1 = p3.executeQuery();
				rs1.next();
				
				//Entering the visitor request to the table
				p2.setString(1, rs1.getString(2));
				p2.setString(2,rs1.getString(3));
				p2.setString(3,vname);
				p2.setString(4, vphoneno);
				p2.setString(5, "Not yet");
				p2.setInt(6, resident_id);
				p2.executeUpdate();
				session.setAttribute("notifyresident", "Notify request sent");
				response.sendRedirect("supervisor.jsp?visitorform=true&newVisitor=true");
				
			}else{
				session.setAttribute("notifyresident", "Notify request already sent");
				response.sendRedirect("supervisor.jsp?visitorform=true&newVisitor=true");
			}
		}catch(SQLException e) {
			System.out.println(e);
		}
	}
}
