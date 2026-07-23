<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
    Static manufacturer showcase page.
    No backend / database changes — car data below is hardcoded on the
    frontend purely for display purposes, as requested. Selected via the
    "brand" query parameter, e.g. /manufacturers/index.jsp?brand=Toyota
--%>
<%
    // ---- Supported manufacturers & their showcase fleet (static demo data) ----
    // Fields per car: { name, fuelType, transmission, seats, pricePerDay, imageUrl, available, rating }
    java.util.Map<String, String[][]> fleetByBrand = new java.util.LinkedHashMap<String, String[][]>();
    java.util.Map<String, String> heroImageByBrand = new java.util.LinkedHashMap<String, String>();
    java.util.Map<String, String> taglineByBrand = new java.util.LinkedHashMap<String, String>();

    fleetByBrand.put("Toyota", new String[][]{
        {"Camry", "Petrol", "Automatic", "5", "4200", "https://images.unsplash.com/photo-1615063029891-497bebd4f03c?auto=format&fit=crop&w=900&q=80", "true", "4.6"},
        {"Fortuner", "Diesel", "Automatic", "7", "5800", "https://images.unsplash.com/photo-1612563893490-d86ed296e5e6?auto=format&fit=crop&w=900&q=80", "true", "4.8"},
        {"Innova Hycross", "Hybrid", "Automatic", "7", "4600", "https://images.unsplash.com/photo-1618353482480-61ca5a9a7879?auto=format&fit=crop&w=800&q=80", "true", "4.7"}
    });
    heroImageByBrand.put("Toyota", "https://images.unsplash.com/photo-1615063029891-497bebd4f03c?auto=format&fit=crop&w=1600&q=80");
    taglineByBrand.put("Toyota", "Legendary reliability meets everyday comfort.");

    fleetByBrand.put("Honda", new String[][]{
        {"City", "Petrol", "Manual", "5", "2800", "https://images.unsplash.com/photo-1572811298797-9eecadf6cb24?auto=format&fit=crop&w=900&q=80", "true", "4.4"},
        {"Civic", "Petrol", "Automatic", "5", "3400", "https://images.unsplash.com/photo-1615063029891-497bebd4f03c?auto=format&fit=crop&w=900&q=80", "true", "4.5"},
        {"Elevate", "Petrol", "Automatic", "5", "3900", "https://images.unsplash.com/photo-1612563893490-d86ed296e5e6?auto=format&fit=crop&w=900&q=80", "false", "4.5"}
    });
    heroImageByBrand.put("Honda", "https://images.unsplash.com/photo-1572811298797-9eecadf6cb24?auto=format&fit=crop&w=1600&q=80");
    taglineByBrand.put("Honda", "Sporty engineering with dependable efficiency.");

    fleetByBrand.put("Mercedes-Benz", new String[][]{
        {"C-Class", "Petrol", "Automatic", "5", "9500", "https://images.unsplash.com/photo-1618418721668-0d1f72aa4bab?auto=format&fit=crop&w=900&q=80", "true", "4.8"},
        {"E-Class", "Diesel", "Automatic", "5", "12000", "https://images.unsplash.com/photo-1580679568899-be51739ba2df?auto=format&fit=crop&w=900&q=80", "true", "4.9"},
        {"GLC", "Diesel", "Automatic", "5", "11200", "https://images.unsplash.com/photo-1610099610040-ab19f3a5ec35?auto=format&fit=crop&w=900&q=80", "true", "4.8"}
    });
    heroImageByBrand.put("Mercedes-Benz", "https://images.unsplash.com/photo-1618418721668-0d1f72aa4bab?auto=format&fit=crop&w=1600&q=80");
    taglineByBrand.put("Mercedes-Benz", "The pinnacle of German luxury motoring.");

    fleetByBrand.put("BMW", new String[][]{
        {"X5", "Diesel", "Automatic", "5", "13500", "https://images.unsplash.com/photo-1612563893490-d86ed296e5e6?auto=format&fit=crop&w=900&q=80", "true", "4.8"},
        {"3 Series", "Petrol", "Automatic", "5", "8900", "https://images.unsplash.com/photo-1618418721668-0d1f72aa4bab?auto=format&fit=crop&w=900&q=80", "true", "4.7"},
        {"M4", "Petrol", "Automatic", "4", "15800", "https://images.unsplash.com/photo-1535448580089-c7f9490c78b1?auto=format&fit=crop&w=900&q=80", "false", "4.9"}
    });
    heroImageByBrand.put("BMW", "https://images.unsplash.com/photo-1618418721668-0d1f72aa4bab?auto=format&fit=crop&w=1600&q=80");
    taglineByBrand.put("BMW", "The ultimate driving machine, redefined.");

    fleetByBrand.put("Hyundai", new String[][]{
        {"Creta", "Diesel", "Automatic", "5", "2600", "https://images.unsplash.com/photo-1612563893490-d86ed296e5e6?auto=format&fit=crop&w=900&q=80", "true", "4.5"},
        {"Verna", "Petrol", "Automatic", "5", "2400", "https://images.unsplash.com/photo-1615063029891-497bebd4f03c?auto=format&fit=crop&w=900&q=80", "true", "4.4"},
        {"Tucson", "Diesel", "Automatic", "5", "3800", "https://images.unsplash.com/photo-1618353482480-61ca5a9a7879?auto=format&fit=crop&w=800&q=80", "true", "4.6"}
    });
    heroImageByBrand.put("Hyundai", "https://images.unsplash.com/photo-1612563893490-d86ed296e5e6?auto=format&fit=crop&w=1600&q=80");
    taglineByBrand.put("Hyundai", "Stylish, smart and built for city living.");

    fleetByBrand.put("Tesla", new String[][]{
        {"Model 3", "Electric", "Automatic", "5", "8200", "https://images.unsplash.com/photo-1599912027611-484b9fc447af?auto=format&fit=crop&w=900&q=80", "true", "4.9"},
        {"Model S", "Electric", "Automatic", "5", "14500", "https://images.unsplash.com/photo-1580679568899-be51739ba2df?auto=format&fit=crop&w=900&q=80", "false", "4.9"},
        {"Model Y", "Electric", "Automatic", "5", "9600", "https://images.unsplash.com/photo-1599912027611-484b9fc447af?auto=format&fit=crop&w=900&q=80", "true", "4.8"}
    });
    heroImageByBrand.put("Tesla", "https://images.unsplash.com/photo-1599912027611-484b9fc447af?auto=format&fit=crop&w=1600&q=80");
    taglineByBrand.put("Tesla", "Zero-emission performance, pure innovation.");

    fleetByBrand.put("Ford", new String[][]{
        {"Mustang", "Petrol", "Automatic", "4", "10200", "https://images.unsplash.com/photo-1535448580089-c7f9490c78b1?auto=format&fit=crop&w=900&q=80", "true", "4.8"},
        {"Endeavour", "Diesel", "Automatic", "7", "5400", "https://images.unsplash.com/photo-1612563893490-d86ed296e5e6?auto=format&fit=crop&w=900&q=80", "true", "4.6"},
        {"EcoSport", "Petrol", "Manual", "5", "2900", "https://images.unsplash.com/photo-1618353482480-61ca5a9a7879?auto=format&fit=crop&w=800&q=80", "true", "4.3"}
    });
    heroImageByBrand.put("Ford", "https://images.unsplash.com/photo-1535448580089-c7f9490c78b1?auto=format&fit=crop&w=1600&q=80");
    taglineByBrand.put("Ford", "Bold American engineering, built for thrills.");

    fleetByBrand.put("Audi", new String[][]{
        {"A4", "Petrol", "Automatic", "5", "6800", "https://images.unsplash.com/photo-1615063029891-497bebd4f03c?auto=format&fit=crop&w=900&q=80", "true", "4.6"},
        {"A6", "Diesel", "Automatic", "5", "9800", "https://images.unsplash.com/photo-1618418721668-0d1f72aa4bab?auto=format&fit=crop&w=900&q=80", "true", "4.7"},
        {"Q5", "Diesel", "Automatic", "5", "7600", "https://images.unsplash.com/photo-1610099610040-ab19f3a5ec35?auto=format&fit=crop&w=900&q=80", "true", "4.6"}
    });
    heroImageByBrand.put("Audi", "https://images.unsplash.com/photo-1615063029891-497bebd4f03c?auto=format&fit=crop&w=1600&q=80");
    taglineByBrand.put("Audi", "Progressive design, quattro confidence.");

    String brand = request.getParameter("brand");
    if (brand == null || !fleetByBrand.containsKey(brand)) {
        brand = "Toyota";
    }

    java.util.List<String[]> cars = java.util.Arrays.asList(fleetByBrand.get(brand));
    request.setAttribute("cars", cars);
    request.setAttribute("brandName", brand);
    request.setAttribute("brandHeroImage", heroImageByBrand.get(brand));
    request.setAttribute("brandTagline", taglineByBrand.get(brand));
    request.setAttribute("allBrands", fleetByBrand.keySet());
