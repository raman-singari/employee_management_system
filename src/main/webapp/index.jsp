<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Employee Management System</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .container {
            margin-top: 40px;
        }
        .form-section, .table-section {
            background: #fff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0px 0px 8px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }
        h2 {
            margin-bottom: 20px;
            color: #343a40;
            text-align: center;
        }
        .btn-custom {
            width: 100%;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Employee Form -->
    <div class="form-section">
        <h2>Add Employee</h2>
        <form action="index.jsp" method="post">
            <div class="mb-3">
                <label class="form-label">Employee No</label>
                <input type="text" name="eno" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Name</label>
                <input type="text" name="name" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Gender</label>
                <input type="text" name="gender" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Department</label>
                <input type="text" name="dept" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary btn-custom">Submit</button>
        </form>

        <%
        if("POST".equalsIgnoreCase(request.getMethod())) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/javafullstack","root","sql16");
                PreparedStatement ps = con.prepareStatement("INSERT INTO employee VALUES (?, ?, ?, ?)");
                ps.setInt(1, Integer.parseInt(request.getParameter("eno")));
                ps.setString(2, request.getParameter("name"));
                ps.setString(3, request.getParameter("gender"));
                ps.setString(4, request.getParameter("dept"));
                ps.executeUpdate();
                ps.close(); con.close();
                out.println("<div class='alert alert-success mt-3'>Employee added successfully!</div>");
            } catch(Exception e) {
                out.println("<div class='alert alert-danger mt-3'>Error: "+e.getMessage()+"</div>");
            }
        }
        %>
    </div>

    <!-- Employee Table -->
    <div class="table-section">
        <h2>Employee List</h2>
        <table class="table table-bordered table-striped text-center">
            <thead class="table-dark">
                <tr>
                    <th>Eno</th>
                    <th>Name</th>
                    <th>Gender</th>
                    <th>Department</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
            <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/javafullstack","root","sql16");
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("SELECT * FROM employee");
                while(rs.next()) {
            %>
                <tr>
                    <td><%= rs.getInt("eno") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("gender") %></td>
                    <td><%= rs.getString("dept") %></td>
                    <td>
                        <a href="update.jsp?eno=<%= rs.getInt("eno") %>" class="btn btn-warning btn-sm">Edit</a>
                        <a href="delete.jsp?eno=<%= rs.getInt("eno") %>" class="btn btn-danger btn-sm" onclick="return confirm('Delete this employee?');">Delete</a>
                    </td>
                </tr>
            <%
                }
                rs.close(); st.close(); con.close();
            } catch(Exception e) {
                out.println("<div class='alert alert-danger mt-3'>Error: "+e.getMessage()+"</div>");
            }
            %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
