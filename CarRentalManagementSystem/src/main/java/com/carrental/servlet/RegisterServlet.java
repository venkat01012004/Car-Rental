package com.carrental.servlet;

import com.carrental.dao.UserDAO;
import com.carrental.model.User;
import com.carrental.util.ValidationUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Handles new customer registration and stores the account in the
 * in-memory UserDAO (backed by a HashMap).
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String address = request.getParameter("address");
        String drivingLicense = request.getParameter("drivingLicense");

        String error = validate(fullName, username, email, phone, password, confirmPassword);

        if (error != null) {
            request.setAttribute("error", error);
            request.setAttribute("fullName", fullName);
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);
            request.setAttribute("drivingLicense", drivingLicense);
            request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
            return;
        }

        UserDAO userDAO = UserDAO.getInstance();

        if (userDAO.usernameExists(username)) {
            request.setAttribute("error", "Username already taken. Please choose another one.");
            request.setAttribute("fullName", fullName);
            request.setAttribute("email", email);
            request.setAttribute("phone", phone);
            request.setAttribute("address", address);
            request.setAttribute("drivingLicense", drivingLicense);
            request.getRequestDispatcher("/WEB-INF/jsp/register.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setFullName(fullName.trim());
        user.setUsername(username.trim());
        user.setEmail(email.trim());
        user.setPhone(phone.trim());
        user.setPassword(password);
        user.setAddress(address == null ? "" : address.trim());
        user.setDrivingLicense(drivingLicense == null ? "" : drivingLicense.trim());

        userDAO.register(user);

        request.setAttribute("successMessage", "Registration successful! You can now log in.");
        request.getRequestDispatcher("/WEB-INF/jsp/login.jsp").forward(request, response);
    }

    private String validate(String fullName, String username, String email, String phone,
                             String password, String confirmPassword) {
        if (ValidationUtil.isEmpty(fullName) || ValidationUtil.isEmpty(username)
                || ValidationUtil.isEmpty(email) || ValidationUtil.isEmpty(phone)
                || ValidationUtil.isEmpty(password) || ValidationUtil.isEmpty(confirmPassword)) {
            return "All required fields must be filled in.";
        }
        if (!ValidationUtil.isValidEmail(email)) {
            return "Please enter a valid email address.";
        }
        if (!ValidationUtil.isValidPhone(phone)) {
            return "Please enter a valid 10-digit phone number.";
        }
        if (password.length() < 6) {
            return "Password must be at least 6 characters long.";
        }
        if (!password.equals(confirmPassword)) {
            return "Passwords do not match.";
        }
        return null;
    }
}
