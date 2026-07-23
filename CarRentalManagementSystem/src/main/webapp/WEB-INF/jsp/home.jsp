<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="PrestigeWheels | Premium Car Rentals" scope="request" />
<jsp:include page="header.jsp" />

<!-- ============================= HERO (split layout) ============================= -->
<section class="hero-split">
    <div class="container">
        <div class="row align-items-center g-5">
            <div class="col-lg-6">
                <span class="hero-eyebrow-pill"><i class="bi bi-award-fill"></i> Trusted by 15,000+ drivers nationwide</span>
                <h1>Premium car rental, <span class="text-gradient">reimagined.</span></h1>
                <p class="lead-text">Skip the counter, skip the wait. Reserve a meticulously maintained vehicle
                    in under two minutes and drive away with transparent pricing, zero hidden fees, every time.</p>
                <div class="d-flex gap-3 flex-wrap">
                    <a href="${pageContext.request.contextPath}/search" class="btn btn-ember btn-ripple btn-lg px-4">
                        <i class="bi bi-search"></i> Browse Fleet
                    </a>
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-glass-light btn-ripple btn-lg px-4">
                        <i class="bi bi-play-circle"></i> Get Started
                    </a>
                </div>
                <div class="hero-trustbar">
                    <div class="trust-item"><i class="bi bi-patch-check-fill"></i> Fully Insured Fleet</div>
                    <div class="trust-item"><i class="bi bi-clock-fill"></i> 24/7 Roadside Support</div>
                    <div class="trust-item"><i class="bi bi-cash-stack"></i> No Hidden Fees</div>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="hero-image-collage hero-image-collage-single">
                    <div class="img-main">
                        <img src="https://images.unsplash.com/photo-1580679568899-be51739ba2df?auto=format&fit=crop&w=1200&q=80" alt="Premium luxury rental vehicle">
                    </div>
                    <div class="hero-stat-chip chip-top">
                        <div class="chip-icon"><i class="bi bi-car-front-fill"></i></div>
                        <div><div class="chip-value"><span data-counter="${totalCars}">0</span>+</div><div class="chip-label">Vehicles Ready</div></div>
                    </div>
                    <div class="hero-stat-chip chip-bottom">
                        <div class="chip-icon"><i class="bi bi-star-fill"></i></div>
                        <div><div class="chip-value">4.9 / 5.0</div><div class="chip-label">Average Rating</div></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ============================= SEARCH WIDGET ============================= -->
<div class="container">
    <div class="search-widget-card reveal" style="margin-top: 0px; position: relative; z-index: 5;">
        <form action="${pageContext.request.contextPath}/search" method="get" class="row g-3 align-items-end">
            <div class="col-lg-3 col-md-6">
                <span class="search-tab-label"><i class="bi bi-grid"></i> Category</span>
                <select name="category" class="form-select">
                    <option value="">All Categories</option>
                    <c:forEach var="cat" items="${categories}"><option value="${cat}">${cat}</option></c:forEach>
                </select>
            </div>
            <div class="col-lg-3 col-md-6">
                <span class="search-tab-label"><i class="bi bi-geo-alt"></i> Location</span>
                <select name="location" class="form-select">
                    <option value="">All Locations</option>
                    <c:forEach var="loc" items="${locations}"><option value="${loc}">${loc}</option></c:forEach>
                </select>
            </div>
            <div class="col-lg-3 col-md-6">
                <span class="search-tab-label"><i class="bi bi-cash"></i> Max Price / Day (₹)</span>
                <input type="number" name="maxPrice" class="form-control" placeholder="e.g. 100" min="0">
            </div>
            <div class="col-lg-3 col-md-6">
                <button type="submit" class="btn btn-ember btn-ripple w-100 py-2"><i class="bi bi-search"></i> Search Cars</button>
            </div>
        </form>
    </div>
</div>

