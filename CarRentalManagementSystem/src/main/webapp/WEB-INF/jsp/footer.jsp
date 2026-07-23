</div><!-- /.page-wrapper -->

<footer class="premium-footer">
    <div class="container py-5">
        <div class="row g-4">
            <div class="col-lg-4">
                <div class="footer-brand">
                    <span class="brand-mark"><i class="bi bi-lightning-charge-fill"></i></span>
                    Prestige<span class="text-ember">Wheels</span>
                </div>
                <p class="text-secondary mt-3">A premium car rental platform offering a curated fleet of economy,
                    SUV, luxury, sports and electric vehicles across major cities. Drive in style, book with ease.</p>
                <div class="d-flex gap-2 mt-3">
                    <a href="#" class="social-icon"><i class="bi bi-facebook"></i></a>
                    <a href="#" class="social-icon"><i class="bi bi-instagram"></i></a>
                    <a href="#" class="social-icon"><i class="bi bi-twitter-x"></i></a>
                    <a href="#" class="social-icon"><i class="bi bi-linkedin"></i></a>
                    <a href="#" class="social-icon"><i class="bi bi-youtube"></i></a>
                </div>
            </div>
            <div class="col-lg-2 col-md-4 col-6">
                <h6 class="mb-3">Company</h6>
                <ul class="list-unstyled footer-links">
                    <li><a href="${pageContext.request.contextPath}/home"><i class="bi bi-chevron-right small me-1"></i>Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/search"><i class="bi bi-chevron-right small me-1"></i>Our Fleet</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact"><i class="bi bi-chevron-right small me-1"></i>Contact Us</a></li>
                    <li><a href="${pageContext.request.contextPath}/home#faq"><i class="bi bi-chevron-right small me-1"></i>FAQs</a></li>
                </ul>
            </div>
            <div class="col-lg-2 col-md-4 col-6">
                <h6 class="mb-3">Account</h6>
                <ul class="list-unstyled footer-links">
                    <li><a href="${pageContext.request.contextPath}/login"><i class="bi bi-chevron-right small me-1"></i>Login</a></li>
                    <li><a href="${pageContext.request.contextPath}/register"><i class="bi bi-chevron-right small me-1"></i>Register</a></li>
                    <li><a href="${pageContext.request.contextPath}/profile"><i class="bi bi-chevron-right small me-1"></i>My Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/login"><i class="bi bi-chevron-right small me-1"></i>Admin Login</a></li>
                </ul>
            </div>
            <div class="col-lg-4 col-md-4">
                <h6 class="mb-3">Stay in the Loop</h6>
                <p class="text-secondary small mb-3">Subscribe for exclusive member pricing and new fleet arrivals.</p>
                <form class="d-flex mb-4" onsubmit="return false;">
                    <input type="email" class="form-control newsletter-input" placeholder="Your email address">
                    <button type="submit" class="btn btn-ember btn-ripple rounded-0" style="border-radius: 0 30px 30px 0 !important;"><i class="bi bi-send-fill"></i></button>
                </form>
                <ul class="list-unstyled footer-links small">
                    <li><i class="bi bi-geo-alt-fill me-2 text-ember"></i>Road No. 12, Banjara Hills, Hyderabad, India</li>
                    <li><i class="bi bi-telephone-fill me-2 text-ember"></i>+91 98765 43210</li>
                    <li><i class="bi bi-envelope-fill me-2 text-ember"></i>support@prestigewheels.com</li>
                </ul>
            </div>
        </div>
    </div>
    <div class="footer-bottom">
        <div class="container d-flex flex-wrap justify-content-between align-items-center gap-2">
            <div class="small">&copy; <%= java.time.Year.now() %> PrestigeWheels Car Rental Management System. All rights reserved.</div>
            <div class="small">Crafted for a premium rental experience &bull; Built with Java &amp; Bootstrap 5</div>
        </div>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
</body>
</html>
