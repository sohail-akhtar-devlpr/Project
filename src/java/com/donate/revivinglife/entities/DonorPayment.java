package com.donate.revivinglife.entities;

import java.sql.Timestamp;

public class DonorPayment {

    private int myPaymentID;
    private String orderID;
    private String paymentID;
    private String donationType;
    private String status;
    private int amount;
    private int donorID;
    private int userID;
    private Timestamp paydate;

    public DonorPayment() {
    }

    public DonorPayment(int myPaymentID, String orderID, String paymentID, String donationType, String status, int amount, int donorID) {
        this.myPaymentID = myPaymentID;
        this.orderID = orderID;
        this.paymentID = paymentID;
        this.donationType = donationType;
        this.status = status;
        this.amount = amount;
        this.donorID = donorID;
    }

    public DonorPayment(String orderID, String paymentID, String donationType, String status, int amount, int donorID, int userID) {
        this.orderID = orderID;
        this.paymentID = paymentID;
        this.donationType = donationType;
        this.status = status;
        this.amount = amount;
        this.donorID = donorID;
        this.userID = userID;
    }

    public DonorPayment(String paymentID, String orderID, int amount, String donationType, Timestamp paidOn) {
        this.paymentID = paymentID;
        this.orderID = orderID;
        this.amount=amount;
        this.donationType = donationType;
        this.paydate=paidOn;

    }

    public int getMyPaymentID() {
        return myPaymentID;
    }

    public void setMyPaymentID(int myPaymentID) {
        this.myPaymentID = myPaymentID;
    }

    public String getOrderID() {
        return orderID;
    }

    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }

    public String getPaymentID() {
        return paymentID;
    }

    public void setPaymentID(String paymentID) {
        this.paymentID = paymentID;
    }

    public String getDonationType() {
        return donationType;
    }

    public void setDonationType(String donationType) {
        this.donationType = donationType;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public int getDonorID() {
        return donorID;
    }

    public void setDonorID(int donorID) {
        this.donorID = donorID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public Timestamp getPayDate() {
        return paydate;
    }

    public void setPayDate(Timestamp paydate) {
        this.paydate = paydate;
    }

}
