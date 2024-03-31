package com.donate.revivinglife.dao;

import java.sql.Connection;
import java.sql.*;

public class CountTotalDonationTypesDao {
    private Connection conn;

    public CountTotalDonationTypesDao(Connection conn) {
        this.conn = conn;
    }

    public int countTotalDonationTypes()
    {
        int count = 0;
        try {
            // Query to count the total number of users in the table
            String query = "SELECT COUNT(*) AS total_donation_types FROM DONATIONTYPE";
            try (PreparedStatement pstmt = this.conn.prepareStatement(query)) {
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) {
                    count = rs.getInt("total_donation_types");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle the exception as per your application's error handling strategy
        }
        return count;
    }
}
