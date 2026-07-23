<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="pageTitle" value="Customer Management | PrestigeWheels" scope="request" />
<c:set var="activePage" value="customers" scope="request" />
<jsp:include page="../header.jsp" />

<div class="container-fluid">
    <div class="row">
        <jsp:include page="adminSidebar.jsp" />

        <div class="col-lg-10 admin-content">
            <div class="mb-4 reveal"><h3 class="fw-bold mb-1">Customer Management</h3><p class="text-muted mb-0">View and manage all registered customers.</p></div>

            <c:choose>
                <c:when test="${empty customers}">
                    <div class="dashboard-card text-center py-5 reveal"><i class="bi bi-people text-muted" style="font-size: 3rem;"></i><h5 class="mt-3">No customers yet</h5><p class="text-muted mb-0">Registered customers will appear here.</p></div>
                </c:when>
                <c:otherwise>
                    <div class="table-modern-wrap reveal" data-table-controller data-page-size="8">
                        <div class="table-modern-toolbar">
                            <h6 class="fw-bold mb-0"><i class="bi bi-people-fill text-ember"></i> Customers (${fn:length(customers)})</h6>
                            <div class="table-search-box"><i class="bi bi-search"></i><input type="text" class="form-control form-control-sm" placeholder="Search customers..." data-table-search></div>
                        </div>
                        <div class="table-responsive-modern">
                            <table class="table table-modern">
                                <thead><tr><th>ID</th><th>Full Name</th><th>Username</th><th>Email</th><th>Phone</th><th>Joined</th><th>Actions</th></tr></thead>
                                <tbody>
                                    <c:forEach var="cust" items="${customers}">
                                        <tr>
                                            <td>${cust.id}</td>
                                            <td class="fw-semibold"><i class="bi bi-person-circle text-ember me-1"></i>${cust.fullName}</td>
                                            <td>${cust.username}</td>
                                            <td>${cust.email}</td>
                                            <td>${cust.phone}</td>
                                            <td>${cust.joinDate}</td>
                                            <td><a href="${pageContext.request.contextPath}/admin/customers?action=delete&username=${cust.username}" class="table-action-icon danger" title="Remove" onclick="return confirm('Remove this customer?');"><i class="bi bi-trash"></i></a></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div class="table-pagination" data-table-pagination></div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<jsp:include page="../footer.jsp" />
