<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="sidebar">

    <div class="sidebar-header">

        <h2>Inventory System</h2>

    </div>

    <ul class="sidebar-menu">

        <li>
            <a href="<%= request.getContextPath() %>/dashboard">
                Dashboard
            </a>
        </li>

        <li>
            <a href="<%= request.getContextPath() %>/products">
                Products
            </a>
        </li>

        <li>
            <a href="<%= request.getContextPath() %>/categories">
                Categories
            </a>
        </li>

        <li>
            <a href="<%= request.getContextPath() %>/stock">
                Stock Management
            </a>
        </li>

        <li>
            <a href="<%= request.getContextPath() %>/low-stock">
                Low Stock Alerts
            </a>
        </li>

        <li>
            <a href="<%= request.getContextPath() %>/ai-insights">
                AI Insights
            </a>
        </li>

        <li>
            <a href="<%= request.getContextPath() %>/logout">
                Logout
            </a>
        </li>

    </ul>

</div>