package vn.codegym.cs_module3.DAO;

import vn.codegym.cs_module3.model.Event;
import vn.codegym.cs_module3.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EventDAO {

    public List<Event> getAllEvents() {
        List<Event> events = new ArrayList<>();
        String sql = "{CALL GetAllEvents()}";

        try (Connection conn = DBConnection.getConnection();
             CallableStatement cs = conn.prepareCall(sql);
             ResultSet rs = cs.executeQuery()) {

            while (rs.next()) {
                Event e = new Event(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getString("location"),
                        rs.getDate("date"),
                        rs.getDouble("price"),
                        rs.getTime("start_time"),
                        rs.getTime("end_time")
                );
                events.add(e);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return events;
    }

    public Event getEventById(int id) {
        Event event = null;
        String sql = "{CALL GetEventById(?)}";

        try (Connection conn = DBConnection.getConnection();
             CallableStatement cs = conn.prepareCall(sql)) {

            cs.setInt(1, id); // truyền tham số
            try (ResultSet rs = cs.executeQuery()) {
                if (rs.next()) {
                    event = new Event(
                            rs.getInt("id"),
                            rs.getString("title"),
                            rs.getString("description"),
                            rs.getString("location"),
                            rs.getDate("date"),
                            rs.getDouble("price"),
                            rs.getTime("start_time"),
                            rs.getTime("end_time"),
                            rs.getInt("total_tickets"),
                            rs.getString("image_url")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return event;
    }

    public boolean insertEvent(Event event) {
        String sql = "INSERT INTO events (title, description, location, date, start_time, end_time, price, total_tickets, image_url) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, event.getTitle());
            ps.setString(2, event.getDescription());
            ps.setString(3, event.getLocation());
            ps.setDate(4, event.getDate());
            ps.setTime(5, event.getStart_time());
            ps.setTime(6, event.getEnd_time());
            ps.setDouble(7, event.getPrice());
            ps.setInt(8, event.getTotal_tickets());
            ps.setString(9, event.getImageUrl());

            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    public int getRemainingTickets(int eventId) {
        String sql = "{CALL getRemainingTickets(?)}"; // Procedure tính remaining
        try (Connection conn = DBConnection.getConnection();
             CallableStatement cs = conn.prepareCall(sql)) {
            cs.setInt(1, eventId);
            try (ResultSet rs = cs.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("remaining");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }




    public List<Event> searchEvents(String keyword, String location, String priceRange) {
        List<Event> events = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM events WHERE 1=1");

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND REPLACE(title, '  ', ' ') LIKE ?");
        }
        if (location != null && !location.trim().isEmpty()) {
            sql.append(" AND location LIKE ?");
        }
        if (priceRange != null && !priceRange.isEmpty()) {
            switch (priceRange) {
                case "1": // dưới 500k
                    sql.append(" AND price < 500000");
                    break;
                case "2": // 500k - 1 triệu
                    sql.append(" AND price BETWEEN 500000 AND 1000000");
                    break;
                case "3": // trên 1 triệu
                    sql.append(" AND price > 1000000");
                    break;
            }
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) { // 🔹 khai báo ps ở đây

            int index = 1; // 🔹 khai báo index

            if (keyword != null && !keyword.trim().isEmpty()) {
                ps.setString(index++, "%" + keyword.trim().replaceAll("\\s+", " ") + "%");
            }
            if (location != null && !location.trim().isEmpty()) {
                ps.setString(index++, "%" + location.trim() + "%");
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Event e = new Event(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getString("location"),
                        rs.getDate("date"),
                        rs.getDouble("price"),
                        rs.getTime("start_time"),
                        rs.getTime("end_time"),
                        rs.getInt("total_tickets"),
                        rs.getInt("tickets_sold"),
                        rs.getString("image_url")
                );
                events.add(e);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return events;
    }
}
