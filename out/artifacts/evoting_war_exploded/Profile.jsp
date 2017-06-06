<%@ page import="java.sql.Connection" %>
<%@ page import="evoting.model.User" %>
<%@page session="false" %>
<%--
  Created by IntelliJ IDEA.
  User: arpit
  Date: 29/1/17
  Time: 5:41 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title></title>

  <style>

    table{
      border-collapse: collapse;
    }
    td{
      border: 1px solid black;
    }
  </style>
</head>
<body>
  <jsp:useBean id="login" class="evoting.model.Login" />
<%--
  <jsp:useBean id="user" class="evoting.model.User" scope="request" />
--%>
  <jsp:setProperty name="login" property="*"/>
  <%
    System.out.println(request.getParameter("uniqueId")+" "+request.getParameter("password"));
    boolean flag=false;
    String[]grid=null;
    User user;
    HttpSession session=request.getSession(false);
    if (request.getMethod().equalsIgnoreCase("get")){

      if (session==null){
        out.println("You must login to see this page");
        RequestDispatcher rd=request.getRequestDispatcher("Login.html");
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

      login.setGrid("12345678");

      if (session==null){

          session=request.getSession(true);
          user=new User();
          System.out.println(login.getUniqueId() +" "+ login.getPassword()+" "+ login.getGrid()+" "+ login);

        String status = login.validate((Connection)request.getServletContext().getAttribute("connection"),user);

        if ("success".equals(status)) {
          session.setAttribute("user", user);
          grid = user.getGrid().split("");
          flag = true;
        }
        else if ("invalid".equals(status)){
  %>
            <h1>Invalid Credentials</h1>
        <%}

    else{%>
      <h1>You must fill all the fields to login</h1>
    <%}
    }
    else {
      flag=true;
      user= (User) session.getAttribute("user");
      grid = user.getGrid().split("");
    }
  }
    if (flag){
      System.out.println("I got in here bro." + user);
  %>


  <h1>Welcome </h1>
      <%=user.getFirstName()%><br>
      <%=user.getLastName()%><br>
      <%=user.getUniqueId()%><br>
      <%=user.getEmail()%><br>
      <%=user.getMobile()%><br>

      <table>
        <tr>
          <td><%=grid[0]%></td>
          <td><%=grid[1]%></td>
          <td><%=grid[2]%></td>
          <td><%=grid[3]%></td>
        </tr>
        <tr>
          <td><%=grid[4]%></td>
          <td><%=grid[5]%></td>
          <td><%=grid[6]%></td>
          <td><%=grid[7]%></td>
        </tr>

      </table>

      <a href="Logout.jsp">logout</a>
      <a href="Vote.html">Cast Vote</a>

  <%}%>
<%--
  <jsp:forward page="index.jsp"/>
--%>

</body>
</html>