<!-- ============================= TRUSTED BRAND STRIP ============================= -->
<section class="section-padding-sm" id="manufacturers">
    <div class="container text-center reveal">
        <p class="text-muted small text-uppercase fw-semibold mb-4" style="letter-spacing:1px;">Popular manufacturers in our fleet</p>
        <div class="brand-strip">
            <c:forEach var="b" items="${fn:split('Toyota,Honda,Mercedes-Benz,BMW,Hyundai,Tesla,Ford,Audi', ',')}">
                <a class="brand-chip" href="${pageContext.request.contextPath}/manufacturers/index.jsp?brand=${b}" title="View ${b} vehicles">
                    <span class="brand-monogram">${fn:substring(b,0,1)}</span>
                    <span>${b}</span>
                    <i class="bi bi-arrow-up-right brand-chip-arrow"></i>
                </a>
            </c:forEach>
        </div>
    </div>
</section>

<!-- ============================= STATS STRIP ============================= -->
<div class="container">
    <div class="stats-strip reveal">
        <div class="row g-4">
            <div class="col-6 col-md-3">
                <div class="stat-block"><div class="stat-value"><span data-counter="${totalCars}">0</span>+</div><div class="stat-caption">Vehicles in Fleet</div></div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-block"><div class="stat-value"><span data-counter="12">0</span>+</div><div class="stat-caption">Cities Covered</div></div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-block"><div class="stat-value"><span data-counter="98" data-decimals="0">0</span>%</div><div class="stat-caption">Satisfaction Rate</div></div>
            </div>
            <div class="col-6 col-md-3">
                <div class="stat-block"><div class="stat-value"><span data-counter="9">0</span>+</div><div class="stat-caption">Years of Trust</div></div>
            </div>
        </div>
    </div>
</div>

<!-- ============================= BROWSE BY CATEGORY ============================= -->
<section class="section-padding">
    <div class="container">
        <div class="text-center reveal">
            <div class="section-eyebrow justify-content-center">Browse Fleet</div>
            <h2 class="section-title">Find Your Perfect Category</h2>
            <p class="section-subtitle mx-auto">Every vehicle type, curated for comfort, performance and style.</p>
        </div>
        <div class="row g-4">
            <div class="col-lg-4 col-md-6 reveal reveal-delay-1">
                <a href="${pageContext.request.contextPath}/search?category=Luxury" class="category-tile">
                    <img src="https://images.unsplash.com/photo-1618418721668-0d1f72aa4bab?auto=format&fit=crop&w=900&q=80" alt="Luxury cars">
                    <span class="tile-count">Premium</span>
                    <span class="tile-arrow"><i class="bi bi-arrow-up-right"></i></span>
                    <div class="tile-content"><h6>Luxury</h6><small>Premium sedans &amp; flagships</small></div>
                </a>
            </div>
            <div class="col-lg-4 col-md-6 reveal reveal-delay-2">
                <a href="${pageContext.request.contextPath}/search?category=SUV" class="category-tile">
                    <img src="https://images.unsplash.com/photo-1612563893490-d86ed296e5e6?auto=format&fit=crop&w=900&q=80" alt="SUV cars">
                    <span class="tile-count">Spacious</span>
                    <span class="tile-arrow"><i class="bi bi-arrow-up-right"></i></span>
                    <div class="tile-content"><h6>SUV</h6><small>Space, comfort &amp; control</small></div>
                </a>
            </div>
            <div class="col-lg-4 col-md-6 reveal reveal-delay-3">
                <a href="${pageContext.request.contextPath}/search?category=Sedan" class="category-tile">
                    <img src="https://images.unsplash.com/photo-1615063029891-497bebd4f03c?auto=format&fit=crop&w=900&q=80" alt="Sedan cars">
                    <span class="tile-count">Everyday</span>
                    <span class="tile-arrow"><i class="bi bi-arrow-up-right"></i></span>
                    <div class="tile-content"><h6>Sedan</h6><small>Smooth everyday driving</small></div>
                </a>
            </div>
            <div class="col-lg-4 col-md-6 reveal reveal-delay-1">
                <a href="${pageContext.request.contextPath}/search?category=Economy" class="category-tile">
                    <img src="https://images.unsplash.com/photo-1572811298797-9eecadf6cb24?auto=format&fit=crop&w=900&q=80" alt="Hatchback cars">
                    <span class="tile-count">Budget</span>
                    <span class="tile-arrow"><i class="bi bi-arrow-up-right"></i></span>
                    <div class="tile-content"><h6>Economy / Hatchback</h6><small>Light, agile &amp; efficient</small></div>
                </a>
            </div>
            <div class="col-lg-4 col-md-6 reveal reveal-delay-2">
                <a href="${pageContext.request.contextPath}/search?category=Convertible" class="category-tile">
                    <img src="https://images.unsplash.com/photo-1535448580089-c7f9490c78b1?auto=format&fit=crop&w=900&q=80" alt="Sports cars">
                    <span class="tile-count">Thrill</span>
                    <span class="tile-arrow"><i class="bi bi-arrow-up-right"></i></span>
                    <div class="tile-content"><h6>Sports &amp; Convertible</h6><small>Built for the thrill</small></div>
                </a>
            </div>
            <div class="col-lg-4 col-md-6 reveal reveal-delay-3">
                <a href="${pageContext.request.contextPath}/search?category=Electric" class="category-tile">
                    <img src="https://images.unsplash.com/photo-1599912027611-484b9fc447af?auto=format&fit=crop&w=900&q=80" alt="Electric cars">
                    <span class="tile-count">Eco</span>
                    <span class="tile-arrow"><i class="bi bi-arrow-up-right"></i></span>
                    <div class="tile-content"><h6>Electric</h6><small>Zero-emission performance</small></div>
                </a>
            </div>
        </div>
    </div>
