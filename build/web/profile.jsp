
<%@ page import="com.donate.revivinglife.entities.User" %>
<%@ page import="com.donate.revivinglife.entities.Message" %>
<%@page import="com.donate.revivinglife.entities.DonationType" %>
<%@page import="com.donate.revivinglife.dao.SelectDonationTypeDao" %>
<%@page import="com.donate.revivinglife.helper.ConnectionProvider" %>
<%@page import="com.donate.revivinglife.dao.DonorPaymentDao" %>
<%@page import="com.donate.revivinglife.entities.DonorPayment" %>
<%@page import="java.util.ArrayList" %>

<%@ page errorPage="error_page.jsp"%>
<%

User user=(User)session.getAttribute("currentUser");
if(user==null)
{
    response.sendRedirect("login_page.jsp");
}

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile Page</title>
        
        <!-- css -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/mycss.css" rel="stylesheet" type="text/css"/>


    </head>
    <body>

        <!--norma_navbar start-->
        <%@include file="user_navbar.jsp" %>

        <!--        <nav class="navbar navbar-expand-lg navbar-light primary-background">
                    <a class="navbar-brand" href="index.jsp">RevivingLife</a>
                    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
        
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav mr-auto">
                            <li class="nav-item active">
                                <a class="nav-link" href="index.jsp">Home <span class="sr-only">(current)</span></a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">contact us</a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                    Donation Type
                                </a>
        
                                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                                    <a class="dropdown-item" href="#">Food</a>
                                    <a class="dropdown-item" href="#">Medicine</a>
                                    <a class="dropdown-item" href="#">Education</a>
                                    <a class="dropdown-item" href="#">Natural Calamities</a>
                                    <a class="dropdown-item" href="#">Environment</a>
                                    <a class="dropdown-item" href="#">others</a>
                                    <div class="dropdown-divider"></div>
        
                                    <div class="text-center">
                                        <button type="button" class="btn btn-success">Donate Now</button>
                                    </div>         
                                </div>
        
                            </li>
                            <li class="nav-item">
                                  <a class="nav-link disabled" href="#">Disabled</a> 
                                <a class="nav-link" href="https://ngodarpan.gov.in/index.php/home/statewise" target="_blank">NGOs</a>
                            </li>
        
                        </ul>
                        <ul class="navbar-nav mr-right">
                            <li class="nav-item">
                                <a class="nav-link" href="#!" data-toggle="modal" data-target="#profile-modal"><span class="fa fa-user-circle"></span><%=user.getName()%></a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="LogoutServlet">Logout</a>
                            </li>
                        </ul>
                    </div>
                </nav> 
        
                normal_navbar end-->


        <%
        Message m=(Message)session.getAttribute("msg");
                            
        if(m!=null)
        {
        %>
        <div class="alert <%= m.getCssClass()%>" role="alert">      
            <%= m.getContent()%>
        </div>
        <%
         session.removeAttribute("msg");
            }
        %>


        <!--start of profile modal-->

        <!-- USER-Modal -->
        <div  class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div  class="modal-dialog" role="document">
                <div class="modal-content" style=" border-radius: 24px;">
                    <div  style=" border-radius: 24px;" class="modal-header primary-background text-white">
                        <h5 class="modal-title" id="exampleModalLabel"><%= user.getName()%></h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container text-center">
                            <img src="pics/<%= user.getProfile()%>" class="img-fluid" style=" border-radius: 50%; max-width: 150px">
                            <br>
                            <h5 class="modal-title mt-3" id="exampleModalLabel"><%=user.getName()%></h5>

                            <!--profile details-->

                        <div id="profile-details">
                            <table class="table">

                                <tbody>
                                    <tr>
                                        <th scope="row">ID</th>
                                        <td><%=user.getUserId()%></td>

                                    </tr>
                                    <tr>
                                        <th scope="row">Email</th>
                                        <td><%=user.getEmail()%></td>

                                    </tr>
                                    <tr>
                                        <th scope="row">Gender</th>
                                        <td><%=user.getGender()%></td>

                                    </tr>
                                    <tr>
                                        <th scope="row">Registered on</th>
                                        <td><%=user.getDateTime().toString()%></td>

                                    </tr>
                                  
                                    <tr>
                                        <th scope="row">Donation Details</th>
                                        <td><button  style=" border-radius: 24px;" id="showMeDonationHistory" type="button" class="btn btn-primary" data-toggle="modal" data-target="#showMeHistory">Show Me</button></td>
                                    </tr>

                                </tbody>
                            </table>
                        </div>

                        <!--profile Edit-->

                        <div id="profile-edit" style="display: none">
                            <h3 class="mt-2">Do edit carefully</h3>
                            <form action="EditServlet" method="POST" enctype="multipart/form-data">
                                <table class="table">
                                    <tr>
                                        <td>ID</td>
                                        <td><%=user.getUserId()%></td>
                                    </tr>

                                    <tr>
                                        <td>Email</td>
                                        <td><input type="email" class="form-control" name="user_email" value="<%=user.getEmail()%>"></td>
                                    </tr>

                                    <tr>
                                        <td>Name</td>
                                        <td><input type="text" class="form-control" name="user_name" value="<%=user.getName()%>"></td>
                                    </tr>
                                    <tr>
                                        <td>Password</td>
                                        <td><input type="password" class="form-control" name="user_password" value="<%=user.getPassword()%>"></td>
                                    </tr>
                                    <tr>
                                        <td>Gender</td>
                                        <td><%=user.getGender().toUpperCase()%></td>
                                    </tr>
                                    <tr>
                                        <td>Select New Profile Pic</td>
                                        <td><input type="file" name="image" class="form-control"></td>
                                    </tr>

