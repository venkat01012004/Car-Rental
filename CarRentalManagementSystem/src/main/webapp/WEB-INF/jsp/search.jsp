<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="Our Fleet | PrestigeWheels" scope="request" />
<jsp:include page="header.jsp" />

<section class="page-banner">
    <div class="container">
        <div class="section-eyebrow">Our Fleet</div>
        <h2 class="fw-bold mb-1">Find Your Perfect Ride</h2>
        <p class="text-secondary mb-0">Filter by category, location, price and more to find your perfect ride.</p>
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb small mb-0">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Home</a></li>
                <li class="breadcrumb-item active">Our Fleet</li>
            </ol>
        </nav>
    </div>
</section>

<section class="section-padding pt-5">
    <div class="container">
        <div class="row">
            <div class="col-lg-3">
                <div class="dashboard-card mb-4 reveal" style="position: sticky; top: 100px;">
                    <h6 class="fw-bold mb-3"><i class="bi bi-sliders text-ember"></i> Refine Search</h6>
                    <form action="${pageContext.request.contextPath}/search" method="get">
                        <div class="mb-3">
                            <label class="form-label small fw-semibold">Keyword</label>
                            <div class="input-icon-group">
                                <i class="bi bi-search form-icon"></i>
                                <input type="text" name="keyword" class="form-control" placeholder="Brand or Model" value="${keyword}">
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label small fw-semibold">Category</label>
                            <select name="category" class="form-select">
                                <option value="">All Categories</option>
                                <c:forEach var="cat" items="${categories}"><option value="${cat}" ${cat eq category ? 'selected' : ''}>${cat}</option></c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label small fw-semibold">Location</label>
                            <select name="location" class="form-select">
                                <option value="">All Locations</option>
                                <c:forEach var="loc" items="${locations}"><option value="${loc}" ${loc eq location ? 'selected' : ''}>${loc}</option></c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label class="form-label small fw-semibold">Max Price / Day (₹)</label>
                            <input type="number" name="maxPrice" class="form-control" min="0" value="${maxPrice}">
                        </div>
                        <div class="mb-4">
                            <label class="form-label small fw-semibold">Minimum Seats</label>
                            <input type="number" name="minSeats" class="form-control" min="1" value="${minSeats}">
                        </div>
                        <button type="submit" class="btn btn-ember btn-ripple w-100">Apply Filters</button>
                        <a href="${pageContext.request.contextPath}/search" class="btn btn-outline-secondary w-100 mt-2">Clear</a>
                    </form>
                </div>
            </div>

            <div class="col-lg-9">
                <div class="d-flex justify-content-between align-items-center mb-4 reveal">
                    <span class="text-muted"><strong class="text-ember">${resultCount}</strong> car(s) found</span>
                </div>

                <c:if test="${resultCount == 0}">
                    <div class="alert alert-warning reveal"><i class="bi bi-exclamation-triangle me-2"></i>No cars matched your search criteria. Try adjusting your filters.</div>
                </c:if>

                <div class="row g-4">
                    <c:forEach var="car" items="${results}" varStatus="st">
                        <div class="col-lg-4 col-md-6 reveal reveal-delay-${(st.index % 3) + 1}">
                            <div class="car-card">
                                <div class="car-image-wrap">
                                    <span class="category-badge">${car.category}</span>
                                    <button class="favorite-heart" data-car-id="${car.id}" type="button" title="Save to favorites"><i class="bi bi-heart"></i></button>
                                    <span class="availability-badge ${car.available ? 'available' : 'unavailable'}"><span class="dot"></span>${car.available ? 'Available' : 'Booked'}</span>
                                    <img src="${pageContext.request.contextPath}/${car.imageUrl}" alt="${car.brand} ${car.model}">
                                    <span class="car-rating-pill"><i class="bi bi-star-fill"></i> ${car.rating}</span>
                                </div>
                                <div class="car-body">
                                    <div class="car-title-row">
                                        <span class="brand-monogram-sm">${fn:substring(car.brand,0,2)}</span>
                                        <div><div class="car-brand-label">${car.brand}</div><h5>${car.model}</h5></div>
                                    </div>
                                    <div class="car-spec-grid">
                                        <div class="spec-item"><i class="bi bi-people-fill"></i>${car.seats}</div>
                                        <div class="spec-item"><i class="bi bi-fuel-pump-fill"></i>${car.fuelType}</div>
                                        <div class="spec-item"><i class="bi bi-gear-fill"></i>${car.transmission}</div>
                                        <div class="spec-item"><i class="bi bi-snow"></i>AC</div>
                                    </div>
                                    <div class="car-footer-row">
                                        <div class="price-tag"><fmt:formatNumber value="${car.pricePerDay}" type="currency" currencySymbol="₹"/> <small>/ day</small></div>
                                        <a href="${pageContext.request.contextPath}/car-details?id=${car.id}" class="btn-book-now">View <span class="bn-icon"><i class="bi bi-arrow-right"></i></span></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="footer.jsp" />
