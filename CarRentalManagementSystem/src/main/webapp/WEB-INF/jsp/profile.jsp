<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, java.util.ArrayList, java.util.Collections" %>
<%@ page import="com.carrental.dao.BookingDAO, com.carrental.dao.CarDAO" %>
<%@ page import="com.carrental.model.Booking, com.carrental.model.Car, com.carrental.model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    // Read-only view-layer lookups against the existing DAOs (no servlets or
    // business logic modified) so the dashboard can show this customer's own
    // booking summary without changing ProfileServlet.
    User currentUser = (User) session.getAttribute("loggedInUser");
    List<Booking> myBookings = new ArrayList<Booking>();
    if (currentUser != null) {
        myBookings = BookingDAO.getInstance().getBookingsByUsername(currentUser.getUsername());
    }
    Collections.reverse(myBookings);
    double totalSpent = 0;
    int activeCount = 0;
    for (Booking b : myBookings) {
        if (!"CANCELLED".equalsIgnoreCase(b.getStatus())) totalSpent += b.getTotalPrice();
        if ("CONFIRMED".equalsIgnoreCase(b.getStatus())) activeCount++;
    }
    List<Booking> recentThree = myBookings.size() > 3 ? myBookings.subList(0, 3) : myBookings;
    List<Car> allCarsForFavorites = CarDAO.getInstance().getAllCars();

    // Build a simple carId -> imageUrl lookup (read-only) so booking cards can show the real car photo.
    java.util.Map<Integer, String> carImageById = new java.util.HashMap<Integer, String>();
    for (Car c : allCarsForFavorites) {
        carImageById.put(c.getId(), c.getImageUrl());
    }
    pageContext.setAttribute("carImageById", carImageById);

    pageContext.setAttribute("myBookings", myBookings);
    pageContext.setAttribute("recentThree", recentThree);
    pageContext.setAttribute("myTotalSpent", totalSpent);
    pageContext.setAttribute("myActiveCount", activeCount);
    pageContext.setAttribute("myTotalBookings", myBookings.size());
    pageContext.setAttribute("allCarsForFavorites", allCarsForFavorites);
%>
<c:set var="pageTitle" value="My Dashboard | PrestigeWheels" scope="request" />
<jsp:include page="header.jsp" />

