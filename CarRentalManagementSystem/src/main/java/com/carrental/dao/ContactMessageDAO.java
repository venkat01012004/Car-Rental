package com.carrental.dao;

import com.carrental.model.ContactMessage;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * In-memory Data Access Object for Contact Us messages.
 */
public class ContactMessageDAO {

    private static final ContactMessageDAO INSTANCE = new ContactMessageDAO();

    private final List<ContactMessage> messages = new ArrayList<>();
    private final AtomicInteger idGenerator = new AtomicInteger(0);

    private ContactMessageDAO() {
    }

    public static ContactMessageDAO getInstance() {
        return INSTANCE;
    }

    public synchronized ContactMessage addMessage(ContactMessage message) {
        message.setId(idGenerator.incrementAndGet());
        messages.add(message);
        return message;
    }

    public synchronized List<ContactMessage> getAllMessages() {
        return new ArrayList<>(messages);
    }
}
