package com.inventorysystem.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.inventorysystem.dao.CategoryDAO;
import com.inventorysystem.dao.ProductDAO;
import com.inventorysystem.dao.StockHistoryDAO;
import com.inventorysystem.dao.impl.CategoryDAOImpl;
import com.inventorysystem.dao.impl.ProductDAOImpl;
import com.inventorysystem.dao.impl.StockHistoryDAOImpl;
import com.inventorysystem.model.Category;
import com.inventorysystem.model.Product;
import com.inventorysystem.model.StockHistory;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ai-insights")
public class AIInsightsServlet extends HttpServlet {

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
                    request.getContextPath());

            return;
        }

        List<Product> productList =
                productDAO.getAllProducts();

        List<Category> categoryList =
                categoryDAO.getAllCategories();

        List<StockHistory> historyList =
                stockHistoryDAO.getAllStockHistory();

        // Total Inventory Value
        double totalInventoryValue = 0;

        for(Product product : productList){

            totalInventoryValue +=
                    product.getPrice()
                    * product.getQuantity();
        }

        // Low Stock Count
        int lowStockCount =
                productDAO.getLowStockProducts().size();

        // Healthy Stock Count
        int healthyStockCount =
                productList.size() - lowStockCount;

        // Product Activity Count
        Map<Integer, Integer> activityMap =
                new HashMap<>();

        for(StockHistory history : historyList){

            int productId =
                    history.getProductId();

            activityMap.put(
                    productId,
                    activityMap.getOrDefault(
                            productId,
                            0) + 1);
        }

        // Most Active Product
        Product mostActiveProduct = null;

        int maxActivity = 0;

        for(Product product : productList){

            int count =
                    activityMap.getOrDefault(
                            product.getProductId(),
                            0);

            if(count > maxActivity){

                maxActivity = count;

                mostActiveProduct = product;
            }
        }

        request.setAttribute(
                "productList",
                productList);

        request.setAttribute(
                "categoryList",
                categoryList);

        request.setAttribute(
                "historyList",
                historyList);

        request.setAttribute(
                "totalInventoryValue",
                totalInventoryValue);

        request.setAttribute(
                "lowStockCount",
                lowStockCount);

        request.setAttribute(
                "healthyStockCount",
                healthyStockCount);

        request.setAttribute(
                "mostActiveProduct",
                mostActiveProduct);

        request.setAttribute(
                "totalProducts",
                productList.size());

        request.setAttribute(
                "totalCategories",
                categoryList.size());

        request.getRequestDispatcher(
                "/WEB-INF/views/ai_insights.jsp")
                .forward(request, response);
    }
}