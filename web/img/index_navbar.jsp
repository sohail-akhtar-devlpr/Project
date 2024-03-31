<!--<%@page import="com.donate.revivinglife.entities.User" %>

<%  //This for conditional rendering matlab jab admin logged in rahe to 
    //use navbar par login and register option nhi dikhna chahiye.
    User user1=(User)session.getAttribute("currentUser");
     boolean isLoggedIn = (user1 != null);
%>-->

<style>
    .navbar-nav a.nav-link {
        font-weight: bold;
        color: #ffffff !important;
    }
</style>

<style>
    .navbar-brand {
        font-weight: bold;
        color: yellow !important;
    }
</style>



<div>
<nav class="navbar navbar-expand-lg navbar-light primary-background">
    <a class="navbar-brand" href="index.jsp">RevivingLife</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="index.jsp">Home <span class="sr-only">(current)</span></a>
            </li>
            <!-- <% if (!isLoggedIn) { %>-->
            <li class="nav-item dropdown" id="donation-dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Donation Type
                </a>

                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <div class="container">
                        <a class="dropdown-item" href="donate_page.jsp">Food</a>
                        <a class="dropdown-item" href="donate_page.jsp">Medicine</a>
                        <a class="dropdown-item" href="donate_page.jsp">Education</a>
                        <a class="dropdown-item" href="donate_page.jsp">Natural Calamities</a>
                        <a class="dropdown-item" href="donate_page.jsp">Environment</a>
                        <a class="dropdown-item" href="donate_page.jsp">others</a>
                    </div>
                    <div class="dropdown-divider"></div>
                    <div class="text-center">
                        <a href="donate_page.jsp" class="btn btn-success" role="button">Donate Us</a>
                    </div>         
                </div>

            </li>
            <% } %>
            <li class="nav-item">
                <!--  <a class="nav-link disabled" href="#">Disabled</a> -->
                <a class="nav-link" href="https://ngodarpan.gov.in/index.php/home/statewise" target="_blank">NGOs</a>
            </li>

            <!--<%
            if(user1==null)
            {
            %>-->

            <li class="nav-item dropdown" id="signup-dropdown">

                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Signup
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="register_page.jsp">Donor</a>
                    <a class="dropdown-item" href="admin_register_page.jsp">Admin</a>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="login_page.jsp">Login</a>
            </li>

            <!-- <%
             }
             else
             {
            %>-->
        </ul>
       
        <!--<%
            
        }
            
        %>-->



    </div>
</nav>
</div>
