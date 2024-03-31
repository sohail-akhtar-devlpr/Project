
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.donate.revivinglife.entities.Message" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>

        <!-- css -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/mycss.css" rel="stylesheet" type="text/css"/>

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


    </head>
    <body>

        <!--navbar-->

        <%@include file="normal_navbar.jsp" %>

        <main class="d-flex align-items-center" style="padding-top:10px">
            <div class="container">
                <div class="row">
                    <div class="col-md-4 offset-md-4">
                        <div class="card" style="border: 2px solid orangered;border-radius: 24px;">
                            <div class="card-header primary-background " style="border-radius: 24px;">
                                <label style="font-weight:bolder; color: white;" class="fa fa-user-plus"> Login Here</label>
                                 
                            </div>



                            <%
                            Message m=(Message)session.getAttribute("msg");
                            
                            if(m!=null)
                            {
                            %>
                            <div style=" border-radius: 24px;" class="alert <%=m.getCssClass()%> " role="alert">
                                <strong><%=m.getContent()%></strong>
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <%
                             session.removeAttribute("msg");
                                }
                            %>



                            <div class="card-body">
                                <form action="LoginServlet" method="POST">
                                    <div class="form-group">
                                        <label for="exampleInputEmail1">Email address</label>
                                        <!--required mean field cannot be left empty-->
                                        <input style="border-radius: 24px;" name="email" required type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
                                        <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                                    </div>
                                    <div class="form-group">
                                        <label for="exampleInputPassword1">Password</label>
                                        <input style="border-radius: 24px;" name="password" required type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
                                    </div>
                                    <div class="container text-center">
                                        <button style="background: orangered; border-radius: 24px;"type="submit" class="btn btn-primary btn-lg font-weight-bold">Submit</button>
                                    </div>

                                </form>
                                <p class="text-center mt-2">New to RevivingLife? <a href="register_page.jsp">Register Now</a></p>
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
        <!-- <script>
            $(document).ready(function(){
                alert("Document loaded")
            })
         </script> -->   

    </body>
</html>
