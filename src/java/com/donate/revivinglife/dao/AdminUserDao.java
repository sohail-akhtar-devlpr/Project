
package com.donate.revivinglife.dao;

import com.donate.revivinglife.entities.AdminUser;
//import com.donate.revivinglife.entities.User;
import java.sql.*;

public class AdminUserDao {
    private Connection conn;

    public AdminUserDao(Connection conn) {
        this.conn = conn;
    }
    
    // userdefined method to insert the data in the User table in the database
    
     public  boolean saveUser(AdminUser adminUser )//called from AdminRegisterServlet
    {
        boolean f=false;
        try {
            
            //coding to send the user data to the database

            String query="INSERT INTO USERS(USERID,USERNAME,EMAIL,PASSWORD,GENDER,REGDATE,PROFILE,USERTYPE) VALUES(USERS_SEQ.NEXTVAL,?,?,?,?,CURRENT_TIMESTAMP,'default.png',?)";
            PreparedStatement pstmt= this.conn.prepareStatement(query);
            pstmt.setString(1, adminUser.getName());
            pstmt.setString(2, adminUser.getEmail());
            pstmt.setString(3, adminUser.getPassword());
            pstmt.setString(4, adminUser.getGender());
            pstmt.setString(5, adminUser.getUserType());
            
            pstmt.executeUpdate();
            pstmt.close();
            f=true;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
    
    //get user by useremail and userpassword, called from LoginServlet
    
    public AdminUser getUserByEmailAndPassword(String email, String password)
    {
        AdminUser adminUser=null;
        
        try {
            
            //fetching details from database
            String query= "select * from users where email=? and password=?";
            PreparedStatement pstmt=conn.prepareStatement(query);
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            ResultSet set=pstmt.executeQuery();
            
            if(set.next())
            {
                adminUser= new AdminUser();
                //DATA FROM DATABASE
                String name=set.getString("USERNAME");
                
                //SET TO USER OBJECT
                adminUser.setName(name);
                
                adminUser.setUserId(set.getInt("USERID"));//same hi hain bas ek me likh diya
                adminUser.setEmail(set.getString("EMAIL"));
                adminUser.setPassword(set.getString("PASSWORD"));
                adminUser.setGender(set.getString("GENDER"));
                //user.setDateTime(set.getTimestamp("REGDATE"));
                adminUser.setDateTime(set.getTimestamp("REGDATE"));
                adminUser.setProfile(set.getString("PROFILE"));
                
            }
        }catch (Exception e){
            
            e.printStackTrace();
        }
        
        return adminUser;
    }
    
    
    public boolean updateUser(AdminUser adminUser)
    {
        boolean f=false;
        try {
            
            String query= "UPDATE USERS SET USERNAME=?, EMAIL=?, PASSWORD=?, GENDER=?, PROFILE=? WHERE USERID=?";
            PreparedStatement p=conn.prepareStatement(query);
            
            p.setString(1, adminUser.getName());
            p.setString(2,adminUser.getEmail());
            p.setString(3, adminUser.getPassword());
            p.setString(4, adminUser.getGender());
            p.setString(5, adminUser.getProfile());
            p.setInt(6, adminUser.getUserId());
            
            p.executeUpdate();
            
            f=true;
            
            
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
}
