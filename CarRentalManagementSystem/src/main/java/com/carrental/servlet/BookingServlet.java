package com.carrental.servlet;

import com.carrental.dao.BookingDAO;
import com.carrental.dao.CarDAO;
import com.carrental.model.Booking;
import com.carrental.model.Car;
import com.carrental.model.User;
import com.carrental.util.DateUtil;
import com.carrental.util.ValidationUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "BookingServlet", urlPatterns = {"/booking"})
public class BookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("carId");
        Car car = null;
        try {
            if (idParam != null) {
                car = CarDAO.getInstance().getCarById(Integer.parseInt(idParam));
            }
        } catch (NumberFormatException ignored) {
        }

        if (car == null) {
            request.setAttribute("errorMessage", "Please select a valid car to book.");
            request.getRequestDispatcher("/WEB-INF/jsp/error.jsp").forward(request, response);
            return;
        }

        request.setAttribute("car", car);
        request.getRequestDispatcher("/WEB-INF/jsp/booking.jsp").forward(request, response);
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

        String carIdParam = request.getParameter("carId");
        String pickupLocation = request.getParameter("pickupLocation");
        String dropLocation = request.getParameter("dropLocation");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String customerName = request.getParameter("customerName");
        String customerPhone = request.getParameter("customerPhone");

        Car car = null;
        try {
            car = CarDAO.getInstance().getCarById(Integer.parseInt(carIdParam));
        } catch (NumberFormatException ignored) {
        }

        String error = null;
        if (car == null) {
            error = "Invalid car selection.";
        } else if (ValidationUtil.isEmpty(pickupLocation) || ValidationUtil.isEmpty(dropLocation)
                || ValidationUtil.isEmpty(startDate) || ValidationUtil.isEmpty(endDate)
                || ValidationUtil.isEmpty(customerName) || !ValidationUtil.isValidPhone(customerPhone)) {
            error = "Please fill in all fields correctly, including a valid 10-digit phone number.";
        } else if (!DateUtil.isValidDateOrder(startDate, endDate)) {
            error = "The return date must be after the pickup date.";
        }

        if (error != null) {
            request.setAttribute("car", car);
            request.setAttribute("error", error);
            request.getRequestDispatcher("/WEB-INF/jsp/booking.jsp").forward(request, response);
            return;
        }

        long totalDays;
        try {
            totalDays = DateUtil.daysBetween(startDate, endDate);
        } catch (Exception e) {
            totalDays = 1;
        }

        double totalPrice = totalDays * car.getPricePerDay();

        Booking booking = new Booking();
        booking.setUsername(user.getUsername());
        booking.setCarId(car.getId());
        booking.setCarBrand(car.getBrand());
        booking.setCarModel(car.getModel());
        booking.setPickupLocation(pickupLocation.trim());
        booking.setDropLocation(dropLocation.trim());
        booking.setStartDate(startDate);
        booking.setEndDate(endDate);
        booking.setTotalDays(totalDays);
        booking.setPricePerDay(car.getPricePerDay());
        booking.setTotalPrice(totalPrice);
        booking.setStatus("CONFIRMED");
        booking.setBookingDate(DateUtil.currentTimestamp());
        booking.setCustomerName(customerName.trim());
        booking.setCustomerPhone(customerPhone.trim());

        Booking saved = BookingDAO.getInstance().createBooking(booking);

        session.setAttribute("lastBookingId", saved.getId());
        response.sendRedirect(request.getContextPath() + "/booking-confirmation?id=" + saved.getId());
    }
}
