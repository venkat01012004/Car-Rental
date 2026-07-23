package com.carrental.dao;

import com.carrental.model.Car;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * In-memory Data Access Object for Car entities.
 * Uses an ArrayList to store the fleet. Thread-safe singleton.
 */
public class CarDAO {

    private static final CarDAO INSTANCE = new CarDAO();

    private final List<Car> cars = new ArrayList<>();
    private final AtomicInteger idGenerator = new AtomicInteger(0);

    private CarDAO() {
        seedFleet();
    }

    public static CarDAO getInstance() {
        return INSTANCE;
    }

    private void seedFleet() {
        addCar(new Car(0, "Toyota", "Camry", "Sedan", 55.00, 5, "Petrol", "Automatic",
                "assets/images/car-camry.svg", true,
                "A comfortable and reliable sedan, perfect for business trips and family outings.",
                4.6, "Hyderabad"));

        addCar(new Car(0, "Toyota", "Fortuner", "SUV", 95.00, 7, "Diesel", "Automatic",
                "assets/images/car-fortuner.svg", true,
                "A powerful and rugged SUV built for both city driving and off-road adventures.",
                4.8, "Hyderabad"));

        addCar(new Car(0, "Honda", "Civic", "Sedan", 50.00, 5, "Petrol", "Manual",
                "assets/images/car-civic.svg", true,
                "Sporty and fuel-efficient, the Civic offers a smooth and responsive drive.",
                4.4, "Bengaluru"));

        addCar(new Car(0, "Mercedes-Benz", "S-Class", "Luxury", 220.00, 5, "Petrol", "Automatic",
                "assets/images/car-sclass.svg", true,
                "The pinnacle of luxury motoring, featuring premium leather and cutting-edge tech.",
                4.9, "Mumbai"));

        addCar(new Car(0, "BMW", "5 Series", "Luxury", 180.00, 5, "Petrol", "Automatic",
                "assets/images/car-bmw5.svg", true,
                "An elegant executive sedan combining performance with sophisticated styling.",
                4.7, "Delhi"));

        addCar(new Car(0, "Hyundai", "Creta", "SUV", 60.00, 5, "Diesel", "Automatic",
                "assets/images/car-creta.svg", true,
                "A stylish compact SUV, ideal for both city commutes and weekend getaways.",
                4.5, "Hyderabad"));

        addCar(new Car(0, "Maruti Suzuki", "Swift", "Economy", 28.00, 5, "Petrol", "Manual",
                "assets/images/car-swift.svg", true,
                "Compact, agile and economical - the perfect city car for everyday use.",
                4.3, "Pune"));

        addCar(new Car(0, "Tesla", "Model 3", "Electric", 130.00, 5, "Electric", "Automatic",
                "assets/images/car-tesla3.svg", true,
                "Zero-emission performance sedan with autopilot and long range battery.",
                4.9, "Bengaluru"));

        addCar(new Car(0, "Ford", "Mustang", "Convertible", 150.00, 4, "Petrol", "Automatic",
                "assets/images/car-mustang.svg", true,
                "An iconic American muscle car - open the top and feel the thrill of the road.",
                4.8, "Chennai"));

        addCar(new Car(0, "Kia", "Carnival", "Van", 90.00, 8, "Diesel", "Automatic",
                "assets/images/car-carnival.svg", true,
                "Spacious and versatile, perfect for group travel and family vacations.",
                4.5, "Hyderabad"));

        addCar(new Car(0, "Audi", "Q7", "SUV", 175.00, 7, "Diesel", "Automatic",
                "assets/images/car-q7.svg", true,
                "A premium three-row SUV offering commanding presence and refined comfort.",
                4.7, "Mumbai"));

        addCar(new Car(0, "Volkswagen", "Polo", "Economy", 32.00, 5, "Petrol", "Manual",
                "assets/images/car-polo.svg", true,
                "A well-built hatchback known for its solid handling and safety.",
                4.2, "Delhi"));
    }

    public synchronized Car addCar(Car car) {
        car.setId(idGenerator.incrementAndGet());
        cars.add(car);
        return car;
    }

    public synchronized List<Car> getAllCars() {
        return new ArrayList<>(cars);
    }

    public synchronized Car getCarById(int id) {
        for (Car car : cars) {
            if (car.getId() == id) {
                return car;
            }
        }
        return null;
    }

    public synchronized boolean updateCar(Car updatedCar) {
        for (int i = 0; i < cars.size(); i++) {
            if (cars.get(i).getId() == updatedCar.getId()) {
                cars.set(i, updatedCar);
                return true;
            }
        }
        return false;
    }

    public synchronized boolean deleteCar(int id) {
        return cars.removeIf(car -> car.getId() == id);
    }

    public synchronized List<Car> searchCars(String category, String location, Double maxPrice, Integer minSeats, String keyword) {
        List<Car> results = new ArrayList<>();
        for (Car car : cars) {
            if (!car.isAvailable()) {
                continue;
            }
            if (category != null && !category.isEmpty() && !"All".equalsIgnoreCase(category)
                    && !car.getCategory().equalsIgnoreCase(category)) {
                continue;
            }
            if (location != null && !location.isEmpty() && !"All".equalsIgnoreCase(location)
                    && !car.getLocation().equalsIgnoreCase(location)) {
                continue;
            }
            if (maxPrice != null && car.getPricePerDay() > maxPrice) {
                continue;
            }
            if (minSeats != null && car.getSeats() < minSeats) {
                continue;
            }
            if (keyword != null && !keyword.isEmpty()) {
                String k = keyword.toLowerCase();
                if (!car.getBrand().toLowerCase().contains(k) && !car.getModel().toLowerCase().contains(k)) {
                    continue;
                }
            }
            results.add(car);
        }
        return results;
    }

    public synchronized int getTotalCars() {
        return cars.size();
    }

    public synchronized int getAvailableCarsCount() {
        int count = 0;
        for (Car car : cars) {
            if (car.isAvailable()) {
                count++;
            }
        }
        return count;
    }

    public synchronized List<Car> getFeaturedCars(int limit) {
        List<Car> featured = new ArrayList<>();
        for (Car car : cars) {
            if (featured.size() >= limit) {
                break;
            }
            if (car.isAvailable()) {
                featured.add(car);
            }
        }
        return featured;
    }

    public synchronized List<String> getAllCategories() {
        List<String> categories = new ArrayList<>();
        for (Car car : cars) {
            if (!categories.contains(car.getCategory())) {
                categories.add(car.getCategory());
            }
        }
        return categories;
    }

    public synchronized List<String> getAllLocations() {
        List<String> locations = new ArrayList<>();
        for (Car car : cars) {
            if (!locations.contains(car.getLocation())) {
                locations.add(car.getLocation());
            }
        }
        return locations;
    }
}
