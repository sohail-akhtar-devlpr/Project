
package com.donate.revivinglife.entities;


public class Donor {
    private int donorID;
    private int userID;

    public Donor() {
    }

    public Donor(int donorID, int userID) {
        this.donorID = donorID;
        this.userID = userID;
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
    
    
}
