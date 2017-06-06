<%@ page import="evoting.model.AdminModel" %>
<%@page session="false"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page session="false" %>
<!doctype html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0"/>
        <title>Admin Panel</title>
        <script type="text/javascript" src="materialize/js/jquery-2.1.1.min.js"></script>
        <script type="text/javascript" src="materialize/js/materialize.js"></script>
        <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link type="text/css" rel="stylesheet" href="materialize/css/materialize.min.css"  media="screen,projection"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    </head>
    <body>

    <%
        HttpSession session=request.getSession(false);
        AdminModel adminModel;
        boolean flag=false;
        System.out.println(request.getMethod());
        if (request.getMethod().equalsIgnoreCase("get")){
            System.out.println(session==null);
            if (session==null) {
                response.sendRedirect("admin_login.html");
                return;
            }
            else {
                adminModel= (AdminModel) session.getAttribute("admin");
                if (adminModel==null){
                    response.sendRedirect("admin_login.html");
                    return;
                }
                else {
                    flag=true;
                }
            }
        }
        else
        {
            if (session==null){

                String userName=request.getParameter("userName");
                String password=request.getParameter("password");
                System.out.println(userName+" "+password+" "+request.getMethod());

                if (userName.equals("admin") && password.equals("password")){
                    AdminModel admin=new AdminModel(userName,password);
                    session=request.getSession(true);
                    session.setAttribute("admin",admin);
                    flag=true;
                }
                else {
                    response.sendRedirect("admin_login.html");
                    return;
                }
            }
            else {
                adminModel= (AdminModel) session.getAttribute("admin");
                flag=true;
            }

        }
        if (flag){
    %>
        <nav class="cyan darken-4" role="navigation">
            <div class="nav-wrapper container">
                <a href="index.html" class="brand-logo" id="logo-container">Logo</a>
                <a href="#" data-activates="mobile-demo" class="button-collapse"><i class="material-icons">menu</i></a>
                <ul id="nav-mobile" class="right hide-on-med-and-down">
                    <li><a href="Logout.jsp">LOGOUT</a></li>
                </ul>
                
                <ul id="mobile-demo" class="side-nav">
                    <li><a href="Logout.jsp">LOGOUT</a></li>
                </ul>
            </div>
        </nav>
        <div class="row section">
            <div class="row"></div>
            <div class="row"></div>
            <div class="row"></div>
            <div class="row"></div>
            <div class="row">
                <div class="col s5"></div>
                <div class="col s2">
                    <form action="AnnounceResult.jsp" method="post">
                        <button class="btn waves-effect waves-light" type="submit" name="action">ANNOUNCE
                        </button>
                    </form>
                </div>
                <div class="col s5"></div>
            </div>
        </div>
    <%}%>
    </body>
</html>