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
        String sql = "SELECT t.id, t.event_id,t.purchase_date, t.quantity, e.title AS eventTitle, e.price AS eventPrice, " +
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
                ticket.setQuantity(rs.getInt("quantity"));
                ticket.setEventTitle(rs.getString("eventTitle"));
                ticket.setEventPrice(rs.getDouble("eventPrice"));
                ticket.setPurchase_date(rs.getDate("purchase_date"));

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
    public Integer findLastTicketId(String userEmail, int eventId) {
        String sql = "SELECT id FROM tickets " +
                "WHERE user_email=? AND event_id=? " +
                "ORDER BY purchase_date DESC, id DESC LIMIT 1";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, userEmail);
            ps.setInt(2, eventId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getInt(1) : null;
            }
        } catch (SQLException e) { throw new RuntimeException(e); }
    }
    public void updateImageUrl(int ticketId, String webPath) {
        String sql = "UPDATE tickets SET image_url=? WHERE id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, webPath);
            ps.setInt(2, ticketId);
            ps.executeUpdate();
        } catch (SQLException e) { throw new RuntimeException(e); }
    }
    /** Lưu đường dẫn (URL) ảnh QR để hiển thị */
    public void updateQrPath(int ticketId, String webPath) {
        String sql = "UPDATE tickets SET qr_code=? WHERE id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, webPath);
            ps.setInt(2, ticketId);
            ps.executeUpdate();
        } catch (SQLException e) { throw new RuntimeException(e); }
    }

    /** Đổi trạng thái vé */
    public void updateStatus(int ticketId, String status) {
        String sql = "UPDATE tickets SET status=? WHERE id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, ticketId);
            ps.executeUpdate();
        } catch (SQLException e) { throw new RuntimeException(e); }
    }

    public String getStatus(int ticketId) {
        String sql = "SELECT status FROM tickets WHERE id=?";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, ticketId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? rs.getString(1) : null;
            }
        } catch (SQLException e) { throw new RuntimeException(e); }
    }

}
