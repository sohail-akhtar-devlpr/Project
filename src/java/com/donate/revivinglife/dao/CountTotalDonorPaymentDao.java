package com.donate.revivinglife.dao;

import java.sql.Connection;
import java.sql.*;

public class CountTotalDonorPaymentDao {

    private Connection conn;

    public CountTotalDonorPaymentDao(Connection conn) {
        this.conn = conn;
    }

    public int sumTotalDonorPayment() {
        int totalAmount = 0;
        try {
            String query = "SELECT SUM(amount) AS total_donor_payment FROM DONORPAYMENT WHERE STATUS='paid'";
            try (PreparedStatement pstmt = this.conn.prepareStatement(query)) {
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) {
                    totalAmount = rs.getInt("total_donor_payment");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle the exception as per your application's error handling strategy
        }
        System.out.println("TOTAL DONOR AMOUNT = " + totalAmount);
        return totalAmount;
    }

}
