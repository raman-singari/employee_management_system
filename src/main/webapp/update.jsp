<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<html>
<head><title>Update Employee</title></head>
<body>
<h2>Update Employee</h2>
<%
String enoStr = request.getParameter("eno");
if(enoStr != null) {
    int eno = Integer.parseInt(enoStr);
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/javafullstack","root","sql16");

        if("POST".equalsIgnoreCase(request.getMethod())) {
            PreparedStatement ps = con.prepareStatement("UPDATE employee SET name=?, gender=?, dept=? WHERE eno=?");
            ps.setString(1, request.getParameter("name"));
            ps.setString(2, request.getParameter("gender"));
            ps.setString(3, request.getParameter("dept"));
            ps.setInt(4, eno);
            ps.executeUpdate();
            ps.close(); con.close();
            response.sendRedirect("index.jsp");
            return;
        } else {
            PreparedStatement ps = con.prepareStatement("SELECT * FROM employee WHERE eno=?");
            ps.setInt(1, eno);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
%>
<form method="post">
<table>
<tr><th>Employee No</th><td><input type="text" value="<%= rs.getInt("eno") %>" disabled></td></tr>
<tr><th>Name</th><td><input type="text" name="name" value="<%= rs.getString("name") %>" required></td></tr>
<tr><th>Gender</th><td><input type="text" name="gender" value="<%= rs.getString("gender") %>" required></td></tr>
<tr><th>Department</th><td><input type="text" name="dept" value="<%= rs.getString("dept") %>" required></td></tr>
<tr><td colspan="2"><input type="submit" value="Update"></td></tr>
</table>
</form>
<%
            }
            rs.close(); ps.close();
        }
    } catch(Exception e) {
        out.println("Error: " + e.getMessage());
    }
}
%>
</body>
</html>
