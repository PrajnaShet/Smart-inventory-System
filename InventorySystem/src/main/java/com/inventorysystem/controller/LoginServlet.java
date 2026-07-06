package com.inventorysystem.controller;

import java.io.IOException;

import com.inventorysystem.dao.AdminDAO;
import com.inventorysystem.dao.impl.AdminDAOImpl;
import com.inventorysystem.model.Admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private AdminDAO adminDAO;

    @Override
    public void init() throws ServletException {

        adminDAO = new AdminDAOImpl();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String username =
                request.getParameter("username");

        String password =
                request.getParameter("password");

        Admin admin =
                adminDAO.login(username, password);

        if (admin != null) {

            HttpSession session =
                    request.getSession();

            session.setAttribute("loggedInAdmin",
                    admin);

            response.sendRedirect(
                    request.getContextPath()
                    + "/dashboard");

        } else {

            request.setAttribute(
                    "errorMessage",
                    "Invalid Username or Password!");

            request.getRequestDispatcher(
                    "/WEB-INF/views/login.jsp")
                    .forward(request, response);
        }
    }
}