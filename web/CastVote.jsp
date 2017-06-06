<%@ page import="evoting.resources.UserDAO" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="evoting.model.User" %>
<%@ page import="java.io.PrintWriter" %>
<%--
  Created by IntelliJ IDEA.
  User: arpit
  Date: 3/2/17
  Time: 8:58 AM
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
        if (request.getMethod().equalsIgnoreCase("post"))
        {
            Connection connection = (Connection) request.getServletContext().getAttribute("connection");
            HttpSession session = request.getSession(false);
            User user = (User) session.getAttribute("user");
            if (user==null){
                response.sendRedirect("index1.html");
                return;
            }

            String hashedVote = request.getParameter("hashedVote");
            String encryptedVote=request.getParameter("encryptedVote");

            String status = UserDAO.addVote(connection, user, encryptedVote, hashedVote);
            PrintWriter pw=response.getWriter();
            if ("success".equals(status))
            {
                pw.println("<input type=\"hidden\" id=\"toastContent\" value=\"Your vote has been casted.\"> \n");
                RequestDispatcher rd=request.getRequestDispatcher("user_profile.jsp");
                rd.include(request,response);
            }
            else if ("voted".equals(status)){
                pw.println("<input type=\"hidden\" id=\"toastContent\" value=\"You can only vote once.\"> \n");
                RequestDispatcher rd=request.getRequestDispatcher("user_profile.jsp");
                rd.include(request,response);
            }
            else {
                System.out.println("Hey!! I got ended with an error");
                response.sendRedirect("user_profile.jsp");
            }
        }
        else {
            response.sendRedirect("user_profile.jsp");
        }

    %>
    <script>
        Materialize.toast(document.getElementById("toastContent").value, 4000);
    </script>"
</body>
</html>
