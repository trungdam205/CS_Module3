package vn.codegym.cs_module3.model;

import java.util.Date;

public class Event {
    private int id;
    private String title;
    private String description;
    private String location;
    private Date date;
    private double price;

    public Event() {
    }

    public Event(String title, String description, String location, Date date, double price) {
        this.title = title;
        this.description = description;
        this.location = location;
        this.date = date;
        this.price = price;
    }

    public Event(int id, String title, String description, String location, Date date, double price) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.location = location;
        this.date = date;
        this.price = price;
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


}
