package com.inventorysystem.controller;

import java.io.IOException;
import java.util.List;

import com.inventorysystem.dao.CategoryDAO;
import com.inventorysystem.dao.ProductDAO;
import com.inventorysystem.dao.StockHistoryDAO;
import com.inventorysystem.dao.impl.CategoryDAOImpl;
import com.inventorysystem.dao.impl.ProductDAOImpl;
import com.inventorysystem.dao.impl.StockHistoryDAOImpl;
import com.inventorysystem.model.Admin;
import com.inventorysystem.model.Product;
import com.inventorysystem.model.StockHistory;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;
    private StockHistoryDAO stockHistoryDAO;

    @Override
    public void init() throws ServletException {

        productDAO = new ProductDAOImpl();
        categoryDAO = new CategoryDAOImpl();
        stockHistoryDAO = new StockHistoryDAOImpl();
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
                    request.getContextPath()
                    + "/loginPage");

            return;
        }

        Admin admin =
                (Admin) session.getAttribute(
                        "loggedInAdmin");

        // Fetch data
        List<Product> productList =
                productDAO.getAllProducts();

        List<StockHistory> historyList =
                stockHistoryDAO.getAllStockHistory();

        int totalProducts =
                productList.size();

        int totalCategories =
                categoryDAO.getAllCategories().size();

        int lowStockCount =
                productDAO.getLowStockProducts().size();

        int healthyStockCount =
                totalProducts - lowStockCount;

        int totalStockUpdates =
                historyList.size();

        // Inventory Value
        double totalInventoryValue = 0;

        for(Product product : productList){

            totalInventoryValue +=
                    product.getPrice()
                    * product.getQuantity();
        }

        // Set attributes
        request.setAttribute(
                "admin",
                admin);

        request.setAttribute(
                "totalProducts",
                totalProducts);

        request.setAttribute(
                "totalCategories",
                totalCategories);

        request.setAttribute(
                "lowStockCount",
                lowStockCount);

        request.setAttribute(
                "healthyStockCount",
                healthyStockCount);

        request.setAttribute(
                "totalStockUpdates",
                totalStockUpdates);

        request.setAttribute(
                "totalInventoryValue",
                totalInventoryValue);
     // Recent Stock History
        request.setAttribute(
                "historyList",
                historyList);
        
     // Product Chart Data
        StringBuilder productNames =
                new StringBuilder();

        StringBuilder productQuantities =
                new StringBuilder();

        for(Product product : productList){

            productNames.append("'")
                    .append(product.getProductName())
                    .append("',");

            productQuantities.append(
                    product.getQuantity())
                    .append(",");
        }

        request.setAttribute(
                "productNames",
                productNames.toString());

        request.setAttribute(
                "productQuantities",
                productQuantities.toString());
        request.setAttribute(
                "productList",
                productList);

        request.setAttribute(
                "historyList",
                historyList);

        request.getRequestDispatcher(
                "/WEB-INF/views/dashboard.jsp")
                .forward(request, response);
    }
}