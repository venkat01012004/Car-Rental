<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="Booking History | PrestigeWheels" scope="request" />
<jsp:include page="header.jsp" />

<section class="page-banner">
    <div class="container">
        <div class="section-eyebrow">My Account</div>
        <h2 class="fw-bold mb-1">Full Booking History</h2>
        <p class="text-secondary mb-0">Every reservation you've made with PrestigeWheels, in one place.</p>
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb small mb-0">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/profile">My Dashboard</a></li>
                <li class="breadcrumb-item active">Booking History</li>
            </ol>
        </nav>
    </div>
</section>

<section class="section-padding pt-5">
    <div class="container">
        <c:choose>
            <c:when test="${empty bookings}">
                <div class="dashboard-card text-center py-5 reveal">
                    <i class="bi bi-calendar-x text-muted" style="font-size: 3rem;"></i>
                    <h5 class="mt-3">You have no bookings yet</h5>
                    <p class="text-muted">Browse our fleet and book your first ride today.</p>
                    <a href="${pageContext.request.contextPath}/search" class="btn btn-ember btn-ripple px-4">Browse Cars</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-modern-wrap reveal" data-table-controller data-page-size="6">
                    <div class="table-modern-toolbar">
                        <h6 class="fw-bold mb-0"><i class="bi bi-journal-text text-ember"></i> All Bookings (${fn:length(bookings)})</h6>
                        <div class="table-search-box"><i class="bi bi-search"></i><input type="text" class="form-control form-control-sm" placeholder="Search bookings..." data-table-search></div>
                    </div>
                    <div class="table-responsive-modern">
                        <table class="table table-modern">
                            <thead><tr><th>Booking ID</th><th>Vehicle</th><th>Pickup</th><th>Return</th><th>Days</th><th>Total</th><th>Status</th></tr></thead>
                            <tbody>
                                <c:forEach var="b" items="${bookings}">
                                    <tr>
                                        <td class="fw-semibold">#${b.id}</td>
                                        <td><i class="bi bi-car-front-fill text-ember me-1"></i>${b.carBrand} ${b.carModel}</td>
                                        <td>${b.startDate}</td>
                                        <td>${b.endDate}</td>
                                        <td>${b.totalDays}</td>
                                        <td class="fw-semibold"><fmt:formatNumber value="${b.totalPrice}" type="currency" currencySymbol="₹"/></td>
                                        <td><span class="status-badge badge-status-${b.status}"><span class="dot"></span>${b.status}</span></td>
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
</section>

<jsp:include page="footer.jsp" />
