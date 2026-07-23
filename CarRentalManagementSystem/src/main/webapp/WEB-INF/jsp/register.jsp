<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Register | PrestigeWheels" scope="request" />
<jsp:include page="header.jsp" />

<div class="auth-wrapper">
    <div class="container">
        <div class="auth-card mx-auto reveal" style="max-width: 980px;">
            <div class="row g-0">
                <div class="col-lg-5 d-none d-lg-block">
                    <div class="auth-side-panel">
                        <span class="brand-mark mb-3" style="width:48px;height:48px;font-size:1.3rem;"><i class="bi bi-lightning-charge-fill"></i></span>
                        <h3 class="fw-bold mb-3 mt-3">Join PrestigeWheels</h3>
                        <p class="text-secondary">Create your account to unlock instant bookings, exclusive
                            member discounts, and a personalized dashboard.</p>
                        <ul class="list-unstyled auth-check-list mt-4">
                            <li><i class="bi bi-check-circle-fill"></i> Instant online booking</li>
                            <li><i class="bi bi-check-circle-fill"></i> Track your rental history</li>
                            <li><i class="bi bi-check-circle-fill"></i> Exclusive member pricing</li>
                            <li><i class="bi bi-check-circle-fill"></i> Save your favorite cars</li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-7">
                    <div class="p-4 p-md-5">
                        <h4 class="fw-bold mb-1">Create Your Account</h4>
                        <p class="text-muted mb-4">Fill in the details below to get started.</p>

                        <c:if test="${not empty error}"><div class="alert alert-danger alert-auto-dismiss"><i class="bi bi-exclamation-circle me-2"></i>${error}</div></c:if>

                        <form action="${pageContext.request.contextPath}/register" method="post" class="row g-3 needs-validation" novalidate>
                            <div class="col-md-6"><div class="input-icon-group form-floating"><i class="bi bi-person form-icon"></i><input type="text" id="regFullName" name="fullName" class="form-control" placeholder="Full Name" value="${fullName}" required><label for="regFullName">Full Name</label></div></div>
                            <div class="col-md-6"><div class="input-icon-group form-floating"><i class="bi bi-at form-icon"></i><input type="text" id="regUsername" name="username" class="form-control" placeholder="Username" value="${username}" required><label for="regUsername">Username</label></div></div>
                            <div class="col-md-6"><div class="input-icon-group form-floating"><i class="bi bi-envelope form-icon"></i><input type="email" id="regEmail" name="email" class="form-control" placeholder="Email" value="${email}" required><label for="regEmail">Email Address</label></div></div>
                            <div class="col-md-6"><div class="input-icon-group form-floating"><i class="bi bi-telephone form-icon"></i><input type="text" id="regPhone" name="phone" class="form-control" placeholder="Phone" value="${phone}" pattern="[0-9]{10}" required><label for="regPhone">Phone Number (10-digit)</label></div></div>
                            <div class="col-md-6"><div class="input-icon-group form-floating"><i class="bi bi-lock form-icon"></i><input type="password" id="regPassword" name="password" class="form-control" placeholder="Password" minlength="6" required><label for="regPassword">Password</label></div></div>
                            <div class="col-md-6"><div class="input-icon-group form-floating"><i class="bi bi-lock-fill form-icon"></i><input type="password" id="regConfirmPassword" name="confirmPassword" class="form-control" placeholder="Confirm Password" minlength="6" required><label for="regConfirmPassword">Confirm Password</label></div></div>
                            <div class="col-md-6"><div class="input-icon-group form-floating"><i class="bi bi-card-text form-icon"></i><input type="text" id="regLicense" name="drivingLicense" class="form-control" placeholder="Driving License" value="${drivingLicense}"><label for="regLicense">Driving License No.</label></div></div>
                            <div class="col-md-6"><div class="input-icon-group form-floating"><i class="bi bi-house form-icon"></i><input type="text" id="regAddress" name="address" class="form-control" placeholder="Address" value="${address}"><label for="regAddress">Address</label></div></div>
                            <div class="col-12 mt-4"><button type="submit" class="btn btn-ember btn-ripple w-100 py-3"><i class="bi bi-person-check"></i> Create Account</button></div>
                            <div class="col-12 text-center"><span class="text-muted">Already have an account?</span> <a href="${pageContext.request.contextPath}/login" class="fw-semibold text-ember">Login here</a></div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
