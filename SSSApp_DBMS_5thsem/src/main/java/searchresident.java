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


@jakarta.servlet.annotation.WebServlet("/searchresident")
public class searchresident extends HttpServlet{
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Database details;
    	String url = "jdbc:mysql://localhost:3306/sss_app?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
		String usr = "root";
		String password = "root";
		
		HttpSession session = request.getSession();
		
		String resname = (String)request.getParameter("resname");
		String resphoneno = (String)request.getParameter("resphoneno");
		String html = "";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		String query = "SELECT res_id, Name, PhoneNo FROM resident WHERE Name LIKE ? AND PhoneNo = ?";
		try(Connection con = DriverManager.getConnection(url,usr,password);){
			PreparedStatement p = con.prepareStatement(query);
			p.setString(1, "%" + resname + "%");
			p.setString(2,resphoneno);
			ResultSet rs = p.executeQuery();
			if(!rs.next()) {
				session.setAttribute("searchresident","No resident found");
				response.sendRedirect("supervisor.jsp?visitorform=true&newVisitor=true");
			}else{
				html+="<table><tr>";
				html+="<th>Resident name</th>";
				html+="<th>Resident phone no</th>";
				html+="<th>Notify</th>";
				html+="</tr>";
				do{
					html+="<tr>";
					html+="<td>"+rs.getString(2)+"</td>";
					html+="<td>"+rs.getString(3)+"</td>";
					html+="<td><form action='notifyrequest' method='post'><input type='hidden' name='resid' value='"+rs.getInt(1)+"'><input type='hidden' name='vname' value='"+request.getParameter("visitorName")+"'><input type='hidden' name='vpno' value='"+request.getParameter("visitorpno")+"'><input type='submit' value='Notify'></form>";
					html+="</tr>";
				}while(rs.next());
				html+="</table>";
				session.setAttribute("searchresident",html);
				response.sendRedirect("supervisor.jsp?visitorform=true&newVisitor=true");
			}
		}catch(SQLException e) {
			System.out.println(e);
		}
	}

}
