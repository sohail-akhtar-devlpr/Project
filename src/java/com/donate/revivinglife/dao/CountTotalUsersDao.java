package com.donate.revivinglife.dao;

import java.sql.Connection;
import java.sql.*;

public class CountTotalUsersDao {
    private Connection conn;

    public CountTotalUsersDao(Connection conn) {
        this.conn = conn;
    }

    public int countTotalUsers()
    {
        int count = 0;
        try {
            // Query to count the total number of users in the table
            String query = "SELECT COUNT(*) AS total_users FROM USERS";
            try (PreparedStatement pstmt = this.conn.prepareStatement(query)) {
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) {
                    count = rs.getInt("total_users");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle the exception as per your application's error handling strategy
        }
        return count;
    }
}
