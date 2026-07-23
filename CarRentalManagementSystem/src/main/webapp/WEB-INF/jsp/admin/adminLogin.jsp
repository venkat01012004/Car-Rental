<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Admin Login | PrestigeWheels" scope="request" />
<jsp:include page="../header.jsp" />

<div class="auth-wrapper">
    <div class="container">
        <div class="auth-card mx-auto reveal" style="max-width: 460px;">
            <div class="p-4 p-md-5">
                <div class="text-center mb-4">
                    <div class="feature-icon-v3 mx-auto" style="width:70px;height:70px;font-size:1.8rem;"><i class="bi bi-shield-lock-fill"></i></div>
                    <h4 class="fw-bold mt-3">Administrator Login</h4>
                    <p class="text-muted small">Restricted access. Authorized personnel only.</p>
                </div>

                <c:if test="${not empty error}"><div class="alert alert-danger alert-auto-dismiss"><i class="bi bi-exclamation-circle me-2"></i>${error}</div></c:if>

                <form action="${pageContext.request.contextPath}/admin/login" method="post" class="needs-validation" novalidate>
                    <div class="input-icon-group form-floating mb-3">
                        <i class="bi bi-person-badge form-icon"></i>
                        <input type="text" id="adminUsername" name="username" class="form-control" placeholder="Admin Username" value="${username}" required autofocus>
                        <label for="adminUsername">Admin Username</label>
                    </div>
                    <div class="input-icon-group form-floating mb-3">
                        <i class="bi bi-lock form-icon"></i>
                        <input type="password" id="adminPassword" name="password" class="form-control" placeholder="Password" required>
                        <label for="adminPassword">Password</label>
                    </div>
                    <button type="submit" class="btn btn-obsidian btn-ripple w-100 py-3 mt-2"><i class="bi bi-box-arrow-in-right"></i> Login as Admin</button>
                    <p class="text-muted small text-center mt-3 mb-0">Demo credentials: admin / admin123</p>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />
