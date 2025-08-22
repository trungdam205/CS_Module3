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
                            rs.getTimestamp("date"),
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
                                rs.getTimestamp("date"),
                                rs.getDouble("price"),
                                rs.getTime("start_time"),
                                rs.getTime("end_time")
                        );
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
            String sql = "INSERT INTO events (title, description, location, date, price, start_time, end_time, total_tickets) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, event.getTitle());
                ps.setString(2, event.getDescription());
                ps.setString(3, event.getLocation());
                ps.setTimestamp(4, new java.sql.Timestamp(event.getDate().getTime()));
                ps.setDouble(5, event.getPrice());
                ps.setTime(6, event.getStart_time());
                ps.setTime(7, event.getEnd_time());
                ps.setInt(8, event.getTotal_tickets());
                ps.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        public void updateEvent(Event event) {
            String sql = "UPDATE events SET title=?, description=?, location=?, date=?, price=?, start_time=?, end_time=?, total_tickets=? WHERE id=?";
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, event.getTitle());
                ps.setString(2, event.getDescription());
                ps.setString(3, event.getLocation());
                ps.setTimestamp(4, new java.sql.Timestamp(event.getDate().getTime()));
                ps.setDouble(5, event.getPrice());
                ps.setTime(6, event.getStart_time());
                ps.setTime(7, event.getEnd_time());
                ps.setInt(8, event.getTotal_tickets());
                ps.setInt(9, event.getId());
                ps.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        public void deleteEvent(int id) {
            String sql = "DELETE FROM events WHERE id=?";
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, id);
                ps.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }


    }
