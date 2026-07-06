<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.inventorysystem.model.Product" %>
<%@ page import="com.inventorysystem.model.StockHistory" %>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Stock Management</title>

<link rel="stylesheet"
      href="<%= request.getContextPath() %>/assets/css/sidebar.css">

<link rel="stylesheet"
      href="<%= request.getContextPath() %>/assets/css/navbar.css">

<link rel="stylesheet"
      href="<%= request.getContextPath() %>/assets/css/stock.css">

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

            <h1>Stock Management</h1>

            <p>Manage inventory stock updates</p>

        </div>

        <!-- Error Message -->
        <%
            String errorMessage =
                    (String) request.getAttribute("errorMessage");

            if(errorMessage != null){
        %>

            <div class="error-box">

                <%= errorMessage %>

            </div>

        <%
            }
        %>

        <!-- Stock Form -->
        <div class="form-container">

            <form action="<%= request.getContextPath() %>/stock"
                  method="post">

                <div class="form-grid">

                    <div class="input-group">

                        <label>Select Product</label>

                        <select name="productId"
                                required>

                            <option value="">
                                Select Product
                            </option>

                            <%
                                List<Product> productList =
                                        (List<Product>)
                                        request.getAttribute("productList");

                                if(productList != null){

                                    for(Product product : productList){
                            %>

                            <option value="<%= product.getProductId() %>">

                                <%= product.getProductName() %>

                            </option>

                            <%
                                    }
                                }
                            %>

                        </select>

                    </div>

                    <div class="input-group">

                        <label>Stock Type</label>

                        <select name="changeType"
                                required>

                            <option value="IN">
                                Stock In
                            </option>

                            <option value="OUT">
                                Stock Out
                            </option>

                        </select>

                    </div>

                    <div class="input-group">

                        <label>Quantity</label>

                        <input type="number"
                               name="quantity"
                               required>

                    </div>

                </div>

                <button type="submit"
                        class="submit-btn">

                    Update Stock

                </button>

            </form>

        </div>

        <!-- Stock History Table -->
        <div class="table-container">

            <table>

                <thead>

                    <tr>

                        <th>History ID</th>
                        <th>Product</th>
                        <th>Type</th>
                        <th>Quantity</th>
                        <th>Date</th>

                    </tr>

                </thead>

                <tbody>

                <%
                    List<StockHistory> historyList =
                            (List<StockHistory>)
                            request.getAttribute("historyList");

                    if(historyList != null){

                        for(StockHistory history : historyList){
                %>

                    <tr>

                        <td>
                            <%= history.getHistoryId() %>
                        </td>

                        <td>

                            <%
                                for(Product product : productList){

                                    if(product.getProductId()
                                       == history.getProductId()){
                            %>

                                <%= product.getProductName() %>

                            <%
                                    }
                                }
                            %>

                        </td>

                        <td>

                            <span class="<%= history.getChangeType()
                                    .equals("IN")
                                    ? "stock-in"
                                    : "stock-out" %>">

                                <%= history.getChangeType() %>

                            </span>

                        </td>

                        <td>
                            <%= history.getQuantityChanged() %>
                        </td>

                        <td>
                            <%= history.getUpdatedAt() %>
                        </td>

                    </tr>

                <%
                        }
                    }
                %>

                </tbody>

            </table>

        </div>

    </div>

</body>

</html>