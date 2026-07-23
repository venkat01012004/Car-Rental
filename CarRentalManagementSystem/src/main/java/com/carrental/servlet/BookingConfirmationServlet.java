package com.carrental.servlet;

import com.carrental.dao.BookingDAO;
import com.carrental.model.Booking;
import com.carrental.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "BookingConfirmationServlet", urlPatterns = {"/booking-confirmation"})
public class BookingConfirmationServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String idParam = request.getParameter("id");
        Booking booking = null;
        try {
            if (idParam != null) {
                booking = BookingDAO.getInstance().getBookingById(Integer.parseInt(idParam));
            }
        } catch (NumberFormatException ignored) {
        }

        if (booking == null || !booking.getUsername().equalsIgnoreCase(user.getUsername())) {
            request.setAttribute("errorMessage", "Booking not found.");
            request.getRequestDispatcher("/WEB-INF/jsp/error.jsp").forward(request, response);
            return;
        }

        request.setAttribute("booking", booking);
        request.getRequestDispatcher("/WEB-INF/jsp/bookingConfirmation.jsp").forward(request, response);
    }
}
