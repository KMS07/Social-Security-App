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

@jakarta.servlet.annotation.WebServlet("/updatestaff")
public class updatestaff extends HttpServlet{
	private static final long serialVersionUID = 1L;
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession();
        
        int staffid = Integer.parseInt(request.getParameter("staffid"));
        int salary = Integer.parseInt(request.getParameter("salupd"));

        String url = "jdbc:mysql://localhost:3306/sss_app?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
        String user = "root";
        String password = "root";
        
        try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		

        try(Connection con = DriverManager.getConnection(url, user, password);){
        	
            String updateQuery = "update staff_details set salary = ? where staff_id = ?";
            String query = "select * from staff_details where staff_id = ?";
            
            PreparedStatement p = con.prepareStatement(query);
            p.setInt(1, staffid);
            
            ResultSet rs = p.executeQuery();
            if(rs.next()) {
	            PreparedStatement preparedStatement = con.prepareStatement(updateQuery);
	            preparedStatement.setInt(1, salary);
	            preparedStatement.setInt(2, staffid);
	            preparedStatement.executeUpdate();
	            session.setAttribute("updatemsg", "Updated successfully");
	            response.sendRedirect("supervisor.jsp?staffform=true&updatestaff=true");
            }else {
            	session.setAttribute("updatemsg", "Update failed!! Staff id doesn't exist");
            	response.sendRedirect("supervisor.jsp?staffform=true&updatestaff=true");
            }
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("updatemsg", "Update failed!! Database error");
            response.sendRedirect("supervisor.jsp?staffform=true&updatestaff=true");
        }
    }

}
