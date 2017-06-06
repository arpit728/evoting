<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.HashMap" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
    <head>
        <title>Results</title>
        <script type="text/javascript" src="materialize/js/jquery-2.1.1.min.js"></script>
        <script type="text/javascript" src="materialize/js/materialize.js"></script>
        <script type="text/javascript" src="materialize/js/view_results_script.js"></script>
        <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"/>
        <link type="text/css" rel="stylesheet" href="materialize/css/materialize.min.css"  media="screen,projection"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <link href="https://fonts.googleapis.com/css?family=Roboto:300" rel="stylesheet"/>
        <link href="materialize/css/styleFinal.css" rel="stylesheet"/>
        <link rel="stylesheet" type="text/css" href="materialize/css/style.css">
    </head>
    <body onload="indicate_winner()">

    <%

        Connection con= (Connection) request.getServletContext().getAttribute("connection");
        PreparedStatement ps=con.prepareStatement("SELECT * FROM vote");
        ResultSet rs=ps.executeQuery();
        HashMap<String,Integer>count=new HashMap();
        while (rs.next()){
            count.put(rs.getString(1),rs.getInt(2));
        }
    %>
        <nav class="cyan darken-4" role="navigation">
            <div class="nav-wrapper container">
                <a href="index1.html" class="brand-logo" id="logo-container">Logo</a>
            </div>
            <div class="row section">
                <div class="row"></div>
                <div class="row"></div>
                <div class="row"></div>
                <div class="row"></div>
                <div class="row">
                    <div class="col s3"></div>
                    <div class="col s6">
                        <h4 class="header" style="color: #006064">RESULTS</h4>
                        <table class="centered" style="color: black">
                            <tbody>
                                <tr>
                                    <td id="images_cell_cont1"><img src="res/cont1.png"/><br><span>John</span><br><span id="badge_cont1" class="new badge invi" data-badge-caption="WINNER"></span></td>
                                    <td id="images_cell_cont2"><img src="res/cont2.png"/><br><span>Micheal</span><br><span id="badge_cont2" class="new badge invi" data-badge-caption="WINNER"></span></td>
                                    <td id="images_cell_cont3"><img src="res/cont3.png"/><br><span>Lina</span><br><span id="badge_cont3" class="new badge invi" data-badge-caption="WINNER"></span></td>
                                </tr>
                                <tr>
                                    <td class="votes_cell"><span id="votes_cont1"><%= count.get("john")%></span></td>
                                    <td class="votes_cell"><span id="votes_cont2"><%= count.get("micheal")%></span></td>
                                    <td class="votes_cell"><span id="votes_cont3"><%= count.get("lina")%></span></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="col s3"></div>
                </div>
            </div>
        </nav>
    </body>
</html>