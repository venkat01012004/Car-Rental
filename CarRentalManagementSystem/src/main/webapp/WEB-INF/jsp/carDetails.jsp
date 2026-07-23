<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="${car.brand} ${car.model} | PrestigeWheels" scope="request" />
<jsp:include page="header.jsp" />

<section class="page-banner pb-4">
    <div class="container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb small mb-2">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Home</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/search">Our Fleet</a></li>
                <li class="breadcrumb-item active">${car.brand} ${car.model}</li>
            </ol>
        </nav>
        <h2 class="fw-bold mb-0">${car.brand} ${car.model}</h2>
    </div>
</section>

<section class="section-padding pt-4">
    <div class="container">
        <div class="row g-5">
            <div class="col-lg-6 reveal">
                <div class="car-image-wrap rounded-xl shadow" style="height: 400px;">
                    <span class="category-badge">${car.category}</span>
                    <button class="favorite-heart" data-car-id="${car.id}" type="button" title="Save to favorites"><i class="bi bi-heart"></i></button>
                    <span class="availability-badge ${car.available ? 'available' : 'unavailable'}"><span class="dot"></span>${car.available ? 'Available Now' : 'Currently Booked'}</span>
                    <img src="${pageContext.request.contextPath}/${car.imageUrl}" alt="${car.brand} ${car.model}">
                    <span class="car-rating-pill"><i class="bi bi-star-fill"></i> ${car.rating} Rating</span>
                </div>
            </div>
            <div class="col-lg-6 reveal reveal-delay-1">
                <div class="d-flex align-items-center gap-3 mb-2">
                    <span class="brand-monogram-sm" style="width:44px;height:44px;font-size:.95rem;border-radius:12px;">${fn:substring(car.brand,0,2)}</span>
                    <div>
                        <div class="car-brand-label">${car.brand}</div>
                        <h2 class="fw-bold mb-0">${car.model}</h2>
                    </div>
                </div>
                <div class="text-warning mb-3">
                    <i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-fill"></i><i class="bi bi-star-half"></i>
                    <span class="text-muted small ms-2">${car.rating} / 5.0 &bull; <i class="bi bi-geo-alt-fill"></i> ${car.location}</span>
                </div>
                <p class="text-muted">${car.description}</p>

                <div class="row g-3 my-4">
                    <div class="col-6 col-md-3">
                        <div class="border rounded-lg p-3 text-center h-100">
                            <i class="bi bi-people-fill fs-4 text-ember"></i>
                            <div class="small text-muted mt-1">Seats</div>
                            <div class="fw-bold">${car.seats}</div>
                        </div>
                    </div>
                    <div class="col-6 col-md-3">
                        <div class="border rounded-lg p-3 text-center h-100">
                            <i class="bi bi-fuel-pump-fill fs-4 text-ember"></i>
                            <div class="small text-muted mt-1">Fuel</div>
                            <div class="fw-bold">${car.fuelType}</div>
                        </div>
                    </div>
                    <div class="col-6 col-md-3">
                        <div class="border rounded-lg p-3 text-center h-100">
                            <i class="bi bi-gear-fill fs-4 text-ember"></i>
                            <div class="small text-muted mt-1">Transmission</div>
                            <div class="fw-bold">${car.transmission}</div>
                        </div>
                    </div>
                    <div class="col-6 col-md-3">
                        <div class="border rounded-lg p-3 text-center h-100">
                            <i class="bi bi-snow fs-4 text-ember"></i>
                            <div class="small text-muted mt-1">Climate</div>
                            <div class="fw-bold">AC</div>
                        </div>
                    </div>
                </div>

                <div class="d-flex justify-content-between align-items-center border-top pt-4">
                    <div>
                        <div class="price-tag fs-2"><fmt:formatNumber value="${car.pricePerDay}" type="currency" currencySymbol="₹"/></div>
                        <small class="text-muted">per day &bull; taxes included</small>
                    </div>
                    <c:choose>
                        <c:when test="${car.available}">
                            <a href="${pageContext.request.contextPath}/booking?carId=${car.id}" class="btn btn-ember btn-ripple btn-lg px-4"><i class="bi bi-calendar-check"></i> Book This Car</a>
                        </c:when>
                        <c:otherwise>
                            <button class="btn btn-secondary btn-lg px-4" disabled>Not Available</button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <div class="row g-4 mt-5 reveal">
            <div class="col-md-4">
                <div class="feature-card-v3">
                    <div class="feature-icon-v3"><i class="bi bi-shield-check"></i></div>
                    <h6 class="fw-bold">Comprehensive Insurance</h6>
                    <p class="text-muted small mb-0">Every booking of this vehicle includes full coverage insurance.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card-v3">
                    <div class="feature-icon-v3"><i class="bi bi-arrow-repeat"></i></div>
                    <h6 class="fw-bold">Free Cancellation</h6>
                    <p class="text-muted small mb-0">Plans changed? Manage or cancel from your dashboard.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card-v3">
                    <div class="feature-icon-v3"><i class="bi bi-headset"></i></div>
                    <h6 class="fw-bold">24/7 Roadside Support</h6>
                    <p class="text-muted small mb-0">Our support team is available around the clock during your trip.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="footer.jsp" />