<!--                                    <tr>
                                        <td>Select New Profile Pic</td>
                                        <td><input type="file" name="image" class="form-control"></td>
                                    </tr>-->

                                </table>
                                <div class="container">
                                    <button  style=" border-radius: 24px;" type="submit" class="btn btn-outline-primary">Save</button>
                                </div>
                            </form>
                        </div>           

                    </div>
                </div>
                <div class="modal-footer">
                    <button  style=" border-radius: 15px;" type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button  style=" border-radius: 15px;" id="edit-profile-button" type="button" class="btn btn-primary">Edit</button>
                </div>
            </div>
        </div>
    </div>

        <!--end of USER- profile modal-->



        <!-- START SHOW PAYMENT HISTORY DETAILS OF USERS-->

        <!-- Button trigger modal -->
        <!--        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter">
                    Launch demo modal
                </button>-->

        <!-- Modal -->
        <div class="modal fade" id="showMeHistory" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLongTitle">Donation History</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="table-responsive">
                            <table class="table" style="border-collapse: collapse;">

                                <thead class="thead-dark">

                                    <tr>

                                        <th scope="col">#</th>
                                        <th scope="col">PaymentID</th>
                                        <th scope="col">OrderID</th>
                                        <th scope="col">Amount</th>
                                        <th scope="col">type</th>
                                        <th scope="col">Paid On</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                    DonorPaymentDao dpd= new DonorPaymentDao(ConnectionProvider.getConnection());
                                    ArrayList<DonorPayment> paymentList = dpd.paymentHistory(user.getUserId());
                                    for(DonorPayment p : paymentList) {
                                    %>
                                    <tr>
                                        <th scope="row">1</th>
                                        <td><%=p.getPaymentID()%></td>
                                        <td><%=p.getOrderID()%></td>
                                        <td><%=p.getAmount()%></td>
                                        <td><%=p.getDonationType()%></td>
                                        <td><%=p.getPayDate().toString()%></td>

                                    </tr>
                                    <%
                                    }
                                    %>


                                </tbody>
                            </table>
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button id="close" type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <!--<button type="button" class="btn btn-primary">Save changes</button>-->
                    </div>
                </div>
            </div>
        </div>

        <!--END OF SHOW PAYMENT HISTORY DETAILS OF USERS--> 




        <div class="container text-center my-5">
            <h1 class="text-primary font-weight-bold">Every act of kindness is a heartbeat of love.</h1>
            <p class="lead text-dark">
                In the world of giving, a single gesture can touch countless lives. Your support can make a difference, no matter how small or large. Together, we can spread love and compassion to those in need.
            </p>
            <p class="text-muted">Your generosity knows no bounds.</p>

            <!-- "Donate Now" button -->
            <button style=" background: orangered; border-radius: 24px; font-weight: bold;" type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#paymentModal">Donate Now</button>

        </div>


        <!--Start of payment modal-->

        <!-- Button trigger modal -->
        <!-- Button trigger modal -->
        <!--        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#paymentModal">
                    Launch demo modal
                </button>-->

        <!-- Modal -->
        <div class="modal fade" id="paymentModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header border-0">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form id="payment-checkout">
                            <div class="form-group">
                                <div class="text-center">
                                    <h3 class="my-2">Donate Us</h3>
                                </div>
                                <div class="text-center my-4">
                                    <select id="donation_category">
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
                            <input id="paymentField" class="form-control" placeholder="Enter Amount">
                            <!--                            <div class="container text-center">
                                                            <label for="anonymous-checkbox">Donate Anonymously?</label>
                                                            <input type="checkbox" id="anonymous-checkbox" onclick="enableButton()">
                                                        </div>-->
                            <div class="container text-center">
                                <button id="payButton2" class="btn primary-background my-4" >Pay Now</button>
                            </div>
                            <!--<p class="text-center mt-2">To be known Donor? Please <a href="login_page.jsp">Login</a></p>-->
                        </form>

                    </div>
                </div>
            </div>
        </div>

        <!--end of payment modal-->



        <!-- javascript -->
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

        <!--//TOGGLE LOGIC BETWEEN PROFILE AND EDIT PROFILE --> 
        <script>
            $(document).ready(function () {

                let editStatus = false;

                $('#edit-profile-button').click(function ()
                {
                    if (editStatus == false)
                    {
                        // alert("button clicked");

                        //now we want to hide the profile details

                        $("#profile-details").hide();

                        //now we wan to show profile edit

                        $("#profile-edit").show();

                        editStatus = true;
                        $(this).text("Back");
                    } else
                    {
                        // alert("button clicked");

                        //now we want to hide the profile details

                        $("#profile-details").show();

                        //now we wan to show profile edit

                        $("#profile-edit").hide();

                        editStatus = false;
                        $(this).text("Edit");
                    }
                });
            });
        </script> 


        <!--//TOGGLE LOGIC BETWEEN SHOW DONATION HISTORY AND EDIT PROFILE --> 
        <!--        <script>
                    $(document).ready(function () {
        
                        let showDonationHistory = true;
        
                        $('#showMeDonationHistory').click(function ()
                        {
                            if (showDonationHistory == true)
                            {
                                // alert("button clicked");
        
                                //now we want to hide the profile details
        
                                $("#profile-details").hide();
        
                                //now we wan to show profile edit
        
                                $("#showMeDonationHistory").show();
        
                                showDonationHistory = false;
                                $("#close").text("Back");
                            } else
                            {
                                // alert("button clicked");
        
                                //now we want to hide the profile details
        
                                $("#profile-details").show();
        
                                //now we wan to show profile edit
        
                                $("#showMeDonationHistory").hide();
        
                                editStatus = false;
                                $(this).text("POP");
                            }
                        });
                    });
                </script>         -->



        <!--////////////////////////////////////////////////-->
        <!--PAYMENTS-->

        <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
        <script>
            document.getElementById('payButton2').addEventListener('click', function (event) {
                event.preventDefault(); // This prevents the default form submission behavior
                createUserOrderID(); // Your function to handle the payment logic
            });
        </script>
        <script>
            var xhttp = new XMLHttpRequest();
            var RazorpayOrderId;
            function createUserOrderID() {
                var amount = document.getElementById("paymentField").value;
                xhttp.open("POST", "http://localhost:1617/RevivingLifeDonationBox/userOrderCreations?amount=" + amount, true);
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
                            var donationType = document.getElementById("donation_category").value;

                            // Get the value of the anonymity field
                            //var isAnonymous = document.getElementById("anonymous-checkbox").checked;
                            //alert("6");
                            OpenCheckOut(amount, donationType);
                        } else {
                            //alert("7");
                            // alert("Payment creation failed.");
                        }
                    }
                };
                //alert("8");
                xhttp.send();
            }
            function OpenCheckOut(amount, donationType) {
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
                        // anonymous: isAnonymous // Include the anonymity field in the notes
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
//            function enableButton() {
//                var checkbox = document.getElementById("anonymous-checkbox");
//                var button = document.getElementById("payButton");
//                if (checkbox.checked) {
//                    button.disabled = false;
//                } else {
//                    button.disabled = true;
//                }
//            }


            function updatePaymentOnServer(payment_id, order_id, donationType, status) {
//                alert("2");
                //var xhttp = new XMLHttpRequest();
                //var url = "http://localhost:1617/RevivingLifeDonationBox/UserUpdatePaymentServlet";
                // var params = "payment_id=" + payment_id + "&order_id=" + order_id + "&status=" + status;

                var xhttp = new XMLHttpRequest();
                var url = "http://localhost:1617/RevivingLifeDonationBox/UserUpdatePaymentServlet?payment_id=" + payment_id + "&order_id=" + order_id + "&donationType=" + donationType + "&status=" + status;
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

            $(document).ready(function (e) {
                // alert("loading...");
            });

            $.ajax({
                url: "load_paymentHistory_page.jsp",
                method:"",
                        success: function (data, textStatus, jqXHR) {
                            console.log(data);
                            $("#paymentHistory").html(data);

                        }

            });
        </script>



    </body>
</html>
