package vn.codegym.cs_module3.controller;

import vn.codegym.cs_module3.DAO.EventDAO;
import vn.codegym.cs_module3.DAO.TicketDAO;
import vn.codegym.cs_module3.model.Event;
import vn.codegym.cs_module3.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "DashboardServlet", urlPatterns = "/dashboard")
public class DashboardServlet extends HttpServlet {

    private final EventDAO eventDAO = new EventDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy danh sách sự kiện
        List<Event> eventList = eventDAO.getAllEvents();
        req.setAttribute("eventList", eventList);
        System.out.println("Event list size: " + eventList.size());

        HttpSession session = req.getSession();
        User loggedUser = (User) session.getAttribute("user");

        if (loggedUser != null) {
            TicketDAO ticketDAO = new TicketDAO();
                // Admin xem tất cả vé
                req.setAttribute("ticketList", ticketDAO.getAllTickets());
        }


        // Forward sang dashboard JSP
        req.getRequestDispatcher("views/admin/dashboard.jsp").forward(req, resp);
    }
}
