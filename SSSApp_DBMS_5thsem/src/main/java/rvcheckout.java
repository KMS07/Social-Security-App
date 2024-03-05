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

@jakarta.servlet.annotation.WebServlet("/checkout")
public class rvcheckout extends HttpServlet{
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Database details;
    	String url = "jdbc:mysql://localhost:3306/sss_app?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
		String usr = "root";
		String password = "root";
		HttpSession session = request.getSession();
		int seccode = Integer.parseInt(request.getParameter("scode"));

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		String query1 = "select id,checkout_time from rvcheck_req where seccode= ?";
		try(Connection con = DriverManager.getConnection(url,usr,password);){
			PreparedStatement p1 = con.prepareStatement(query1,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
			p1.setInt(1, seccode);
			ResultSet rs1 = p1.executeQuery();
//			
//			PreparedStatement p2 = con.prepareStatement(query2);
//			p2.setInt(1, seccode);
//			ResultSet rs2 = p2.executeQuery();
			
//			PreparedStatement p3 = con.prepareStatement(checkin);
			if(rs1.next()) {
				while(rs1.next());
				System.out.println("no");
				rs1.last();
				if(rs1.getString(2)!=null) {// already checked out
					session.setAttribute("CHECK-MSG", "Vistor already checked out");
					System.out.println("already");
					response.sendRedirect("supervisor.jsp?visitorform=true&rvEntry=true");
				}else { //This is new check in so visitor allowed
					System.out.println(rs1.getString(1));
					LocalTime currentTime = LocalTime.now();
//					p3.setInt(1,seccode);
//					p3.setTime(2, Time.valueOf(currentTime));
//					p3.setNull(3, Types.TIME);
//					p3.executeUpdate();
					String updateq = "update rvcheck_req set checkout_time = ? where id = ?";
					PreparedStatement update = con.prepareStatement(updateq);
					update.setTime(1,Time.valueOf(currentTime));
					update.setInt(2, rs1.getInt(1));
					update.executeUpdate();
					
					session.setAttribute("CHECK-MSG", "Vistor checked out!!");
					response.sendRedirect("supervisor.jsp?visitorform=true&rvEntry=true");
				}
			}else {
//				LocalTime currentTime = LocalTime.now();
//				p3.setInt(1,seccode);
//				p3.setTime(2, Time.valueOf(currentTime));
//				p3.setNull(3, Types.TIME);
//				p3.executeUpdate();
				session.setAttribute("CHECK-MSG", "Vistor didnt check in!!");
				response.sendRedirect("supervisor.jsp?visitorform=true&rvEntry=true");
			}
		}catch(SQLException e){
			System.out.print(e);
		}
		
		
	}
}
