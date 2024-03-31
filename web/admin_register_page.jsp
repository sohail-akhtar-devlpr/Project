
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page</title>
        
         <style>

            .required::after{
                content: " *";
                color: red;
                font: 20px;
            }

        </style>
        
        <!-- css -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/mycss.css" rel="stylesheet" type="text/css"/>
        
        
    </head>
    <body>
        
    <!--navbar-->
    
    <%@include file="normal_navbar.jsp" %>
        <main style="padding-top:5px">
            <div class="container">
                <div class="col-md-6 offset-md-3">
                    <div class="card" style="border: 2px solid orangered; border-radius: 24px;">
                        
                        <div class="card-header" style="border-radius: 24px; background: #e040fb;">
                            <label style="font-weight: bold; color: white">Admin Registration</label>
                            
                        </div>
                        
                        <div class="card-body">
                            
                            <form id="admin-reg-form" action="AdminRegisterServlet" method="post">
                                
                                <div class="form-group">
                                    <label class="required" for="user_name">User Name</label>
                                  <input style="border-radius: 24px;" name="user-name" type="text" class="form-control" id="user_name" aria-describedby="emailHelp" placeholder="Enter Name">
                                </div>
                                
                                <div class="form-group">
                                    <label class="required" for="exampleInputEmail1">Email address</label>
                                  <input style="border-radius: 24px;" name="user-email" type="email" class="form-control " id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email">
                                  <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                                </div>
                                
                                
                                
                                <div class="form-group">
                                  <label class="required" for="exampleInputPassword1">Password</label>
                                  <input style="border-radius: 24px;" name="user-password" type="password" class="form-control " id="exampleInputPassword1" placeholder="Password">
                                </div>
                                
                                
                                <div class="form-group">
                                  <label class="required" for="gender">Select Gender</label>
                                  <br>
                              <input type="radio" id="male-gender" name="gender" value="male">Male
                                  <input type="radio" id="female-gender" name="gender" value="female">Female

                                </div>                          
                                <div class="form-check">
                                  <input name="check" type="checkbox" class="form-check-input" id="exampleCheck1" value="checked">
                                  <label style="border-radius: 24px;" class="form-check-label required" for="exampleCheck1">Agree terms and conditions</label>
                                </div>
                                <br>
                                <div class="container text-center">
                                <button style="background: orangered; border-radius: 24px;" type="submit" class="btn btn-primary btn-lg">Submit</button>
                                </div>
                            </form>
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

        
        <script>
            $(document).ready(function(){
                console.log("loaded.....");
                //alert("Document loaded")
                $('#admin-reg-form').on('submit',function(event){
                 
                 event.preventDefault();//prevent from going to Servlet
                 //we will submit the whole data to the servlet from here
                 
                 let form= new FormData(this);//this object will get the whole data of the form
                 
                 //Now send the whole data on the RegisterServlet
                 //to do this, we will use the ajax function.
                 
                 $.ajax({
                    url:"AdminRegisterServlet",
                    type:'POST',
                    data:form,
                    success:function(data,textStatus,jqXHR){
                        console.log(data);
                        if(data.trim()==='done')
                        {
                            swal("Successfully Registered!!click ok to Login")
                        .then((value) => {
                            
                        //to redirect on the login page use window object
                        window.location="login_page.jsp"
                        /*swal(`The returned value is: ${value}`);*/
                        });
                        }
                        else
                        {
                             swal(data);
                        } 
                    },
                    error:function(jqXHR,textStatus,errorThrwon){
                     //console.log(jqXHR);
                     
                     swal("Something went wrong..try again");
                      
                     
                    },
                    processData:false,
                    contentType:false//from this line server gets confused that is what type of 
                    //data is comming from the form, it is text, image, video, or large data
                    //server is confused.Therefore to process image or large data
                    //we will use annotation @MultiPartConfig in RegisterServlet.java
                 });
                 
                });
            });
         </script> 
    </body>
</html>
