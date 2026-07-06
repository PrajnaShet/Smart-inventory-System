<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.inventorysystem.model.Admin" %>

<%
    Admin admin =
            (Admin) session.getAttribute("loggedInAdmin");

    String username = "Admin";

    if(admin != null){
        username = admin.getUsername();
    }
%>

<div class="navbar">

    <div class="navbar-left">

        <h2>Dashboard</h2>

    </div>

    <div class="navbar-right">

        <span>
            Welcome,
            <strong><%= username %></strong>
        </span>

    </div>

</div>