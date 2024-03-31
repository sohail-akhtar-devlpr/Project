
package com.donate.revivinglife.entities;

public class DonationType {
    private int typeID;
    private String donationType;
    
    public DonationType()
    {
        
    }

    public DonationType(String donationType) {
        this.donationType = donationType;
    }

    public DonationType(int typeID, String donationType) {
        this.typeID = typeID;
        this.donationType = donationType;
        
        
    }

    public int getTypeID() {
        return typeID;
    }

    public void setTypeID(int typeID) {
        this.typeID = typeID;
    }
    
    
    
    public String getDonationType() {
        return donationType;
    }

    public void setDonationType(String donationType) {
        this.donationType = donationType;
    }
    
    
    
    
    
    
}
