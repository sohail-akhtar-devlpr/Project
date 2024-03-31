<%@page import="com.donate.revivinglife.entities.DonationType" %>
<%@page import="com.donate.revivinglife.dao.SelectDonationTypeDao" %>
<%@page import="com.donate.revivinglife.helper.ConnectionProvider" %>
<%@page import="java.util.ArrayList" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Donation Page</title>

        <style>
            body {
                background-image: url('img/josh-appel-NeTPASr-bmQ-unsplash.jpg');
                background-size: cover; /* To ensure the image covers the entire background */
                background-repeat: no-repeat; /* To prevent the image from repeating */
                background-position: center center; /* To position the image at the center */
            }

            /* Preload the image */
            #preload-img {
                display: none;
                background-image: url('img/josh-appel-NeTPASr-bmQ-unsplash.jpg');
            }
        </style>

        <script>

            var xhttp = new XMLHttpRequest();
            var RazorpayOrderId;
            function createUserOrderID()
            {

                xhttp.open("POST", "http://localhost:1617/RevivingLifeDonationBox/userOrderCreation", true);
                xhttp.send();
                RazorpayOrderId = xhttp.responseText;
                OpenCheckOut(event);

            }

        </script>

        <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
        <script>
            function OpenCheckOut(e) {
                var userAmount = document.getElementById("payment_field").value;
                var options = {
                    key: "rzp_test_qksO01f0N20twI", // Enter the Key ID generated from the Dashboard
                    amount: userAmount * 100,
                    currency: "INR",
                    name: "RevivingLife",
                    description: "Test Transaction",
                    order_id: RazorpayOrderId, //This is a sample Order ID. Pass the `id` obtained in the response of Step 1
                    handler: function (response) {
//                        alert(response.razorpay_payment_id);
//                        alert(response.razorpay_order_id);
//                        alert(response.razorpay_signature);
                    },
                    prefill: {
                        name: "",
                        email: "",
                        contact: ""
                    }
                };
                var rzp = new Razorpay(options);
                rzp.on('payment.failed', function (response) {
                    alert(response.error.code);
                    alert(response.error.description);
                    alert(response.error.source);
                    alert(response.error.step);
                    alert(response.error.reason);
                    alert(response.error.metadata.order_id);
                    alert(response.error.metadata.payment_id);
                });
                rzp.open();
                e.preventDefault();

            }
        </script>


        <!-- css -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/mycss.css" rel="stylesheet" type="text/css"/>


    </head>
    <body>


        <main class="d-flex align-items-center" style="height:70vh">
            <div class="container">
                <div class="row">
                    <div class="col-md-4 offset-md-4">
                        <div class="card">  
                            <div class="card-body">
                                <form id="payment-checkout">
                                    <div class="form-group">
                                        <div class="text-center">
                                            <h3 class="my-2">Donate Us</h3>
                                        </div>
                                        <div class="text-center my-4">
                                            <select id="donation-category">
                                                <option selected disabled>Donation Category</option>
                                                <%
                                                    SelectDonationTypeDao sd= new SelectDonationTypeDao(ConnectionProvider.getConnection());
                                                    ArrayList<DonationType> list=sd.getAllCategories();
                                                    for(DonationType d:list)
                                                    {
                                                %>
                                                <option><%=d.getDonationType()%></option>
                                                <%
                                                    }
                                                %>

                                            </select>
                                        </div>


                                        <input name="donate-us" class="form-control" id="payment_field"  placeholder="Enter Amount">
                                    </div>

                                    <div class="container text-center">
                                        <button onClick="createUserOrderID()" class="btn primary-background">Donate Now</button>
                                    </div>

                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!-- javascript -->
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    </body>
</html>
