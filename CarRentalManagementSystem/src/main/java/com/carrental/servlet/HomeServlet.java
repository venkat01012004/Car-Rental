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
 * Serves the premium home page, displaying a hero banner,
 * featured cars and quick highlights of the platform.
 */
@WebServlet(name = "HomeServlet", urlPatterns = {"", "/home"})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        CarDAO carDAO = CarDAO.getInstance();
        List<Car> featuredCars = carDAO.getFeaturedCars(6);

        request.setAttribute("featuredCars", featuredCars);
        request.setAttribute("totalCars", carDAO.getTotalCars());
        request.setAttribute("categories", carDAO.getAllCategories());
        request.setAttribute("locations", carDAO.getAllLocations());

        request.getRequestDispatcher("/WEB-INF/jsp/home.jsp").forward(request, response);
    }
}
