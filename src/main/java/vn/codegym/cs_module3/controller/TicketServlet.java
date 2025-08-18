package vn.codegym.cs_module3.controller;

import vn.codegym.cs_module3.DAO.TicketDAO;
import vn.codegym.cs_module3.model.Ticket;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.UUID;

@WebServlet(name = "TicketServlet", urlPatterns = "/tickets")
public class TicketServlet extends HttpServlet {
    private TicketDAO ticketDAO;

    @Override
    public void init() throws ServletException {
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
                    case "list":
                default:
                    response.sendRedirect("events"); // quay lại danh sách event
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy eventId từ param và truyền sang form
        String eventId = request.getParameter("eventId");
        request.setAttribute("eventId", eventId);
        request.getRequestDispatcher("/views/ticket.jsp").forward(request, response);
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

    private void insertTicket(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException, ServletException {
        int eventId = Integer.parseInt(request.getParameter("eventId"));
        String userName = request.getParameter("userName");
        String userEmail = request.getParameter("userEmail");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String qrCode = UUID.randomUUID().toString();

        Ticket ticket = new Ticket(eventId, userName, userEmail, quantity, qrCode);
        ticketDAO.insert(ticket);
        request.setAttribute("successMessage", "Đặt vé thành công!");
        request.setAttribute("eventId", eventId);
        request.getRequestDispatcher("/views/ticket.jsp").forward(request, response);
        response.sendRedirect("events?action=detail&id=" + eventId);
    }


}

