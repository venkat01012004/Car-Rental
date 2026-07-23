package com.carrental.servlet;

import com.carrental.dao.CarDAO;
import com.carrental.model.Car;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Displays the full detail page for a single car, identified by the
 * "id" request parameter.
 */
@WebServlet(name = "CarDetailsServlet", urlPatterns = {"/car-details"})
public class CarDetailsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        Car car = null;

        if (idParam != null) {
            try {
                int id = Integer.parseInt(idParam);
                car = CarDAO.getInstance().getCarById(id);
            } catch (NumberFormatException ignored) {
                car = null;
            }
        }

        if (car == null) {
            request.setAttribute("errorMessage", "The requested car could not be found.");
            request.getRequestDispatcher("/WEB-INF/jsp/error.jsp").forward(request, response);
            return;
        }

        request.setAttribute("car", car);
        request.getRequestDispatcher("/WEB-INF/jsp/carDetails.jsp").forward(request, response);
    }
}