</section>

<!-- ============================= SPECIAL OFFER BANNER ============================= -->
<section class="pb-5">
    <div class="container reveal">
        <div class="offer-banner">
            <img src="https://images.unsplash.com/photo-1610099610040-ab19f3a5ec35?auto=format&fit=crop&w=1600&q=80" alt="Special offer">
            <div class="offer-overlay"></div>
            <div class="offer-content">
                <span class="offer-badge"><i class="bi bi-lightning-fill"></i> Limited Time</span>
                <h3>Weekend Getaway Special</h3>
                <p>Book any SUV or Luxury vehicle for 3+ days and save on your total rental — perfect for
                    your next road trip or weekend escape.</p>
                <div class="offer-discount-tag">
                    <span class="num">15%</span>
                    <span class="txt">OFF weekend<br>bookings</span>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/search?category=SUV" class="btn btn-ember btn-ripple px-4"><i class="bi bi-calendar-check"></i> Claim This Offer</a>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ============================= WHY CHOOSE US ============================= -->
<section class="section-padding pt-0">
    <div class="container">
        <div class="text-center reveal">
            <div class="section-eyebrow justify-content-center">Advantages</div>
            <h2 class="section-title">Why Choose PrestigeWheels</h2>
            <p class="section-subtitle mx-auto">Everything you need for a seamless, worry-free rental experience.</p>
        </div>
        <div class="row g-4">
            <div class="col-md-3 col-6 reveal reveal-delay-1">
                <div class="feature-card-v3">
                    <div class="feature-icon-v3"><i class="bi bi-shield-check"></i></div>
                    <h6 class="fw-bold">Fully Insured</h6>
                    <p class="text-muted small mb-0">Every rental is covered with comprehensive insurance for total peace of mind.</p>
                </div>
            </div>
            <div class="col-md-3 col-6 reveal reveal-delay-2">
                <div class="feature-card-v3">
                    <div class="feature-icon-v3"><i class="bi bi-cash-coin"></i></div>
                    <h6 class="fw-bold">Best Price Guarantee</h6>
                    <p class="text-muted small mb-0">Transparent pricing with absolutely no hidden charges, ever.</p>
                </div>
            </div>
            <div class="col-md-3 col-6 reveal reveal-delay-3">
                <div class="feature-card-v3">
                    <div class="feature-icon-v3"><i class="bi bi-geo-alt"></i></div>
                    <h6 class="fw-bold">Multiple Locations</h6>
                    <p class="text-muted small mb-0">Pick up and drop off across major cities nationwide.</p>
                </div>
            </div>
            <div class="col-md-3 col-6 reveal reveal-delay-4">
                <div class="feature-card-v3">
                    <div class="feature-icon-v3"><i class="bi bi-headset"></i></div>
                    <h6 class="fw-bold">24/7 Support</h6>
                    <p class="text-muted small mb-0">Our dedicated support team is always here whenever you need us.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ============================= FEATURED VEHICLES ============================= -->
