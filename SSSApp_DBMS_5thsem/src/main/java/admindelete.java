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

@jakarta.servlet.annotation.WebServlet("/deletebuilding")
public class admindelete extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		// Database details;
    	String url = "jdbc:mysql://localhost:3306/sss_app?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
		String usr = "root";
		String password = "root";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		String query1 = "delete from building_details where building_id = ?";
		String query2 = "delete from flat_details where flat_no = ?";
		try(Connection con = DriverManager.getConnection(url,usr,password);){
			try {
				if(request.getParameter("buildingid")!=null) {
					PreparedStatement p = con.prepareStatement(query1);
					System.out.println(request.getParameter("buildingid"));
					p.setInt(1,Integer.parseInt(request.getParameter("buildingid")));
					p.executeUpdate();
					response.sendRedirect("administrator.jsp?deleteform=true");
				}
				
				if(request.getParameter("flatid")!=null) {
					PreparedStatement p = con.prepareStatement(query2);
					p.setInt(1,Integer.parseInt(request.getParameter("flatid")));
					p.executeUpdate();
					response.sendRedirect("administrator.jsp?deleteform=true");
				}
			}catch(SQLException e) {
				session.setAttribute("deletemsg", "Error Occured");
				response.sendRedirect("administrator.jsp?deleteform=true");
			}
			
			
		}catch(SQLException e) {
			session.setAttribute("deletemsg", "Error Occured");
			response.sendRedirect("administrator.jsp");
		}
	}

}