%>
<c:set var="pageTitle" value="${brandName} Vehicles | PrestigeWheels" scope="request" />
<jsp:include page="/WEB-INF/jsp/header.jsp" />

<section class="page-banner manufacturer-banner" style="background-image:url('${brandHeroImage}');">
    <div class="overlay"></div>
    <div class="container">
        <div class="d-flex align-items-center gap-3 mb-2">
            <span class="brand-monogram-lg">${fn:substring(brandName,0,1)}</span>
            <div>
                <div class="section-eyebrow mb-1">Manufacturer</div>
                <h2 class="fw-bold mb-0">${brandName}</h2>
            </div>
        </div>
        <p class="text-secondary mb-0">${brandTagline}</p>
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb small mb-0">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home">Home</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home#manufacturers">Manufacturers</a></li>
                <li class="breadcrumb-item active">${brandName}</li>
            </ol>
        </nav>
    </div>
</section>

<section class="section-padding pt-5">
    <div class="container">

        <!-- Manufacturer quick-switch -->
        <div class="brand-strip mb-5 reveal">
            <c:forEach var="b" items="${allBrands}">
                <a class="brand-chip ${b eq brandName ? 'brand-chip-active' : ''}" href="${pageContext.request.contextPath}/manufacturers/index.jsp?brand=${b}">
                    <span class="brand-monogram">${fn:substring(b,0,1)}</span>
                    <span>${b}</span>
                </a>
            </c:forEach>
        </div>

        <div class="d-flex justify-content-between align-items-end flex-wrap gap-3 mb-4 reveal">
            <div>
                <div class="section-eyebrow">${brandName} Fleet</div>
                <h2 class="section-title mb-0">Available ${brandName} Vehicles</h2>
            </div>
            <a href="${pageContext.request.contextPath}/search" class="btn btn-outline-ember btn-ripple px-4">View Full Fleet <i class="bi bi-arrow-right"></i></a>
        </div>

        <div class="row g-4">
            <c:forEach var="car" items="${cars}" varStatus="st">
                <div class="col-lg-4 col-md-6 reveal reveal-delay-${st.index + 1}">
                    <div class="car-card">
                        <div class="car-image-wrap">
                            <span class="category-badge">${brandName}</span>
                            <button class="favorite-heart" data-car-id="${fn:toLowerCase(brandName)}-${fn:toLowerCase(fn:replace(car[0],' ',''))}" type="button" title="Save to favorites"><i class="bi bi-heart"></i></button>
                            <span class="availability-badge ${car[6] == 'true' ? 'available' : 'unavailable'}"><span class="dot"></span>${car[6] == 'true' ? 'Available' : 'Booked'}</span>
                            <img src="${car[5]}" alt="${brandName} ${car[0]}">
                            <span class="car-rating-pill"><i class="bi bi-star-fill"></i> ${car[7]}</span>
                        </div>
                        <div class="car-body">
                            <div class="car-title-row">
                                <span class="brand-monogram-sm">${fn:substring(brandName,0,2)}</span>
                                <div>
                                    <div class="car-brand-label">${brandName}</div>
                                    <h5>${car[0]}</h5>
                                </div>
                            </div>
                            <div class="car-spec-grid">
                                <div class="spec-item"><i class="bi bi-people-fill"></i>${car[3]}</div>
                                <div class="spec-item"><i class="bi bi-fuel-pump-fill"></i>${car[1]}</div>
                                <div class="spec-item"><i class="bi bi-gear-fill"></i>${car[2]}</div>
                                <div class="spec-item"><i class="bi bi-snow"></i>AC</div>
                            </div>
                            <div class="car-footer-row">
                                <div class="price-tag">&#8377;<fmt:formatNumber value="${car[4] * 1}" type="number" groupingUsed="true"/> <small>/ day</small></div>
                                <c:choose>
                                    <c:when test="${sessionScope.loggedInUser != null}">
                                        <a href="${pageContext.request.contextPath}/search?keyword=${fn:replace(car[0],' ','+')}" class="btn-book-now">Book Now <span class="bn-icon"><i class="bi bi-arrow-right"></i></span></a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/login" class="btn-book-now">Book Now <span class="bn-icon"><i class="bi bi-arrow-right"></i></span></a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="text-center mt-5 reveal">
            <p class="text-muted mb-3">Looking for a different make or model from our live fleet?</p>
            <a href="${pageContext.request.contextPath}/search" class="btn btn-obsidian btn-ripple px-4"><i class="bi bi-search"></i> Browse Our Full Fleet</a>
        </div>
    </div>
</section>

<jsp:include page="/WEB-INF/jsp/footer.jsp" />
