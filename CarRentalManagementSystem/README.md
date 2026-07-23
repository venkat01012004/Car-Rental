# 🚗 Car Rental Management System

A **production-ready, premium Car Rental Management System** built as a Java Maven Web
Application, using **Servlets + JSP** on the server side and **Bootstrap 5** on the
client side. The application stores all data **in memory** using Java Collections
(`ArrayList`, `HashMap`) and `HttpSession` — **no database, no Spring, no Docker**.

---

## Tech Stack

| Layer            | Technology                                   |
|-------------------|-----------------------------------------------|
| Language          | Java 21                                       |
| Build Tool        | Maven                                         |
| Web Server        | Apache Tomcat 9                               |
| Server-side Views | JSP + JSTL                                    |
| Controllers       | Java Servlets (`javax.servlet.*`)             |
| Data Storage      | Java Collections (`ArrayList`, `HashMap`) + `HttpSession` |
| Frontend          | HTML5, CSS3, JavaScript, Bootstrap 5          |
| Version Control   | Git / GitHub                                  |
| CI/CD             | Jenkins Pipeline                              |
| Hosting           | AWS EC2 (Apache Tomcat 9)                     |

> **No** MySQL, JDBC, Spring/Spring Boot, Hibernate, React, Angular, Docker,
> Kubernetes, or `jakarta.servlet.*` are used anywhere in this project.

---

## Project Structure

```
CarRentalManagementSystem/
├── pom.xml
├── Jenkinsfile
├── .gitignore
├── README.md
└── src/
    └── main/
        ├── java/com/carrental/
        │   ├── model/          User, Car, Booking, ContactMessage
        │   ├── dao/            UserDAO, CarDAO, BookingDAO, ContactMessageDAO (in-memory)
        │   ├── servlet/        HomeServlet, RegisterServlet, LoginServlet, SearchServlet,
        │   │                   CarDetailsServlet, BookingServlet, BookingConfirmationServlet,
        │   │                   BookingHistoryServlet, ProfileServlet, ContactServlet, LogoutServlet
        │   ├── servlet/admin/  AdminLoginServlet, AdminLogoutServlet, AdminDashboardServlet,
        │   │                   AdminCarManagementServlet, AdminCustomerManagementServlet,
        │   │                   AdminBookingManagementServlet
        │   ├── filter/         AuthFilter, AdminAuthFilter
        │   └── util/           DateUtil, ValidationUtil
        ├── resources/
        └── webapp/
            ├── index.jsp
            ├── WEB-INF/
            │   ├── web.xml
            │   └── jsp/         home.jsp, login.jsp, register.jsp, search.jsp, carDetails.jsp,
            │                    booking.jsp, bookingConfirmation.jsp, bookingHistory.jsp,
            │                    profile.jsp, contact.jsp, error.jsp, header.jsp, footer.jsp,
            │                    admin/  adminLogin.jsp, adminDashboard.jsp, adminCars.jsp,
            │                            adminCustomers.jsp, adminBookings.jsp, adminSidebar.jsp
            └── assets/
                ├── css/style.css
                ├── js/script.js
                └── images/      SVG placeholder images for each vehicle
```

---

## Features

### Customer-Facing
- **Premium Home Page** — hero banner, quick search widget, featured vehicles, testimonials
- **User Registration & Login** — session-based authentication (`HttpSession`)
- **Search Cars** — filter by category, location, price, seats, and keyword
- **Car Details** — full specs, pricing, and imagery for each vehicle
- **Car Booking** — date-based booking with live price estimation
- **Booking Confirmation** — instant confirmation summary after checkout
- **Booking History** — a customer's full rental history
- **User Profile** — view and update personal information
- **Contact Page** — public contact form

### Admin-Facing
- **Admin Login** — separate, hard-coded admin authentication (`admin` / `admin123`)
- **Admin Dashboard** — live stats: total cars, customers, bookings, and revenue
- **Car Management** — add, edit, enable/disable, or delete vehicles
- **Customer Management** — view and remove registered customers
- **Booking Management** — confirm, complete, cancel, or delete bookings

### General
- Fully **responsive UI** built with Bootstrap 5
- Clean, modern "premium" visual design system (custom CSS)
- Client-side form validation with vanilla JavaScript
- Server-side validation in every servlet
- Custom error handling (404 / 500 / exceptions) via `web.xml`

---

## Data Storage Model

This application intentionally uses **no external database**. All data lives in memory
for the lifetime of the deployed application:

- `UserDAO` — a `LinkedHashMap<String, User>` keyed by username
- `CarDAO` — an `ArrayList<Car>` seeded with a sample fleet on startup
- `BookingDAO` — an `ArrayList<Booking>`
- `ContactMessageDAO` — an `ArrayList<ContactMessage>`

Each DAO is a thread-safe singleton, and all mutating methods are `synchronized`.
Logged-in customer state is tracked via `HttpSession` (`loggedInUser` attribute);
admin state is tracked via the `isAdmin` session attribute.

> **Note:** Because storage is in-memory, all data resets whenever the application
> (or the Tomcat instance) restarts. A demo customer account (`demo` / `demo123`) is
> seeded automatically for convenience.

---

## Building the Application

### Prerequisites
- JDK 21
- Apache Maven 3.8+
- Apache Tomcat 9

### Build

```bash
mvn clean package
```

This generates `target/CarRentalManagementSystem.war`.

### Deploy to Tomcat 9

```bash
cp target/CarRentalManagementSystem.war $CATALINA_HOME/webapps/
$CATALINA_HOME/bin/startup.sh
```

Then browse to:

```
http://localhost:8080/CarRentalManagementSystem/
```

### Default Credentials

| Role     | Username | Password  |
|----------|----------|-----------|
| Customer | `demo`   | `demo123` |
| Admin    | `admin`  | `admin123`|

---

## Jenkins Pipeline / AWS EC2 Deployment

The included `Jenkinsfile` defines a declarative pipeline that:

1. Checks out source from GitHub
2. Builds and compiles the project with Maven (JDK 21)
3. Runs tests (if present)
4. Packages the WAR file (`CarRentalManagementSystem.war`)
5. Archives the build artifact in Jenkins
6. Deploys the WAR to Apache Tomcat 9 on an AWS EC2 instance via SSH/SCP
7. Performs a post-deployment health check against `/home`

### Required Jenkins Configuration
- A JDK tool named `JDK21`
- A Maven tool named `Maven3`
- Credentials:
  - `ec2-host` (Secret text) — the EC2 instance's public DNS/IP
  - `ec2-ssh-key` (SSH Username with private key) — for `ubuntu` user access
- The EC2 instance must have Apache Tomcat 9 installed as a `systemd` service
  named `tomcat9`, listening on port `8080`.

---

## Notes on Servlet API

This project uses the **`javax.servlet.*`** namespace (Servlet 4.0 / Tomcat 9),
**not** the newer `jakarta.servlet.*` namespace used by Tomcat 10+. Ensure the
target Tomcat version is **9.x** when deploying this WAR.

---

## License

This project was built for educational and demonstration purposes.
