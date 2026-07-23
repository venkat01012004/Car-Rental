<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Booking Confirmed | PrestigeWheels" scope="request" />
<jsp:include page="header.jsp" />

<section class="pt-5">
    <div class="container">
        <div class="success-hero reveal" id="confettiHost" style="position: relative;">
            <img src="https://images.unsplash.com/photo-1610099610040-ab19f3a5ec35?auto=format&fit=crop&w=1600&q=80" alt="Premium car ready for pickup">
            <div class="overlay"></div>
            <div class="content">
                <div class="success-check"><i class="bi bi-check-lg"></i></div>
                <h2 class="fw-bold">Booking Confirmed!</h2>
                <p class="text-light mb-0" style="opacity:.85;">Your reservation has been placed successfully.</p>
            </div>
        </div>
    </div>
</section>

<section class="section-padding pt-5">
    <div class="container">
        <div class="dashboard-card mx-auto reveal" style="max-width: 720px;">
            <div class="d-flex justify-content-between align-items-center border-bottom pb-3 mb-3 flex-wrap gap-2">
                <h5 class="fw-bold mb-0">Booking #${booking.id}</h5>
                <span class="status-badge badge-status-${booking.status}"><span class="dot"></span>${booking.status}</span>
            </div>

            <div class="row g-4">
                <div class="col-6"><div class="small text-muted"><i class="bi bi-car-front-fill text-ember me-1"></i>Vehicle</div><div class="fw-semibold">${booking.carBrand} ${booking.carModel}</div></div>
                <div class="col-6"><div class="small text-muted"><i class="bi bi-person-fill text-ember me-1"></i>Customer</div><div class="fw-semibold">${booking.customerName}</div></div>
                <div class="col-6"><div class="small text-muted"><i class="bi bi-geo-alt-fill text-ember me-1"></i>Pickup Location</div><div class="fw-semibold">${booking.pickupLocation}</div></div>
                <div class="col-6"><div class="small text-muted"><i class="bi bi-geo-alt text-ember me-1"></i>Drop-off Location</div><div class="fw-semibold">${booking.dropLocation}</div></div>
                <div class="col-6"><div class="small text-muted"><i class="bi bi-calendar-event text-ember me-1"></i>Pickup Date</div><div class="fw-semibold">${booking.startDate}</div></div>
                <div class="col-6"><div class="small text-muted"><i class="bi bi-calendar-check text-ember me-1"></i>Return Date</div><div class="fw-semibold">${booking.endDate}</div></div>
                <div class="col-6"><div class="small text-muted"><i class="bi bi-clock-history text-ember me-1"></i>Total Days</div><div class="fw-semibold">${booking.totalDays}</div></div>
                <div class="col-6"><div class="small text-muted"><i class="bi bi-telephone-fill text-ember me-1"></i>Contact Number</div><div class="fw-semibold">${booking.customerPhone}</div></div>
            </div>

            <hr class="my-4">

            <div class="d-flex justify-content-between align-items-center flex-wrap gap-2">
                <div><span class="fw-bold fs-5 d-block">Total Amount</span><small class="text-muted">Booked on ${booking.bookingDate}</small></div>
                <span class="fw-bold fs-3 text-ember"><fmt:formatNumber value="${booking.totalPrice}" type="currency" currencySymbol="₹"/></span>
            </div>

            <div class="alert alert-light border mt-4 mb-0 small">
                <i class="bi bi-credit-card-2-front text-ember"></i> Payment Status:
                <span class="fw-semibold text-success">Confirmed &mdash; Pay at Pickup Counter</span>
            </div>
        </div>

        <div class="text-center mt-4 reveal">
            <a href="${pageContext.request.contextPath}/profile" class="btn btn-ember btn-ripple px-4">Go to My Dashboard</a>
            <a href="${pageContext.request.contextPath}/search" class="btn btn-outline-ember btn-ripple px-4">Book Another Car</a>
        </div>
    </div>
</section>

<jsp:include page="footer.jsp" />
