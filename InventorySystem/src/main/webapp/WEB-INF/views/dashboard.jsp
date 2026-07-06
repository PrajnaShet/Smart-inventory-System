<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.inventorysystem.model.Product" %>
<%@ page import="com.inventorysystem.model.StockHistory" %>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Dashboard</title>

<link rel="stylesheet"
      href="<%= request.getContextPath() %>/assets/css/sidebar.css">

<link rel="stylesheet"
      href="<%= request.getContextPath() %>/assets/css/navbar.css">

<link rel="stylesheet"
      href="<%= request.getContextPath() %>/assets/css/dashboard.css">

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<link rel="preconnect"
      href="https://fonts.googleapis.com">

<link rel="preconnect"
      href="https://fonts.gstatic.com"
      crossorigin>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap"
      rel="stylesheet">

</head>

<body>

    <!-- Sidebar -->
    <jsp:include page="../partials/sidebar.jsp" />

    <!-- Navbar -->
    <jsp:include page="../partials/navbar.jsp" />

    <!-- Main Content -->
    <div class="main-content">

        <!-- Header -->
        <div class="dashboard-header">

            <h1>Inventory Dashboard</h1>

            <p>
                Smart Inventory Analytics & Monitoring
            </p>

        </div>

        <!-- Dashboard Cards -->
        <div class="dashboard-cards">

            <div class="card">

                <h3>Total Products</h3>

                <p>
                    <%= request.getAttribute("totalProducts") != null
                            ? request.getAttribute("totalProducts")
                            : 0 %>
                </p>

            </div>

            <div class="card">

                <h3>Total Categories</h3>

                <p>
                    <%= request.getAttribute("totalCategories") != null
                            ? request.getAttribute("totalCategories")
                            : 0 %>
                </p>

            </div>

            <div class="card">

                <h3>Low Stock Products</h3>

                <p>
                    <%= request.getAttribute("lowStockCount") != null
                            ? request.getAttribute("lowStockCount")
                            : 0 %>
                </p>

            </div>

            <div class="card">

                <h3>Total Stock Updates</h3>

                <p>
                    <%= request.getAttribute("totalStockUpdates") != null
                            ? request.getAttribute("totalStockUpdates")
                            : 0 %>
                </p>

            </div>

            <div class="card">

                <h3>Total Inventory Value</h3>

                <p>

                    ₹
                    <%= request.getAttribute("totalInventoryValue") != null
                            ? request.getAttribute("totalInventoryValue")
                            : 0 %>

                </p>

            </div>

        </div>

        <!-- Charts Section -->
        <div class="charts-grid">

            <!-- Bar Chart -->
            <div class="chart-container">

                <h2>Inventory Stock Distribution</h2>

                <canvas id="inventoryChart"></canvas>

            </div>

            <!-- Pie Chart -->
            <div class="chart-container">

                <h2>Inventory Health Overview</h2>

                <div class="pie-chart-wrapper">

                    <canvas id="stockPieChart"></canvas>

                </div>

            </div>

        </div>

        <!-- Charts Script -->
        <script>

            // BAR CHART

            const ctx = document
                .getElementById('inventoryChart')
                .getContext('2d');

            new Chart(ctx, {

                type: 'bar',

                data: {

                    labels: [

                        <%= request.getAttribute("productNames") != null
                                ? request.getAttribute("productNames")
                                : "" %>

                    ],

                    datasets: [{

                        label: 'Available Quantity',

                        data: [

                            <%= request.getAttribute("productQuantities") != null
                                    ? request.getAttribute("productQuantities")
                                    : "" %>

                        ],

                        backgroundColor: [
                            '#3b82f6',
                            '#22c55e',
                            '#f59e0b',
                            '#ef4444',
                            '#8b5cf6'
                        ],

                        borderRadius: 8,

                        borderWidth: 1

                    }]
                },

                options: {

                    responsive: true,

                    plugins: {

                        legend: {

                            display: false
                        }
                    },

                    scales: {

                        y: {

                            beginAtZero: true
                        }
                    }
                }
            });

            // PIE CHART

            const pieCtx = document
                .getElementById('stockPieChart')
                .getContext('2d');

            new Chart(pieCtx, {

                type: 'doughnut',

                data: {

                    labels: [
                        'Healthy Stock',
                        'Low Stock'
                    ],

                    datasets: [{

                        data: [

                            <%= request.getAttribute("healthyStockCount") != null
                                    ? request.getAttribute("healthyStockCount")
                                    : 0 %>,

                            <%= request.getAttribute("lowStockCount") != null
                                    ? request.getAttribute("lowStockCount")
                                    : 0 %>

                        ],

                        backgroundColor: [
                            '#22c55e',
                            '#ef4444'
                        ],

                        borderColor: [
                            '#16a34a',
                            '#dc2626'
                        ],

                        borderWidth: 2,

                        hoverOffset: 10

                    }]
                },

                options: {

                    responsive: true,

                    cutout: '65%',

                    plugins: {

                        legend: {

                            position: 'bottom',

                            labels: {

                                padding: 20,

                                usePointStyle: true,

                                font: {

                                    size: 13
                                }
                            }
                        },

                        tooltip: {

                            callbacks: {

                                label: function(context) {

                                    const total =
                                        context.dataset.data.reduce(
                                            (a, b) => a + b, 0);

                                    const value =
                                        context.parsed;

                                    const pct =
                                        total > 0
                                        ? ((value / total) * 100)
                                            .toFixed(1)
                                        : 0;

                                    return context.label +
                                           ': ' +
                                           value +
                                           ' products (' +
                                           pct +
                                           '%)';
                                }
                            }
                        }
                    }
                }
            });

        </script>

        <!-- Recent Activity -->
        <div class="activity-section">

            <div class="section-header">

                <h2>Recent Stock Activity</h2>

                <p>
                    Latest inventory updates and stock movement
                </p>

            </div>

            <div class="activity-list">

            <%

                List<StockHistory> historyList =
                    (List<StockHistory>)
                    request.getAttribute("historyList");

                List<Product> productList =
                    (List<Product>)
                    request.getAttribute("productList");

                int count = 0;

                if(historyList != null){

                    for(StockHistory history : historyList){

                        if(count == 5){
                            break;
                        }

                        count++;
            %>

                <div class="activity-card">

                    <!-- TOP -->

                    <div class="activity-top">

                        <div class="activity-product">

                            <div class="activity-icon
                                <%= "IN".equals(history.getChangeType())
                                    ? "in-bg"
                                    : "out-bg" %>">

                                <%= "IN".equals(history.getChangeType())
                                        ? "+"
                                        : "-" %>

                            </div>

                            <div>

                                <h3>

                                <%

                                    String productName =
                                        "Unknown Product";

                                    if(productList != null){

                                        for(Product product : productList){

                                            if(product.getProductId()
                                                    == history.getProductId()){

                                                productName =
                                                    product.getProductName();

                                                break;
                                            }
                                        }
                                    }

                                %>

                                <%= productName %>

                                </h3>

                                <p>

                                    Updated on:
                                    <%= history.getUpdatedAt() %>

                                </p>

                            </div>

                        </div>

                        <span class="<%= "IN".equals(history.getChangeType())
                                ? "stock-in"
                                : "stock-out" %>">

                            <%= history.getChangeType() != null
                                    ? history.getChangeType()
                                    : "N/A" %>

                        </span>

                    </div>

                    <!-- BOTTOM -->

                    <div class="activity-bottom">

                        <div class="activity-stat">

                            <small>
                                Quantity Changed
                            </small>

                            <strong>

                                <%= history.getQuantityChanged() %>

                            </strong>

                        </div>

                        <div class="activity-stat">

                            <small>
                                Movement Type
                            </small>

                            <strong>

                                <%= "IN".equals(history.getChangeType())
                                        ? "Added to Inventory"
                                        : "Removed from Inventory" %>

                            </strong>

                        </div>

                    </div>

                </div>

            <%
                    }
                }
            %>

            </div>

        </div>

    </div>

</body>

</html>