package vn.codegym.cs_module3.controller;

import vn.codegym.cs_module3.model.Event;
import vn.codegym.cs_module3.DAO.EventDAO;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "EventServlet", urlPatterns = "/events")
public class EventServlet extends HttpServlet {
    private EventDAO eventDAO = new EventDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher dispatcher;
        String action = req.getParameter("action");
        if (action == null) {
            action = "list";
        }

        // Lấy user từ session để load vé
        HttpSession session = req.getSession();
        vn.codegym.cs_module3.model.User loggedUser = (vn.codegym.cs_module3.model.User) session.getAttribute("user");
        if (loggedUser != null) {
            vn.codegym.cs_module3.DAO.TicketDAO ticketDAO = new vn.codegym.cs_module3.DAO.TicketDAO();
            // Sử dụng email thay vì id
            req.setAttribute("ticketList", ticketDAO.getTicketsByUserEmail(loggedUser.getEmail()));
        }

        switch (action) {
            case "detail":
                int id = Integer.parseInt(req.getParameter("id"));
                Event event = eventDAO.getEventById(id);
                int remainingTickets = eventDAO.getRemainingTickets(id);
                req.setAttribute("event", event); // chỉ 1 sự kiện
                req.setAttribute("remainingTickets", remainingTickets);
                dispatcher = req.getRequestDispatcher("views/detail.jsp");
                break;
            default:
                List<Event> eventList = eventDAO.getAllEvents();
                req.setAttribute("eventList", eventList); // danh sách sự kiện
                dispatcher = req.getRequestDispatcher("views/list.jsp");
                break;
        }
        dispatcher.forward(req, resp);
    }
}

