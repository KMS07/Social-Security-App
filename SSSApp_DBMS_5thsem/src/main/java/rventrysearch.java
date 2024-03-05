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

@jakarta.servlet.annotation.WebServlet("/rventrysearch")
public class rventrysearch extends HttpServlet{
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Database details;
    	String url = "jdbc:mysql://localhost:3306/sss_app?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
		String usr = "root";
		String password = "root";
		HttpSession session = request.getSession();
		int seccode = Integer.parseInt(request.getParameter("seccode"));

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		String query = "select name,phoneno,address from regular_visitor where sec_code = ?";
		String searchres = "";
		try(Connection con = DriverManager.getConnection(url,usr,password);){
			PreparedStatement p1 = con.prepareStatement(query);
			p1.setInt(1, seccode);
			ResultSet rs1 = p1.executeQuery();
			searchres += "<table><tr>";
			searchres += "<th>Visitor name</th>";
			searchres += "<th>Visitor phoneno</th>";
			searchres += "<th>Visitor address</th>";
			searchres += "<th>Checkin</th>";
			searchres += "<th> Checkout </th></tr>";
			if(rs1.next()) {
				do {
					searchres+="<tr>";
					searchres += "<td>"+rs1.getString(1)+"</td>";
					searchres += "<td>"+rs1.getString(2)+"</td>";
					searchres += "<td>"+rs1.getString(3)+"</td>";
					searchres += "<td><form action='checkin' method='post'><input type='hidden' name='scode' value='"+seccode+"'><input type='submit' value='Check-in'></form></td>";
					searchres += "<td><form action='checkout' method='post'><input type='hidden' name='scode' value='"+seccode+"'><input type='submit' value='Check-out'></form></td>";
					searchres += "</tr>";
				}while(rs1.next());
				searchres += "</table>";
				session.setAttribute("searchres", searchres);
				response.sendRedirect("supervisor.jsp?visitorform=true&rvEntry=true");
			}else {
				session.setAttribute("searchres","Not found");
				response.sendRedirect("supervisor.jsp?visitorform=true&rvEntry=true");
			}
		}catch(SQLException e) {
			System.out.println(e);
			response.sendRedirect("supervisor.jsp?visitorform=true&rvEntry=true");
		}
	}

}
