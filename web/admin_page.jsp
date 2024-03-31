<%@page import="com.donate.revivinglife.entities.User" %>
<%@page import="com.donate.revivinglife.dao.CountTotalUsersDao" %>
<%@page import="com.donate.revivinglife.dao.CountTotalAnonymousPaymentDao" %>
<%@page import="com.donate.revivinglife.dao.CountTotalDonorPaymentDao" %>
<%@page import="com.donate.revivinglife.dao.CountTotalDonationTypesDao" %>
<%@page import="com.donate.revivinglife.helper.ConnectionProvider" %>

<%
    User user=(User)session.getAttribute("currentUser");
    if(user==null)
    {
        session.setAttribute("message","you are not logged in !!Login first");
        response.sendRedirect("login_page.jsp");
        return;
    }
    else
    {
        if(user.getUserType().equals("user"))
        {
            session.setAttribute("message","You are not Admin !!Do not access this page");
            response.sendRedirect("login_page.jsp");
            return;
        }
    }

%>

<%

CountTotalUsersDao count= new CountTotalUsersDao(ConnectionProvider.getConnection());
CountTotalDonationTypesDao typeCount= new CountTotalDonationTypesDao(ConnectionProvider.getConnection());
CountTotalAnonymousPaymentDao anonymouPaymentCount= new CountTotalAnonymousPaymentDao(ConnectionProvider.getConnection());
CountTotalDonorPaymentDao donorPaymentCount= new CountTotalDonorPaymentDao(ConnectionProvider.getConnection());
int anonymousAmount=anonymouPaymentCount.sumTotalAnonymousPayment();
int donorAmount=donorPaymentCount.sumTotalDonorPayment();
int totalSum=0;
totalSum=((anonymousAmount+donorAmount)/100);

System.out.println(totalSum);
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Panel</title>

        <!-- css -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/mycss.css" rel="stylesheet" type="text/css"/>
        <link href="css/admincss.css" rel="stylesheet" type="text/css"/>

    </head>
    <body>
        <%@include file="admin_navbar.jsp" %>

        <div class="container admin"><!-- main contain -->
            <div class="row mt-3"><!-- ROW(first ROW) -->


                <div class="col-md-4"><!-- COLUMN1 -->

                    <!-- fIRST BOX, BOX IS NOTHING BUT CARD -->

                    <div class="card">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-height: 125px" class="img-fluid rounded-circle" src="img/man.png" alt="user_icon"/>
                            </div>
                            <h1><%=count.countTotalUsers()%></h1>
                            <h1 class="text-uppercase text-muted">USERS</h1>

                        </div>

                    </div>

                </div>

                <div class="col-md-4"><!-- COLUMN2 -->

                    <!-- second BOX, BOX IS NOTHING BUT CARD -->

                    <div class="card">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-height: 125px" class="img-fluid rounded-circle" src="img/gross.png" alt="user_icon"/>
                            </div>
                            <h1><%=totalSum%> Rs</h1>
                            <h1 class="text-uppercase text-muted">DONATIONS</h1>

                        </div>

                    </div>

                </div>

                <div class="col-md-4"><!-- COLUMN3 -->

                    <!-- THIRD BOX, BOX IS NOTHING BUT CARD -->

                    <div class="card text-center">
                        <div class="card-body">
                            <div class="container">
                                <img style="max-height: 125px" class="img-fluid rounded-circle" src="img/give-love.png" alt="user_icon"/>
                            </div>
                            <h1><%=typeCount.countTotalDonationTypes()%></h1>
                            <h1 class="text-uppercase text-muted">TYPEs</h1>

                        </div>

                    </div>


                </div>

            </div>

            <!-- SECOND ROW  FIRST COLUMN-->

            <div class="row mt-3">

                <div class="col-md-6 addtype">
                    <div class="card text-center">
                        <div class="card-body" data-toggle="modal" data-target="#add-category-modal">
                            <div class="container">
                                <img style="max-height: 125px" class="img-fluid rounded-circle" src="img/add.png" alt="user_icon"/>
                            </div>
                            <!--                            <p>Click here to add Donation Categories</p>-->
                            <h1 class="text-uppercase text-muted">ADD TYPES</h1>

                        </div>

                    </div>
                </div>
                <!-- SECOND ROW  SECOND COLUMN-->
                <!--                <div class="col-md-6">
                                    <div class="card text-center">
                                        <div class="card-body">
                                            <div class="container">
                                                <img style="max-height: 125px" class="img-fluid rounded-circle" src="img/add-file.png" alt="user_icon"/>
                                            </div>
                                            <p>Click here to add NGOs information</p>
                                            <h1 class="text-uppercase text-muted">ADD NGOs</h1>
                
                                        </div>
                
                                    </div>
                                </div>-->
                <!-- SECOND ROW  SECOND COLUMN-->
                <div class="col-md-6 deletetype">
                    <div class="card text-center">
                        <div class="card-body" data-toggle="modal" data-target="#delete-category-modal">
                            <div class="container">
                                <img style="max-height: 125px" class="img-fluid rounded-circle" src="img/trash.png" alt="user_icon"/>
                            </div>
                            <!--<p>Click here to add Donation Categories</p>-->
                            <h1 class="text-uppercase text-muted">DELETE TYPES</h1>

                        </div>

                    </div>
                </div>


            </div>


            <!-- ADD DONATION TYPE MODAL -->

            <!-- modal start -->

            <!-- Button trigger modal -->


            <!-- Modal -->
            <div class="modal fade" id="add-category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Add Donation Categories</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <form  id="addDonationType" action="DonationTypeServlet" method="POST">

                                <div class="form-group">
                                    <input type="text" class="form-control" name="catTitle" placeholder="Enter category" required=""/>

                                </div>

                                <div class="container text-center">
                                    <button class="btn btn-outline-primary">ADD</button>
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>

                                </div>

                            </form>

                        </div>

                    </div>
                </div>
            </div>

            <!-- ADD DONATION TYPE modal end -->



            <!-- DELETE DONATION TYPE MODAL -->

            <!-- modal start -->

            <!-- Button trigger modal -->


            <!-- Modal -->
            <div class="modal fade" id="delete-category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Delete Donation Categories</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <form  id="deleteDonationType" action="DeleteDonationTypeServlet" method="POST">

                                <div class="form-group">
                                    <input type="text" class="form-control" name="donationType" placeholder="Enter category" required=""/>

                                </div>

                                <div class="container text-center">
                                    <button class="btn btn-outline-primary">DELETE</button>
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>

                                </div>

                            </form>

                        </div>

                    </div>
                </div>
            </div>

            <!-- DELETE DONATION TYPE modal end -->


            <!-- ADMIN PROFILE -->

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
                                <img src="pics/<%= user.getProfile()%>"  style="border-radius: 50%; max-width: 150px" class="rounded-circle">
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
                                                <th scope="row">Role</th>
                                                <td>Admin</td>

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

