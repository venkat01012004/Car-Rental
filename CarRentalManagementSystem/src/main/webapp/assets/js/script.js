/* ==========================================================================
   Car Rental Management System — Premium Interactions v3
   ========================================================================== */

(function () {
    'use strict';

    /* ---------------- Page loader ---------------- */
    window.addEventListener('load', function () {
        var loader = document.getElementById('pageLoader');
        if (loader) setTimeout(function () { loader.classList.add('loaded'); }, 250);
    });

    document.addEventListener('DOMContentLoaded', function () {

        /* ---------------- Navbar scroll effect ---------------- */
        var navbar = document.querySelector('.premium-navbar');
        function handleNavScroll() {
            if (!navbar) return;
            navbar.classList.toggle('scrolled', window.scrollY > 30);
        }
        handleNavScroll();
        window.addEventListener('scroll', handleNavScroll, { passive: true });

        /* ---------------- Active nav link highlighting ---------------- */
        var currentPath = window.location.pathname;
        document.querySelectorAll('.premium-navbar .nav-link[data-nav]').forEach(function (link) {
            var target = link.getAttribute('data-nav');
            if (target && currentPath.indexOf(target) !== -1) link.classList.add('active');
        });

        /* ---------------- Scroll reveal ---------------- */
        var revealEls = document.querySelectorAll('.reveal');
        if ('IntersectionObserver' in window && revealEls.length) {
            var observer = new IntersectionObserver(function (entries) {
                entries.forEach(function (entry) {
                    if (entry.isIntersecting) { entry.target.classList.add('in-view'); observer.unobserve(entry.target); }
                });
            }, { threshold: 0.12 });
            revealEls.forEach(function (el) { observer.observe(el); });
        } else {
            revealEls.forEach(function (el) { el.classList.add('in-view'); });
        }

        /* ---------------- Animated counters ---------------- */
        var counters = document.querySelectorAll('[data-counter]');
        function animateCounter(el) {
            var target = parseFloat(el.getAttribute('data-counter'));
            var decimals = el.getAttribute('data-decimals') ? parseInt(el.getAttribute('data-decimals'), 10) : 0;
            var duration = 1400, startTime = null;
            function step(ts) {
                if (!startTime) startTime = ts;
                var progress = Math.min((ts - startTime) / duration, 1);
                var eased = 1 - Math.pow(1 - progress, 3);
                var value = target * eased;
                el.textContent = decimals > 0 ? value.toFixed(decimals) : Math.floor(value).toLocaleString();
                if (progress < 1) requestAnimationFrame(step);
                else el.textContent = decimals > 0 ? target.toFixed(decimals) : target.toLocaleString();
            }
            requestAnimationFrame(step);
        }
        if ('IntersectionObserver' in window && counters.length) {
            var counterObserver = new IntersectionObserver(function (entries) {
                entries.forEach(function (entry) {
                    if (entry.isIntersecting) { animateCounter(entry.target); counterObserver.unobserve(entry.target); }
                });
            }, { threshold: 0.4 });
            counters.forEach(function (el) { counterObserver.observe(el); });
        }

        /* ---------------- Button ripple ---------------- */
        document.querySelectorAll('.btn-ripple').forEach(function (btn) {
            btn.addEventListener('click', function (e) {
                var rect = btn.getBoundingClientRect();
                var circle = document.createElement('span');
                var size = Math.max(rect.width, rect.height);
                circle.className = 'ripple-circle';
                circle.style.width = circle.style.height = size + 'px';
                circle.style.left = (e.clientX - rect.left - size / 2) + 'px';
                circle.style.top = (e.clientY - rect.top - size / 2) + 'px';
                btn.appendChild(circle);
                setTimeout(function () { circle.remove(); }, 650);
            });
        });

        /* ---------------- Alert auto-dismiss ---------------- */
        document.querySelectorAll('.alert-auto-dismiss').forEach(function (alertEl) {
            setTimeout(function () {
                if (window.bootstrap && bootstrap.Alert) bootstrap.Alert.getOrCreateInstance(alertEl).close();
                else alertEl.remove();
            }, 5500);
        });

        /* ---------------- Form validation ---------------- */
        document.querySelectorAll('.needs-validation').forEach(function (form) {
            form.addEventListener('submit', function (event) {
                if (!form.checkValidity()) { event.preventDefault(); event.stopPropagation(); }
                form.classList.add('was-validated');
            }, false);
        });

        /* ---------------- Booking price calculator ---------------- */
        var startDateInput = document.getElementById('startDate');
        var endDateInput = document.getElementById('endDate');
        var priceDisplay = document.getElementById('estimatedTotal');
        var daysDisplay = document.getElementById('estimatedDays');
        var pricePerDayEl = document.getElementById('pricePerDay');
        var subtotalDisplay = document.getElementById('estimatedSubtotal');
        var taxDisplay = document.getElementById('estimatedTax');

        function recalcTotal() {
            if (!startDateInput || !endDateInput || !priceDisplay || !pricePerDayEl) return;
            var start = new Date(startDateInput.value);
            var end = new Date(endDateInput.value);
            var pricePerDay = parseFloat(pricePerDayEl.value || '0');
            if (startDateInput.value && endDateInput.value && end > start) {
                var diffDays = Math.max(Math.round((end.getTime() - start.getTime()) / 86400000), 1);
                var subtotal = diffDays * pricePerDay;
                daysDisplay.textContent = diffDays;
                if (subtotalDisplay) subtotalDisplay.textContent = '₹' + subtotal.toFixed(2);
                if (taxDisplay) taxDisplay.textContent = '₹0.00';
                priceDisplay.textContent = '₹' + subtotal.toFixed(2);
            } else {
                daysDisplay.textContent = '0';
                if (subtotalDisplay) subtotalDisplay.textContent = '₹0.00';
                if (taxDisplay) taxDisplay.textContent = '₹0.00';
                priceDisplay.textContent = '₹0.00';
            }
        }
        if (startDateInput && endDateInput) {
            startDateInput.addEventListener('change', recalcTotal);
            endDateInput.addEventListener('change', recalcTotal);
            recalcTotal();
        }

        /* ---------------- Minimum selectable date ---------------- */
        document.querySelectorAll('input[type="date"]').forEach(function (input) {
            var today = new Date().toISOString().split('T')[0];
            if (!input.getAttribute('min')) input.setAttribute('min', today);
        });

        /* ---------------- Toggle password visibility ---------------- */
        document.querySelectorAll('.toggle-password').forEach(function (toggle) {
            toggle.addEventListener('click', function () {
                var input = document.getElementById(toggle.getAttribute('data-target'));
                if (input) {
                    var isPassword = input.getAttribute('type') === 'password';
                    input.setAttribute('type', isPassword ? 'text' : 'password');
                    var icon = toggle.querySelector('i');
                    if (icon) { icon.classList.toggle('bi-eye'); icon.classList.toggle('bi-eye-slash'); }
                }
            });
        });

        /* ---------------- Confetti burst (booking success) ---------------- */
        var confettiHost = document.getElementById('confettiHost');
        if (confettiHost) {
            var colors = ['#ff5a1f', '#ff8a3d', '#22c55e', '#22d3ee', '#f5b93d', '#ffffff'];
            for (var i = 0; i < 60; i++) {
                var piece = document.createElement('div');
                piece.className = 'confetti-piece';
                piece.style.left = Math.random() * 100 + '%';
                piece.style.background = colors[Math.floor(Math.random() * colors.length)];
                piece.style.animationDuration = (1.6 + Math.random() * 1.6) + 's';
                piece.style.animationDelay = (Math.random() * 0.6) + 's';
                piece.style.transform = 'rotate(' + Math.floor(Math.random() * 360) + 'deg)';
                confettiHost.appendChild(piece);
            }
        }

        /* ---------------- Generic client-side table search + pagination ---------------- */
        document.querySelectorAll('[data-table-controller]').forEach(function (wrapper) {
            var table = wrapper.querySelector('table');
            var searchInput = wrapper.querySelector('[data-table-search]');
            var pagination = wrapper.querySelector('[data-table-pagination]');
            var rowsPerPage = parseInt(wrapper.getAttribute('data-page-size') || '8', 10);
            if (!table) return;
            var tbody = table.querySelector('tbody');
            var allRows = Array.prototype.slice.call(tbody.querySelectorAll('tr'));
            var currentPage = 1;

            function getFilteredRows() {
                var term = (searchInput ? searchInput.value : '').trim().toLowerCase();
                if (!term) return allRows;
                return allRows.filter(function (row) { return row.textContent.toLowerCase().indexOf(term) !== -1; });
            }

            function render() {
                var filtered = getFilteredRows();
                var totalPages = Math.max(Math.ceil(filtered.length / rowsPerPage), 1);
                if (currentPage > totalPages) currentPage = totalPages;
                allRows.forEach(function (row) { row.style.display = 'none'; });
                var start = (currentPage - 1) * rowsPerPage;
                filtered.slice(start, start + rowsPerPage).forEach(function (row) { row.style.display = ''; });

                if (pagination) {
                    pagination.innerHTML = '';
                    if (totalPages > 1) {
                        var prev = document.createElement('button');
                        prev.type = 'button'; prev.className = 'page-btn';
                        prev.innerHTML = '<i class="bi bi-chevron-left"></i>';
                        prev.disabled = currentPage === 1;
                        prev.addEventListener('click', function () { currentPage--; render(); });
                        pagination.appendChild(prev);
                        for (var p = 1; p <= totalPages; p++) {
                            (function (pageNum) {
                                var btn = document.createElement('button');
                                btn.type = 'button'; btn.className = 'page-btn' + (pageNum === currentPage ? ' active' : '');
                                btn.textContent = pageNum;
                                btn.addEventListener('click', function () { currentPage = pageNum; render(); });
                                pagination.appendChild(btn);
                            })(p);
                        }
                        var next = document.createElement('button');
                        next.type = 'button'; next.className = 'page-btn';
                        next.innerHTML = '<i class="bi bi-chevron-right"></i>';
                        next.disabled = currentPage === totalPages;
                        next.addEventListener('click', function () { currentPage++; render(); });
                        pagination.appendChild(next);
                    }
                }
            }
            if (searchInput) searchInput.addEventListener('input', function () { currentPage = 1; render(); });
            render();
        });

        /* ==========================================================================
           FAVORITES — client-side only, stored in this browser via localStorage.
           No server/database involved; purely a frontend convenience feature.
           ========================================================================== */
        var FAVORITES_KEY = 'prestigewheels_favorites';

        function getFavorites() {
            try {
                var raw = localStorage.getItem(FAVORITES_KEY);
                return raw ? JSON.parse(raw) : [];
            } catch (e) { return []; }
        }
        function saveFavorites(list) {
            try { localStorage.setItem(FAVORITES_KEY, JSON.stringify(list)); } catch (e) { /* storage unavailable */ }
        }
        function isFavorite(carId) { return getFavorites().indexOf(String(carId)) !== -1; }
        function toggleFavorite(carId) {
            var list = getFavorites();
            var idx = list.indexOf(String(carId));
            if (idx === -1) list.push(String(carId)); else list.splice(idx, 1);
            saveFavorites(list);
            return idx === -1;
        }

        // Paint heart state on load
        document.querySelectorAll('.favorite-heart[data-car-id]').forEach(function (btn) {
            var carId = btn.getAttribute('data-car-id');
            if (isFavorite(carId)) {
                btn.classList.add('active');
                btn.querySelector('i').className = 'bi bi-heart-fill';
            }
            btn.addEventListener('click', function (e) {
                e.preventDefault(); e.stopPropagation();
                var nowActive = toggleFavorite(carId);
                btn.classList.toggle('active', nowActive);
                btn.querySelector('i').className = nowActive ? 'bi bi-heart-fill' : 'bi bi-heart';
            });
        });

        // Render favorites list on the customer dashboard (if present)
        var favoritesContainer = document.getElementById('favoritesContainer');
        if (favoritesContainer) {
            var favIds = getFavorites();
            var emptyState = document.getElementById('favoritesEmpty');
            if (favIds.length === 0) {
                if (emptyState) emptyState.style.display = 'block';
            } else {
                if (emptyState) emptyState.style.display = 'none';
                // Pull matching car card templates already rendered (hidden) in #favoritesSource
                var source = document.getElementById('favoritesSource');
                if (source) {
                    favIds.forEach(function (id) {
                        var template = source.querySelector('[data-car-id="' + id + '"]');
                        if (template) {
                            var clone = template.cloneNode(true);
                            clone.classList.remove('d-none');
                            favoritesContainer.appendChild(clone);
                        }
                    });
                    // re-bind heart buttons in the newly cloned cards
                    favoritesContainer.querySelectorAll('.favorite-heart[data-car-id]').forEach(function (btn) {
                        var carId = btn.getAttribute('data-car-id');
                        btn.classList.add('active');
                        btn.querySelector('i').className = 'bi bi-heart-fill';
                        btn.addEventListener('click', function (e) {
                            e.preventDefault(); e.stopPropagation();
                            toggleFavorite(carId);
                            btn.closest('.col-md-6, .col-lg-4').remove();
                            if (getFavorites().length === 0 && emptyState) emptyState.style.display = 'block';
                        });
                    });
                }
            }
        }

    });
})();
