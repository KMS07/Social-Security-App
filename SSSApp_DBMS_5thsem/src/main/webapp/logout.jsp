<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	session.invalidate(); // This will destroy the session
	
	// Set cache-control headers to prevent caching
	response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, max-age=0");
	response.setHeader("Pragma", "no-cache");
	
	// Redirect the user to the login page
	response.sendRedirect("login.html"); // Replace with your actual login page
%>
