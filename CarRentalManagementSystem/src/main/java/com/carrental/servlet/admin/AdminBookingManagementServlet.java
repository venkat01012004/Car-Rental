package com.carrental.servlet.admin;

import com.carrental.dao.BookingDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collections;
import java.util.List;
import com.carrental.model.Booking;

/**
 * Admin view for managing bookings: confirm, cancel, mark completed
 * or delete (Booking Management feature).
 */
@WebServlet(name = "AdminBookingManagementServlet", urlPatterns = {"/admin/bookings"})
public class AdminBookingManagementServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        BookingDAO bookingDAO = BookingDAO.getInstance();

        if (action != null) {
            String idParam = request.getParameter("id");
            try {
                int id = Integer.parseInt(idParam);
                switch (action.toLowerCase()) {
                    case "confirm":
                        bookingDAO.updateStatus(id, "CONFIRMED");
                        break;
                    case "cancel":
                        bookingDAO.updateStatus(id, "CANCELLED");
                        break;
                    case "complete":
                        bookingDAO.updateStatus(id, "COMPLETED");
                        break;
                    case "delete":
                        bookingDAO.deleteBooking(id);
                        break;
                    default:
                        break;
                }
            } catch (NumberFormatException ignored) {
            }
            response.sendRedirect(request.getContextPath() + "/admin/bookings");
            return;
        }

        List<Booking> bookings = bookingDAO.getAllBookings();
        Collections.reverse(bookings);
        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("/WEB-INF/jsp/admin/adminBookings.jsp").forward(request, response);
    }
}
