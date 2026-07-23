<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="Booking Management | PrestigeWheels" scope="request" />
<c:set var="activePage" value="bookings" scope="request" />
<jsp:include page="../header.jsp" />

<div class="container-fluid">
    <div class="row">
        <jsp:include page="adminSidebar.jsp" />

        <div class="col-lg-10 admin-content">
            <div class="mb-4 reveal"><h3 class="fw-bold mb-1">Booking Management</h3><p class="text-muted mb-0">Confirm, cancel, complete, or remove customer bookings.</p></div>

            <c:choose>
                <c:when test="${empty bookings}">
                    <div class="dashboard-card text-center py-5 reveal"><i class="bi bi-journal-x text-muted" style="font-size: 3rem;"></i><h5 class="mt-3">No bookings yet</h5><p class="text-muted mb-0">Customer bookings will appear here.</p></div>
                </c:when>
                <c:otherwise>
                    <div class="table-modern-wrap reveal" data-table-controller data-page-size="8">
                        <div class="table-modern-toolbar">
                            <h6 class="fw-bold mb-0"><i class="bi bi-journal-check text-ember"></i> Bookings (${fn:length(bookings)})</h6>
                            <div class="table-search-box"><i class="bi bi-search"></i><input type="text" class="form-control form-control-sm" placeholder="Search bookings..." data-table-search></div>
                        </div>
                        <div class="table-responsive-modern">
                            <table class="table table-modern">
                                <thead><tr><th>ID</th><th>Customer</th><th>Vehicle</th><th>Pickup</th><th>Return</th><th>Total</th><th>Status</th><th>Actions</th></tr></thead>
                                <tbody>
                                    <c:forEach var="b" items="${bookings}">
                                        <tr>
                                            <td class="fw-semibold">#${b.id}</td>
                                            <td>${b.customerName}<br><small class="text-muted">@${b.username}</small></td>
                                            <td><i class="bi bi-car-front-fill text-ember me-1"></i>${b.carBrand} ${b.carModel}</td>
                                            <td>${b.startDate}</td>
                                            <td>${b.endDate}</td>
                                            <td class="fw-semibold"><fmt:formatNumber value="${b.totalPrice}" type="currency" currencySymbol="₹"/></td>
                                            <td><span class="status-badge badge-status-${b.status}"><span class="dot"></span>${b.status}</span></td>
                                            <td class="text-nowrap">
                                                <a href="${pageContext.request.contextPath}/admin/bookings?action=confirm&id=${b.id}" class="table-action-icon success" title="Confirm"><i class="bi bi-check-lg"></i></a>
                                                <a href="${pageContext.request.contextPath}/admin/bookings?action=complete&id=${b.id}" class="table-action-icon info" title="Complete"><i class="bi bi-flag-fill"></i></a>
                                                <a href="${pageContext.request.contextPath}/admin/bookings?action=cancel&id=${b.id}" class="table-action-icon warn" title="Cancel"><i class="bi bi-x-lg"></i></a>
                                                <a href="${pageContext.request.contextPath}/admin/bookings?action=delete&id=${b.id}" class="table-action-icon danger" title="Delete" onclick="return confirm('Delete this booking?');"><i class="bi bi-trash"></i></a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div class="table-pagination" data-table-pagination></div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />
