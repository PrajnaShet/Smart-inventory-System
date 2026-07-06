package com.inventorysystem.controller;

import java.io.IOException;
import java.util.List;

import com.inventorysystem.dao.ProductDAO;
import com.inventorysystem.dao.StockHistoryDAO;
import com.inventorysystem.dao.impl.ProductDAOImpl;
import com.inventorysystem.dao.impl.StockHistoryDAOImpl;
import com.inventorysystem.model.Product;
import com.inventorysystem.model.StockHistory;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/stock")
public class StockServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ProductDAO productDAO;
    private StockHistoryDAO stockHistoryDAO;

    @Override
    public void init() throws ServletException {

        productDAO = new ProductDAOImpl();
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

        List<StockHistory> historyList =
                stockHistoryDAO.getAllStockHistory();

        request.setAttribute(
                "productList",
                productList);

        request.setAttribute(
                "historyList",
                historyList);

        request.getRequestDispatcher(
                "/WEB-INF/views/stock.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        int productId =
                Integer.parseInt(
                        request.getParameter("productId"));

        String changeType =
                request.getParameter("changeType");

        int quantity =
                Integer.parseInt(
                        request.getParameter("quantity"));

        Product product =
                productDAO.getProductById(productId);

        if(product != null){

            int currentQuantity =
                    product.getQuantity();

            if(changeType.equals("OUT")
                    && quantity > currentQuantity){

                request.setAttribute(
                        "errorMessage",
                        "Insufficient stock available!");

                doGet(request, response);

                return;
            }

            int finalQuantity =
                    changeType.equals("IN")
                    ? quantity
                    : -quantity;

            productDAO.updateStock(
                    productId,
                    finalQuantity);

            StockHistory history =
                    new StockHistory(
                            productId,
                            changeType,
                            quantity);

            stockHistoryDAO.addStockHistory(history);
        }

        response.sendRedirect(
                request.getContextPath()
                + "/stock");
    }
}