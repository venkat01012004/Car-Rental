<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="Car Management | PrestigeWheels" scope="request" />
<c:set var="activePage" value="cars" scope="request" />
<jsp:include page="../header.jsp" />

<div class="container-fluid">
    <div class="row">
        <jsp:include page="adminSidebar.jsp" />

        <div class="col-lg-10 admin-content">
            <div class="d-flex justify-content-between align-items-center flex-wrap gap-2 mb-4 reveal">
                <div><h3 class="fw-bold mb-1">Car Management</h3><p class="text-muted mb-0">Add, edit, or remove vehicles from the rental fleet.</p></div>
                <button class="btn btn-ember btn-ripple" type="button" data-bs-toggle="collapse" data-bs-target="#carFormPanel">
                    <i class="bi bi-plus-circle"></i> <c:choose><c:when test="${not empty editCar}">Edit Car</c:when><c:otherwise>Add New Car</c:otherwise></c:choose>
                </button>
            </div>

            <c:if test="${not empty error}"><div class="alert alert-danger alert-auto-dismiss"><i class="bi bi-exclamation-circle me-2"></i>${error}</div></c:if>

            <div class="collapse ${not empty editCar ? 'show' : ''} reveal" id="carFormPanel">
                <div class="dashboard-card mb-4">
                    <h5 class="fw-bold mb-4"><i class="bi bi-car-front text-ember"></i> <c:choose><c:when test="${not empty editCar}">Update Vehicle #${editCar.id}</c:when><c:otherwise>New Vehicle</c:otherwise></c:choose></h5>
                    <form action="${pageContext.request.contextPath}/admin/cars" method="post" class="row g-3 needs-validation" novalidate>
                        <input type="hidden" name="action" value="${not empty editCar ? 'update' : 'add'}">
                        <c:if test="${not empty editCar}"><input type="hidden" name="id" value="${editCar.id}"></c:if>
                        <div class="col-md-4"><div class="form-floating"><input type="text" id="carBrand" name="brand" class="form-control" placeholder="Brand" value="${editCar.brand}" required><label for="carBrand">Brand</label></div></div>
                        <div class="col-md-4"><div class="form-floating"><input type="text" id="carModel" name="model" class="form-control" placeholder="Model" value="${editCar.model}" required><label for="carModel">Model</label></div></div>
                        <div class="col-md-4">
                            <div class="form-floating">
                                <select name="category" id="carCategory" class="form-select" required>
                                    <c:forEach var="cat" items="${fn:split('Economy,Sedan,SUV,Luxury,Electric,Convertible,Van', ',')}"><option value="${cat}" ${cat eq editCar.category ? 'selected' : ''}>${cat}</option></c:forEach>
                                </select>
                                <label for="carCategory">Category</label>
                            </div>
                        </div>
                        <div class="col-md-3"><div class="form-floating"><input type="number" step="0.01" id="carPrice" name="pricePerDay" class="form-control" placeholder="Price" value="${editCar.pricePerDay}" required><label for="carPrice">Price / Day ($)</label></div></div>
                        <div class="col-md-3"><div class="form-floating"><input type="number" id="carSeats" name="seats" class="form-control" placeholder="Seats" value="${editCar.seats}" required><label for="carSeats">Seats</label></div></div>
                        <div class="col-md-3">
                            <div class="form-floating">
                                <select name="fuelType" id="carFuel" class="form-select">
                                    <c:forEach var="f" items="${fn:split('Petrol,Diesel,Electric,Hybrid', ',')}"><option value="${f}" ${f eq editCar.fuelType ? 'selected' : ''}>${f}</option></c:forEach>
                                </select>
                                <label for="carFuel">Fuel Type</label>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="form-floating">
                                <select name="transmission" id="carTransmission" class="form-select">
                                    <c:forEach var="t" items="${fn:split('Automatic,Manual', ',')}"><option value="${t}" ${t eq editCar.transmission ? 'selected' : ''}>${t}</option></c:forEach>
                                </select>
                                <label for="carTransmission">Transmission</label>
                            </div>
                        </div>
                        <div class="col-md-6"><div class="form-floating"><input type="text" id="carLocation" name="location" class="form-control" placeholder="Location" value="${editCar.location}"><label for="carLocation">Location</label></div></div>
                        <div class="col-md-6"><div class="form-floating"><input type="text" id="carImage" name="imageUrl" class="form-control" placeholder="Image Path" value="${editCar.imageUrl}"><label for="carImage">Image Path (optional)</label></div></div>
                        <div class="col-12"><div class="form-floating"><textarea id="carDescription" name="description" class="form-control" placeholder="Description" style="height: 100px;">${editCar.description}</textarea><label for="carDescription">Description</label></div></div>
                        <div class="col-12">
                            <button type="submit" class="btn btn-ember btn-ripple px-4 py-2">
                                <c:choose><c:when test="${not empty editCar}"><i class="bi bi-check-circle"></i> Update Vehicle</c:when><c:otherwise><i class="bi bi-plus-circle"></i> Add Vehicle</c:otherwise></c:choose>
                            </button>
                        </div>
                    </form>
                </div>
            </div>

            <div class="table-modern-wrap reveal reveal-delay-1" data-table-controller data-page-size="8">
                <div class="table-modern-toolbar">
                    <h6 class="fw-bold mb-0"><i class="bi bi-collection text-ember"></i> Fleet (${fn:length(cars)})</h6>
                    <div class="table-search-box"><i class="bi bi-search"></i><input type="text" class="form-control form-control-sm" placeholder="Search vehicles..." data-table-search></div>
                </div>
                <div class="table-responsive-modern">
                    <table class="table table-modern">
                        <thead><tr><th>ID</th><th>Vehicle</th><th>Category</th><th>Price/Day</th><th>Seats</th><th>Location</th><th>Status</th><th>Actions</th></tr></thead>
                        <tbody>
                            <c:forEach var="car" items="${cars}">
                                <tr>
                                    <td>${car.id}</td>
                                    <td class="fw-semibold"><i class="bi bi-car-front-fill text-ember me-1"></i>${car.brand} ${car.model}</td>
                                    <td>${car.category}</td>
                                    <td><fmt:formatNumber value="${car.pricePerDay}" type="currency" currencySymbol="₹"/></td>
                                    <td>${car.seats}</td>
                                    <td>${car.location}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${car.available}"><span class="status-badge badge-status-CONFIRMED"><span class="dot"></span>Available</span></c:when>
                                            <c:otherwise><span class="status-badge badge-status-CANCELLED"><span class="dot"></span>Unavailable</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-nowrap">
                                        <a href="${pageContext.request.contextPath}/admin/cars?action=edit&id=${car.id}" class="table-action-icon edit" title="Edit"><i class="bi bi-pencil-square"></i></a>
                                        <a href="${pageContext.request.contextPath}/admin/cars?action=toggle&id=${car.id}" class="table-action-icon warn" title="Toggle Availability"><i class="bi bi-toggle2-on"></i></a>
                                        <a href="${pageContext.request.contextPath}/admin/cars?action=delete&id=${car.id}" class="table-action-icon danger" title="Delete" onclick="return confirm('Delete this vehicle?');"><i class="bi bi-trash"></i></a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="table-pagination" data-table-pagination></div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />
