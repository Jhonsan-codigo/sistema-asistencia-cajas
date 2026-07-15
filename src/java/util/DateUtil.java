package util;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class DateUtil {
    public static String getCurrentDate() {
        return LocalDate.now().toString();
    }
    
    public static String formatDate(String date) {
        if (date == null || date.isEmpty()) return "";
        try {
            LocalDate d = LocalDate.parse(date);
            return d.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
        } catch (Exception e) {
            return date;
        }
    }
}