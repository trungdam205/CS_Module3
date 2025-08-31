//package vn.codegym.cs_module3.controller;
//
//import vn.codegym.cs_module3.DAO.EventDAO;
//import vn.codegym.cs_module3.DAO.TicketDAO;
//import vn.codegym.cs_module3.model.Event;
//import vn.codegym.cs_module3.model.User;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//import java.io.IOException;
//import java.util.List;
//
//@WebServlet(name = "DashboardServlet", urlPatterns = "/dashboard")
//public class DashboardServlet extends HttpServlet {
//
//    private final EventDAO eventDAO = new EventDAO();
//
//    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        // Lấy danh sách sự kiện
//        List<Event> eventList = eventDAO.getAllEvents();
//        req.setAttribute("eventList", eventList);
//        HttpSession session = req.getSession();
//        User loggedUser = (User) session.getAttribute("user");
//
//        if (loggedUser != null) {
//            TicketDAO ticketDAO = new TicketDAO();
//                // Admin xem tất cả vé
//                req.setAttribute("ticketList", ticketDAO.getAllTickets());
//        }
//
//
//        // Forward sang dashboard JSP
//        req.getRequestDispatcher("views/admin/dashboard.jsp").forward(req, resp);
//    }
//}

package vn.codegym.cs_module3.controller;
import vn.codegym.cs_module3.model.Ticket;
import vn.codegym.cs_module3.DAO.EventDAO;
import vn.codegym.cs_module3.DAO.TicketDAO;
import vn.codegym.cs_module3.model.Event;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "DashboardServlet", urlPatterns = "/dashboard")
public class DashboardServlet extends HttpServlet {
    private EventDAO eventDAO;
    private TicketDAO ticketDAO;

    @Override
    public void init() {
        eventDAO = new EventDAO();
        ticketDAO = new TicketDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "search":
                handleSearch(req);
                break;

            case "list":
            default:
                handleList(req);
                break;
        }

        req.getRequestDispatcher("views/admin/dashboard.jsp").forward(req, resp);
    }

    private void handleList(HttpServletRequest req) {
        List<Event> allEvents = eventDAO.getAllEvents();
        List<Ticket> allTickets = ticketDAO.getAllTickets();

        req.setAttribute("eventList", allEvents);
        req.setAttribute("ticketList", allTickets);
        req.setAttribute("activeTab", "events"); // mặc định mở tab sự kiện
    }

    private void handleSearch(HttpServletRequest req) {
        String keyword = req.getParameter("keyword");
        if (keyword != null) {
            keyword = keyword.trim().replaceAll("\\s+", " ");
        }

        String tab = req.getParameter("tab");
        if (tab == null) tab = "events";

        if ("events".equals(tab)) {
            String location = req.getParameter("location");
            String price = req.getParameter("price");

            List<Event> searchResults = eventDAO.searchEvents(keyword, location, price);
            req.setAttribute("eventList", searchResults);

        } else if ("tickets".equals(tab)) {
            List<Ticket> searchResults = ticketDAO.searchTickets(keyword);
            req.setAttribute("ticketList", searchResults);
        }

        req.setAttribute("activeTab", tab);
    }
}
