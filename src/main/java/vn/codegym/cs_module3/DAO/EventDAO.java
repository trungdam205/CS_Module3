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
     public boolean deleteEventById(int id) {
         String sql = "DELETE FROM events WHERE id = ?";
         try (Connection conn = DBConnection.getConnection();
              PreparedStatement ps = conn.prepareStatement(sql)) {
             ps.setInt(1, id);
             int rows = ps.executeUpdate();
             return rows > 0;
         } catch (SQLException e) {
             e.printStackTrace();
             return false;
         }
     }
     public boolean updateEvent(Event event) {
         String sql = "UPDATE events SET title=?, description=?, location=?, date=?, " +
                 "start_time=?, end_time=?, price=?, total_tickets=?, image_url=? " +
                 "WHERE id=?";
         try (Connection conn = DBConnection.getConnection();
              PreparedStatement ps = conn.prepareStatement(sql)) {

             ps.setString(1, event.getTitle());
             ps.setString(2, event.getDescription());
             ps.setString(3, event.getLocation());
             ps.setTimestamp(4, new java.sql.Timestamp(event.getDate().getTime()));
             ps.setTime(5, event.getStartTime());
             ps.setTime(6, event.getEndTime());
             ps.setDouble(7, event.getPrice());
             ps.setInt(8, event.getTotalTickets());
             ps.setString(9, event.getImageUrl());
             ps.setInt(10, event.getId());

             int rows = ps.executeUpdate();
             return rows > 0;
         } catch (SQLException e) {
             e.printStackTrace();
             return false;
         }
     }
}
