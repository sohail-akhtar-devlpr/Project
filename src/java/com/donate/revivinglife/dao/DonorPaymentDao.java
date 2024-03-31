package com.donate.revivinglife.dao;

import com.donate.revivinglife.entities.DonorPayment;
import com.donate.revivinglife.entities.Payment;
import java.sql.*;
import java.util.ArrayList;

public class DonorPaymentDao {

    private Connection conn;

    public DonorPaymentDao(Connection conn) {//constructor
        this.conn = conn;
    }

    public boolean savePaymentDetails(DonorPayment donorpayment)//called from DonationTypeServlet
    {
        boolean f = false;
        try {

            //coding to send the donationType data to the database
            String query = "INSERT INTO DONORPAYMENT(MYPAYMENTID,ORDERID,PAYMENTID,DONATIONTYPE,STATUS,AMOUNT,DONORID,USERID,PAIDON) VALUES(ISEQ$$_97183.NEXTVAL,?,?,?,?,?,?,?,CURRENT_TIMESTAMP)";
            try (PreparedStatement pstmt = this.conn.prepareStatement(query)) {
                pstmt.setString(1, donorpayment.getOrderID());
                pstmt.setString(2, donorpayment.getPaymentID());
                pstmt.setString(3, donorpayment.getDonationType());
                pstmt.setString(4, donorpayment.getStatus());
                pstmt.setInt(5, donorpayment.getAmount());
                pstmt.setInt(6, donorpayment.getDonorID());
                pstmt.setInt(7, donorpayment.getUserID());

                pstmt.executeUpdate();
                System.out.println("MAI DONORPAYMENT DAO HUN");
                System.out.println(donorpayment.getOrderID());
                System.out.println(donorpayment.getPaymentID());
                System.out.println(donorpayment.getDonationType());
                System.out.println(donorpayment.getStatus());
                System.out.println(donorpayment.getAmount());
                System.out.println(donorpayment.getDonorID());
                System.out.println(donorpayment.getUserID());
            }
            f = true;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return f;
    }

    public boolean updatePaymentInformation(String payment_id, String order_id, String donationType, String status) {
        boolean f = false;
        try {
            Connection conn = this.conn;
            //  String query = "UPDATE ANONYMOUSPAYMENT SET STATUS=? WHERE PAYMENTID=? AND ORDERID=?";
            String query = "UPDATE DONORPAYMENT SET PAYMENTID=?,DONATIONTYPE=?, STATUS=? WHERE ORDERID=?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, payment_id);
            pstmt.setString(2, donationType);
            // pstmt.setString(3, "anonymous");
            pstmt.setString(3, status);
            pstmt.setString(4, order_id);
            pstmt.executeUpdate();
            f = true;
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return f;
    }

    public ArrayList<DonorPayment> paymentHistory(int userID) {
        System.out.println("chal gya AJAX ");
        System.out.println("chal gya AJAX");
        System.out.println("chal gya AJAX");
        System.out.println("chal gya ");
        ArrayList<DonorPayment> paymentList = new ArrayList<>();
        try {
            String query = "SELECT * FROM DONORPAYMENT WHERE USERID=?";
            PreparedStatement st = this.conn.prepareStatement(query);
            st.setInt(1, userID);
            ResultSet set = st.executeQuery();
            while (set.next()) {
                String paymentID = set.getString("PAYMENTID");
                String orderID = set.getString("ORDERID");
                int amount = set.getInt("AMOUNT");
                String donationType = set.getString("DONATIONTYPE");
                Timestamp paidOn = set.getTimestamp("PAIDON");
                DonorPayment dp = new DonorPayment(paymentID, orderID, amount, donationType, paidOn);
                paymentList.add(dp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return paymentList;
    }

}
