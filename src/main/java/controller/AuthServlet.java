package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import dao.userDAO;
import model.User;

@WebServlet(name = "AuthServlet",urlPatterns = "/auth")
public class AuthServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private userDAO userDAO = new userDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chuyển hướng tới trang login hoặc register dựa trên parameter
        String action = request.getParameter("action");
        if ("register".equals(action)) {
            request.getRequestDispatcher("views/register.jsp").forward(request, response);
        } else { // default login
            request.getRequestDispatcher("views/login.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Xác định action: register hoặc login
        String action = request.getParameter("action");
        if ("register".equals(action)) {
            register(request, response);
        } else if ("login".equals(action)) {
            login(request, response);
        } else {
            response.sendRedirect("views/login.jsp");
        }
    }

    private void register(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");

        // Kiểm tra username đã tồn tại chưa
        if (userDAO.checkUsername(username)) {
            request.setAttribute("message", "Username đã tồn tại!");
            request.getRequestDispatcher("views/register.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setFullname(fullname);
        user.setEmail(email);
        user.setRole("user");

        boolean success = userDAO.register(user);
        if (success) {
            request.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.getRequestDispatcher("views/login.jsp").forward(request, response);
        } else {
            request.setAttribute("message", "Đăng ký thất bại. Vui lòng thử lại.");
            request.getRequestDispatcher("views/register.jsp").forward(request, response);
        }
    }

    private void login(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        User user = userDAO.login(username, password);
        if (user != null) {
            // Lưu thông tin user vào session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Chuyển hướng theo role
            if ("admin".equals(user.getRole())) {
                response.sendRedirect("admin/events.jsp");
            } else {
                response.sendRedirect("events.jsp");
            }
        } else {
            request.setAttribute("message", "Username hoặc password không đúng!");
            request.getRequestDispatcher("views/login.jsp").forward(request, response);
        }
    }
}
