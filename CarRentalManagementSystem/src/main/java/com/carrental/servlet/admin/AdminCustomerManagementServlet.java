package com.carrental.servlet.admin;

import com.carrental.dao.UserDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Admin view of all registered customers (Customer Management feature).
 */
@WebServlet(name = "AdminCustomerManagementServlet", urlPatterns = {"/admin/customers"})
public class AdminCustomerManagementServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        UserDAO userDAO = UserDAO.getInstance();

        if ("delete".equalsIgnoreCase(action)) {
            String username = request.getParameter("username");
            if (username != null) {
                userDAO.deleteUser(username);
            }
            response.sendRedirect(request.getContextPath() + "/admin/customers");
            return;
        }

        request.setAttribute("customers", userDAO.getAllUsers());
        request.getRequestDispatcher("/WEB-INF/jsp/admin/adminCustomers.jsp").forward(request, response);
    }
}
