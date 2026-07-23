package com.carrental.servlet;

import com.carrental.dao.UserDAO;
import com.carrental.model.User;
import com.carrental.util.ValidationUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.setAttribute("user", user);
        request.getRequestDispatcher("/WEB-INF/jsp/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String drivingLicense = request.getParameter("drivingLicense");

        if (ValidationUtil.isEmpty(fullName) || !ValidationUtil.isValidEmail(email)
                || !ValidationUtil.isValidPhone(phone)) {
            request.setAttribute("error", "Please provide a valid name, email and 10-digit phone number.");
            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/jsp/profile.jsp").forward(request, response);
            return;
        }

        user.setFullName(fullName.trim());
        user.setEmail(email.trim());
        user.setPhone(phone.trim());
        user.setAddress(address == null ? "" : address.trim());
        user.setDrivingLicense(drivingLicense == null ? "" : drivingLicense.trim());

        UserDAO.getInstance().updateUser(user);
        session.setAttribute("loggedInUser", user);

        request.setAttribute("successMessage", "Profile updated successfully.");
        request.setAttribute("user", user);
        request.getRequestDispatcher("/WEB-INF/jsp/profile.jsp").forward(request, response);
    }
}
