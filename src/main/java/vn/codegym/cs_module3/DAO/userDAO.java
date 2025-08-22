package vn.codegym.cs_module3.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import vn.codegym.cs_module3.model.User;
import vn.codegym.cs_module3.util.DBConnection;

public class userDAO {

    // Kiểm tra email đã tồn tại
    public boolean checkEmail(String email) {
        String sql = "SELECT id FROM user WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email.trim().toLowerCase());
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false; // Nếu lỗi DB, coi như không tồn tại để tránh chặn sai
        }
    }

    // Đăng ký user mới (MẬT KHẨU GIỮ NGUYÊN)
    public boolean register(User user) {
        String sql = "INSERT INTO user(name, email, password, role) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getName().trim());
            ps.setString(2, user.getEmail().trim().toLowerCase());
            ps.setString(3, user.getPassword().trim()); // giữ nguyên bản
            ps.setString(4, user.getRole());

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Đăng nhập bằng email + password (SO SÁNH NGUYÊN BẢN)
    public User login(String email, String password) {
        String sql = "SELECT id, name, email, password, role FROM user WHERE email = ? AND password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email.trim().toLowerCase());
            ps.setString(2, password.trim());

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password")); // (có thể không set nếu không cần)
                    user.setRole(rs.getString("role"));
                    return user;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // không tìm thấy
    }
}
