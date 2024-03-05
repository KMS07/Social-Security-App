import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Time;
import java.sql.Types;
import java.sql.PreparedStatement;
import java.util.logging.Level;
import java.util.logging.Logger;

import java.util.Properties;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Scanner;
import java.time.LocalDate;
import java.time.LocalTime;
import java.io.*;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@jakarta.servlet.annotation.WebServlet("/reqapproval")
public class requestapproval extends HttpServlet{
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Database details;
    	String url = "jdbc:mysql://localhost:3306/sss_app?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
		String usr = "root";
		String password = "root";
		
		HttpSession session = request.getSession();
		
		String vphoneno = request.getParameter("vphoneno");
		String approve = request.getParameter("approve");
		String deny = request.getParameter("deny");
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		String deleteq = "delete from visit_requests where vphoneno = ?";
		String req_details = "select * from visit_requests where vphoneno = ?";
		String insertq = "insert into approved_requests values(?,?,?,?,?,?,?)";
		try(Connection con = DriverManager.getConnection(url,usr,password);){
			
			if(approve != null) {
				
				
				PreparedStatement req_st = con.prepareStatement(req_details);
				req_st.setString(1, vphoneno);
				ResultSet rs1 = req_st.executeQuery();
				
				PreparedStatement deletereq = con.prepareStatement(deleteq);
				deletereq.setString(1, vphoneno);
				deletereq.executeUpdate(); // Request is now deleted
				
				rs1.next();
				System.out.println("yes");
				LocalTime currentTime = LocalTime.now();
				PreparedStatement insreq = con.prepareStatement(insertq);
				insreq.setString(1, rs1.getString(1));
				insreq.setString(2, rs1.getString(2));
				insreq.setString(3, rs1.getString(3));
				insreq.setString(4, rs1.getString(4));
				insreq.setInt(5, rs1.getInt(6));
				insreq.setString(6, "Approved");
				insreq.setTime(7, Time.valueOf(currentTime));
				insreq.executeUpdate(); // approved request
				
				response.sendRedirect("resident.jsp?vrequest=true");
			}else if(deny!=null) {
				PreparedStatement deletereq = con.prepareStatement(deleteq);
				deletereq.setString(1, vphoneno);
				deletereq.executeUpdate(); // Request is now deleted
				
				PreparedStatement req_st = con.prepareStatement(req_details);
				req_st.setString(1, vphoneno);
				ResultSet rs1 = req_st.executeQuery();
				
				rs1.next();
				
				LocalTime currentTime = LocalTime.now();
				PreparedStatement insreq = con.prepareStatement(deleteq);
				insreq.setString(1, rs1.getString(1));
				insreq.setString(2, rs1.getString(2));
				insreq.setString(3, rs1.getString(3));
				insreq.setString(4, rs1.getString(4));
				insreq.setInt(5, rs1.getInt(6));
				insreq.setString(6, "Denied");
				insreq.setTime(7, Time.valueOf(currentTime));
				insreq.executeUpdate(); // approved request
				response.sendRedirect("resident.jsp?vrequest=true");
			}
			
		}catch(SQLException e) {
			System.out.println(e);
		}
	}

}
