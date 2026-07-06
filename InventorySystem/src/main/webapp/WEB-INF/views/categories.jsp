<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.inventorysystem.model.Category" %>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Categories</title>

<link rel="stylesheet"
      href="<%= request.getContextPath() %>/assets/css/sidebar.css">

<link rel="stylesheet"
      href="<%= request.getContextPath() %>/assets/css/navbar.css">

<link rel="stylesheet"
      href="<%= request.getContextPath() %>/assets/css/categories.css">

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

            <h1>Category Management</h1>

            <p>Manage product categories</p>

        </div>

        <!-- Category Form -->
        <div class="form-container">

            <%
                Category editCategory =
                        (Category) request.getAttribute("category");
            %>

            <form action="<%= request.getContextPath() %>/categories"
                  method="post">

                <input type="hidden"
                       name="action"
                       value="<%= (editCategory != null) ? "update" : "add" %>">

                <%
                    if(editCategory != null){
                %>

                    <input type="hidden"
                           name="categoryId"
                           value="<%= editCategory.getCategoryId() %>">

                <%
                    }
                %>

                <div class="input-group">

                    <label>Category Name</label>

                    <input type="text"
                           name="categoryName"
                           required
                           value="<%= (editCategory != null)
                                   ? editCategory.getCategoryName()
                                   : "" %>">

                </div>

                <div class="input-group">

                    <label>Description</label>

                    <textarea name="description"
                              rows="3"><%= (editCategory != null)
                                      ? editCategory.getDescription()
                                      : "" %></textarea>

                </div>

                <button type="submit"
                        class="submit-btn">

                    <%= (editCategory != null)
                            ? "Update Category"
                            : "Add Category" %>

                </button>

            </form>

        </div>

        <!-- Category Table -->
        <div class="table-container">

            <table>

                <thead>

                    <tr>

                        <th>ID</th>
                        <th>Category Name</th>
                        <th>Description</th>
                        <th>Actions</th>

                    </tr>

                </thead>

                <tbody>

                <%
                    List<Category> categoryList =
                            (List<Category>)
                            request.getAttribute("categoryList");

                    if(categoryList != null){

                        for(Category category : categoryList){
                %>

                    <tr>

                        <td>
                            <%= category.getCategoryId() %>
                        </td>

                        <td>
                            <%= category.getCategoryName() %>
                        </td>

                        <td>
                            <%= category.getDescription() %>
                        </td>

                        <td>

                            <a class="edit-btn"
                               href="<%= request.getContextPath() %>/categories?action=edit&id=<%= category.getCategoryId() %>">

                                Edit

                            </a>

                            <a class="delete-btn"
   href="<%= request.getContextPath() %>/categories?action=delete&id=<%= category.getCategoryId() %>"
   onclick="return confirm(
       'Are you sure you want to delete this category?');">

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

</html>