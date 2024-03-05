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

@jakarta.servlet.annotation.WebServlet("/mupload")
public class mupload extends HttpServlet{
	private static final long serialVersionUID = 1L;
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession();
    	
    	int flatid = Integer.parseInt(request.getParameter("flatid"));
    	int amount = Integer.parseInt(request.getParameter("amount"));
    	String url = "jdbc:mysql://localhost:3306/sss_app?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
        String user = "root";
        String password = "root";
        
        try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

        try(Connection con = DriverManager.getConnection(url, user, password);){
        	String insertQuery = "INSERT INTO maintenance_details(flat_id,amount, due) VALUES (?, ?, ?)";
        	String updateQuery = "update maintenance_details set amount = amount + ?,due='Yes' where flat_id = ?";
        	String mofaflat = "select distinct flat_id from maintenance_details where flat_id = ?";
        	PreparedStatement p1 = con.prepareStatement(mofaflat);
        	p1.setInt(1, flatid);
        	ResultSet rs = p1.executeQuery();
        	
        	PreparedStatement p2 = con.prepareStatement(insertQuery);
        	p2.setInt(1, flatid);
        	p2.setInt(2, amount);
        	p2.setString(3,"Yes");
        	
        	PreparedStatement p3 = con.prepareStatement(updateQuery);
        	p3.setInt(1, amount);
        	p3.setInt(2, flatid);
        	
        	if(rs.next()) {
	        		p3.executeUpdate();// update existing maintenance of the flat
	        		session.setAttribute("muploadmsg","Updated the existing flat maintenance amount");

        	}else {
        		try {
        		p2.executeUpdate(); // insert the maintenance record 
        		session.setAttribute("muploadmsg","Uploaded the flat maintenance");
        		}catch(SQLException e) {
        			session.setAttribute("muploadmsg","Flat doesn't exist");
        		}
        	}
        	response.sendRedirect("supervisor.jsp?maintenance=true&mupload=true");
        }catch(SQLException e) {
        	System.out.println(e);
        }
    }

}
