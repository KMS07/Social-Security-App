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

@jakarta.servlet.annotation.WebServlet("/uploadstaff")
public class uploadstaff extends HttpServlet {
	private static final long serialVersionUID = 1L;
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession();
        String staffName = request.getParameter("staffname");
        int staffSalary = Integer.parseInt(request.getParameter("staffsal"));
        String workType = request.getParameter("worktype");
        String joinDate = request.getParameter("joindate");

        String url = "jdbc:mysql://localhost:3306/sss_app?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
        String user = "root";
        String password = "root";
        
        try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		

        try(Connection con = DriverManager.getConnection(url, user, password);){
        	
            String insertQuery = "INSERT INTO staff_details(name,salary, work_type, join_date) VALUES (?, ?, ?, ?)";
            PreparedStatement preparedStatement = con.prepareStatement(insertQuery);
            preparedStatement.setString(1, staffName);
            preparedStatement.setInt(2, staffSalary);
            preparedStatement.setString(3, workType);
            preparedStatement.setString(4, joinDate);

            preparedStatement.executeUpdate();
            session.setAttribute("uploadmsg","Staff details uploaded");
            response.sendRedirect("supervisor.jsp?staffform=true&newstaff=true");
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("supervisor.jsp?staffform=true&newstaff=true");
        }
    }
}
