/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.donate.revivinglife.servlets;

import com.donate.revivinglife.dao.PaymentDao;
import com.donate.revivinglife.helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
/**
 *
 * @author sa451
 */
@WebServlet(name = "UpdatePaymentServlet", urlPatterns = {"/Updat_order"})
public class UpdatePaymentServlet extends HttpServlet {

    /**
     *
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        String payment_id = request.getParameter("payment_id");
        String order_id = request.getParameter("order_id");
        String status = request.getParameter("status");
        String donationType = request.getParameter("donationType");

        // Your update logic here
        // Example: Update the payment information in the database
        // Replace this with your own logic
        PaymentDao paymentDao = new PaymentDao(ConnectionProvider.getConnection());
        paymentDao.updatePaymentInformation(payment_id, order_id,donationType, status);
//        boolean updateSuccess = paymentDao.updatePaymentInformation(payment_id, order_id, status);
//
//        if (updateSuccess) {
//            out.println("Payment information updated successfully.");
//        } else {
//            out.println("Failed to update payment information.");
//        }
    }
}