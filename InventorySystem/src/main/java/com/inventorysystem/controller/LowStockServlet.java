package com.inventorysystem.controller;

import java.io.IOException;
import java.util.List;

import com.inventorysystem.dao.CategoryDAO;
import com.inventorysystem.dao.ProductDAO;
import com.inventorysystem.dao.impl.CategoryDAOImpl;
import com.inventorysystem.dao.impl.ProductDAOImpl;
import com.inventorysystem.model.Category;
import com.inventorysystem.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/low-stock")
public class LowStockServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;

    @Override
    public void init() throws ServletException {

        productDAO = new ProductDAOImpl();
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

        List<Product> lowStockProducts =
                productDAO.getLowStockProducts();

        List<Category> categoryList =
                categoryDAO.getAllCategories();

        request.setAttribute(
                "lowStockProducts",
                lowStockProducts);

        request.setAttribute(
                "categoryList",
                categoryList);

        request.getRequestDispatcher(
                "/WEB-INF/views/low_stock.jsp")
                .forward(request, response);
    }
}