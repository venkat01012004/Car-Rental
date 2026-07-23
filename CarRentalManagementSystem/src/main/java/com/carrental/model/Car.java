package com.carrental.model;

import java.io.Serializable;

/**
 * Represents a car available in the rental fleet.
 */
public class Car implements Serializable {

    private static final long serialVersionUID = 1L;

    private int id;
    private String brand;
    private String model;
    private String category;      // Economy, SUV, Luxury, Sedan, Convertible, Van
    private double pricePerDay;
    private int seats;
    private String fuelType;      // Petrol, Diesel, Electric, Hybrid
    private String transmission;  // Manual, Automatic
    private String imageUrl;
    private boolean available;
    private String description;
    private double rating;
    private String location;

    public Car() {
    }

    public Car(int id, String brand, String model, String category, double pricePerDay,
               int seats, String fuelType, String transmission, String imageUrl,
               boolean available, String description, double rating, String location) {
        this.id = id;
        this.brand = brand;
        this.model = model;
        this.category = category;
        this.pricePerDay = pricePerDay;
        this.seats = seats;
        this.fuelType = fuelType;
        this.transmission = transmission;
        this.imageUrl = imageUrl;
        this.available = available;
        this.description = description;
        this.rating = rating;
        this.location = location;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public double getPricePerDay() {
        return pricePerDay;
    }

    public void setPricePerDay(double pricePerDay) {
        this.pricePerDay = pricePerDay;
    }

    public int getSeats() {
        return seats;
    }

    public void setSeats(int seats) {
        this.seats = seats;
    }

    public String getFuelType() {
        return fuelType;
    }

    public void setFuelType(String fuelType) {
        this.fuelType = fuelType;
    }

    public String getTransmission() {
        return transmission;
    }

    public void setTransmission(String transmission) {
        this.transmission = transmission;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public boolean isAvailable() {
        return available;
    }

    public void setAvailable(boolean available) {
        this.available = available;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getFullName() {
        return brand + " " + model;
    }
}
