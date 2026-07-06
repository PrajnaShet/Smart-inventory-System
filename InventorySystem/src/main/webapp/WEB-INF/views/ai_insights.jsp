<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.inventorysystem.model.Product" %>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>AI Insights</title>

<link rel="stylesheet"
      href="<%= request.getContextPath() %>/assets/css/sidebar.css">

<link rel="stylesheet"
      href="<%= request.getContextPath() %>/assets/css/navbar.css">

<link rel="stylesheet"
      href="<%= request.getContextPath() %>/assets/css/ai_insights.css">

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

    <div class="main-content">

        <div class="page-header">

            <h1>AI Inventory Insights</h1>

            <p>Smart inventory analytics and recommendations</p>

        </div>

        <!-- AI Cards -->
        <div class="insight-cards">

            <div class="card">

                <h3>Total Inventory Value</h3>

                <p>
                    ₹ <%= request.getAttribute("totalInventoryValue") %>
                </p>

            </div>

            <div class="card">

                <h3>Total Products</h3>

                <p>
                    <%= request.getAttribute("totalProducts") %>
                </p>

            </div>

            <div class="card">

                <h3>Low Stock Products</h3>

                <p>
                    <%= request.getAttribute("lowStockCount") %>
                </p>

            </div>

            <div class="card">

                <h3>Healthy Products</h3>

                <p>
                    <%= request.getAttribute("healthyStockCount") %>
                </p>

            </div>

        </div>

        <!-- Most Active Product -->
        <div class="ai-section">

            <h2>Most Active Product</h2>

            <%
                Product mostActiveProduct =
                        (Product)
                        request.getAttribute(
                                "mostActiveProduct");
            %>

            <%
                if(mostActiveProduct != null){
            %>

                <div class="ai-box">

                    <h3>
                        <%= mostActiveProduct.getProductName() %>
                    </h3>

                    <p>
                        This product has the highest stock activity.
                    </p>

                </div>

            <%
                }
            %>

        </div>

        <!-- Restock Recommendations -->
        <div class="ai-section">

            <h2>Restock Recommendations</h2>

            <div class="recommendation-list">

            <%
                List<Product> productList =
                        (List<Product>)
                        request.getAttribute("productList");

                if(productList != null){

                    for(Product product : productList){

                        if(product.getQuantity()
                           <= product.getMinStock()){
            %>

                <div class="recommendation-item">

                    <h3>
                        <%= product.getProductName() %>
                    </h3>

                    <p>

                        Current Quantity:
                        <strong>
                            <%= product.getQuantity() %>
                        </strong>

                    </p>

                    <p class="danger-text">

                        AI Suggestion:
                        Restock immediately to avoid shortage.

                    </p>

                </div>

            <%
                        }
                    }
                }
            %>

            </div>

        </div>

    </div>

</body>

</html>