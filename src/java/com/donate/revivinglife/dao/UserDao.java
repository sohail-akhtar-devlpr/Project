
package com.donate.revivinglife.dao;

import com.donate.revivinglife.entities.User;
import java.sql.*;

public class UserDao {
    private Connection conn;

    public UserDao(Connection conn) {//constructor
        this.conn = conn;
    }
    
    // userdefined method to insert the data in the User table in the database
    
    public boolean saveUser(User user) {
    boolean f = false;
    try {

        // coding to send the user data to the database

        String query = "INSERT INTO USERS VALUES(USERS_SEQ.NEXTVAL,?,?,?,?,CURRENT_TIMESTAMP,'default.png','user')";
        PreparedStatement pstmt = this.conn.prepareStatement(query);
        pstmt.setString(1, user.getName());
        pstmt.setString(2, user.getEmail());
        pstmt.setString(3, user.getPassword());
        pstmt.setString(4, user.getGender());

        int result = pstmt.executeUpdate();
        if (result > 0) {
            // Get the last inserted userId
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT MAX(USERID) AS USERID FROM USERS");
            int userId = 0;
            if (rs.next()) {
                userId = rs.getInt("USERID");
            }
            // Insert the userId into the Donor table
            String donorQuery = "INSERT INTO DONOR(DONORID,USERID) VALUES(ISEQ$$_96954.NEXTVAL, ?)";
            PreparedStatement donorPstmt = conn.prepareStatement(donorQuery);
            donorPstmt.setInt(1, userId);
            donorPstmt.executeUpdate();
            donorPstmt.close();
            f = true;
        }
        pstmt.close();

    } catch (Exception e) {
        e.printStackTrace();
    }
    return f;
}

    
    //get user by useremail and userpassword, called from LoginServlet
    
    public User getUserByEmailAndPassword(String email, String password)
    {
        User user=null;
        
        try {
            
            //fetching details from database
            String query= "select * from users where email=? and password=?";
            PreparedStatement pstmt=conn.prepareStatement(query);
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            ResultSet set=pstmt.executeQuery();
            
            if(set.next())
            {
                user= new User();
                //DATA FROM DATABASE(database se data le rhe hain)
                String name=set.getString("USERNAME");
                
                //SET TO USER OBJECT
                user.setName(name);
                
                user.setUserId(set.getInt("USERID"));//same hi hain bas ek me likh diya
                user.setEmail(set.getString("EMAIL"));
                user.setPassword(set.getString("PASSWORD"));
                user.setGender(set.getString("GENDER"));
                //user.setDateTime(set.getTimestamp("REGDATE"));
                user.setDateTime(set.getTimestamp("REGDATE"));
                user.setProfile(set.getString("PROFILE"));
                user.setUserType(set.getString("USERTYPE"));
            }
        }catch (Exception e){
            
            e.printStackTrace();
        }
        
        return user;
    }
    
    
    public boolean updateUser(User user)
    {
        boolean f=false;
        try {
            
            String query= "UPDATE USERS SET USERNAME=?, EMAIL=?, PASSWORD=?, GENDER=?, PROFILE=? WHERE USERID=?";
            PreparedStatement p=conn.prepareStatement(query);
            
            p.setString(1, user.getName());
            p.setString(2,user.getEmail());
            p.setString(3, user.getPassword());
            p.setString(4, user.getGender());
            p.setString(5, user.getProfile());
            p.setInt(6, user.getUserId());
            
            p.executeUpdate();
            
            f=true;
            
            
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
}
