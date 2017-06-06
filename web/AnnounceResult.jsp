<%@ page import="java.sql.Connection" %>
<%@ page import="evoting.resources.Utility" %>
<%@ page import="java.io.PrintWriter" %>
<%--
  Created by IntelliJ IDEA.
  User: hardCode
  Date: 2/18/2017
  Time: 8:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@page session="false" %>%
<html>
<head>
    <title></title>
    <script type="text/javascript" src="materialize/js/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="materialize/js/materialize.js"></script>
    <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link type="text/css" rel="stylesheet" href="materialize/css/materialize.min.css"  media="screen,projection"/>

</head>
<body onload="Materialize.toast(document.getElementById('toastContent').value, 4000);">

<%
    ServletContext sc=request.getServletContext();
    Connection con= (Connection) sc.getAttribute("connection");
    PrintWriter pw=response.getWriter();

    if ((boolean)sc.getAttribute("result")){
        pw.println("<input type=\"hidden\" id=\"toastContent\" value=\"The result is already announced\">\n");
        RequestDispatcher rd=request.getRequestDispatcher("admin_panel.jsp");
        rd.include(request,response);
        return;
    }
    String status=Utility.countVotes(con);
    if ("success".equals(status)){
        //cut and paste this line at the last line of this if block.
        sc.setAttribute("result",true);
        pw.println("<input type=\"hidden\" id=\"toastContent\" value=\"The result has been successfully posted\"> \n");
        RequestDispatcher rd=request.getRequestDispatcher("admin_panel.jsp");
        rd.include(request,response);
        return;
    }
    else{
        out.println("<input type=\"hidden\" id=\"toastContent\" value=\"Unable to compute result, Something went wrong on the server.\"> \n");
    }
%>
<script>
    Materialize.toast(document.getElementById("toastContent").value, 4000);
</script>"
</body>
</html>
