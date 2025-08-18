package vn.codegym.cs_module3.model;

import java.sql.Time;
import java.util.Date;

public class Event {
    private int id;
    private String title;
    private String description;
    private String location;
    private Date date;
    private double price;
    private Time start_time;
    private Time end_time;
    private int total_tickets;
    private int tickets_sold;
    private String imageUrl;

    public Event() {
    }

    public Event(String title, String description, String location, Date date, double price, Time start_time, Time end_time) {
        this.title = title;
        this.description = description;
        this.location = location;
        this.date = date;
        this.price = price;
        this.start_time = start_time;
        this.end_time = end_time;
    }

    public Event(int id, String title, String description, String location, Date date, double price, Time start_time, Time end_time) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.location = location;
        this.date = date;
        this.price = price;
        this.start_time = start_time;
        this.end_time = end_time;
    }

    public Event(int id, String title, String description, String location, Date date, double price, Time start_time, Time end_time, int total_tickets, int tickets_sold,String imageUrl) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.location = location;
        this.date = date;
        this.price = price;
        this.start_time = start_time;
        this.end_time = end_time;
        this.total_tickets = total_tickets;
        this.tickets_sold = tickets_sold;
        this.imageUrl = imageUrl;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Time getStart_time() {
        return start_time;
    }

    public void setStart_time(Time start_time) {
        this.start_time = start_time;
    }

    public Time getEnd_time() {
        return end_time;
    }

    public void setEnd_time(Time end_time) {
        this.end_time = end_time;
    }

    public int getTickets_sold() {
        return tickets_sold;
    }

    public void setTickets_sold(int tickets_sold) {
        this.tickets_sold = tickets_sold;
    }

    public int getTotal_tickets() {
        return total_tickets;
    }

    public void setTotal_tickets(int total_tickets) {
        this.total_tickets = total_tickets;
    }
    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

}
