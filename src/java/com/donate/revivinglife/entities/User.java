
package com.donate.revivinglife.entities;
import java.sql.*;
import java.sql.Timestamp;
public class User {
    private int userId;
    private String name;
    private String email;
    private String password;
    private String gender;
    private Timestamp regDate;
    private String profile;
    private String userType="user";
   

    public User(int userId, String name, String email, String password, String gender, Timestamp regDate) {
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.password = password;
        this.gender = gender;
        this.regDate = regDate;
    }

    public User() {
    }

    public User(String name, String email, String password, String gender) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.gender = gender;
        
    }
    
    
    
    //getters and setters because variables are private

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Timestamp getDateTime() {
        return regDate;
    }

    public void setDateTime(Timestamp regDate) {
        this.regDate = regDate;
    }

    public String getProfile() {//agar zaroorat pdi to constructor me add kr denge
        return profile;
    }

    public void setProfile(String profile) {
        this.profile = profile;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String user) {
        this.userType = user;
    }
    
    
}
