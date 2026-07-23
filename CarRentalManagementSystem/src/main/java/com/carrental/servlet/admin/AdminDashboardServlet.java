package com.carrental.servlet.admin;

import com.carrental.dao.BookingDAO;
import com.carrental.dao.CarDAO;
import com.carrental.dao.UserDAO;
import com.carrental.model.Booking;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collections;
import java.util.List;

@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/admin/dashboard"})
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        CarDAO carDAO = CarDAO.getInstance();
        UserDAO userDAO = UserDAO.getInstance();
        BookingDAO bookingDAO = BookingDAO.getInstance();

        List<Booking> recentBookings = bookingDAO.getAllBookings();
        Collections.reverse(recentBookings);
        if (recentBookings.size() > 5) {
            recentBookings = recentBookings.subList(0, 5);
        }

        request.setAttribute("totalCars", carDAO.getTotalCars());
        request.setAttribute("availableCars", carDAO.getAvailableCarsCount());
        request.setAttribute("totalCustomers", userDAO.getTotalUsers());
        request.setAttribute("totalBookings", bookingDAO.getTotalBookings());
        request.setAttribute("activeBookings", bookingDAO.getActiveBookingsCount());
        request.setAttribute("totalRevenue", bookingDAO.getTotalRevenue());
        request.setAttribute("recentBookings", recentBookings);

        request.getRequestDispatcher("/WEB-INF/jsp/admin/adminDashboard.jsp").forward(request, response);
    }
}
