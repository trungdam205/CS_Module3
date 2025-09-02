package vn.codegym.cs_module3.controller;

import vn.codegym.cs_module3.DAO.EventDAO;
import vn.codegym.cs_module3.DAO.TicketDAO;
import vn.codegym.cs_module3.model.Event;
import vn.codegym.cs_module3.model.Ticket;
import vn.codegym.cs_module3.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@WebServlet(name = "TicketServlet", urlPatterns = "/tickets")
public class TicketServlet extends HttpServlet {
    private TicketDAO ticketDAO;

    @Override
    public void init() {
        ticketDAO = new TicketDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "create":
                    showNewForm(request, response);
                    break;
                default:
                    response.sendRedirect("events"); // quay lại danh sách event
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "save":
                    insertTicket(request, response);
                    break;
                default:
                    response.sendRedirect("events");
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User loggedUser = (User) session.getAttribute("user");
        if (loggedUser != null) {
            TicketDAO ticketDAO = new TicketDAO();
            // Sử dụng email thay vì id
            request.setAttribute("ticketList", ticketDAO.getTicketsByUserEmail(loggedUser.getEmail()));
        }

        int eventId = Integer.parseInt(request.getParameter("eventId"));
        EventDAO eventDAO = new EventDAO();
        Event event = eventDAO.getEventById(eventId);

        int remainingTickets = eventDAO.getRemainingTickets(eventId);

        request.setAttribute("eventId", eventId);
        request.setAttribute("event", event);
        request.setAttribute("remainingTickets", remainingTickets);

        request.getRequestDispatcher("/views/ticket.jsp").forward(request, response);
    }

    private void insertTicket(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        int eventId = Integer.parseInt(request.getParameter("eventId"));

        // Lấy user từ session
        HttpSession session = request.getSession();
        User loggedUser = (User) session.getAttribute("user");
        if (loggedUser == null) {
            response.sendRedirect("auth?action=login");
            return;
        }

        String userName = loggedUser.getName();
        String userEmail = loggedUser.getEmail();
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // Kiểm tra vé còn lại từ EventDAO
        EventDAO eventDAO = new EventDAO();
        int remainingTickets = eventDAO.getRemainingTickets(eventId);
        if (quantity > remainingTickets) {
            request.setAttribute("errorMessage",
                    "Số lượng vé vượt quá giới hạn! Chỉ còn " + remainingTickets + " vé.");
            request.setAttribute("eventId", eventId);
            Event event = eventDAO.getEventById(eventId);
            request.setAttribute("event", event);
            request.setAttribute("remainingTickets", remainingTickets);
            request.getRequestDispatcher("/views/ticket.jsp").forward(request, response);
            return;
        }

        String qrCode = UUID.randomUUID().toString();
        Ticket ticket = new Ticket(eventId, userName, userEmail, quantity, qrCode);

        boolean success = ticketDAO.insert(ticket);
        if (success) {
            request.setAttribute("successMessage", "Đặt vé thành công!");
        } else {
            request.setAttribute("errorMessage", "Có lỗi khi đặt vé. Vui lòng thử lại.");
        }
        Event event = eventDAO.getEventById(eventId);
        request.setAttribute("eventId", eventId);
        request.setAttribute("event", event);
        request.setAttribute("remainingTickets", remainingTickets);
        request.getRequestDispatcher("/views/ticket.jsp").forward(request, response);
    }

}

