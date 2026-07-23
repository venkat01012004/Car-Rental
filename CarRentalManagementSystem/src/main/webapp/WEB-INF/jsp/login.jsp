<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Login | PrestigeWheels" scope="request" />
<jsp:include page="header.jsp" />

<div class="auth-wrapper">
    <div class="container">
        <div class="auth-card mx-auto reveal" style="max-width: 900px;">
            <div class="row g-0">
                <div class="col-lg-5 d-none d-lg-block">
                    <div class="auth-side-panel">
                        <span class="brand-mark mb-3" style="width:48px;height:48px;font-size:1.3rem;"><i class="bi bi-lightning-charge-fill"></i></span>
                        <h3 class="fw-bold mb-3 mt-3">Welcome Back</h3>
                        <p class="text-secondary">Log in to manage your bookings, view your rental history and
                            book your next premium ride in seconds.</p>
                        <ul class="list-unstyled auth-check-list mt-4">
                            <li><i class="bi bi-check-circle-fill"></i> Instant online booking</li>
                            <li><i class="bi bi-check-circle-fill"></i> Personalized dashboard</li>
                            <li><i class="bi bi-check-circle-fill"></i> Exclusive member pricing</li>
                        </ul>
                        <div class="glass rounded-lg p-3 mt-4">
                            <p class="text-secondary small mb-1">Demo credentials</p>
                            <p class="text-ember small mb-0 fw-semibold">Username: demo &nbsp;|&nbsp; Password: demo123</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-7">
                    <div class="p-4 p-md-5">
                        <h4 class="fw-bold mb-1">Login to Your Account</h4>
                        <p class="text-muted mb-4">Enter your credentials to continue.</p>

                        <c:if test="${not empty error}"><div class="alert alert-danger alert-auto-dismiss"><i class="bi bi-exclamation-circle me-2"></i>${error}</div></c:if>
                        <c:if test="${not empty successMessage}"><div class="alert alert-success alert-auto-dismiss"><i class="bi bi-check-circle me-2"></i>${successMessage}</div></c:if>

                        <form action="${pageContext.request.contextPath}/login" method="post" class="needs-validation" novalidate>
                            <c:if test="${not empty redirect}"><input type="hidden" name="redirect" value="${redirect}"></c:if>

                            <div class="input-icon-group form-floating mb-3">
                                <i class="bi bi-person form-icon"></i>
                                <input type="text" id="loginUsername" name="username" class="form-control" placeholder="Username" value="${username}" required autofocus>
                                <label for="loginUsername">Username</label>
                            </div>

                            <div class="input-group mb-3">
                                <div class="input-icon-group form-floating flex-grow-1">
                                    <i class="bi bi-lock form-icon"></i>
                                    <input type="password" id="loginPassword" name="password" class="form-control" placeholder="Password" required>
                                    <label for="loginPassword">Password</label>
                                </div>
                                <button class="btn toggle-password" type="button" data-target="loginPassword"><i class="bi bi-eye"></i></button>
                            </div>

                            <button type="submit" class="btn btn-ember btn-ripple w-100 py-3 mt-2"><i class="bi bi-box-arrow-in-right"></i> Login</button>
                            <div class="text-center mt-4"><span class="text-muted">Don't have an account?</span> <a href="${pageContext.request.contextPath}/register" class="fw-semibold text-ember">Register here</a></div>
                            <div class="text-center mt-2"><a href="${pageContext.request.contextPath}/admin/login" class="text-muted small"><i class="bi bi-shield-lock"></i> Login as Administrator</a></div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
