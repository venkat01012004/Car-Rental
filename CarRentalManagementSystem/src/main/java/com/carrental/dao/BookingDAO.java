package com.carrental.dao;

import com.carrental.model.Booking;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * In-memory Data Access Object for Booking entities.
 * Uses an ArrayList to store all bookings. Thread-safe singleton.
 */
public class BookingDAO {

    private static final BookingDAO INSTANCE = new BookingDAO();

    private final List<Booking> bookings = new ArrayList<>();
    private final AtomicInteger idGenerator = new AtomicInteger(5000);

    private BookingDAO() {
    }

    public static BookingDAO getInstance() {
        return INSTANCE;
    }

    public synchronized Booking createBooking(Booking booking) {
        booking.setId(idGenerator.incrementAndGet());
        if (booking.getStatus() == null) {
            booking.setStatus("CONFIRMED");
        }
        bookings.add(booking);
        return booking;
    }

    public synchronized List<Booking> getAllBookings() {
        return new ArrayList<>(bookings);
    }

    public synchronized List<Booking> getBookingsByUsername(String username) {
        List<Booking> result = new ArrayList<>();
        for (Booking booking : bookings) {
            if (booking.getUsername().equalsIgnoreCase(username)) {
                result.add(booking);
            }
        }
        return result;
    }

    public synchronized Booking getBookingById(int id) {
        for (Booking booking : bookings) {
            if (booking.getId() == id) {
                return booking;
            }
        }
        return null;
    }

    public synchronized boolean updateStatus(int id, String status) {
        Booking booking = getBookingById(id);
        if (booking != null) {
            booking.setStatus(status);
            return true;
        }
        return false;
    }

    public synchronized boolean deleteBooking(int id) {
        return bookings.removeIf(b -> b.getId() == id);
    }

    public synchronized int getTotalBookings() {
        return bookings.size();
    }

    public synchronized double getTotalRevenue() {
        double total = 0;
        for (Booking booking : bookings) {
            if (!"CANCELLED".equalsIgnoreCase(booking.getStatus())) {
                total += booking.getTotalPrice();
            }
        }
        return total;
    }

    public synchronized int getActiveBookingsCount() {
        int count = 0;
        for (Booking booking : bookings) {
            if ("CONFIRMED".equalsIgnoreCase(booking.getStatus())) {
                count++;
            }
        }
        return count;
    }
}