<section class="section-padding pt-5 pb-3">
    <div class="container">

        <c:if test="${not empty error}"><div class="alert alert-danger alert-auto-dismiss"><i class="bi bi-exclamation-circle me-2"></i>${error}</div></c:if>
        <c:if test="${not empty successMessage}"><div class="alert alert-success alert-auto-dismiss"><i class="bi bi-check-circle me-2"></i>${successMessage}</div></c:if>

        <!-- Dashboard hero -->
        <div class="dashboard-hero reveal mb-4">
            <div class="content d-flex flex-wrap justify-content-between align-items-center gap-3">
                <div class="d-flex align-items-center gap-3">
                    <div class="avatar-ring">${fn:toUpperCase(fn:substring(user.fullName, 0, 1))}</div>
                    <div>
                        <h3 class="fw-bold mb-1">Welcome back, ${fn:split(user.fullName, ' ')[0]}!</h3>
                        <p class="text-secondary mb-0">Member since ${user.joinDate} &bull; <span class="text-ember">@${user.username}</span></p>
                    </div>
                </div>
                <div class="d-flex gap-2">
                    <a href="${pageContext.request.contextPath}/search" class="btn btn-ember btn-ripple"><i class="bi bi-search"></i> Browse Fleet</a>
                </div>
            </div>
        </div>

        <!-- Stat cards -->
        <div class="row g-4 mb-4">
            <div class="col-md-3 col-6 reveal reveal-delay-1">
                <div class="stat-card icon-blue">
                    <div class="stat-icon"><i class="bi bi-journal-check"></i></div>
                    <div><div class="stat-value">${myTotalBookings}</div><div class="stat-caption">Total Bookings</div></div>
                </div>
            </div>
            <div class="col-md-3 col-6 reveal reveal-delay-2">
                <div class="stat-card icon-green">
                    <div class="stat-icon"><i class="bi bi-car-front-fill"></i></div>
                    <div><div class="stat-value">${myActiveCount}</div><div class="stat-caption">Active Rentals</div></div>
                </div>
            </div>
            <div class="col-md-3 col-6 reveal reveal-delay-3">
                <div class="stat-card icon-orange">
                    <div class="stat-icon"><i class="bi bi-cash-stack"></i></div>
                    <div><div class="stat-value"><fmt:formatNumber value="${myTotalSpent}" type="currency" currencySymbol="₹"/></div><div class="stat-caption">Total Spent</div></div>
                </div>
            </div>
            <div class="col-md-3 col-6 reveal reveal-delay-4">
                <div class="stat-card icon-cyan">
                    <div class="stat-icon"><i class="bi bi-heart-fill"></i></div>
                    <div><div class="stat-value" id="favCountDisplay">&mdash;</div><div class="stat-caption">Saved Favorites</div></div>
                </div>
            </div>
        </div>

        <!-- Tabs -->
        <ul class="nav dash-tabs mb-4 reveal" id="dashTabs" role="tablist">
            <li class="nav-item"><button class="nav-link active" data-bs-toggle="tab" data-bs-target="#tabOverview" type="button"><i class="bi bi-grid me-1"></i> Overview</button></li>
            <li class="nav-item"><button class="nav-link" data-bs-toggle="tab" data-bs-target="#tabBookings" type="button"><i class="bi bi-journal-text me-1"></i> My Bookings</button></li>
            <li class="nav-item"><button class="nav-link" data-bs-toggle="tab" data-bs-target="#tabFavorites" type="button"><i class="bi bi-heart me-1"></i> Favorites</button></li>
            <li class="nav-item"><button class="nav-link" data-bs-toggle="tab" data-bs-target="#tabNotifications" type="button"><i class="bi bi-bell me-1"></i> Notifications</button></li>
            <li class="nav-item"><button class="nav-link" data-bs-toggle="tab" data-bs-target="#tabProfile" type="button"><i class="bi bi-person-gear me-1"></i> Edit Profile</button></li>
        </ul>

        <div class="tab-content">

            <!-- OVERVIEW -->
            <div class="tab-pane fade show active" id="tabOverview">
                <div class="row g-4">
                    <div class="col-lg-8 reveal">
                        <div class="dashboard-card">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h6 class="fw-bold mb-0"><i class="bi bi-clock-history text-ember"></i> Recent Activity</h6>
                            </div>
                            <c:choose>
                                <c:when test="${empty recentThree}">
                                    <div class="favorites-empty"><i class="bi bi-calendar-x fs-1 d-block mb-2"></i>No bookings yet — start by browsing our fleet.</div>
                                </c:when>
                                <c:otherwise>
                                    <div class="d-flex flex-column gap-3">
                                        <c:forEach var="b" items="${recentThree}">
                                            <div class="booking-mini-card">
                                                <div class="mini-thumb"><img src="${pageContext.request.contextPath}/${not empty carImageById[b.carId] ? carImageById[b.carId] : 'assets/images/car-default.svg'}" alt="${b.carBrand}"></div>
                                                <div class="flex-grow-1">
                                                    <div class="d-flex justify-content-between">
                                                        <h6 class="fw-bold mb-1">${b.carBrand} ${b.carModel}</h6>
                                                        <span class="status-badge badge-status-${b.status}"><span class="dot"></span>${b.status}</span>
                                                    </div>
                                                    <div class="small text-muted">${b.startDate} &rarr; ${b.endDate} &bull; <fmt:formatNumber value="${b.totalPrice}" type="currency" currencySymbol="₹"/></div>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="col-lg-4 reveal reveal-delay-1">
                        <div class="dashboard-card h-100">
                            <h6 class="fw-bold mb-3"><i class="bi bi-lightning-charge-fill text-ember"></i> Quick Actions</h6>
                            <div class="d-flex flex-column gap-2">
                                <a href="${pageContext.request.contextPath}/search" class="quick-action-btn"><i class="bi bi-search"></i> Browse Fleet</a>
                                <a href="${pageContext.request.contextPath}/booking-history" class="quick-action-btn"><i class="bi bi-journal-text"></i> Full Booking History</a>
                                <a href="${pageContext.request.contextPath}/contact" class="quick-action-btn"><i class="bi bi-headset"></i> Contact Support</a>
                                <a href="${pageContext.request.contextPath}/logout" class="quick-action-btn"><i class="bi bi-box-arrow-right"></i> Logout</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- MY BOOKINGS -->
            <div class="tab-pane fade" id="tabBookings">
                <c:choose>
                    <c:when test="${empty myBookings}">
                        <div class="dashboard-card favorites-empty reveal"><i class="bi bi-journal-x fs-1 d-block mb-2"></i>You haven't made any bookings yet.</div>
                    </c:when>
                    <c:otherwise>
                        <div class="row g-3">
                            <c:forEach var="b" items="${myBookings}" varStatus="st">
                                <div class="col-lg-6 reveal reveal-delay-${(st.index % 3) + 1}">
                                    <div class="booking-mini-card">
                                        <div class="mini-thumb"><img src="${pageContext.request.contextPath}/${not empty carImageById[b.carId] ? carImageById[b.carId] : 'assets/images/car-default.svg'}" alt="${b.carBrand}"></div>
                                        <div class="flex-grow-1">
                                            <div class="d-flex justify-content-between">
                                                <h6 class="fw-bold mb-1">${b.carBrand} ${b.carModel}</h6>
                                                <span class="status-badge badge-status-${b.status}"><span class="dot"></span>${b.status}</span>
                                            </div>
                                            <div class="small text-muted mb-1">Booking #${b.id} &bull; ${b.startDate} &rarr; ${b.endDate}</div>
                                            <div class="fw-semibold text-ember"><fmt:formatNumber value="${b.totalPrice}" type="currency" currencySymbol="₹"/></div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- FAVORITES -->
            <div class="tab-pane fade" id="tabFavorites">
                <div class="dashboard-card reveal mb-3">
                    <p class="text-muted small mb-0"><i class="bi bi-info-circle text-ember"></i> Favorites are saved privately in this browser by tapping the heart icon on any car card &mdash; no account data is shared.</p>
                </div>
                <div id="favoritesEmpty" class="dashboard-card favorites-empty" style="display:none;"><i class="bi bi-heart fs-1 d-block mb-2"></i>No favorites saved yet. Tap the heart on any car to save it here.</div>
                <div class="row g-4" id="favoritesContainer"></div>

                <!-- Hidden template source: every car, cloned into favoritesContainer by JS when favorited -->
                <div id="favoritesSource" class="d-none">
                    <c:forEach var="car" items="${allCarsForFavorites}">
                        <div class="col-lg-4 col-md-6" data-car-id="${car.id}">
                            <div class="car-card">
                                <div class="car-image-wrap">
                                    <span class="category-badge">${car.category}</span>
                                    <button class="favorite-heart" data-car-id="${car.id}" type="button" title="Remove from favorites"><i class="bi bi-heart"></i></button>
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

            <!-- NOTIFICATIONS -->
            <div class="tab-pane fade" id="tabNotifications">
                <div class="dashboard-card reveal">
                    <div class="notification-item type-offer">
                        <div class="notif-icon"><i class="bi bi-lightning-fill"></i></div>
                        <div><h6 class="fw-bold mb-1">Weekend Special is live</h6><p class="text-muted small mb-0">Save on SUV and Luxury bookings of 3+ days. Applies automatically at checkout.</p></div>
                    </div>
                    <hr>
                    <div class="notification-item type-success">
                        <div class="notif-icon"><i class="bi bi-shield-check"></i></div>
                        <div><h6 class="fw-bold mb-1">Every booking is fully insured</h6><p class="text-muted small mb-0">Comprehensive coverage and 24/7 roadside assistance are included at no extra cost.</p></div>
                    </div>
                    <hr>
                    <div class="notification-item type-info">
                        <div class="notif-icon"><i class="bi bi-person-check"></i></div>
                        <div><h6 class="fw-bold mb-1">Complete your profile</h6><p class="text-muted small mb-0">Add your driving license number in Edit Profile for a faster checkout next time.</p></div>
                    </div>
                </div>
            </div>

            <!-- EDIT PROFILE -->
            <div class="tab-pane fade" id="tabProfile">
                <div class="row g-4">
                    <div class="col-lg-4 reveal">
                        <div class="dashboard-card text-center">
                            <div class="nav-avatar mx-auto mb-3" style="width: 84px; height: 84px; font-size: 2rem; border-radius: 22px;">${fn:toUpperCase(fn:substring(user.fullName, 0, 1))}</div>
                            <h5 class="fw-bold mt-2 mb-0">${user.fullName}</h5>
                            <p class="text-muted small">${user.email}</p>
                            <span class="status-badge badge-status-CONFIRMED mb-3"><span class="dot"></span>Verified Member</span>
                            <hr>
                            <div class="text-start small text-muted">
                                <p class="mb-2"><i class="bi bi-person-badge text-ember me-2"></i>Username: <strong class="text-dark">${user.username}</strong></p>
                                <p class="mb-2"><i class="bi bi-calendar3 text-ember me-2"></i>Member Since: <strong class="text-dark">${user.joinDate}</strong></p>
                                <p class="mb-0"><i class="bi bi-telephone text-ember me-2"></i>Phone: <strong class="text-dark">${user.phone}</strong></p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-8 reveal reveal-delay-1">
                        <div class="dashboard-card">
                            <h5 class="fw-bold mb-4"><i class="bi bi-pencil-square text-ember"></i> Edit Profile</h5>
                            <form action="${pageContext.request.contextPath}/profile" method="post" class="row g-3 needs-validation" novalidate>
                                <div class="col-md-6">
                                    <div class="input-icon-group form-floating">
                                        <i class="bi bi-person form-icon"></i>
                                        <input type="text" id="profFullName" name="fullName" class="form-control" placeholder="Full Name" value="${user.fullName}" required>
                                        <label for="profFullName">Full Name</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="input-icon-group form-floating">
                                        <i class="bi bi-envelope form-icon"></i>
                                        <input type="email" id="profEmail" name="email" class="form-control" placeholder="Email" value="${user.email}" required>
                                        <label for="profEmail">Email Address</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="input-icon-group form-floating">
                                        <i class="bi bi-telephone form-icon"></i>
                                        <input type="text" id="profPhone" name="phone" class="form-control" placeholder="Phone" value="${user.phone}" pattern="[0-9]{10}" required>
                                        <label for="profPhone">Phone Number</label>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="input-icon-group form-floating">
                                        <i class="bi bi-card-text form-icon"></i>
                                        <input type="text" id="profLicense" name="drivingLicense" class="form-control" placeholder="Driving License" value="${user.drivingLicense}">
                                        <label for="profLicense">Driving License No.</label>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <div class="input-icon-group form-floating">
                                        <i class="bi bi-house form-icon"></i>
                                        <textarea id="profAddress" name="address" class="form-control" placeholder="Address" style="height: 110px; padding-left: 44px;">${user.address}</textarea>
                                        <label for="profAddress">Address</label>
                                    </div>
                                </div>
                                <div class="col-12 mt-4">
                                    <button type="submit" class="btn btn-ember btn-ripple px-4 py-2"><i class="bi bi-check-circle"></i> Save Changes</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</section>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        try {
            var favs = JSON.parse(localStorage.getItem('prestigewheels_favorites') || '[]');
            document.getElementById('favCountDisplay').textContent = favs.length;
        } catch (e) {
            document.getElementById('favCountDisplay').textContent = '0';
        }
    });
</script>

<jsp:include page="footer.jsp" />
