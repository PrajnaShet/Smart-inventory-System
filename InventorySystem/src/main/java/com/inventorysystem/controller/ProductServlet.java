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

@WebServlet("/products")
public class ProductServlet extends HttpServlet {

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

        String action =
                request.getParameter("action");

        if(action == null){

            action = "list";
        }

        switch(action){

            case "delete":

                deleteProduct(request, response);
                break;

            case "edit":

                showEditProduct(request, response);
                break;

            case "search":

                searchProducts(request, response);
                break;

            default:

                listProducts(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action =
                request.getParameter("action");

        if(action == null){

            action = "add";
        }

        switch(action){

            case "update":

                updateProduct(request, response);
                break;

            default:

                addProduct(request, response);
                break;
        }
    }

    private void listProducts(HttpServletRequest request,
                              HttpServletResponse response)
            throws ServletException, IOException {

        List<Product> productList =
                productDAO.getAllProducts();

        List<Category> categoryList =
                categoryDAO.getAllCategories();

        request.setAttribute(
                "productList",
                productList);

        request.setAttribute(
                "categoryList",
                categoryList);

        request.getRequestDispatcher(
                "/WEB-INF/views/products.jsp")
                .forward(request, response);
    }

    private void addProduct(HttpServletRequest request,
                            HttpServletResponse response)
            throws IOException {

        String productName =
                request.getParameter("productName");

        int categoryId =
                Integer.parseInt(
                        request.getParameter("categoryId"));

        double price =
                Double.parseDouble(
                        request.getParameter("price"));

        int quantity =
                Integer.parseInt(
                        request.getParameter("quantity"));

        int minStock =
                Integer.parseInt(
                        request.getParameter("minStock"));

        String description =
                request.getParameter("description");

        Product product =
                new Product(
                        productName,
                        categoryId,
                        price,
                        quantity,
                        minStock,
                        description);

        productDAO.addProduct(product);
        
        HttpSession session =
                request.getSession();

        session.setAttribute(
                "successMessage",
                "Product added successfully!");

        response.sendRedirect(
                request.getContextPath()
                + "/products");
    }

    private void deleteProduct(HttpServletRequest request,
                               HttpServletResponse response)
            throws IOException {

        int productId =
                Integer.parseInt(
                        request.getParameter("id"));

        productDAO.deleteProduct(productId);
        
        HttpSession session =
                request.getSession();

        session.setAttribute(
                "successMessage",
                "Product deleted successfully!");

        response.sendRedirect(
                request.getContextPath()
                + "/products");
    }

    private void showEditProduct(HttpServletRequest request,
                                 HttpServletResponse response)
            throws ServletException, IOException {

        int productId =
                Integer.parseInt(
                        request.getParameter("id"));

        Product product =
                productDAO.getProductById(productId);

        List<Product> productList =
                productDAO.getAllProducts();

        List<Category> categoryList =
                categoryDAO.getAllCategories();

        request.setAttribute(
                "product",
                product);

        request.setAttribute(
                "productList",
                productList);

        request.setAttribute(
                "categoryList",
                categoryList);

        request.getRequestDispatcher(
                "/WEB-INF/views/products.jsp")
                .forward(request, response);
    }

    private void updateProduct(HttpServletRequest request,
                               HttpServletResponse response)
            throws IOException {

        int productId =
                Integer.parseInt(
                        request.getParameter("productId"));

        String productName =
                request.getParameter("productName");

        int categoryId =
                Integer.parseInt(
                        request.getParameter("categoryId"));

        double price =
                Double.parseDouble(
                        request.getParameter("price"));

        int quantity =
                Integer.parseInt(
                        request.getParameter("quantity"));

        int minStock =
                Integer.parseInt(
                        request.getParameter("minStock"));

        String description =
                request.getParameter("description");

        Product product =
                new Product(
                        productId,
                        productName,
                        categoryId,
                        price,
                        quantity,
                        minStock,
                        description,
                        null);

        productDAO.updateProduct(product);

        HttpSession session =
                request.getSession();

        session.setAttribute(
                "successMessage",
                "Product updated successfully!");
        
        response.sendRedirect(
                request.getContextPath()
                + "/products");
    }

    private void searchProducts(HttpServletRequest request,
                                HttpServletResponse response)
            throws ServletException, IOException {

        String keyword =
                request.getParameter("keyword");

        List<Product> productList =
                productDAO.searchProducts(keyword);

        List<Category> categoryList =
                categoryDAO.getAllCategories();

        request.setAttribute(
                "productList",
                productList);

        request.setAttribute(
                "categoryList",
                categoryList);

        request.getRequestDispatcher(
                "/WEB-INF/views/products.jsp")
                .forward(request, response);
    }
}