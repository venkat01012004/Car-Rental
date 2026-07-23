package com.carrental.servlet;

import com.carrental.dao.CarDAO;
import com.carrental.model.Car;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Allows customers to search and filter available cars by category,
 * location, maximum price, minimum seats and keyword.
 */
@WebServlet(name = "SearchServlet", urlPatterns = {"/search"})
public class SearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleSearch(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleSearch(request, response);
    }

    private void handleSearch(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        CarDAO carDAO = CarDAO.getInstance();

        String category = trimOrNull(request.getParameter("category"));
        String location = trimOrNull(request.getParameter("location"));
        String priceParam = trimOrNull(request.getParameter("maxPrice"));
        String seatsParam = trimOrNull(request.getParameter("minSeats"));
        String keyword = trimOrNull(request.getParameter("keyword"));

        Double maxPrice = null;
        Integer minSeats = null;

        try {
            if (priceParam != null) {
                maxPrice = Double.parseDouble(priceParam);
            }
        } catch (NumberFormatException ignored) {
            // ignore invalid input, treat as no filter
        }

        try {
            if (seatsParam != null) {
                minSeats = Integer.parseInt(seatsParam);
            }
        } catch (NumberFormatException ignored) {
            // ignore invalid input, treat as no filter
        }

        List<Car> results = carDAO.searchCars(category, location, maxPrice, minSeats, keyword);

        request.setAttribute("results", results);
        request.setAttribute("resultCount", results.size());
        request.setAttribute("category", category);
        request.setAttribute("location", location);
        request.setAttribute("maxPrice", priceParam);
        request.setAttribute("minSeats", seatsParam);
        request.setAttribute("keyword", keyword);
        request.setAttribute("categories", carDAO.getAllCategories());
        request.setAttribute("locations", carDAO.getAllLocations());

        request.getRequestDispatcher("/WEB-INF/jsp/search.jsp").forward(request, response);
    }

    private String trimOrNull(String value) {
        if (value == null) {
            return null;
        }
        String trimmed = value.trim();
        return trimmed.isEmpty() ? null : trimmed;
    }
}
