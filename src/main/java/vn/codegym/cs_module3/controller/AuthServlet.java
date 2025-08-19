package vn.codegym.cs_module3.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import vn.codegym.cs_module3.DAO.userDAO;
import vn.codegym.cs_module3.model.User;

@WebServlet(name = "AuthServlet", urlPatterns = "/auth")
public class AuthServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private userDAO userDAO = new userDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // ĐẢM BẢO UTF-8 CHO JSP/HTML
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String action = request.getParameter("action");
        if ("register".equals(action)) {
            request.getRequestDispatcher("views/register.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("views/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // ĐẢM BẢO UTF-8 CHO FORM SUBMIT
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String action = request.getParameter("action");
        if ("register".equals(action)) {
            register(request, response);
        } else if ("login".equals(action)) {
            login(request, response);
        } else {
            response.sendRedirect("auth");
        }
    }

    private void register(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = safe(request.getParameter("name"));
        String email = safe(request.getParameter("email")).toLowerCase();
        String password = safe(request.getParameter("password"));

        if (name.isEmpty() || email.isEmpty() || password.isEmpty()) {
            request.setAttribute("message", "Vui lòng điền đầy đủ thông tin!");
            request.setAttribute("type", "danger");
            request.getRequestDispatcher("views/register.jsp").forward(request, response);
            return;
        }

        if (userDAO.checkEmail(email)) {
            request.setAttribute("message", "Email đã tồn tại!");
            request.setAttribute("type", "danger");
            request.getRequestDispatcher("views/register.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password); // GIỮ NGUYÊN, KHÔNG HASH
        user.setRole("USER");

        boolean success = userDAO.register(user);
        if (success) {
            request.setAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
            request.setAttribute("type", "success");
            request.getRequestDispatcher("views/login.jsp").forward(request, response);
        } else {
            request.setAttribute("message", "Đăng ký thất bại. Vui lòng thử lại.");
            request.setAttribute("type", "danger");
            request.getRequestDispatcher("views/register.jsp").forward(request, response);
        }
    }

    private void login(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = safe(request.getParameter("email")).toLowerCase();
        String password = safe(request.getParameter("password"));

        User user = userDAO.login(email, password); // SO SÁNH NGUYÊN BẢN
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect("/events");
        } else {
            request.setAttribute("message", "Email hoặc mật khẩu không đúng!");
            request.setAttribute("type", "danger");
            request.getRequestDispatcher("views/login.jsp").forward(request, response);
        }
    }

    private String safe(String s) {
        return s == null ? "" : s.trim();
    }
}
