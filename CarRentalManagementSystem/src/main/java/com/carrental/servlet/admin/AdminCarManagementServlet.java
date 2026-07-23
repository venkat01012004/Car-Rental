package com.carrental.servlet.admin;

import com.carrental.dao.CarDAO;
import com.carrental.model.Car;
import com.carrental.util.ValidationUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Admin CRUD management for the car fleet (Car Management feature).
 * Actions are dispatched via the "action" request parameter:
 * add, update, delete, toggle.
 */
@WebServlet(name = "AdminCarManagementServlet", urlPatterns = {"/admin/cars"})
public class AdminCarManagementServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        CarDAO carDAO = CarDAO.getInstance();

        if ("delete".equalsIgnoreCase(action)) {
            String idParam = request.getParameter("id");
            try {
                carDAO.deleteCar(Integer.parseInt(idParam));
            } catch (NumberFormatException ignored) {
            }
            response.sendRedirect(request.getContextPath() + "/admin/cars");
            return;
        }

        if ("toggle".equalsIgnoreCase(action)) {
            String idParam = request.getParameter("id");
            try {
                Car car = carDAO.getCarById(Integer.parseInt(idParam));
                if (car != null) {
                    car.setAvailable(!car.isAvailable());
                    carDAO.updateCar(car);
                }
            } catch (NumberFormatException ignored) {
            }
            response.sendRedirect(request.getContextPath() + "/admin/cars");
            return;
        }

        if ("edit".equalsIgnoreCase(action)) {
            String idParam = request.getParameter("id");
            try {
                Car car = carDAO.getCarById(Integer.parseInt(idParam));
                request.setAttribute("editCar", car);
            } catch (NumberFormatException ignored) {
            }
        }

        request.setAttribute("cars", carDAO.getAllCars());
        request.getRequestDispatcher("/WEB-INF/jsp/admin/adminCars.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        CarDAO carDAO = CarDAO.getInstance();
        String action = request.getParameter("action");

        String brand = request.getParameter("brand");
        String model = request.getParameter("model");
        String category = request.getParameter("category");
        String priceParam = request.getParameter("pricePerDay");
        String seatsParam = request.getParameter("seats");
        String fuelType = request.getParameter("fuelType");
        String transmission = request.getParameter("transmission");
        String imageUrl = request.getParameter("imageUrl");
        String description = request.getParameter("description");
        String location = request.getParameter("location");

        if (ValidationUtil.isEmpty(brand) || ValidationUtil.isEmpty(model)
                || ValidationUtil.isEmpty(category) || ValidationUtil.isEmpty(priceParam)
                || ValidationUtil.isEmpty(seatsParam)) {
            request.setAttribute("error", "Please fill in all required car fields.");
            request.setAttribute("cars", carDAO.getAllCars());
            request.getRequestDispatcher("/WEB-INF/jsp/admin/adminCars.jsp").forward(request, response);
            return;
        }

        double price;
        int seats;
        try {
            price = Double.parseDouble(priceParam);
            seats = Integer.parseInt(seatsParam);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Price and seats must be valid numbers.");
            request.setAttribute("cars", carDAO.getAllCars());
            request.getRequestDispatcher("/WEB-INF/jsp/admin/adminCars.jsp").forward(request, response);
            return;
        }

        if ("update".equalsIgnoreCase(action)) {
            String idParam = request.getParameter("id");
            try {
                int id = Integer.parseInt(idParam);
                Car car = carDAO.getCarById(id);
                if (car != null) {
                    car.setBrand(brand.trim());
                    car.setModel(model.trim());
                    car.setCategory(category.trim());
                    car.setPricePerDay(price);
                    car.setSeats(seats);
                    car.setFuelType(fuelType);
                    car.setTransmission(transmission);
                    car.setImageUrl(ValidationUtil.isEmpty(imageUrl) ? car.getImageUrl() : imageUrl.trim());
                    car.setDescription(description == null ? "" : description.trim());
                    car.setLocation(location == null ? car.getLocation() : location.trim());
                    carDAO.updateCar(car);
                }
            } catch (NumberFormatException ignored) {
            }
        } else {
            Car car = new Car();
            car.setBrand(brand.trim());
            car.setModel(model.trim());
            car.setCategory(category.trim());
            car.setPricePerDay(price);
            car.setSeats(seats);
            car.setFuelType(fuelType);
            car.setTransmission(transmission);
            car.setImageUrl(ValidationUtil.isEmpty(imageUrl) ? "assets/images/car-default.svg" : imageUrl.trim());
            car.setAvailable(true);
            car.setDescription(description == null ? "" : description.trim());
            car.setRating(4.5);
            car.setLocation(ValidationUtil.isEmpty(location) ? "Hyderabad" : location.trim());
            carDAO.addCar(car);
        }

        response.sendRedirect(request.getContextPath() + "/admin/cars");
    }
}
