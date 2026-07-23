package com.carrental.dao;

import com.carrental.model.User;

import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * In-memory Data Access Object for User entities.
 * Uses a HashMap (LinkedHashMap to preserve insertion order) keyed by username.
 * This class is a thread-safe singleton so data persists for the lifetime
 * of the web application (no external database is used).
 */
public class UserDAO {

    private static final UserDAO INSTANCE = new UserDAO();

    private final Map<String, User> usersByUsername = new LinkedHashMap<>();
    private final AtomicInteger idGenerator = new AtomicInteger(1000);

    private UserDAO() {
        seedDemoUser();
    }

    public static UserDAO getInstance() {
        return INSTANCE;
    }

    private void seedDemoUser() {
        User demo = new User();
        demo.setId(idGenerator.incrementAndGet());
        demo.setFullName("Demo Customer");
        demo.setUsername("demo");
        demo.setEmail("demo@carrental.com");
        demo.setPhone("9876543210");
        demo.setPassword("demo123");
        demo.setAddress("123 Main Street, Hyderabad, India");
        demo.setDrivingLicense("DL-0420110149646");
        demo.setJoinDate(new SimpleDateFormat("dd-MMM-yyyy").format(new Date()));
        usersByUsername.put(demo.getUsername(), demo);
    }

    public synchronized boolean register(User user) {
        if (usersByUsername.containsKey(user.getUsername())) {
            return false;
        }
        user.setId(idGenerator.incrementAndGet());
        user.setJoinDate(new SimpleDateFormat("dd-MMM-yyyy").format(new Date()));
        usersByUsername.put(user.getUsername(), user);
        return true;
    }

    public synchronized User authenticate(String username, String password) {
        User user = usersByUsername.get(username);
        if (user != null && user.getPassword().equals(password)) {
            return user;
        }
        return null;
    }

    public synchronized User getByUsername(String username) {
        return usersByUsername.get(username);
    }

    public synchronized boolean usernameExists(String username) {
        return usersByUsername.containsKey(username);
    }

    public synchronized boolean updateUser(User user) {
        if (!usersByUsername.containsKey(user.getUsername())) {
            return false;
        }
        usersByUsername.put(user.getUsername(), user);
        return true;
    }

    public synchronized Collection<User> getAllUsers() {
        return usersByUsername.values();
    }

    public synchronized int getTotalUsers() {
        return usersByUsername.size();
    }

    public synchronized boolean deleteUser(String username) {
        return usersByUsername.remove(username) != null;
    }
}
