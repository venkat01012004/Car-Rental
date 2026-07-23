package com.carrental.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.concurrent.TimeUnit;

/**
 * Utility helper methods for date parsing and day-difference calculation.
 * Kept dependency-free (no external libraries) as required by the project.
 */
public final class DateUtil {

    public static final String DATE_PATTERN = "yyyy-MM-dd";

    private DateUtil() {
    }

    public static long daysBetween(String startDate, String endDate) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN);
        sdf.setLenient(false);
        Date start = sdf.parse(startDate);
        Date end = sdf.parse(endDate);
        long diff = end.getTime() - start.getTime();
        long days = TimeUnit.MILLISECONDS.toDays(diff);
        return Math.max(days, 1);
    }

    public static boolean isValidDateOrder(String startDate, String endDate) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat(DATE_PATTERN);
            sdf.setLenient(false);
            Date start = sdf.parse(startDate);
            Date end = sdf.parse(endDate);
            return end.after(start);
        } catch (ParseException e) {
            return false;
        }
    }

    public static String currentTimestamp() {
        return new SimpleDateFormat("dd-MMM-yyyy hh:mm a").format(new Date());
    }

    public static String currentDate() {
        return new SimpleDateFormat("dd-MMM-yyyy").format(new Date());
    }
}
