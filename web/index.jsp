<%@page import="com.donate.revivinglife.entities.User" %>
<%@page import="com.donate.revivinglife.dao.CountTotalUsersDao" %>
<%@page import="com.donate.revivinglife.dao.CountTotalAnonymousPaymentDao" %>
<%@page import="com.donate.revivinglife.dao.CountTotalDonorPaymentDao" %>
<%--<%@page import="com.donate.revivinglife.dao.CountTotalDonationTypesDao" %>--%>
<%@page import="com.donate.revivinglife.helper.ConnectionProvider" %>

<%
CountTotalUsersDao count= new CountTotalUsersDao(ConnectionProvider.getConnection());
//CountTotalDonationTypesDao typeCount= new CountTotalDonationTypesDao(ConnectionProvider.getConnection());
CountTotalAnonymousPaymentDao anonymouPaymentCount= new CountTotalAnonymousPaymentDao(ConnectionProvider.getConnection());
CountTotalDonorPaymentDao donorPaymentCount= new CountTotalDonorPaymentDao(ConnectionProvider.getConnection());
int anonymousAmount=anonymouPaymentCount.sumTotalAnonymousPayment();
int donorAmount=donorPaymentCount.sumTotalDonorPayment();
int totalSum=0;
totalSum=((anonymousAmount+donorAmount)/100);

System.out.println(totalSum);
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>

        <!--css-->
        <!--<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">-->
        <link href="css/mycss.css" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="preload" href="img/micheile-henderson-SoT4-mZhyhE-unsplash.jpg" as="image"/>

        <!-- css -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!--<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">-->

    </head>
    <body 
        style=" background-image: url('img/micheile-henderson-SoT4-mZhyhE-unsplash.jpg');
        background-size: cover; /* To ensure the image covers the entire background */
        background-repeat: no-repeat; /* To prevent the image from repeating */
        background-position: center top -120px; /* To position the image at the center */
        margin: 0;
        padding: 0;"

        >
        <!-- include directive -->
        <!--navbar-->
        <%@include file="normal_navbar.jsp" %>
        <div class="container-fluid p-0 m-0 ">
            <div class="jumbotron bg-transparent ">
                <div class="container text-right">
                    <h4 class="display-3" style="font-weight: 350;">Donation is welfare</h4>
                    <p style="font-weight: bold;margin-bottom:0;padding-right: 350px;">Its a way of thousands blessing</p>
                    <a href="donate_page.jsp"  class="btn btn-primary btn-lg font-weight-bold" style="background: orangered; border-radius: 50px; ">Donate Now</a>
                    <div class="contianer">
                        <div class="row mt-5 ml-10"><!-- ROW(first ROW) -->
                            <div class="col-md-3">
                                <!--empty COLUMN1-->
                            </div>
                            <div class="col-md-3">
                                <!--empty COLUMN2-->
                            </div>
                            <div class="col-md-3"><!-- COLUMN2 -->
                                <!-- second BOX, BOX IS NOTHING BUT CARD -->
                                <div class="card" style="border-radius: 20px; border: 2px solid orangered">
                                    <div class="card-body text-center">
                                        <div class="container">
                                            <img style="max-height: 50px" class="img-fluid rounded-circle" src="img/food-donation.png" alt="user_icon"/>
                                        </div>
                                        <h1><span class="fa fa-rupee" style="font-size:33px;"></span> <%=totalSum%></h1>
                                        <p style="font-weight:bold;">Worth Donations</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3"><!-- COLUMN3 -->
                                <!-- THIRD BOX, BOX IS NOTHING BUT CARD -->                               
                                <div class="card text-center" style="border-radius: 20px; border: 2px solid orangered;">
                                    <div class="card-body">
                                        <div class="container">
                                            <img style="max-height: 50px" class="img-fluid rounded-circle" src="img/group.png" alt="user_icon"/>
                                        </div>
                                        <h1><%=count.countTotalUsers()%></h1>
                                        <p style="font-weight:bold;">Donors</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- javascript -->
                <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

                <script>
                    // Handle dropdown hover
                    $(document).ready(function () {
                        $("#donation-dropdown").hover(
                                function () {
                                    $(this).addClass("show");
                                    $(this).find(".dropdown-menu").addClass("show");
                                },
                                function () {
                                    $(this).removeClass("show");
                                    $(this).find(".dropdown-menu").removeClass("show");
                                }
                        );

                        $("#signup-dropdown").hover(
                                function () {
                                    $(this).addClass("show");
                                    $(this).find(".dropdown-menu").addClass("show");
                                },
                                function () {
                                    $(this).removeClass("show");
                                    $(this).find(".dropdown-menu").removeClass("show");
                                }
                        );
                    });
                </script>
    </body>
</html>
