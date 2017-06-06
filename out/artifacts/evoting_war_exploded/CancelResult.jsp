<%--
  Created by IntelliJ IDEA.
  User: hardCode
  Date: 2/24/2017
  Time: 12:38 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>

  <%
    request.getServletContext().setAttribute("result",false);
      response.sendRedirect("AdminPanel.jsp");
  %>
</body>
</html>
