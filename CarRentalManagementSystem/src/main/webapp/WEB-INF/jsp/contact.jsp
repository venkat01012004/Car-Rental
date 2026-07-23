<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pageTitle" value="Contact Us | PrestigeWheels" scope="request" />
<jsp:include page="header.jsp" />

<section class="page-banner">
    <div class="container">
        <div class="section-eyebrow">Get In Touch</div>
        <h2 class="fw-bold mb-1">Contact Us</h2>
        <p class="text-secondary mb-0">Have a question or need assistance? We'd love to hear from you.</p>
    </div>
</section>

<section class="section-padding pt-5">
    <div class="container">
        <div class="row g-4">
            <div class="col-lg-4 reveal reveal-delay-1">
                <div class="feature-card-v3 h-100">
                    <div class="feature-icon-v3"><i class="bi bi-geo-alt-fill"></i></div>
                    <h6 class="fw-bold">Our Office</h6>
                    <p class="text-muted small mb-0">Road No. 12, Banjara Hills,<br>Hyderabad, Telangana, India</p>
                </div>
            </div>
            <div class="col-lg-4 reveal reveal-delay-2">
                <div class="feature-card-v3 h-100">
                    <div class="feature-icon-v3"><i class="bi bi-telephone-fill"></i></div>
                    <h6 class="fw-bold">Call Us</h6>
                    <p class="text-muted small mb-0">+91 98765 43210<br>Mon - Sun, 24/7 Support</p>
                </div>
            </div>
            <div class="col-lg-4 reveal reveal-delay-3">
                <div class="feature-card-v3 h-100">
                    <div class="feature-icon-v3"><i class="bi bi-envelope-fill"></i></div>
                    <h6 class="fw-bold">Email Us</h6>
                    <p class="text-muted small mb-0">support@prestigewheels.com<br>partnerships@prestigewheels.com</p>
                </div>
            </div>
        </div>

        <div class="row justify-content-center mt-5">
            <div class="col-lg-8 reveal">
                <div class="dashboard-card p-md-5">
                    <h4 class="fw-bold mb-1"><i class="bi bi-chat-dots text-ember"></i> Send Us a Message</h4>
                    <p class="text-muted mb-4">We typically respond within one business day.</p>

                    <c:if test="${not empty error}"><div class="alert alert-danger alert-auto-dismiss"><i class="bi bi-exclamation-circle me-2"></i>${error}</div></c:if>
                    <c:if test="${not empty successMessage}"><div class="alert alert-success alert-auto-dismiss"><i class="bi bi-check-circle me-2"></i>${successMessage}</div></c:if>

                    <form action="${pageContext.request.contextPath}/contact" method="post" class="row g-3 needs-validation" novalidate>
                        <div class="col-md-6">
                            <div class="input-icon-group form-floating">
                                <i class="bi bi-person form-icon"></i>
                                <input type="text" id="contactName" name="name" class="form-control" placeholder="Your Name" value="${name}" required>
                                <label for="contactName">Your Name</label>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="input-icon-group form-floating">
                                <i class="bi bi-envelope form-icon"></i>
                                <input type="email" id="contactEmail" name="email" class="form-control" placeholder="Your Email" value="${email}" required>
                                <label for="contactEmail">Your Email</label>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="input-icon-group form-floating">
                                <i class="bi bi-chat-left-text form-icon"></i>
                                <input type="text" id="contactSubject" name="subject" class="form-control" placeholder="Subject" value="${subject}" required>
                                <label for="contactSubject">Subject</label>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="input-icon-group form-floating">
                                <i class="bi bi-pencil form-icon"></i>
                                <textarea id="contactMessage" name="message" class="form-control" placeholder="Message" style="height: 140px; padding-left: 44px;" required>${message}</textarea>
                                <label for="contactMessage">Message</label>
                            </div>
                        </div>
                        <div class="col-12 mt-3">
                            <button type="submit" class="btn btn-ember btn-ripple px-4 py-2"><i class="bi bi-send"></i> Send Message</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ============================= GOOGLE MAP ============================= -->
<section class="section-padding pt-0">
    <div class="container">
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
