<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Inventory System - Login</title>

<link rel="stylesheet"
      href="<%= request.getContextPath() %>/assets/css/login.css">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap"
      rel="stylesheet">

</head>

<body>

    <div class="login-container">

        <div class="login-card">

            <div class="login-header">

                <h1>Inventory System</h1>

                <p>Admin Login</p>

            </div>

            <form action="<%= request.getContextPath() %>/login"
                  method="post">

                <div class="input-group">

                    <label>Username</label>

                    <input type="text"
                           name="username"
                           placeholder="Enter username"
                           required>

                </div>

                <div class="input-group">

                    <label>Password</label>

                    <input type="password"
                           name="password"
                           placeholder="Enter password"
                           required>

                </div>

                <button type="submit"
                        class="login-btn">

                    Login

                </button>

            </form>

            <%
                String error =
                        (String) request.getAttribute("errorMessage");

                if (error != null) {
            %>

                <p class="error-message">
                    <%= error %>
                </p>

            <%
                }
            %>

        </div>

    </div>

</body>

</html>