package vn.codegym.cs_module3.model;

public class User {
    private int id;
    private String name;      // tên người dùng
    private String email;
    private String password;
    private String role;      // "ADMIN" hoặc "USER"

    // Constructor rỗng
    public User() {
    }

    // Constructor đầy đủ
    public User(int id, String name, String email, String password, String role) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.role = role;
    }

    // --- Getter & Setter ---
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // name
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    // email
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    // password
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    // role
    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    // toString()
    @Override
    public String toString() {
        return "User [id=" + id + ", name=" + name + ", email=" + email + ", role=" + role + "]";
    }
}
