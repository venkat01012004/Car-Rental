<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="pageTitle" value="Book ${car.brand} ${car.model} | PrestigeWheels" scope="request" />
<jsp:include page="header.jsp" />

<section class="page-banner pb-4">
    <div class="container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb small mb-2">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Home</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/car-details?id=${car.id}">${car.brand} ${car.model}</a></li>
                <li class="breadcrumb-item active">Book Now</li>
            </ol>
        </nav>
        <h2 class="fw-bold mb-0">Complete Your Booking</h2>
    </div>
</section>

<section class="section-padding pt-4">
    <div class="container">

        <div class="step-progress reveal">
            <div class="step done"><div class="circle"><i class="bi bi-check-lg"></i></div><div class="label">Select Car</div></div>
            <div class="step active"><div class="circle">2</div><div class="label">Booking Details</div></div>
            <div class="step"><div class="circle">3</div><div class="label">Confirmation</div></div>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-auto-dismiss"><i class="bi bi-exclamation-circle me-2"></i>${error}</div>
        </c:if>

        <div class="row g-4">
            <div class="col-lg-7 reveal">
                <div class="dashboard-card">
                    <h5 class="fw-bold mb-4"><i class="bi bi-person-lines-fill text-ember"></i> Renter &amp; Trip Details</h5>
                    <form action="${pageContext.request.contextPath}/booking" method="post" class="row g-3 needs-validation" novalidate>
                        <input type="hidden" name="carId" value="${car.id}">
                        <input type="hidden" id="pricePerDay" value="${car.pricePerDay}">

                        <div class="col-md-6">
                            <div class="input-icon-group form-floating">
                                <i class="bi bi-person form-icon"></i>
                                <input type="text" id="customerName" name="customerName" class="form-control" placeholder="Full Name" value="${sessionScope.loggedInUser.fullName}" required>
                                <label for="customerName">Full Name</label>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="input-icon-group form-floating">
                                <i class="bi bi-telephone form-icon"></i>
                                <input type="text" id="customerPhone" name="customerPhone" class="form-control" placeholder="Phone" pattern="[0-9]{10}" value="${sessionScope.loggedInUser.phone}" required>
                                <label for="customerPhone">Phone Number</label>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="input-icon-group form-floating">
                                <i class="bi bi-geo-alt form-icon"></i>
                                <input type="text" id="pickupLocation" name="pickupLocation" class="form-control" placeholder="Pickup Location" value="${car.location}" required>
                                <label for="pickupLocation">Pickup Location</label>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="input-icon-group form-floating">
                                <i class="bi bi-geo-alt-fill form-icon"></i>
                                <input type="text" id="dropLocation" name="dropLocation" class="form-control" placeholder="Drop-off Location" value="${car.location}" required>
                                <label for="dropLocation">Drop-off Location</label>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="input-icon-group form-floating">
                                <i class="bi bi-calendar-event form-icon"></i>
                                <input type="date" id="startDate" name="startDate" class="form-control" placeholder="Pickup Date" required>
                                <label for="startDate">Pickup Date</label>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="input-icon-group form-floating">
                                <i class="bi bi-calendar-check form-icon"></i>
                                <input type="date" id="endDate" name="endDate" class="form-control" placeholder="Return Date" required>
                                <label for="endDate">Return Date</label>
                            </div>
                        </div>

                        <div class="col-12 mt-4">
                            <button type="submit" class="btn btn-ember btn-ripple w-100 py-3"><i class="bi bi-check-circle"></i> Confirm Booking</button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="col-lg-5 reveal reveal-delay-1">
                <div class="dashboard-card summary-sticky-card">
                    <h5 class="fw-bold mb-3">Booking Summary</h5>
                    <div class="booking-hero-image mb-3">
                        <img src="${pageContext.request.contextPath}/${car.imageUrl}" alt="${car.brand} ${car.model}">
                        <span class="overlay-tag"><i class="bi bi-star-fill text-warning"></i> ${car.rating} Rating</span>
                    </div>
                    <div class="car-brand-label">${car.brand}</div>
                    <h6 class="fw-bold">${car.brand} ${car.model}</h6>
                    <p class="text-muted small mb-3">${car.category} &bull; ${car.seats} Seats &bull; ${car.transmission} &bull; AC</p>

                    <div class="price-breakdown-row"><span>Price per day</span><span class="fw-semibold"><fmt:formatNumber value="${car.pricePerDay}" type="currency" currencySymbol="₹"/></span></div>
                    <div class="price-breakdown-row"><span>Total days</span><span class="fw-semibold" id="estimatedDays">0</span></div>
                    <div class="price-breakdown-row"><span>Subtotal</span><span class="fw-semibold" id="estimatedSubtotal">₹0.00</span></div>
                    <div class="price-breakdown-row"><span>Taxes &amp; Fees</span><span class="fw-semibold" id="estimatedTax">₹0.00</span></div>
                    <div class="price-breakdown-row total"><span>Estimated Total</span><span class="text-ember" id="estimatedTotal">₹0.00</span></div>

                    <div class="alert alert-light border mt-3 mb-0 small">
                        <i class="bi bi-shield-check text-ember"></i> Comprehensive insurance and 24/7 roadside
                        support are included with every PrestigeWheels booking.
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="footer.jsp" />
