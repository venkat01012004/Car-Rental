<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Error | PrestigeWheels" scope="request" />
<jsp:include page="header.jsp" />

<section class="section-padding text-center" style="min-height: 60vh; display:flex; align-items:center;">
    <div class="container reveal">
        <div class="feature-icon-v3 mx-auto mb-3" style="width: 92px; height: 92px; font-size: 2.4rem; background: linear-gradient(135deg,#dc3545,#ff8a3d);">
            <i class="bi bi-exclamation-triangle-fill"></i>
        </div>
        <h2 class="fw-bold mt-3">Oops! Something went wrong.</h2>
        <p class="text-muted">
            <c:choose>
                <c:when test="${not empty errorMessage}">${errorMessage}</c:when>
                <c:otherwise>The page you're looking for doesn't exist or an unexpected error occurred.</c:otherwise>
            </c:choose>
        </p>
        <a href="${pageContext.request.contextPath}/home" class="btn btn-ember btn-ripple px-4 mt-3"><i class="bi bi-house-fill"></i> Back to Home</a>
    </div>
</section>

<jsp:include page="footer.jsp" />
