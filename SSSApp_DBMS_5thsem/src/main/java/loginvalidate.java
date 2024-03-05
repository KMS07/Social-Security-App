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


@jakarta.servlet.annotation.WebServlet("/loginvalidate")
public class loginvalidate extends HttpServlet{
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
		try(Connection con = DriverManager.getConnection(url,usr,password);){
			String query = "select * from users";
			Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(query);
            
            
            boolean validLogin = false;
            while (rs.next()) {
                if(request.getParameter("usr").equals(rs.getString("username")) && request.getParameter("passwd").equals(rs.getString("password")) && rs.getString("user_type").equals("Resident")) {
                	String resid_q = "select res_id from resident where app_username = ?";
                	HttpSession usrsession = request.getSession(true);
                	PreparedStatement p = con.prepareStatement(resid_q);
                	p.setString(1,request.getParameter("usr"));
                	ResultSet rs1 = p.executeQuery();
                	
                	rs1.next();
                	
                    usrsession.setAttribute("username",request.getParameter("usr"));
                    usrsession.setAttribute("residentid", rs1.getInt(1));
                    usrsession.setMaxInactiveInterval(1800); //session valid for 30 minutes
//                	RequestDispatcher dispatcher = request.getRequestDispatcher("resident.jsp?homepage=true");
//                    dispatcher.forward(request, response);
                	response.sendRedirect("resident.jsp?homepage=true");
                	validLogin = true;
                	break;
                }
                else if(request.getParameter("usr").equals(rs.getString("username")) && request.getParameter("passwd").equals(rs.getString("password")) && rs.getString("user_type").equals("Administrator")) {
                	HttpSession sellersession = request.getSession(true);
                    sellersession.setAttribute("adminname",request.getParameter("usr"));
                    sellersession.setMaxInactiveInterval(1800); //session valid for 30 minutes
                	response.sendRedirect("administrator.jsp?uploadform=true");
                	validLogin = true;
                	break;
                }else if(request.getParameter("usr").equals(rs.getString("username")) && request.getParameter("passwd").equals(rs.getString("password")) && rs.getString("user_type").equals("Supervisor")) {
                	HttpSession sellersession = request.getSession(true);
                    sellersession.setAttribute("svrname",request.getParameter("usr"));
                    sellersession.setMaxInactiveInterval(1800); //session valid for 30 minutes
                    response.sendRedirect("supervisor.jsp?visitorform=true&newVisitor=true");
                	validLogin = true;
                	break;
                }
            }
            if(!validLogin) {
            	response.sendRedirect("login.html?error=true");
            }
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
    }

}
