package vn.codegym.cs_module3;

import vn.codegym.cs_module3.model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {"/dashboard/*"})   // chặn mọi request vào /dashboard/*
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("user") : null;

        if (user == null) {
            // Chưa đăng nhập → đưa về login
            res.sendRedirect(req.getContextPath() + "/auth");
            return;
        }

        if (!"ADMIN".equalsIgnoreCase(user.getRole())) {
            // Không phải admin → đưa về events
            res.sendRedirect(req.getContextPath() + "/events");
            return;
        }

        // Nếu là ADMIN thì cho đi tiếp
        chain.doFilter(request, response);
    }
}
