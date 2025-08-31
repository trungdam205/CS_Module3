package vn.codegym.cs_module3.DAO;

import vn.codegym.cs_module3.model.Ticket;
import vn.codegym.cs_module3.util.DBConnection;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class TicketDAO {

    public boolean insert(Ticket ticket) {
        String insertSql = "{CALL insert_ticket(?, ?, ?, ?, ?)}";
        String updateSql = "{CALL updateTicketsSold(?, ?)}";
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false); // bắt đầu transaction

            // 1. Insert ticket
            try (CallableStatement cs = conn.prepareCall(insertSql)) {
                cs.setInt(1, ticket.getEventId());
                cs.setString(2, ticket.getUserName());
                cs.setString(3, ticket.getUserEmail());
                cs.setInt(4, ticket.getQuantity());
                cs.setString(5, ticket.getQrCode());
                cs.executeUpdate();
            }

            // 2. Update vé đã bán
            try (CallableStatement cs2 = conn.prepareCall(updateSql)) {
                cs2.setInt(1, ticket.getEventId());
                cs2.setInt(2, ticket.getQuantity());
                cs2.executeUpdate();
            }

            conn.commit();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Ticket> getTicketsByUserEmail(String userEmail) {
        List<Ticket> tickets = new ArrayList<>();
        String sql = "SELECT t.id,t.user_name, t.event_id,t.user_email,t.purchase_date, t.quantity, e.title AS eventTitle, e.price AS eventPrice, " +
                "e.date AS eventDate, e.end_time AS eventEndTime " +
                "FROM tickets t " +
                "JOIN events e ON t.event_id = e.id " +
                "WHERE t.user_email = ? " +
                "ORDER BY t.purchase_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, userEmail);
            ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                Ticket ticket = new Ticket();
                ticket.setId(rs.getInt("id"));
                ticket.setEventId(rs.getInt("event_id"));
                ticket.setUserName(rs.getString("user_name"));
                ticket.setUserEmail(rs.getString("user_email"));
                ticket.setQuantity(rs.getInt("quantity"));
                ticket.setEventTitle(rs.getString("eventTitle"));
                ticket.setEventPrice(rs.getDouble("eventPrice"));
                ticket.setPurchase_date(rs.getTimestamp("purchase_date"));

                // --- Tính trạng thái dựa trên thời gian sự kiện ---
                Timestamp eventDate = rs.getTimestamp("eventDate");
                Time eventEndTime = rs.getTime("eventEndTime");
                if (eventDate != null && eventEndTime != null) {
                    LocalDateTime eventEnd = eventDate.toLocalDateTime().with(eventEndTime.toLocalTime());
                    boolean isActive = LocalDateTime.now().isBefore(eventEnd);
                    ticket.setStatus(isActive ? "Sự kiện đang diễn ra" : "Sự kiện đã kết thúc");
                } else {
                    ticket.setStatus("Không xác định");
                }

                tickets.add(ticket);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return tickets;
    }
    public List<Ticket> getAllTickets() {
        List<Ticket> tickets = new ArrayList<>();
        String sql = "SELECT t.id,t.user_name, t.event_id,t.user_email,t.purchase_date,t.quantity, e.title AS eventTitle, e.price AS eventPrice, " +
                "e.date AS eventDate, e.end_time AS eventEndTime " +
                "FROM tickets t " +
                "JOIN events e ON t.event_id = e.id " +
                "ORDER BY eventTitle DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Ticket ticket = new Ticket();
                ticket.setId(rs.getInt("id"));
                ticket.setEventId(rs.getInt("event_id"));
                ticket.setUserName(rs.getString("user_name"));
                ticket.setUserEmail(rs.getString("user_email"));
                ticket.setQuantity(rs.getInt("quantity"));
                ticket.setEventTitle(rs.getString("eventTitle"));
                ticket.setEventPrice(rs.getDouble("eventPrice"));
                ticket.setPurchase_date(rs.getTimestamp("purchase_date"));

                tickets.add(ticket);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return tickets;
    }


    public static List<Ticket> searchTickets(String keyword) {
        List<Ticket> tickets = new ArrayList<>();
        String sql = "SELECT t.id, t.user_name, t.user_email, t.quantity, t.purchase_date, " +
                "e.title AS eventTitle, e.price AS eventPrice " +
                "FROM tickets t " +
                "JOIN events e ON t.event_id = e.id " +
                "WHERE t.user_name LIKE ? OR t.user_email LIKE ? OR e.title LIKE ? " +
                "ORDER BY t.purchase_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String likeKeyword = "%" + (keyword == null ? "" : keyword) + "%";
            ps.setString(1, likeKeyword);
            ps.setString(2, likeKeyword);
            ps.setString(3, likeKeyword);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Ticket ticket = new Ticket();
                ticket.setId(rs.getInt("id"));
                ticket.setUserName(rs.getString("user_name"));
                ticket.setUserEmail(rs.getString("user_email"));
                ticket.setQuantity(rs.getInt("quantity"));
                ticket.setEventTitle(rs.getString("eventTitle"));
                ticket.setEventPrice(rs.getDouble("eventPrice"));
                ticket.setPurchase_date(rs.getTimestamp("purchase_date"));

                tickets.add(ticket);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return tickets;
    }

}
