/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author c9
 */
public class Users {
    private String user;
    private String pass;
    private String email;
    private int roll;

    public Users() {
    }

    public Users(String user, String pass, String email, int roll) {
        this.user = user;
        this.pass = pass;
        this.email = email;
        this.roll = roll;
    }
    
    public Users(String user, String pass, int roll) {
        this.user = user;
        this.pass = pass;
        this.roll = roll;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getRoll() {
        return roll;
    }

    public void setRoll(int roll) {
        this.roll = roll;
    }

    @Override
    public String toString() {
        return "Users{" + "user=" + user + ", pass=" + pass + ", email=" + email + ", roll=" + roll + '}';
    }
    
    
}
