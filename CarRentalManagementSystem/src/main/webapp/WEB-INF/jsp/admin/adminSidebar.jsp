<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-lg-2 px-0 admin-sidebar">
    <div class="sidebar-heading">
        <div class="nav-avatar mx-auto mb-2" style="width: 52px; height: 52px; font-size: 1.3rem; border-radius: 16px;"><i class="bi bi-shield-lock-fill"></i></div>
        <div class="fw-bold text-light">Admin Panel</div>
        <div class="text-muted small">${sessionScope.adminUsername}</div>
    </div>
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="${activePage == 'dashboard' ? 'active' : ''}"><i class="bi bi-speedometer2"></i> Dashboard</a>
    <a href="${pageContext.request.contextPath}/admin/cars" class="${activePage == 'cars' ? 'active' : ''}"><i class="bi bi-car-front-fill"></i> Car Management</a>
    <a href="${pageContext.request.contextPath}/admin/customers" class="${activePage == 'customers' ? 'active' : ''}"><i class="bi bi-people-fill"></i> Customer Management</a>
    <a href="${pageContext.request.contextPath}/admin/bookings" class="${activePage == 'bookings' ? 'active' : ''}"><i class="bi bi-journal-check"></i> Booking Management</a>
    <hr class="border-secondary mx-4 opacity-25">
    <a href="${pageContext.request.contextPath}/home"><i class="bi bi-box-arrow-up-right"></i> View Site</a>
    <a href="${pageContext.request.contextPath}/admin/logout" class="text-danger"><i class="bi bi-box-arrow-right"></i> Logout</a>
</div>
