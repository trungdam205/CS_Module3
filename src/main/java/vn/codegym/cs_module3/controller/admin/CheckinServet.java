package vn.codegym.cs_module3.controller.admin;

import vn.codegym.cs_module3.DAO.TicketDAO;
import vn.codegym.cs_module3.util.SignUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "CheckinServlet", urlPatterns = {"/admin/checkin"})
class CheckinServlet extends HttpServlet {

    private final TicketDAO ticketDAO = new TicketDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String data = req.getParameter("data");
        if (data == null) {
            resp.sendError(400, "Thiếu tham số data");
            return;
        }
        String[] parts = data.split(":");
        if (parts.length != 3) {
            resp.sendError(400, "QR payload không hợp lệ");
            return;
        }
        String ticketId = parts[0], eventId = parts[1], sig = parts[2];

        if (!SignUtil.verify(ticketId, eventId, sig)) {
            resp.sendError(403, "QR không hợp lệ (signature sai)");
            return;
        }

        int tId = Integer.parseInt(ticketId);
        String status = ticketDAO.getStatus(tId);
        if ("CHECKED_IN".equalsIgnoreCase(status)) {
            req.setAttribute("message", "Vé #" + ticketId + " đã check-in trước đó!");
        } else {
            ticketDAO.updateStatus(tId, "CHECKED_IN");
            req.setAttribute("message", "Check-in thành công cho vé #" + ticketId);
        }
        req.getRequestDispatcher("/views/checkin_result.jsp").forward(req, resp);
    }
}
