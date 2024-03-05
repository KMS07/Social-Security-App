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

@jakarta.servlet.annotation.WebServlet("/uploadbuildingflat")
public class adminupload extends HttpServlet{
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
		String query1 = "insert into building_details values(?,?,?,?)";
		String query2 = "insert into flat_details values(?,?,?,?)";
		try(Connection con = DriverManager.getConnection(url,usr,password);){
				if(request.getParameter("bid")!=null && request.getParameter("nfloor")!=null &&request.getParameter("tsqft")!=null && request.getParameter("nof")!=null){
					try{PreparedStatement p1 = con.prepareStatement(query1);
					p1.setInt(1, Integer.parseInt(request.getParameter("bid")));
					p1.setInt(2, Integer.parseInt(request.getParameter("nfloor")));
					p1.setInt(3, Integer.parseInt(request.getParameter("tsqft")));
					p1.setInt(4, Integer.parseInt(request.getParameter("nof")));
					p1.executeUpdate();
					session.setAttribute("uploadmsg","Uploaded successfully");
					response.sendRedirect("administrator.jsp?uploadform=true");
					}
					catch(SQLException e) {
						session.setAttribute("uploadmsg","Building id already exists");
						response.sendRedirect("administrator.jsp?uploadform=true");
					}
				}
				
				if(request.getParameter("flatno")!=null && request.getParameter("nb")!=null &&request.getParameter("available")!=null && request.getParameter("fbid")!=null){
					try{
						PreparedStatement p2 = con.prepareStatement(query2);
						p2.setInt(1, Integer.parseInt(request.getParameter("flatno")));
						p2.setInt(2, Integer.parseInt(request.getParameter("nb")));
						p2.setString(3, request.getParameter("available"));
						p2.setInt(4, Integer.parseInt(request.getParameter("fbid")));
						p2.executeUpdate();
						session.setAttribute("uploadmsg","Uploaded successfully");
						response.sendRedirect("administrator.jsp?uploadform=true");
					}
					catch(SQLException e) {
						String sqlState = e.getSQLState();
						if (sqlState != null && sqlState.startsWith("23")) {
					        if (e.getMessage().toLowerCase().contains("foreign key") && !(e.getMessage().toLowerCase().contains("primary key"))) {
					            // only foreign key constraint violation
					        	session.setAttribute("uploadmsg","Building does not exist");
					        	response.sendRedirect("administrator.jsp?uploadform=true");
					        } else if(e.getMessage().toLowerCase().contains("primary key") && !(e.getMessage().toLowerCase().contains("foreign key"))){
					            // only pk constraint violation
					        	session.setAttribute("uploadmsg","flat already exists");
					        	response.sendRedirect("administrator.jsp?uploadform=true");
					        }
					    }
					}
				}
			
		}catch(SQLException e){
			System.out.println(e);
			session.setAttribute("uploadmsg","Upload failed...Connection error");
			response.sendRedirect("administrator.jsp");
		}
	}
}
