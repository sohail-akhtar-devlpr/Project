package com.donate.revivinglife.servlets;

import com.donate.revivinglife.dao.PaymentDao;
import org.json.*;
import com.razorpay.*;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.donate.revivinglife.entities.Payment;
import com.donate.revivinglife.helper.ConnectionProvider;

@WebServlet("/OrderCreations")
public class OrderCreation extends HttpServlet {

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
                String anonymity = null;

                JSONArray notesArray = (JSONArray) order.get("notes");
                // Loop through the array to find the required values
                for (Object obj : notesArray) {
                    JSONObject note = (JSONObject) obj;

                    donationType = note.get("donation_type").toString();
                    anonymity = note.get("anonymous").toString();
                }
                String status = order.get("status").toString();

                
                //----------------------------------------------
                //SAVER THE ORDER IN DATABASE 
                Payment myPayment = new Payment();
                myPayment.setOrderID(orderId);
                myPayment.setPaymentID("null");
                myPayment.setDonationType(donationType);
                myPayment.setAnonymity(anonymity);
                myPayment.setStatus(status);
                myPayment.setAmount(amt);
            
////                // myPayment.setAmount(order.get("amount"));
                PaymentDao pd = new PaymentDao(ConnectionProvider.getConnection());
                pd.savePaymentDetails(myPayment);
//  
//                if (pd.savePaymentDetails(myPayment)) {
//                    out.println("done");
//                } else {
//                    out.println("Error");
//                }

            } catch (RazorpayException e) {
                // Handle Exception
                System.out.println(e.getMessage());
            }
            response.getWriter().append(orderId);

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


/*
if (orderId != null) {
                    response.getWriter().append(orderId);
                } else {
                    // handle the error
                    response.getWriter().append("SOHAIL AKHTAR").toString();
                }
                //-----------------------------------------------------
                //-------------------------------------------------------
                int amt = order.get("amount");
                String paymentId = null;
                String donationType = null;
                String anonymity = null;

                JSONArray notesArray = (JSONArray) order.get("notes");
                // Loop through the array to find the required values
                for (Object obj : notesArray) {
                    JSONObject note = (JSONObject) obj;

                    donationType = note.get("donation_type").toString();
                    anonymity = note.get("anonymous").toString();
                }
                String status = order.get("status").toString();

                //SAVER THE ORDER IN DATABASE 
                Payment myPayment = new Payment(orderId, paymentId, donationType, anonymity, status, amt);
                // myPayment.setAmount(order.get("amount"));
                PaymentDao pd = new PaymentDao(ConnectionProvider.getConnection());

                if (pd.savePaymentDetails(myPayment)) {
                    out.println("done");
                } else {
                    out.println("Error");
                }
 */
