<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${pageTitle != null ? pageTitle : 'PrestigeWheels | Premium Car Rentals'}" /></title>
    <meta name="description" content="PrestigeWheels — premium car rental with a curated fleet of economy, SUV, luxury, sports and electric vehicles.">
    <link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 24 24%22><text y=%2218%22 font-size=%2218%22>🚗</text></svg>">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700;800&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

<div id="pageLoader"><div class="loader-car"></div></div>

<nav class="navbar navbar-expand-lg navbar-dark fixed-top premium-navbar">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
            <span class="brand-mark"><i class="bi bi-lightning-charge-fill"></i></span>
            Prestige<span class="text-ember">Wheels</span>
        </a>
        <button class="navbar-toggler border-0 text-white" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav">
            <i class="bi bi-list fs-1 text-white"></i>
        </button>
        <div class="collapse navbar-collapse" id="mainNav">
            <ul class="navbar-nav ms-auto align-items-lg-center">
                <li class="nav-item"><a class="nav-link" data-nav="/home" href="${pageContext.request.contextPath}/home">Home</a></li>
                <li class="nav-item"><a class="nav-link" data-nav="/search" href="${pageContext.request.contextPath}/search">Our Fleet</a></li>
                <li class="nav-item"><a class="nav-link" data-nav="/contact" href="${pageContext.request.contextPath}/contact">Contact</a></li>

                <c:choose>
                    <c:when test="${sessionScope.loggedInUser != null}">
                        <li class="nav-item"><a class="nav-link" data-nav="/profile" href="${pageContext.request.contextPath}/profile">Dashboard</a></li>
                        <li class="nav-item dropdown ms-lg-1">
                            <a class="nav-link position-relative" href="#" role="button" title="Notifications">
                                <i class="bi bi-bell fs-5"></i>
                                <span class="notif-dot"></span>
                            </a>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle d-flex align-items-center gap-2" href="#" role="button" data-bs-toggle="dropdown">
                                <span class="nav-avatar">${fn:toUpperCase(fn:substring(sessionScope.loggedInUser.fullName, 0, 1))}</span>
                                <span class="d-none d-lg-inline">${sessionScope.loggedInUser.fullName}</span>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile"><i class="bi bi-speedometer2 me-2"></i>My Dashboard</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/booking-history"><i class="bi bi-clock-history me-2"></i>Booking History</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i>Logout</a></li>
                            </ul>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item"><a class="nav-link" data-nav="/login" href="${pageContext.request.contextPath}/login">Login</a></li>
                        <li class="nav-item">
                            <a class="btn btn-nav-cta btn-sm ms-lg-2 btn-ripple" href="${pageContext.request.contextPath}/register">Get Started</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>

<div class="page-wrapper">