<section class="section-padding bg-fog">
    <div class="container">
        <div class="d-flex justify-content-between align-items-end flex-wrap gap-3 mb-4 reveal">
            <div>
                <div class="section-eyebrow">Our Fleet</div>
                <h2 class="section-title mb-0">Featured Vehicles</h2>
            </div>
            <a href="${pageContext.request.contextPath}/search" class="btn btn-outline-ember btn-ripple px-4">View All Cars <i class="bi bi-arrow-right"></i></a>
        </div>

        <c:choose>
        <c:when test="${fn:length(featuredCars) > 3}">
        <div id="featuredCarousel" class="carousel slide featured-carousel reveal" data-bs-ride="carousel" data-bs-interval="4500">
            <div class="carousel-inner">
                <c:forEach var="carGroup" items="${featuredCars}" varStatus="status">
                    <c:if test="${status.index % 3 == 0}">
                        <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
                            <div class="row g-4 px-1 px-md-4">
                                <c:forEach var="car" items="${featuredCars}" begin="${status.index}" end="${status.index + 2 < fn:length(featuredCars) ? status.index + 2 : fn:length(featuredCars) - 1}">
                                    <div class="col-lg-4 col-md-6">
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
                                                    <div>
                                                        <div class="car-brand-label">${car.brand}</div>
                                                        <h5>${car.model}</h5>
                                                    </div>
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
                    </c:if>
                </c:forEach>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#featuredCarousel" data-bs-slide="prev"><i class="bi bi-chevron-left text-white fs-5"></i></button>
            <button class="carousel-control-next" type="button" data-bs-target="#featuredCarousel" data-bs-slide="next"><i class="bi bi-chevron-right text-white fs-5"></i></button>
            <div class="carousel-indicators"></div>
        </div>
        </c:when>
        <c:otherwise>
        <div class="row g-4">
            <c:forEach var="car" items="${featuredCars}" varStatus="st">
                <div class="col-lg-4 col-md-6 reveal reveal-delay-${st.index + 1}">
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
        </c:otherwise>
        </c:choose>
    </div>
</section>

<!-- ============================= RENTAL PROCESS ============================= -->
<section class="section-padding bg-dark-section">
    <div class="container">
        <div class="text-center reveal">
            <div class="section-eyebrow justify-content-center">How It Works</div>
            <h2 class="section-title">Rent In 4 Simple Steps</h2>
            <p class="section-subtitle mx-auto">From search to the open road — booking has never been easier.</p>
        </div>
        <div class="row g-4">
            <div class="col-md-3 col-6 reveal reveal-delay-1">
                <div class="process-step">
                    <div class="process-line d-none d-md-block"></div>
                    <div class="step-circle"><i class="bi bi-search"></i><span class="step-number">1</span></div>
                    <h6 class="fw-bold text-white">Search</h6>
                    <p class="small text-secondary mb-0">Browse our fleet by category, location and budget.</p>
                </div>
            </div>
            <div class="col-md-3 col-6 reveal reveal-delay-2">
                <div class="process-step">
                    <div class="process-line d-none d-md-block"></div>
                    <div class="step-circle"><i class="bi bi-calendar-check"></i><span class="step-number">2</span></div>
                    <h6 class="fw-bold text-white">Select Dates</h6>
                    <p class="small text-secondary mb-0">Choose your pickup and return dates instantly.</p>
                </div>
            </div>
            <div class="col-md-3 col-6 reveal reveal-delay-3">
                <div class="process-step">
                    <div class="process-line d-none d-md-block"></div>
                    <div class="step-circle"><i class="bi bi-credit-card"></i><span class="step-number">3</span></div>
                    <h6 class="fw-bold text-white">Confirm Booking</h6>
                    <p class="small text-secondary mb-0">Enter your details and secure your reservation.</p>
                </div>
            </div>
            <div class="col-md-3 col-6 reveal reveal-delay-4">
                <div class="process-step">
                    <div class="step-circle"><i class="bi bi-key"></i><span class="step-number">4</span></div>
                    <h6 class="fw-bold text-white">Drive Away</h6>
                    <p class="small text-secondary mb-0">Pick up your car and hit the road in style.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ============================= TESTIMONIALS ============================= -->
