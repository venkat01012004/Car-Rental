package com.carrental.filter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Ensures that only authenticated administrators can access the
 * admin dashboard, car management, customer management and
 * booking management pages.
 */
@WebFilter(urlPatterns = {"/admin/dashboard", "/admin/cars", "/admin/customers", "/admin/bookings"})
public class AdminAuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // no-op
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        boolean isAdmin = (session != null && Boolean.TRUE.equals(session.getAttribute("isAdmin")));

        if (isAdmin) {
            chain.doFilter(request, response);
        } else {
            String contextPath = httpRequest.getContextPath();
            httpResponse.sendRedirect(contextPath + "/admin/login");
        }
    }

    @Override
    public void destroy() {
        // no-op
    }
}
