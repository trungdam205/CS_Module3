package vn.codegym.cs_module3.controller;

import vn.codegym.cs_module3.DAO.EventDAO;
import vn.codegym.cs_module3.DAO.TicketDAO;
import vn.codegym.cs_module3.model.Event;
import vn.codegym.cs_module3.model.Ticket;
import vn.codegym.cs_module3.model.User;
import vn.codegym.cs_module3.util.QRUtil;
import vn.codegym.cs_module3.util.SignUtil;
import vn.codegym.cs_module3.util.MailUtil;
import java.io.File;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

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
            throws SQLException, IOException, ServletException {

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

        // Kiểm tra vé còn lại
        EventDAO eventDAO = new EventDAO();
        int remaining = eventDAO.getRemainingTickets(eventId);
        if (quantity > remaining) {
            request.setAttribute("errorMessage",
                    "Số lượng vé vượt quá giới hạn! Chỉ còn " + remaining + " vé.");
            request.setAttribute("eventId", eventId);
            request.setAttribute("event", eventDAO.getEventById(eventId));
            request.setAttribute("remainingTickets", remaining);
            request.getRequestDispatcher("/views/ticket.jsp").forward(request, response);
            return;
        }

        // === CÁCH B ===
        // 1) Insert ticket qua SP (chưa có id) – tạm để qr_code null
        Ticket ticket = new Ticket(eventId, userName, userEmail, quantity, null);
        boolean success = ticketDAO.insert(ticket);
        if (!success) {
            request.setAttribute("errorMessage", "Có lỗi khi đặt vé. Vui lòng thử lại.");
            request.setAttribute("eventId", eventId);
            request.setAttribute("event", eventDAO.getEventById(eventId));
            request.setAttribute("remainingTickets", eventDAO.getRemainingTickets(eventId));
            request.getRequestDispatcher("/views/ticket.jsp").forward(request, response);
            return;
        }

        // 2) Tìm ticketId mới nhất theo email + event (dựa vào purchase_date, id)
        Integer ticketId = ticketDAO.findLastTicketId(userEmail, eventId);
        if (ticketId == null) {
            request.setAttribute("errorMessage", "Không tìm thấy mã vé vừa tạo.");
            request.setAttribute("eventId", eventId);
            request.setAttribute("event", eventDAO.getEventById(eventId));
            request.setAttribute("remainingTickets", eventDAO.getRemainingTickets(eventId));
            request.getRequestDispatcher("/views/ticket.jsp").forward(request, response);
            return;
        }

        try {
            // 3) Tạo payload có chữ ký + sinh ảnh QR
            String payload = SignUtil.sign(ticketId, eventId);

            String absDir  = getServletContext().getRealPath("/assets/qrcodes");
            String fileNameNoExt = "ticket_" + ticketId;
            String qrPath  = QRUtil.generateQRCodePng(payload, absDir, fileNameNoExt, 350);

            // Đường dẫn web để hiển thị trong app/email
            String webPath = request.getContextPath() + "/assets/qrcodes/" + fileNameNoExt + ".png";

            // 4) Lưu đường dẫn QR vào DB
            ticketDAO.updateQrPath(ticketId, webPath);

            // 5) Gửi email xác nhận kèm ảnh QR
            String baseUrl = request.getScheme() + "://" + request.getServerName() + ":" +
                    request.getServerPort() + request.getContextPath();

            String html = "<h3>Đặt vé thành công</h3>"
                    + "<p>Xin chào " + userName + ", bạn đã đặt " + quantity + " vé cho sự kiện #" + eventId + ".</p>"
                    + "<p>Mã QR được đính kèm email. Bạn cũng có thể check-in trực tiếp bằng liên kết: "
                    + "<a href='" + baseUrl + "/admin/checkin?data=" + payload + "'>Check-in nhanh</a></p>";

            MailUtil.sendWithQr(userEmail, "Xác nhận vé #" + ticketId, html, new File(qrPath));

            // 6) Forward sang trang cảm ơn
            request.setAttribute("ticketId", ticketId);
            request.getRequestDispatcher("/views/thankyou.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            // (tuỳ chọn) rollback một phần: xoá ảnh QR nếu đã tạo
            request.setAttribute("errorMessage", "Lỗi tạo QR/gửi email: " + e.getMessage());
            request.setAttribute("eventId", eventId);
            request.setAttribute("event", eventDAO.getEventById(eventId));
            request.setAttribute("remainingTickets", eventDAO.getRemainingTickets(eventId));
            request.getRequestDispatcher("/views/ticket.jsp").forward(request, response);
        }
    }


}

