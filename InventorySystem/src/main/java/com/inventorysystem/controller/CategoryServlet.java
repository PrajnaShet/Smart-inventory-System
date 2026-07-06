package com.inventorysystem.controller;

import java.io.IOException;
import java.util.List;

import com.inventorysystem.dao.CategoryDAO;
import com.inventorysystem.dao.impl.CategoryDAOImpl;
import com.inventorysystem.model.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/categories")
public class CategoryServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {

        categoryDAO = new CategoryDAOImpl();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        if (session == null ||
            session.getAttribute("loggedInAdmin") == null) {

            response.sendRedirect(
                    request.getContextPath());

            return;
        }

        String action =
                request.getParameter("action");

        if (action == null) {

            action = "list";
        }

        switch (action) {

            case "delete":

                deleteCategory(request, response);
                break;

            case "edit":

                showEditCategory(request, response);
                break;

            default:

                listCategories(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action =
                request.getParameter("action");

        if (action == null) {

            action = "add";
        }

        switch (action) {

            case "update":

                updateCategory(request, response);
                break;

            default:

                addCategory(request, response);
                break;
        }
    }

    private void listCategories(HttpServletRequest request,
                                HttpServletResponse response)
            throws ServletException, IOException {

        List<Category> categoryList =
                categoryDAO.getAllCategories();

        request.setAttribute(
                "categoryList",
                categoryList);

        request.getRequestDispatcher(
                "/WEB-INF/views/categories.jsp")
                .forward(request, response);
    }

    private void addCategory(HttpServletRequest request,
                             HttpServletResponse response)
            throws IOException {

        String categoryName =
                request.getParameter("categoryName");

        String description =
                request.getParameter("description");

        Category category =
                new Category(categoryName, description);

        categoryDAO.addCategory(category);

        response.sendRedirect(
                request.getContextPath()
                + "/categories");
    }

    private void deleteCategory(HttpServletRequest request,
                                HttpServletResponse response)
            throws IOException {

        int categoryId =
                Integer.parseInt(
                        request.getParameter("id"));

        categoryDAO.deleteCategory(categoryId);

        response.sendRedirect(
                request.getContextPath()
                + "/categories");
    }

    private void showEditCategory(HttpServletRequest request,
                                  HttpServletResponse response)
            throws ServletException, IOException {

        int categoryId =
                Integer.parseInt(
                        request.getParameter("id"));

        Category category =
                categoryDAO.getCategoryById(categoryId);

        request.setAttribute(
                "category",
                category);

        listCategories(request, response);
    }

    private void updateCategory(HttpServletRequest request,
                                HttpServletResponse response)
            throws IOException {

        int categoryId =
                Integer.parseInt(
                        request.getParameter("categoryId"));

        String categoryName =
                request.getParameter("categoryName");

        String description =
                request.getParameter("description");

        Category category =
                new Category(
                        categoryId,
                        categoryName,
                        description);

        categoryDAO.updateCategory(category);

        response.sendRedirect(
                request.getContextPath()
                + "/categories");
    }
}