<section class="testimonials-section section-padding" style="background-image:url('https://images.unsplash.com/photo-1541348263662-e068662d82af?auto=format&fit=crop&w=1920&q=80');">
    <div class="overlay"></div>
    <div class="container">
        <div class="text-center reveal">
            <div class="section-eyebrow justify-content-center">Testimonials</div>
            <h2 class="section-title text-white">What Our Customers Say</h2>
            <p class="section-subtitle mx-auto" style="color:#d6d9e6;">Real experiences from real PrestigeWheels drivers.</p>
        </div>
        <div class="row g-4">
            <div class="col-md-4 reveal reveal-delay-1">
                <div class="testimonial-card">
                    <div class="quote-icon"><i class="bi bi-quote"></i></div>
                    <p>Booking was seamless and the Mercedes S-Class was immaculate. Will definitely rent again for my next business trip.</p>
                    <div class="d-flex align-items-center gap-3 mt-3">
                        <div class="testimonial-avatar">AS</div>
                        <div><h6 class="fw-bold mb-0 text-white">Aditi Sharma</h6><small class="text-secondary">Hyderabad &bull; <i class="bi bi-star-fill text-warning"></i>5.0</small></div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 reveal reveal-delay-2">
                <div class="testimonial-card">
                    <div class="quote-icon"><i class="bi bi-quote"></i></div>
                    <p>Great prices and an even better fleet. The Tesla Model 3 was a game changer for our weekend trip.</p>
                    <div class="d-flex align-items-center gap-3 mt-3">
                        <div class="testimonial-avatar">RM</div>
                        <div><h6 class="fw-bold mb-0 text-white">Rohan Mehta</h6><small class="text-secondary">Bengaluru &bull; <i class="bi bi-star-fill text-warning"></i>5.0</small></div>
                    </div>
                </div>
            </div>
            <div class="col-md-4 reveal reveal-delay-3">
                <div class="testimonial-card">
                    <div class="quote-icon"><i class="bi bi-quote"></i></div>
                    <p>Customer support resolved my query within minutes. Highly recommend PrestigeWheels for family trips.</p>
                    <div class="d-flex align-items-center gap-3 mt-3">
                        <div class="testimonial-avatar">SF</div>
                        <div><h6 class="fw-bold mb-0 text-white">Sara Fernandes</h6><small class="text-secondary">Mumbai &bull; <i class="bi bi-star-fill text-warning"></i>4.5</small></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ============================= FAQ ============================= -->
