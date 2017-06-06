<%@ page import="java.io.PrintWriter" %>
<%--
  Created by IntelliJ IDEA.
  User: hardCode
  Date: 2/19/2017
  Time: 7:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page session="false" %>
<html>
<head>
    <title></title>
</head>
<body>

<%
  HttpSession session=request.getSession(false);
  PrintWriter pw=response.getWriter();
  if (session!=null){
    session.invalidate();
    pw.println("<input type=\"hidden\" id=\"toastContent\" value=\"You have been logged out.\">\n");
    RequestDispatcher rd=request.getRequestDispatcher("index1.html");
    rd.include(request,response);
  }
  else {
    response.sendRedirect("index1.html");
  }
%>
<script>
  Materialize.toast(document.getElementById("toastContent").value, 4000);
</script>
</body>
</html>
