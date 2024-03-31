
package com.donate.revivinglife.dao;
import com.donate.revivinglife.entities.DonationType;
import java.sql.*;
import java.util.ArrayList;
public class SelectDonationTypeDao {
    Connection conn;

    public SelectDonationTypeDao(Connection conn) {
        this.conn = conn;
    }
    public ArrayList<DonationType> getAllCategories()//DonationType.java
    {
        ArrayList<DonationType> list=new ArrayList<>();
        try {
            String q="select * from donationtype";
            Statement st= this.conn.createStatement();
            ResultSet set= st.executeQuery(q);
            while(set.next())
            {
                int typeID= set.getInt("TYPEID");
                String donationType= set.getString("DONATIONTYPE");
                
                DonationType dt= new DonationType(typeID, donationType);
                list.add(dt);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
