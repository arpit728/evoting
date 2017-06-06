<%@ page import="java.sql.Connection" %>
<%@ page import="evoting.model.User" %>
<%@page session="false"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1.0"/>
        <title>User Profile</title>
        <script type="text/javascript" src="materialize/js/jquery-2.1.1.min.js"></script>
        <script type="text/javascript" src="materialize/js/materialize.js"></script>
        <script type="text/javascript" src="materialize/js/user_profile_script.js"></script>
        <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link type="text/css" rel="stylesheet" href="materialize/css/materialize.min.css"  media="screen,projection"/>
        <link type="text/css" rel="stylesheet" href="materialize/css/style.css"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    </head>
    <body>

    <jsp:useBean id="login" class="evoting.model.Login" />

    <jsp:setProperty name="login" property="*"/>
    <%
        System.out.println(request.getParameter("uniqueId")+" "+request.getParameter("password"));
        boolean flag=false;
        String[]grid=null;
        User user;
        HttpSession session=request.getSession(false);
        System.out.println("session "+session);
        if (request.getMethod().equalsIgnoreCase("get")){

            if (session==null){
                out.println("You must login to see this page");
                System.out.println();
                RequestDispatcher rd=request.getRequestDispatcher("index1.html");
                rd.include(request, response);
                out.clear ();
                return;
            }

            else {
                flag=true;
                user= (User) session.getAttribute("user");
                grid = user.getGrid().split("");
            }
        }
        else {

            if (session == null) {

                user = new User();
                String status = login.validate((Connection) request.getServletContext().getAttribute("connection"), user);
                System.out.println(login.getUniqueId() + " " + login.getPassword() + " " + login.getGrid() + " " + login);
                System.out.println("login status "+status);
                System.out.println("user details "+user);
                if ("success".equals(status)) {
                    session = request.getSession(true);
                    session.setAttribute("user", user);
                    grid = user.getGrid().split("");
                    flag = true;
                }
                else if ("invalid".equals(status)) {
                    out.println("Enter valid username and password");
                    System.out.println("Enter valid username and password");
                    RequestDispatcher rd = request.getRequestDispatcher("index1.html");
                    rd.include(request, response);
                    out.clear();
                    return;
                }
                else {
                    out.println("You must fill all the fields to login");
                    RequestDispatcher rd = request.getRequestDispatcher("index1.html");
                    rd.include(request, response);
                    out.clear();
                    return;
                }
            }
            else {
                flag = true;
                user = (User) session.getAttribute("user");
                System.out.println("User Details "+user);
                grid = user.getGrid().split("");
            }
        }

        if (flag){
            System.out.println("I got in here bro." + user);
    %>
    <nav class="cyan darken-4" role="navigation">
            <div class="nav-wrapper container">
                <a href="index.html" class="brand-logo" id="logo-container">Logo</a>
                <a href="#" data-activates="mobile-demo" class="button-collapse"><i class="material-icons">menu</i></a>
                <ul id="nav-mobile" class="right hide-on-med-and-down">
                    <li><a href="voteFinal.html">CAST VOTE</a></li>
                    <li><a href="Logout.jsp">LOGOUT</a></li>
                </ul>

                <ul id="mobile-demo" class="side-nav">
                    <li><a href="voteFinal.html">CAST VOTE</a></li>
                    <li><a href="Logout.jsp">LOGOUT</a></li>
                </ul>
            </div>
        </nav>
        <div class="row section">
            <div class="row"></div>
            <div class="col s3"></div>
            <div class="col s6">
                <form action="#" method="post">
                    <div class="row">
                        <div class="col s12">
                            <h4 class="header" style="color: #006064">USER PROFILE</h4>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col s6">
                            <span style="color: #006064"><b>ID</b></span>
                            <span id="ID"><%=user.getUniqueId()%></span>
                        </div>
                        <div class="col s6">
                            <span style="color: #006064"><b>NAME</b></span>
                            <span id="name"><%=user.getFirstName()+" "+user.getLastName()%></span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col s6">
                            <span style="color: #006064"><b>EMAIL</b></span>
                            <span id="email"> <%=user.getEmail()%></span>
                        </div>
                        <div class="col s6">
                            <span style="color: #006064"><b>MOBILE PHONE</b></span>
                            <span id="mobile_phone"><%=user.getMobile()%></span>
                        </div>
                    </div>
                    <div class="row"></div>
                    <div class="row"></div>
                    <div class="row"></div>
                    <div class="row">
                        <div class="col s2"></div>
                        <div class="col s8">
                            <table class="centered">
                                <thead>
                                    <tr style="color: #006064"]>
                                        <th data-field="grid" colspan="4"><b>GRID CARD</b></th>
                                    </tr>
                                </thead>
                                
                                <thead class="apply_top_border">
                                    <tr style="color: white">
                                        <th data-field="0">0</th>
                                        <th data-field="1">1</th>
                                        <th data-field="2">2</th>
                                        <th data-field="3">3</th>
                                    </tr>
                                </thead>
                                
                                <tbody>
                                    <tr>
                                        <td><%=grid[0]%></td>
                                        <td><%=grid[1]%></td>
                                        <td><%=grid[2]%></td>
                                        <td><%=grid[3]%></td>
                                    </tr>
                                </tbody>
                                
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                </tbody>
                                <thead class="apply_top_border">
                                    <tr style="color: white">
                                        <th data-field="4">4</th>
                                        <th data-field="5">5</th>
                                        <th data-field="6">6</th>
                                        <th data-field="7">7</th>
                                    </tr>
                                </thead>
                                
                                <tbody>
                                    <tr>
                                        <td><%=grid[4]%></td>
                                        <td><%=grid[5]%></td>
                                        <td><%=grid[6]%></td>
                                        <td><%=grid[7]%></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="col s2"></div>
                    </div>
                 
                </form>
            </div>
            <div class="col s3"></div>
        </div>
    <a href="Logout.jsp">logout</a>
    <a href="voteFinal.html">Cast Vote</a>

    <%}%>
    </body>
</html>