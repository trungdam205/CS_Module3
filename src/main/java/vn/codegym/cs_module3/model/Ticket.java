package vn.codegym.cs_module3.model;

import java.util.Date;

public class Ticket {
    private int id;
    private int eventId;
    private String userName;
    private String userEmail;
    private int quantity;
    private String qrCode;
    private String status;
    private Date purchase_date;
    private String eventTitle;
    private double eventPrice;

    public Ticket() {}

    public Ticket(int id, int eventId, String userName, String userEmail, int quantity, String qrCode, String status, Date purchase_date) {
        this.id = id;
        this.eventId = eventId;
        this.userName = userName;
        this.userEmail = userEmail;
        this.quantity = quantity;
        this.qrCode = qrCode;
        this.status = status;
        this.purchase_date = purchase_date;
    }
    public Ticket(int eventId,String userName,String userEmail,int quantity,String qrCode) {
        this.eventId = eventId;
        this.userName = userName;
        this.userEmail = userEmail;
        this.quantity = quantity;
        this.qrCode = qrCode;
    }
    public Ticket(int eventId, String userName, String userEmail, int quantity, String qrCode, String status, Date purchase_date) {
        this.eventId = eventId;
        this.userName = userName;
        this.userEmail = userEmail;
        this.quantity = quantity;
        this.qrCode = qrCode;
        this.status = status;
        this.purchase_date = purchase_date;
    }


    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getQrCode() {
        return qrCode;
    }

    public void setQrCode(String qrCode) {
        this.qrCode = qrCode;
    }

    public Date getPurchase_date() {
        return purchase_date;
    }

    public void setPurchase_date(Date purchase_date) {
        this.purchase_date = purchase_date;
    }
    public String getEventTitle() { return eventTitle; }
    public void setEventTitle(String eventTitle) { this.eventTitle = eventTitle; }
    public double getTotalPrice() {
        return quantity * eventPrice;
    }

    public double getEventPrice() {
        return eventPrice;
    }

    public void setEventPrice(double eventPrice) {
        this.eventPrice = eventPrice;
    }
}

