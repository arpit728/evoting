<%@ page import="evoting.resources.UserDAO" %>
<%@ page import="evoting.resources.Utility" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="javax.mail.Session" %>
<%@ page import="java.io.PrintWriter" %>
<%@page session="false" %>
<%--
  Created by IntelliJ IDEA.
  User: arpit
  Date: 30/1/17
  Time: 8:17 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>

  <jsp:useBean id="user" class="evoting.model.User"/>
  <jsp:setProperty name="user" property="*"/>
  <%
    Connection connection=(Connection)request.getServletContext().getAttribute("connection");

    if (!UserDAO.ifAllValuesFilled(user)){
      System.out.println("I got terminated here"+" \"Fill all the fields\"");
      out.println("Fill all the fields");
      RequestDispatcher rd=request.getRequestDispatcher("signup.html");
      rd.include(request,response);
      return;
    }
    if (UserDAO.isAlreadyRegistered(user,connection ))
    {
      System.out.println("I got terminated here"+" \"User with the following details already exist\"");
      out.println("User with the following details already exist");
      RequestDispatcher rd=request.getRequestDispatcher("signup.html");
      rd.include(request,response);
      return;
    }
    int []grid=Utility.generateGridCard();
    String gridString=Utility.gridToString(grid);
    String Otp=Utility.generateOtp();

    //set grid and password in user pojo
    user.setGrid(gridString);
    user.setPassword(Otp);
    String s=UserDAO.addUser(user,connection);

    if ("error".equals(s)){

      System.out.println("Hey man! I failed to add user.");
      //if values not inserted into database, show error page

    }
    else{
      String emailStatus=Utility.sendEmail(user.getEmail(),"SECURE PASSWORD FOR E-VOTING", Otp);
      System.out.println("Email status = "+s+" "+"Sending email......");
        if ("error".equals(emailStatus)){
            //if email not sent, remove entry from database and show error page.
            UserDAO.deleteUser(user.getUniqueId(),connection);
            //error page
        }
        else {
          HttpSession session=request.getSession(true);
          session.setAttribute("user",user);
          RequestDispatcher rd=request.getRequestDispatcher("user_profile.jsp");
          out.println("You have been successfully registered, now you can cast your vote");
          rd.include(request,response);
          out.clear ();
          System.out.println("profile page loaded");
        }
    }
  %>

</body>
</html>
