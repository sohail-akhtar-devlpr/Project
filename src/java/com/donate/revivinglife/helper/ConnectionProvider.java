
package com.donate.revivinglife.helper;

import java.sql.*;

public class ConnectionProvider {
    private static Connection conn;
    
    public static Connection getConnection(){
        
        try {
            
            
            if(conn==null)
            {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                
                conn= DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl",
                "c##RevivingLife", "life");
            } 
        } catch (Exception e) {
            //out.println("connection not established");
            System.out.println("Connection not established");
            e.printStackTrace();
        }
        
        return conn;
    }
}



