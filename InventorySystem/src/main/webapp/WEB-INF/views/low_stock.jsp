<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.inventorysystem.model.Product" %>
<%@ page import="com.inventorysystem.model.Category" %>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Low Stock Alerts</title>

<link rel="stylesheet"
      href="<%= request.getContextPath() %>/assets/css/sidebar.css">

<link rel="stylesheet"
      href="<%= request.getContextPath() %>/assets/css/navbar.css">

<link rel="stylesheet"
      href="<%= request.getContextPath() %>/assets/css/low_stock.css">

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

            <h1>Low Stock Alerts</h1>

            <p>Products that need restocking</p>

        </div>

        <div class="table-container">

            <table>

                <thead>

                    <tr>

                        <th>Product ID</th>
                        <th>Product Name</th>
                        <th>Category</th>
                        <th>Current Quantity</th>
                        <th>Minimum Stock</th>
                        <th>Status</th>

                    </tr>

                </thead>

                <tbody>

                <%
                    List<Product> lowStockProducts =
                            (List<Product>)
                            request.getAttribute("lowStockProducts");

                    List<Category> categoryList =
                            (List<Category>)
                            request.getAttribute("categoryList");

                    if(lowStockProducts != null &&
                       !lowStockProducts.isEmpty()){

                        for(Product product : lowStockProducts){
                %>

                    <tr>

                        <td>
                            <%= product.getProductId() %>
                        </td>

                        <td>
                            <%= product.getProductName() %>
                        </td>

                        <td>

                            <%
                                for(Category category : categoryList){

                                    if(category.getCategoryId()
                                       == product.getCategoryId()){
                            %>

                                <%= category.getCategoryName() %>

                            <%
                                    }
                                }
                            %>

                        </td>

                        <td>
                            <%= product.getQuantity() %>
                        </td>

                        <td>
                            <%= product.getMinStock() %>
                        </td>

                        <td>

                            <span class="alert-badge">

                                Low Stock

                            </span>

                        </td>

                    </tr>

                <%
                        }

                    } else {
                %>

                    <tr>

                        <td colspan="6"
                            class="no-data">

                            No low stock products found.

                        </td>

                    </tr>

                <%
                    }
                %>

                </tbody>

            </table>

        </div>

    </div>

</body>

</html>