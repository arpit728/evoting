<%--
  Created by IntelliJ IDEA.
  User: arpit
  Date: 29/1/17
  Time: 4:46 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@page session="false" %>
<html>
  <head>
    <title></title>
    <style>
        table{
            border-collapse: collapse;
        }
        table,td,th{
        border: 1px solid black;
        }
        td,th{
            padding: 5px;
        }
    </style>
  </head>
  <body>

    <h1>WELCOME TO SECURE ELECTRONIC VOTING SYSTEM</h1>
    <a href="Login.html">login</a>
    <a href="RegistrationForm.jsp">register</a>
    <a href="AdminPanel.jsp">admin login</a>

  <%

    ServletContext sc=request.getServletContext();
    Connection con= (Connection) request.getServletContext().getAttribute("connection");

    PreparedStatement ps= null;
    ResultSet rs=null;
      String maxVoteParty=null;
      int maxVoteCount=0;

    if ((Boolean)sc.getAttribute("result"))
    try {
      ps = con.prepareStatement("SELECT * from vote");
      rs=ps.executeQuery();

      out.println("<table><tr>");
      out.println("<th>Party name</th>");
      out.println("<th>Votes</th>");
      out.println("</tr>");
      while (rs.next()){
          int tempCount=rs.getInt(2);
          String tempParty=rs.getString(1);
          if (tempCount>maxVoteCount){
              maxVoteCount=tempCount;
              maxVoteParty=tempParty;
          }
  %>
        <tr>
          <td><%=rs.getString(1)%></td>
          <td><%=rs.getString(2)%></td>
        </tr>
  <%  }
      out.println("<h3>"+maxVoteParty+" won the election"+"</h3>");
  }
    catch (SQLException e) {
      e.printStackTrace();
    }


  %>

  </table>

  </body>
</html>
