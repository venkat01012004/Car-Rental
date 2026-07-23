<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, com.carrental.dao.BookingDAO, com.carrental.model.Booking" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    // Read-only lookup against the existing BookingDAO to build an accurate
    // status-breakdown chart (no servlet or business logic changes).
    List<Booking> allBookingsForChart = BookingDAO.getInstance().getAllBookings();
    int confirmedCount = 0, pendingCount = 0, cancelledCount = 0, completedCount = 0;
    for (Booking b : allBookingsForChart) {
        String s = b.getStatus() == null ? "" : b.getStatus().toUpperCase();
        if (s.equals("CONFIRMED")) confirmedCount++;
        else if (s.equals("PENDING")) pendingCount++;
        else if (s.equals("CANCELLED")) cancelledCount++;
        else if (s.equals("COMPLETED")) completedCount++;
    }
    pageContext.setAttribute("confirmedCount", confirmedCount);
    pageContext.setAttribute("pendingCount", pendingCount);
    pageContext.setAttribute("cancelledCount", cancelledCount);
    pageContext.setAttribute("completedCount", completedCount);
%>
<c:set var="pageTitle" value="Admin Dashboard | PrestigeWheels" scope="request" />
<c:set var="activePage" value="dashboard" scope="request" />
<jsp:include page="../header.jsp" />

