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
        String action = request.getParameter("action");
        if ("register".equals(action)) {
            request.getRequestDispatcher("views/register.jsp").forward(request, response);
        } else { // default login
            request.getRequestDispatcher("views/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if ("register".equals(action)) {
            register(request, response);
        } else if ("login".equals(action)) {
            login(request, response);
        } else {
            response.sendRedirect("/auth"); // default to login
        }
    }

    private void register(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullname = request.getParameter("fullname"); // trùng với register.jsp
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (userDAO.checkEmail(email)) {
            request.setAttribute("message", "Email đã tồn tại!");
            request.setAttribute("type", "danger");
            request.getRequestDispatcher("views/register.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setName(fullname);
        user.setEmail(email);
        user.setPassword(password);
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
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = userDAO.login(email, password);
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Redirect the role
            if ("ADMIN".equals(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin/events");
            } else {
                response.sendRedirect(request.getContextPath() + "/events");
            }
        } else {
            request.setAttribute("message", "Email hoặc mật khẩu không đúng!");
            request.setAttribute("type", "danger");
            request.getRequestDispatcher("views/login.jsp").forward(request, response);
        }
    }
}
