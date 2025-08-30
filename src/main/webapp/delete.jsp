<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<%
String enoStr = request.getParameter("eno");
if(enoStr != null) {
    try {
        int eno = Integer.parseInt(enoStr);
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/javafullstack","root","sql16");
        PreparedStatement ps = con.prepareStatement("DELETE FROM employee WHERE eno=?");
        ps.setInt(1, eno);
        ps.executeUpdate();
        ps.close(); con.close();
    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
    }
}
response.sendRedirect("index.jsp");
%>
