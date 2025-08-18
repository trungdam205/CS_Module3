package vn.codegym.cs_module3.DAO;

import vn.codegym.cs_module3.model.Ticket;
import vn.codegym.cs_module3.util.DBConnection;

import java.sql.*;

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
}