<div class="container-fluid">
    <div class="row">
        <jsp:include page="adminSidebar.jsp" />

        <div class="col-lg-10 admin-content">
            <div class="d-flex justify-content-between align-items-center flex-wrap gap-2 mb-4 reveal">
                <div>
                    <h3 class="fw-bold mb-1">Dashboard Overview</h3>
                    <p class="text-muted mb-0">Welcome back! Here's what's happening with PrestigeWheels today.</p>
                </div>
                <a href="${pageContext.request.contextPath}/admin/cars" class="btn btn-ember btn-ripple btn-sm"><i class="bi bi-plus-circle"></i> Add Vehicle</a>
            </div>

            <div class="row g-4">
                <div class="col-md-3 col-6 reveal reveal-delay-1">
                    <div class="stat-card icon-blue"><div class="stat-icon"><i class="bi bi-car-front-fill"></i></div><div><div class="stat-value"><span data-counter="${totalCars}">0</span></div><div class="stat-caption">Total Cars (${availableCars} available)</div></div></div>
                </div>
                <div class="col-md-3 col-6 reveal reveal-delay-2">
                    <div class="stat-card icon-green"><div class="stat-icon"><i class="bi bi-people-fill"></i></div><div><div class="stat-value"><span data-counter="${totalCustomers}">0</span></div><div class="stat-caption">Registered Customers</div></div></div>
                </div>
                <div class="col-md-3 col-6 reveal reveal-delay-3">
                    <div class="stat-card icon-orange"><div class="stat-icon"><i class="bi bi-journal-check"></i></div><div><div class="stat-value"><span data-counter="${totalBookings}">0</span></div><div class="stat-caption">Total Bookings (${activeBookings} active)</div></div></div>
                </div>
                <div class="col-md-3 col-6 reveal reveal-delay-4">
                    <div class="stat-card icon-purple"><div class="stat-icon"><i class="bi bi-cash-stack"></i></div><div><div class="stat-value">$<span data-counter="${totalRevenue}" data-decimals="0">0</span></div><div class="stat-caption">Total Revenue</div></div></div>
                </div>
            </div>

            <div class="row g-4 mt-1">
                <div class="col-lg-4 reveal">
                    <div class="dashboard-card h-100">
                        <h6 class="fw-bold mb-3"><i class="bi bi-pie-chart-fill text-ember"></i> Fleet Availability</h6>
                        <canvas id="fleetChart" height="200"></canvas>
                        <div class="d-flex justify-content-center gap-4 mt-3 small">
                            <span><span class="chart-legend-dot" style="background:#ff5a1f;"></span>Available (${availableCars})</span>
                            <span><span class="chart-legend-dot" style="background:#14141f;"></span>Booked (${totalCars - availableCars})</span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 reveal reveal-delay-1">
                    <div class="dashboard-card h-100">
                        <h6 class="fw-bold mb-3"><i class="bi bi-bar-chart-fill text-ember"></i> Booking Status Breakdown</h6>
                        <canvas id="statusChart" height="200"></canvas>
                    </div>
                </div>
                <div class="col-lg-4 reveal reveal-delay-2">
                    <div class="dashboard-card h-100">
                        <h6 class="fw-bold mb-3"><i class="bi bi-lightning-charge-fill text-ember"></i> Quick Actions</h6>
                        <div class="d-flex flex-column gap-2">
                            <a href="${pageContext.request.contextPath}/admin/cars" class="quick-action-btn"><i class="bi bi-car-front"></i> Manage Fleet</a>
                            <a href="${pageContext.request.contextPath}/admin/bookings" class="quick-action-btn"><i class="bi bi-journal-check"></i> Manage Bookings</a>
                            <a href="${pageContext.request.contextPath}/admin/customers" class="quick-action-btn"><i class="bi bi-people"></i> View Customers</a>
                            <a href="${pageContext.request.contextPath}/home" class="quick-action-btn"><i class="bi bi-box-arrow-up-right"></i> View Live Site</a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="dashboard-card mt-4 reveal reveal-delay-2">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h6 class="fw-bold mb-0"><i class="bi bi-clock-history text-ember"></i> Recent Bookings</h6>
                    <a href="${pageContext.request.contextPath}/admin/bookings" class="btn btn-sm btn-outline-ember">View All</a>
                </div>
                <c:choose>
                    <c:when test="${empty recentBookings}"><p class="text-muted mb-0">No bookings have been made yet.</p></c:when>
                    <c:otherwise>
                        <div class="table-responsive-modern">
                            <table class="table table-modern">
                                <thead><tr><th>ID</th><th>Customer</th><th>Vehicle</th><th>Dates</th><th>Total</th><th>Status</th></tr></thead>
                                <tbody>
                                    <c:forEach var="b" items="${recentBookings}">
                                        <tr>
                                            <td class="fw-semibold">#${b.id}</td>
                                            <td>${b.customerName}</td>
                                            <td>${b.carBrand} ${b.carModel}</td>
                                            <td>${b.startDate} &rarr; ${b.endDate}</td>
                                            <td class="fw-semibold"><fmt:formatNumber value="${b.totalPrice}" type="currency" currencySymbol="₹"/></td>
                                            <td><span class="status-badge badge-status-${b.status}"><span class="dot"></span>${b.status}</span></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.4/dist/chart.umd.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        var fleetCtx = document.getElementById('fleetChart');
        if (fleetCtx && window.Chart) {
            new Chart(fleetCtx, {
                type: 'doughnut',
                data: { labels: ['Available', 'Booked'], datasets: [{ data: [${availableCars}, ${totalCars - availableCars}], backgroundColor: ['#ff5a1f', '#14141f'], borderWidth: 0, hoverOffset: 8 }] },
                options: { cutout: '70%', plugins: { legend: { display: false } } }
            });
        }
        var statusCtx = document.getElementById('statusChart');
        if (statusCtx && window.Chart) {
            new Chart(statusCtx, {
                type: 'bar',
                data: {
                    labels: ['Confirmed', 'Pending', 'Completed', 'Cancelled'],
                    datasets: [{
                        data: [${confirmedCount}, ${pendingCount}, ${completedCount}, ${cancelledCount}],
                        backgroundColor: ['#16a34a', '#fd7e14', '#0891b2', '#dc3545'],
                        borderRadius: 8, maxBarThickness: 36
                    }]
                },
                options: { plugins: { legend: { display: false } }, scales: { y: { beginAtZero: true, ticks: { precision: 0 } } } }
            });
        }
    });
</script>

<jsp:include page="../footer.jsp" />
