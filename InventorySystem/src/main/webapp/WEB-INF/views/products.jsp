<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.inventorysystem.model.Product" %>
<%@ page import="com.inventorysystem.model.Category" %>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Products</title>

<link rel="stylesheet"
      href="<%= request.getContextPath() %>/assets/css/sidebar.css">

<link rel="stylesheet"
      href="<%= request.getContextPath() %>/assets/css/navbar.css">

<link rel="stylesheet"
      href="<%= request.getContextPath() %>/assets/css/products.css">

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

        <!-- Success Message -->

        <%
            String successMessage =
                    (String) session.getAttribute(
                            "successMessage");

            if(successMessage != null){
        %>

        <div class="success-box">

            <%= successMessage %>

        </div>

        <%
                session.removeAttribute(
                        "successMessage");
            }
        %>

        <!-- Page Header -->

        <div class="page-header">

            <h1>Product Management</h1>

            <p>
                Manage inventory products efficiently
            </p>

        </div>

        <!-- Search -->

        <div class="search-container">

            <form action="<%= request.getContextPath() %>/products"
                  method="get">

                <input type="hidden"
                       name="action"
                       value="search">

                <input type="text"
                       name="keyword"
                       placeholder="Search products...">

                <button type="submit">

                    Search

                </button>

            </form>

        </div>

        <!-- Product Form -->

        <div class="form-container">

            <%
                Product editProduct =
                        (Product)
                        request.getAttribute(
                                "product");

                List<Category> categoryList =
                        (List<Category>)
                        request.getAttribute(
                                "categoryList");
            %>

            <form action="<%= request.getContextPath() %>/products"
                  method="post">

                <input type="hidden"
                       name="action"
                       value="<%= (editProduct != null)
                               ? "update"
                               : "add" %>">

                <%
                    if(editProduct != null){
                %>

                    <input type="hidden"
                           name="productId"
                           value="<%= editProduct.getProductId() %>">

                <%
                    }
                %>

                <div class="form-grid">

                    <!-- Product Name -->

                    <div class="input-group">

                        <label>Product Name</label>

                        <input type="text"
                               name="productName"
                               required
                               value="<%= (editProduct != null)
                                       ? editProduct.getProductName()
                                       : "" %>">

                    </div>

                    <!-- Category -->

                    <div class="input-group">

                        <label>Category</label>

                        <select name="categoryId"
                                required>

                            <option value="">
                                Select Category
                            </option>

                            <%
                                if(categoryList != null){

                                    for(Category category : categoryList){
                            %>

                            <option value="<%= category.getCategoryId() %>"

                            <%
                                if(editProduct != null &&
                                   editProduct.getCategoryId()
                                   == category.getCategoryId()){
                            %>

                                selected

                            <%
                                }
                            %>

                            >

                                <%= category.getCategoryName() %>

                            </option>

                            <%
                                    }
                                }
                            %>

                        </select>

                    </div>

                    <!-- Price -->

                    <div class="input-group">

                        <label>Price</label>

                        <input type="number"
                               step="0.01"
                               min="1"
                               name="price"
                               required
                               oninput="this.value =
                               Math.abs(this.value)"
                               value="<%= (editProduct != null)
                                       ? editProduct.getPrice()
                                       : "" %>">

                    </div>

                    <!-- Quantity -->

                    <div class="input-group">

                        <label>Quantity</label>

                        <input type="number"
                               min="0"
                               name="quantity"
                               required
                               oninput="this.value =
                               Math.abs(this.value)"
                               value="<%= (editProduct != null)
                                       ? editProduct.getQuantity()
                                       : "" %>">

                    </div>

                    <!-- Minimum Stock -->

                    <div class="input-group">

                        <label>Minimum Stock</label>

                        <input type="number"
                               min="0"
                               name="minStock"
                               required
                               oninput="this.value =
                               Math.abs(this.value)"
                               value="<%= (editProduct != null)
                                       ? editProduct.getMinStock()
                                       : "" %>">

                    </div>

                </div>

                <!-- Description -->

                <div class="input-group">

                    <label>Description</label>

                    <textarea name="description"
                              rows="4"><%= (editProduct != null)
                                      ? editProduct.getDescription()
                                      : "" %></textarea>

                </div>

                <!-- Submit Button -->

                <button type="submit"
                        class="submit-btn">

                    <%= (editProduct != null)
                            ? "Update Product"
                            : "Add Product" %>

                </button>

            </form>

        </div>

        <!-- Product Table -->

        <div class="table-container">

            <table>

                <thead>

                    <tr>

                        <th>ID</th>
                        <th>Name</th>
                        <th>Category</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Min Stock</th>
                        <th>Actions</th>

                    </tr>

                </thead>

                <tbody>

                <%
                    List<Product> productList =
                            (List<Product>)
                            request.getAttribute(
                                    "productList");

                    if(productList != null){

                        for(Product product : productList){
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
                            ₹ <%= product.getPrice() %>
                        </td>

                        <td>

    <div class="stock-info">

        <span class="stock-quantity">

            <%= product.getQuantity() %>

        </span>

        <%
            if(product.getQuantity() == 0){
        %>

            <span class="stock-badge out-stock">

                Out of Stock

            </span>

        <%
            }
            else if(product.getQuantity()
                    <= product.getMinStock()){
        %>

            <span class="stock-badge low-stock">

                Low Stock

            </span>

        <%
            }
            else{
        %>

            <span class="stock-badge in-stock">

                In Stock

            </span>

        <%
            }
        %>

    </div>

</td>

                        <td>
                            <%= product.getMinStock() %>
                        </td>

                        <td>

                            <!-- Edit -->

                            <a class="edit-btn"
                               href="<%= request.getContextPath() %>/products?action=edit&id=<%= product.getProductId() %>">

                                Edit

                            </a>

                            <!-- Delete -->

                            <a class="delete-btn"
                               href="<%= request.getContextPath() %>/products?action=delete&id=<%= product.getProductId() %>"
                               onclick="return confirm(
                               'Are you sure you want to delete this product?');">

                                Delete

                            </a>

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

</html>r