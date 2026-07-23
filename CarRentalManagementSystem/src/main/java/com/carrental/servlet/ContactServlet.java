package com.carrental.servlet;

import com.carrental.dao.ContactMessageDAO;
import com.carrental.model.ContactMessage;
import com.carrental.util.DateUtil;
import com.carrental.util.ValidationUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Handles the public Contact Us page: displays the form and stores
 * submitted messages in the in-memory ContactMessageDAO.
 */
@WebServlet(name = "ContactServlet", urlPatterns = {"/contact"})
public class ContactServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/jsp/contact.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        if (ValidationUtil.isEmpty(name) || !ValidationUtil.isValidEmail(email)
                || ValidationUtil.isEmpty(subject) || ValidationUtil.isEmpty(message)) {
            request.setAttribute("error", "Please fill in all fields with a valid email address.");
            request.setAttribute("name", name);
            request.setAttribute("email", email);
            request.setAttribute("subject", subject);
            request.setAttribute("message", message);
            request.getRequestDispatcher("/WEB-INF/jsp/contact.jsp").forward(request, response);
            return;
        }

        ContactMessage contactMessage = new ContactMessage();
        contactMessage.setName(name.trim());
        contactMessage.setEmail(email.trim());
        contactMessage.setSubject(subject.trim());
        contactMessage.setMessage(message.trim());
        contactMessage.setSubmittedDate(DateUtil.currentTimestamp());

        ContactMessageDAO.getInstance().addMessage(contactMessage);

        request.setAttribute("successMessage", "Thank you for reaching out! Our team will get back to you soon.");
        request.getRequestDispatcher("/WEB-INF/jsp/contact.jsp").forward(request, response);
    }
}
