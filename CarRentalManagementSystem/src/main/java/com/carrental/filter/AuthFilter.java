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
 * Ensures that only authenticated (logged-in) customers can access
 * booking, booking history and profile pages. Redirects to login
 * with a "redirect" parameter otherwise.
 */
@WebFilter(urlPatterns = {"/booking", "/booking-confirmation", "/booking-history", "/profile"})
public class AuthFilter implements Filter {

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

        boolean loggedIn = (session != null && session.getAttribute("loggedInUser") != null);

        if (loggedIn) {
            chain.doFilter(request, response);
        } else {
            String contextPath = httpRequest.getContextPath();
            String requestedUri = httpRequest.getRequestURI();
            httpResponse.sendRedirect(contextPath + "/login?redirect=" + requestedUri);
        }
    }

    @Override
    public void destroy() {
        // no-op
    }
}
