package com.donate.revivinglife.dao;

import com.donate.revivinglife.entities.DonationType;
import java.sql.*;

public class DonationTypeDao {

    private Connection conn;

    public DonationTypeDao(Connection conn) {//constructor
        this.conn = conn;

    }

    public boolean saveDonationType(DonationType donationType)//called from DonationTypeServlet
    {
        boolean f = false;
        try {

            //coding to send the donationType data to the database
            String query = "INSERT INTO DONATIONTYPE(TYPEID,DONATIONTYPE) VALUES(DONATIONTYPE_SEQ.NEXTVAL,?)";
            try (PreparedStatement pstmt = this.conn.prepareStatement(query)) {
                pstmt.setString(1, donationType.getDonationType());
                pstmt.executeUpdate();
            }
            f = true;

        } catch (SQLException e) {
        }
        return f;
    }

    public boolean deleteDonationType(DonationType donationType) // called from DeleteDonationTypeServlet
    {
        boolean f = false;
        try {
            // Search for the donation type to ensure it exists in the database
            String searchQuery = "SELECT * FROM DONATIONTYPE WHERE DONATIONTYPE = ?";
            try (PreparedStatement searchStmt = this.conn.prepareStatement(searchQuery)) {
                searchStmt.setString(1, donationType.getDonationType());
                ResultSet resultSet = searchStmt.executeQuery();

                if (resultSet.next()) {
                    // If the entry exists, proceed with the deletion
                    String deleteQuery = "DELETE FROM DONATIONTYPE WHERE DONATIONTYPE = ?";
                    try (PreparedStatement deleteStmt = this.conn.prepareStatement(deleteQuery)) {
                        deleteStmt.setString(1, donationType.getDonationType());
                        deleteStmt.executeUpdate();
                        f = true; // Setting the flag to true upon successful deletion
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace(); // Printing the stack trace for debugging purposes
        }
        return f;
    }

}
