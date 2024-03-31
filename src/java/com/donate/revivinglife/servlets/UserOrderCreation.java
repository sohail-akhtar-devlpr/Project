package com.donate.revivinglife.servlets;

import com.donate.revivinglife.dao.DonorDao;
import com.donate.revivinglife.dao.DonorPaymentDao;
import com.donate.revivinglife.dao.PaymentDao;
import com.donate.revivinglife.entities.Donor;
import com.donate.revivinglife.entities.DonorPayment;
import com.donate.revivinglife.entities.User;
import org.json.*;
import com.razorpay.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.donate.revivinglife.entities.Payment;
import com.donate.revivinglife.helper.ConnectionProvider;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author sa451
 */
@WebServlet("/userOrderCreations")
public class UserOrderCreation extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        try (PrintWriter out = response.getWriter()) {
            RazorpayClient client = null;
            String orderId = null;
            int amt = 0;
            try {
                client = new RazorpayClient("rzp_test_qksO01f0N20twI", "CqBiSslqW8ICjRvPfnZYslPM");

                JSONObject options = new JSONObject();

                int amount = Integer.parseInt(request.getParameter("amount"));
                options.put("amount", (amount * 100)); // amount in the smallest currency unit
                options.put("currency", "INR");
                options.put("receipt", "order_rcptid_11");

                options.put("payment_capture", true);

                Order order = client.orders.create(options);
                orderId = order.get("id");
                amt = order.get("amount");

                //-------------------------------------------
                String paymentId = null;
                String donationType = null;

                JSONArray notesArray = (JSONArray) order.get("notes");
                // Loop through the array to find the required values
                for (Object obj : notesArray) {
                    JSONObject note = (JSONObject) obj;

                    donationType = note.get("donation_type").toString();
                }
                String status = order.get("status").toString();
//                int userId=Integer.parseInt(request.getParameter("userId"));

                //---------------------------------------------
                //GETTING CURRENT USER ID
//                User u= new User();

                int donorID=0;
                HttpSession session = request.getSession();
               User user=(User)session.getAttribute("currentUser");
               
                //User user = (User) session.getAttribute("currentUser");
                //                int userID=user.getUserId();
                //                user.setUserId(userID);
                //                System.out.println(user);
                //                System.out.println("hello i m userid");

                //----------------------------------------------
                //SAVER THE ORDER IN DATABASE 
//    public DonorPayment(String orderID, String paymentID, String donationType, String status, int amount, int donorID, int userID) {
         
                int userID=user.getUserId();
                Donor donor= new Donor();
                donor.setUserID(userID);
                DonorDao dd= new DonorDao(ConnectionProvider.getConnection());
                int dnrID=dd.getDonorID(userID);
//                 System.out.println("MAI YAHA HUN");
//                System.out.println(orderId);
//                System.out.println(paymentId);
//                System.out.println(donationType);
//                System.out.println(status);
//                System.out.println(amt);
//                System.out.println(dnrID);
//                System.out.println(userID);
//                System.out.println("MAI YAHA HUN");
        DonorPayment donorPayment = new DonorPayment(orderId,paymentId,donationType,status,amt,dnrID,userID);

        DonorPaymentDao dpd = new DonorPaymentDao(ConnectionProvider.getConnection());
                System.out.println("EXECUTED");
        dpd.savePaymentDetails(donorPayment);
                System.out.println("EXECUTED");
////  
//                if (dpd.savePaymentDetails(donorPayment)) {
//                    out.println("done");
//                } else {
//                    out.println("Error");
//                }

    }
    catch (RazorpayException e

    
        ) {
                // Handle Exception
                System.out.println(e.getMessage());
    }

    response.getWriter ()

.append(orderId);

        }
    }

    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);

    }

    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        RazorpayClient client = null;
        try {

            client = new RazorpayClient("rzp_test_qksO01f0N20twI", "CqBiSslqW8ICjRvPfnZYslPM");

            JSONObject options = new JSONObject();
            options.put("razorpay_payment_id", request.getParameter("razorpay_payment_id"));
            options.put("razorpay_order_id", request.getParameter("razorpay_order_id"));
            options.put("razorpay_signature", request.getParameter("razorpay_signature"));
            boolean SigRes = Utils.verifyPaymentSignature(options, "CqBiSslqW8ICjRvPfnZYslPM");

            if (SigRes) {
                response.getWriter().append("Payment successfull and signature verified");
                response.getWriter().append("YAHA GADBAD HAIN");
            } else {
                response.getWriter().append("Payment failed and signature not verified");
                response.getWriter().append("KI YAHA GADBAD HAIN");
            }

        } catch (RazorpayException e) {
            e.printStackTrace();
        }
    }

    @Override
public String getServletInfo() {
        return "Short description";
    }
}
