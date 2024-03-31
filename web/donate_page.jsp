<%@page import="com.donate.revivinglife.entities.DonationType" %>
<%@page import="com.donate.revivinglife.dao.SelectDonationTypeDao" %>
<%@page import="com.donate.revivinglife.helper.ConnectionProvider" %>
<%@page import="java.util.ArrayList" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Annonymous Donation Page</title>
        <link rel="preload" href="img/decorative-colorful-daisy-flowers-background.jpg" as="image"/>

        <style>

            .required::after{
                content: " *";
                color: red;
                font: 20px;
            }

        </style>

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/mycss.css" rel="stylesheet" type="text/css"/>
        <link rel="preload" href="img/decorative-colorful-daisy-flowers-background.jpg" as="image"/>


    </head>
    <body

        style="background-image: url('img/decorative-colorful-daisy-flowers-background.jpg');
        background-size: cover;
        background-repeat: no-repeat;
         margin: 0;
        padding: 0;"
        >

        <%@include file="normal_navbar.jsp" %>
        <main class="d-flex align-items-center" style="height:70vh">
            <div class="container">
                <div class="row" >
                    <div class="col-md-4 offset-md-4">
                        <div class="card" style="border: 3px solid orangered; border-radius: 20px;">  
                            <div class="card-body">
                                <form id="payment-checkout"  >
                                    <div class="form-group">
                                        <div class="text-center">
                                            <h3 class="my-2" style="font-weight: bolder">Donate Us</h3>
                                        </div>
                                        <div class="text-center my-4">
                                            <label class="required">Choose Category</label>
                                            <br>
                                            <select id="donation-category" required >
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
                                    </div>
                                    <label class="required">Fill Amount</label>
                                    <input style="border-radius: 24px;" id="payment_field" class="form-control" placeholder="Enter Amount" required>
                                    <div class="container text-center">
                                        <label for="anonymous-checkbox">Donate Anonymously?</label>
                                        <input type="checkbox" id="anonymous-checkbox" onclick="enableButton()">
                                    </div>
                                    <div class="container text-center">
                                        <button style="border-radius: 24px; color: white; font-weight: bold" id="payButton" class="btn primary-background" disabled="" type="submit">Donate Now</button>
                                    </div>
                                    <p class="text-center mt-2">To be known Donor? Please <a href="login_page.jsp">Login</a></p>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
        <script>
                                            document.getElementById('payButton').addEventListener('click', function (event) {
                                                event.preventDefault(); // This prevents the default form submission behavior
                                                createOrderID(); // Your function to handle the payment logic
                                            });
        </script>
        <script>
            var xhttp = new XMLHttpRequest();
            var RazorpayOrderId;
            function createOrderID() {
                var amount = document.getElementById("payment_field").value;
                xhttp.open("POST", "http://localhost:1617/RevivingLifeDonationBox/OrderCreations?amount=" + amount, true);
                // alert("1");
                xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                //alert("2");
                xhttp.onreadystatechange = function () {
                    //alert("3");
                    if (this.readyState === 4 && this.status === 200) {
                        // alert("4");
                        if (this.responseText) {
                            // alert("5");
                            RazorpayOrderId = this.responseText;

                            // Get the selected donation type
                            var donationType = document.getElementById("donation-category").value;

                            // Get the value of the anonymity field
                            var isAnonymous = document.getElementById("anonymous-checkbox").checked;
                            //alert("6");
                            OpenCheckOut(amount, donationType, isAnonymous);
                        } else {
                            //alert("7");
                            // alert("Payment creation failed.");
                        }
                    }
                };
                //alert("8");
                xhttp.send();
            }
            function OpenCheckOut(amount, donationType, isAnonymous) {
                var options = {
                    key: "rzp_test_qksO01f0N20twI", // Enter the Key ID generated from the Dashboard
                    amount: amount * 100, // Amount is in currency subunits. Default currency is INR. Hence, 50000 refers to 50000 paise
                    currency: "INR",
                    name: "Reviving Life",
                    description: "Test Transaction",
                    order_id: RazorpayOrderId, //This is a sample Order ID. Pass the `id` obtained in the response of Step 1
                    handler: function (response) {
//                        alert("1");
                        console.log(response.razorpay_payment_id);
                        console.log(response.razorpay_order_id);
                        console.log(response.razorpay_signature);

                        updatePaymentOnServer
                                (
                                        response.razorpay_payment_id,
                                        response.razorpay_order_id,
                                        donationType,
                                        "paid"
                                        );
                    },
                    prefill: {
                        name: "",
                        email: "",
                        contact: ""
                    },
                    notes: {
                        /* "address": "Razorpay Corporate Office"*/
                        donation_type: donationType, // Include the donation type in the notes
                        anonymous: isAnonymous // Include the anonymity field in the notes
                    },
                    theme: {
                        "color": "#3399cc"
                    }
                };
                var rzp1 = new Razorpay(options);
                rzp1.on('payment.failed', function (response) {
                    alert(response.error.code);
                    alert(response.error.description);
                    alert(response.error.source);
                    alert(response.error.step);
                    alert(response.error.reason);
                    alert(response.error.metadata.order_id);
                    alert(response.error.metadata.payment_id);
                });

                rzp1.open();

            }
            //alert("payment fail...");

        </script>



        <script>
            function enableButton() {
                var checkbox = document.getElementById("anonymous-checkbox");
                var button = document.getElementById("payButton");
                if (checkbox.checked) {
                    button.disabled = false;
                } else {
                    button.disabled = true;
                }
            }


            function updatePaymentOnServer(payment_id, order_id, donationType, status) {
//                alert("2");
                //var xhttp = new XMLHttpRequest();
                //var url = "http://localhost:1617/RevivingLifeDonationBox/Updat_order";
                // var params = "payment_id=" + payment_id + "&order_id=" + order_id + "&status=" + status;

                var xhttp = new XMLHttpRequest();
                var url = "http://localhost:1617/RevivingLifeDonationBox/Updat_order?payment_id=" + payment_id + "&order_id=" + order_id + "&donationType=" + donationType + "&status=" + status;
                xhttp.open("POST", url, true);
                xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                xhttp.onreadystatechange = function () {
                    if (this.readyState === 4 && this.status === 200) {
                        // Response handling code here
                        console.log("Payment updated on the server.");
                    }
                };

                xhttp.send();
            }
        </script>
        
        
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

