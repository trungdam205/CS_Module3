package vn.codegym.cs_module3.controller;

import vn.codegym.cs_module3.DAO.TicketDAO;
import vn.codegym.cs_module3.model.Event;
import vn.codegym.cs_module3.DAO.EventDAO;
import vn.codegym.cs_module3.model.User;
import vn.codegym.cs_module3.model.Ticket;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Time;
import java.sql.Date;
import java.util.List;

@WebServlet(name = "EventServlet", urlPatterns = "/events")
public class EventServlet extends HttpServlet {
    private final EventDAO eventDAO = new EventDAO();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher dispatcher;
        String action = req.getParameter("action");
        if (action == null) {
            action = "list";
        }

        // Lấy user từ session để load vé
        HttpSession session = req.getSession();
        User loggedUser = (User) session.getAttribute("user");
        if (loggedUser != null) {
            TicketDAO ticketDAO = new TicketDAO();
            // Sử dụng email thay vì id
            req.setAttribute("ticketList", ticketDAO.getTicketsByUserEmail(loggedUser.getEmail()));
        }

        switch (action) {
            case "detail":
                int id = Integer.parseInt(req.getParameter("id"));
                Event event = eventDAO.getEventById(id);
                int remainingTickets = eventDAO.getRemainingTickets(id);
                req.setAttribute("event", event);
                req.setAttribute("remainingTickets", remainingTickets);
                dispatcher = req.getRequestDispatcher("views/detail.jsp");
                break;
            case "create":
                // Hiển thị form tạo event
                dispatcher = req.getRequestDispatcher("views/admin/create.jsp");
                break;
            case "update":
                int idUD = Integer.parseInt(req.getParameter("id"));
                Event eventUD = eventDAO.getEventById(idUD);
                req.setAttribute("event", eventUD);
                dispatcher = req.getRequestDispatcher("views/admin/update.jsp");
                break;
            case "delete":
                int idDelete = Integer.parseInt(req.getParameter("id"));
                eventDAO.deleteEventById(idDelete);

                // Thêm thông báo vào session (nếu muốn)
                HttpSession sessionDelete = req.getSession();
                sessionDelete.setAttribute("message", "Xóa sự kiện thành công!");

                resp.sendRedirect("dashboard");
                return;
            case "search":
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
                    List<Ticket> searchResults = TicketDAO.searchTickets(keyword);
                    req.setAttribute("ticketList", searchResults);
                }

                req.setAttribute("activeTab", tab);
                dispatcher = req.getRequestDispatcher("views/admin/dashboard.jsp");
                break;

//
            default:
                List<Event> eventList = eventDAO.getAllEvents();
                req.setAttribute("eventList", eventList); // danh sách sự kiện
                dispatcher = req.getRequestDispatcher("views/list.jsp");
                break;
        }
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String action = req.getParameter("action");
        switch (action) {
            case "create":
                String title = req.getParameter("title");
                String description = req.getParameter("description");
                String location = req.getParameter("location");
                String dateStr = req.getParameter("date");
                String startStr = req.getParameter("start_time");
                String endStr = req.getParameter("end_time");
                String priceStr = req.getParameter("price");
                String totalTicketsStr = req.getParameter("total_tickets");
                String imageUrl = req.getParameter("imageUrl");

                // Parse dữ liệu
                java.sql.Date date = java.sql.Date.valueOf(dateStr);

                Time startTime = Time.valueOf(startStr.length() == 5 ? startStr + ":00" : startStr);
                Time endTime = Time.valueOf(endStr.length() == 5 ? endStr + ":00" : endStr);
                double price = Double.parseDouble(priceStr);
                int totalTickets = Integer.parseInt(totalTicketsStr);

                Event newEvent = new Event(title, description, location, date, price, startTime, endTime, totalTickets, imageUrl);
                boolean success = eventDAO.insertEvent(newEvent);
                if (success) {
                    req.setAttribute("successMessage", "Thêm sự kiện mới thành công!");
                } else {
                    req.setAttribute("errorMessage", "Có lỗi khi thêm sự kiện mới. Vui lòng thử lại.");
                }
                // Thông báo thành công qua session
                HttpSession session = req.getSession();
                session.setAttribute("message", "Thêm sự kiện thành công!");

                req.getRequestDispatcher("/views/admin/create.jsp").forward(req, resp);
                break;
            case "update":
                int id = Integer.parseInt(req.getParameter("id"));
                String titleUD = req.getParameter("title");
                String descriptionUD = req.getParameter("description");
                String locationUD = req.getParameter("location");
                double priceUD = Double.parseDouble(req.getParameter("price"));
                int totalTicketsUD = Integer.parseInt(req.getParameter("total_tickets"));
                String imageUrlUD = req.getParameter("imageUrl");

                Date dateUD = Date.valueOf(req.getParameter("date"));
                Time start = Time.valueOf(req.getParameter("start_time") + ":00");
                Time end = Time.valueOf(req.getParameter("end_time") + ":00");

                Event updatedEvent = new Event(id, titleUD, descriptionUD, locationUD, dateUD, priceUD, start, end, totalTicketsUD, imageUrlUD);


                eventDAO.updateEvent(updatedEvent);
                resp.sendRedirect("dashboard");
                break;
        }
    }
}



