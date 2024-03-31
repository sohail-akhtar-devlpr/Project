package com.donate.revivinglife.dao;

import java.sql.*;

public class DonorDao {

    private Connection conn;

    public DonorDao(Connection conn) {
        this.conn = conn;
    }

    public int getDonorID(int userID) {
        int donorID = -1; // Default value if not found
        try {
            // Query to fetch donorID from DONOR table based on email
            String query = "SELECT donorID FROM DONOR WHERE userID = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, userID);

            // Execute the query
            ResultSet rs = pstmt.executeQuery();

            // If the result set is not empty, get the donorID
            if (rs.next()) {
                donorID = rs.getInt("donorID");
            }

            rs.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return donorID;
    }
}
