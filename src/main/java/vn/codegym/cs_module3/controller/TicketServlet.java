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
import java.sql.SQLException;
import java.util.UUID;

@WebServlet(name = "TicketServlet", urlPatterns = "/tickets")
public class TicketServlet extends HttpServlet {
    private TicketDAO ticketDAO;
    private EventDAO eventDAO;

    @Override
    public void init() throws ServletException {
        ticketDAO = new TicketDAO();
        eventDAO = new EventDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "create":
                    showNewForm(request, response);
                    break;
                default:
                    response.sendRedirect("events");
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
            request.setAttribute("ticketList", ticketDAO.getTicketsByUserEmail(loggedUser.getEmail()));
        }

        String eventIdParam = request.getParameter("eventId");
        int eventId;
        try {
            eventId = Integer.parseInt(eventIdParam);
        } catch (NumberFormatException e) {
            response.sendRedirect("events");
            return;
        }

        Event event = eventDAO.getEventById(eventId);
        int remainingTickets = eventDAO.getRemainingTickets(eventId);

        request.setAttribute("eventId", eventId);
        request.setAttribute("event", event);
        request.setAttribute("remainingTickets", remainingTickets);

        request.getRequestDispatcher("/views/ticket.jsp").forward(request, response);
    }

    private void insertTicket(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String eventIdParam = request.getParameter("eventId");
        String quantityParam = request.getParameter("quantity");
        int eventId, quantity;

        try {
            eventId = Integer.parseInt(eventIdParam);
            quantity = Integer.parseInt(quantityParam);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Dữ liệu không hợp lệ. Vui lòng thử lại.");
            showNewForm(request, response);
            return;
        }

        HttpSession session = request.getSession();
        User loggedUser = (User) session.getAttribute("user");
        if (loggedUser == null) {
            response.sendRedirect("auth?action=login");
            return;
        }

        String userName = loggedUser.getName();
        String userEmail = loggedUser.getEmail();

        int remainingTickets = eventDAO.getRemainingTickets(eventId);
        if (quantity > remainingTickets) {
            request.setAttribute("errorMessage", "Số lượng vé đặt vượt quá giới hạn! Chỉ còn " + remainingTickets + " vé.");
            showNewForm(request, response);
            return;
        }

        String qrCode = UUID.randomUUID().toString();
        Ticket ticket = new Ticket(eventId, userName, userEmail, quantity, qrCode);

        boolean success;
        try {
            success = ticketDAO.insert(ticket);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Có lỗi khi đặt vé. Vui lòng thử lại.");
            showNewForm(request, response);
            return;
        }

        if (success) {
            request.setAttribute("successMessage", "Đặt vé thành công!");
        } else {
            request.setAttribute("errorMessage", "Có lỗi khi đặt vé. Vui lòng thử lại.");
        }

        showNewForm(request, response);
    }
}