<section class="section-padding" id="faq">
    <div class="container">
        <div class="row">
            <div class="col-lg-5 reveal">
                <div class="section-eyebrow">Support</div>
                <h2 class="section-title">Frequently Asked Questions</h2>
                <p class="text-muted">Can't find what you're looking for? Reach out to our support team any time.</p>
                <a href="${pageContext.request.contextPath}/contact" class="btn btn-obsidian btn-ripple px-4 mt-2"><i class="bi bi-headset"></i> Contact Support</a>
            </div>
            <div class="col-lg-7 reveal reveal-delay-1">
                <div class="accordion faq-accordion" id="faqAccordion">
                    <div class="accordion-item">
                        <h2 class="accordion-header"><button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#faq1">What documents do I need to rent a car?</button></h2>
                        <div id="faq1" class="accordion-collapse collapse show" data-bs-parent="#faqAccordion"><div class="accordion-body">You'll need a valid driving license, a government-issued photo ID, and a registered PrestigeWheels account. Some premium vehicles may require additional verification.</div></div>
                    </div>
                    <div class="accordion-item">
                        <h2 class="accordion-header"><button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq2">Is insurance included in the rental price?</button></h2>
                        <div id="faq2" class="accordion-collapse collapse" data-bs-parent="#faqAccordion"><div class="accordion-body">Yes — every booking includes comprehensive insurance coverage at no additional cost, so you can drive with complete confidence.</div></div>
                    </div>
                    <div class="accordion-item">
                        <h2 class="accordion-header"><button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq3">Can I cancel or modify my booking?</button></h2>
                        <div id="faq3" class="accordion-collapse collapse" data-bs-parent="#faqAccordion"><div class="accordion-body">Yes, bookings can be managed from your Dashboard. Cancellation policies vary depending on how close to the pickup date the change is requested.</div></div>
                    </div>
                    <div class="accordion-item">
                        <h2 class="accordion-header"><button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#faq4">Do you offer airport pickup and drop-off?</button></h2>
                        <div id="faq4" class="accordion-collapse collapse" data-bs-parent="#faqAccordion"><div class="accordion-body">Absolutely — most of our locations offer convenient airport pickup and drop-off. Simply mention your preferred location while booking.</div></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ============================= CTA ============================= -->
<section class="py-5" style="background: var(--grad-dark);">
    <div class="container text-center text-light py-4 reveal">
        <h3 class="fw-bold mb-3">Ready to hit the road?</h3>
        <p class="text-secondary mb-4">Create your free account today and unlock exclusive member pricing.</p>
        <a href="${pageContext.request.contextPath}/register" class="btn btn-ember btn-ripple btn-lg px-5">Sign Up Now</a>
    </div>
</section>

<!-- ============================= LOCATION / GOOGLE MAP ============================= -->
<section class="section-padding bg-fog" id="location">
    <div class="container">
        <div class="text-center reveal mb-5">
            <div class="section-eyebrow justify-content-center">Visit Us</div>
            <h2 class="section-title">Find Our Office</h2>
            <p class="section-subtitle mx-auto">Drop by our Hyderabad office for in-person assistance, or get in touch anytime.</p>
        </div>
        <div class="map-section-card reveal">
            <div class="row g-0">
                <div class="col-lg-7">
                    <div class="map-frame-wrap">
                        <iframe src="https://www.google.com/maps?q=Road+No.+12,+Banjara+Hills,+Hyderabad,+Telangana,+India&amp;output=embed" loading="lazy" referrerpolicy="no-referrer-when-downgrade" allowfullscreen title="PrestigeWheels Office Location"></iframe>
                    </div>
                </div>
                <div class="col-lg-5">
                    <div class="map-info-panel">
                        <div class="map-info-item">
                            <div class="map-info-icon"><i class="bi bi-geo-alt-fill"></i></div>
                            <div><h6>Office Address</h6><p>Road No. 12, Banjara Hills,<br>Hyderabad, Telangana, India</p></div>
                        </div>
                        <div class="map-info-item">
                            <div class="map-info-icon"><i class="bi bi-telephone-fill"></i></div>
                            <div><h6>Phone Number</h6><p>+91 98765 43210</p></div>
                        </div>
                        <div class="map-info-item">
                            <div class="map-info-icon"><i class="bi bi-envelope-fill"></i></div>
                            <div><h6>Email Address</h6><p>support@prestigewheels.com</p></div>
                        </div>
                        <div class="map-info-item">
                            <div class="map-info-icon"><i class="bi bi-clock-fill"></i></div>
                            <div><h6>Working Hours</h6><p>Mon - Sun &bull; 8:00 AM - 10:00 PM</p></div>
                        </div>
                        <a href="https://www.google.com/maps/dir/?api=1&amp;destination=Road+No.+12,+Banjara+Hills,+Hyderabad,+Telangana,+India" target="_blank" rel="noopener" class="btn btn-ember btn-ripple px-4">
                            <i class="bi bi-signpost-2-fill"></i> Get Directions
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="footer.jsp" />
