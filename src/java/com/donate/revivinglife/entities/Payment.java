
package com.donate.revivinglife.entities;



public class Payment {
    private int myPaymentID;
    private String orderID;
    private String paymentID;
    private String donationType;
    private String anonymity;
    private String status;
   private int amount;
 
    public Payment() {
    }

    
    
    public Payment(int myPaymentID, String orderID, String paymentID, String donationType, String anonymity, String status,int amount) {
        this.myPaymentID = myPaymentID;
        this.orderID = orderID;
        this.paymentID = paymentID;
        this.donationType = donationType;
        this.anonymity = anonymity;
        this.status = status;
        this.amount=amount;
        
        
       
    }

    public Payment(String orderID, String paymentID, String donationType, String anonymity, String status,int amount) {
        this.orderID = orderID;
        this.paymentID = paymentID;
        this.donationType = donationType;
        this.anonymity = anonymity;
        this.status = status;
        this.amount=amount;
        
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

    public String getAnonymity() {
        return anonymity;
    }

    public void setAnonymity(String anonymity) {
        this.anonymity = anonymity;
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
    
   
}
