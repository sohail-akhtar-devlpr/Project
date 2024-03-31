package com.donate.revivinglife.dao;

import com.donate.revivinglife.entities.Payment;
//import com.donate.revivinglife.servlets.OrderCreation;
import java.sql.*;

public class PaymentDao {

    private Connection conn;

    public PaymentDao(Connection conn) {//constructor
        this.conn = conn;

    }

    public boolean savePaymentDetails(Payment payment)//called from DonationTypeServlet
    {
        boolean f = false;
        try {

            //coding to send the donationType data to the database
            String query = "INSERT INTO ANONYMOUSPAYMENT(MYPAYMENTID,ORDERID,PAYMENTID,DONATIONTYPE,ANONYMITY,STATUS,AMOUNT) VALUES(ISEQ$$_97137.NEXTVAL,?,?,?,?,?,?)";
            try (PreparedStatement pstmt = this.conn.prepareStatement(query)) {
                pstmt.setString(1, payment.getOrderID());
                pstmt.setString(2, payment.getPaymentID());
                pstmt.setString(3, payment.getDonationType());
                pstmt.setString(4, payment.getAnonymity());
                pstmt.setString(5, payment.getStatus());
                pstmt.setInt(6, payment.getAmount());

                pstmt.executeUpdate();
            }
            f = true;

        } catch (SQLException e) {
        }
        return f;
    }

    public boolean updatePaymentInformation(String payment_id, String order_id,String donationType, String status) {
        boolean f = false;
        try {
            Connection conn = this.conn;
          //  String query = "UPDATE ANONYMOUSPAYMENT SET STATUS=? WHERE PAYMENTID=? AND ORDERID=?";
            String query = "UPDATE ANONYMOUSPAYMENT SET PAYMENTID=?,DONATIONTYPE=?,ANONYMITY=?, STATUS=? WHERE ORDERID=?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, payment_id);
            pstmt.setString(2, donationType);
            pstmt.setString(3, "anonymous");
            pstmt.setString(4, status);
            pstmt.setString(5, order_id);
            pstmt.executeUpdate();
            f = true;
            pstmt.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
}
