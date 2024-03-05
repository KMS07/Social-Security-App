import java.sql.Connection;
import java.sql.Date;
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

@jakarta.servlet.annotation.WebServlet("/apppay")
public class apppay extends HttpServlet{
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
        	String updateQuery = "update maintenance_details set amount = amount - ?,due=?,dop=?,payment_mode = ? where flat_id = ?";
        	String amountq = "select amount from maintenance_details where flat_id = ?";
        	
        	PreparedStatement p4 = con.prepareStatement(amountq);
        	p4.setInt(1, flatid);
        	ResultSet rs2 = p4.executeQuery();
			rs2.next();
			if(amount >= rs2.getInt(1)) {
				PreparedStatement p2 = con.prepareStatement(updateQuery);
	        	p2.setInt(1, rs2.getInt(1));
	        	p2.setString(2, "No");
	        	p2.setDate(3,Date.valueOf(LocalDate.now()) );
	        	p2.setString(4, "app payment");
	        	p2.setInt(5, flatid);
	        	p2.executeUpdate();
	        	session.setAttribute("apppaymsg", "Amount paid!! Dues cleared");
			}else {
				PreparedStatement p2 = con.prepareStatement(updateQuery);
	        	p2.setInt(1,amount);
	        	p2.setString(2, "Yes");
	        	p2.setDate(3,Date.valueOf(LocalDate.now()) );
	        	p2.setString(4, "app payment");
	        	p2.setInt(5, flatid);
	        	p2.executeUpdate();
	        	session.setAttribute("apppaymsg", "Amount paid!! But due of "+(rs2.getInt(1)-amount)+"remaining");
			}
        	response.sendRedirect("resident.jsp?mpay=true");
        }catch(SQLException e) {
        	System.out.println(e);
        }
    }

}
