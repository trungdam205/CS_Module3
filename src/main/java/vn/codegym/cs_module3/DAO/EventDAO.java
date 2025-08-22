package vn.codegym.cs_module3.DAO;

import vn.codegym.cs_module3.model.Event;
import vn.codegym.cs_module3.util.DBConnection;
import java.sql.*;
import java.time.LocalDateTime;
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
                e.setImageUrl(rs.getString("image_url"));
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
                            rs.getTime("end_time")
                    );
                    event.setImageUrl(rs.getString("image_url"));
                    // tính thời điểm kết thúc = ngày sự kiện + giờ kết thúc
                    LocalDateTime eventEnd = rs.getTimestamp("date")
                            .toLocalDateTime()
                            .with(rs.getTime("end_time").toLocalTime());

                    // so sánh với thời điểm hiện tại
                    event.setActive(LocalDateTime.now().isBefore(eventEnd));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return event;
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
    public void insertEvent(Event event) {
        String sql = "{CALL insert_event(?, ?, ?, ?, ?, ?, ?, ?, ?)}";
        try (Connection conn = DBConnection.getConnection();
             CallableStatement cs = conn.prepareCall(sql)) {

            cs.setString(1, event.getTitle());
            cs.setString(2, event.getDescription());
            cs.setString(3, event.getLocation());
            cs.setDate(4, event.getDate());
            cs.setDouble(5, event.getPrice());
            cs.setTime(6, event.getStart_time());
            cs.setTime(7, event.getEnd_time());
            cs.setInt(8, event.getTotal_tickets());
            cs.setString(9, event.getImageUrl());

            cs.executeUpdate();
            System.out.println("Thêm event thành công bằng Stored Procedure!");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }



}
