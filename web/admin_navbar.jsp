<%@page import="com.donate.revivinglife.entities.User" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">


<%  //This for conditional rendering matlab jab admin logged in rahe to 
    //use navbar par login and register option nhi dikhna chahiye.
    User user1=(User)session.getAttribute("currentUser");
     boolean isLoggedIn = (user1 != null);
%>

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


<nav class="navbar navbar-expand-lg navbar-light primary-background">
    <a class="navbar-brand" href="admin_page.jsp">RevivingLife</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="admin_page.jsp">Dashboard <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="https://ngodarpan.gov.in/index.php/home/statewise" target="_blank">NGOs</a>
            </li>
        </ul>
        <ul class="navbar-nav mr-right">
            <li class="nav-item">
                <a class="nav-link" href="#!" data-toggle="modal" data-target="#profile-modal"><span class="fa fa-user-circle"></span> <%=user1.getName()%></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="LogoutServlet">Logout</a>
            </li>
        </ul>
    </div>
</nav> 