<!--                                            <tr>
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


            <!-- END of ADMIN Profile -->



            <!-- javascript -->
            <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>

            <script>
                $(document).ready(function () {
                    $('#addDonationType').on("submit", function (event) {
                        // This code gets called when the form gets submitted
                        event.preventDefault();
                        let form = new FormData(this);

                        // Now requesting to SERVER
                        $.ajax({
                            url: "DonationTypeServlet",
                            type: 'POST',
                            data: form,
                            success: function (data, textStatus, jqXHR) {
                                // SUCCESS...
                                console.log(data);
                                if (data.trim() === 'done') {
                                    swal("DONE", "Data Inserted Successfully", "success");
                                } else {
                                    swal("ERROR", "Something went wrong!!", "error");
                                }
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                // ERROR...
                                swal("ERROR", "Something went wrong!!", "error");
                            },
                            processData: false,
                            contentType: false
                        });
                    });
                });
            </script>

            <script>


                $(document).ready(function () {
                    $('#deleteDonationType').on("submit", function (event) {
                        // This code gets called when the form gets submitted
                        event.preventDefault();
                        let form = new FormData(this);

                        // Now requesting to SERVER
                        $.ajax({
                            url: "DeleteDonationTypeServlet",
                            type: 'POST',
                            data: form,
                            success: function (data, textStatus, jqXHR) {
                                // SUCCESS...
                                console.log(data);
                                if (data.trim() === 'done') {
                                    swal("DONE", "Data Deleted Successfully", "success");
                                } else {
                                    swal("ERROR", "Data does not exist to delete", "error");
                                }
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                // ERROR...
                                swal("ERROR", "Something went wrong!!", "error");
                            },
                            processData: false,
                            contentType: false
                        });
                    });
                });

            </script>


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


    </body>
</html>
