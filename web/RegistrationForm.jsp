<%--
  Created by IntelliJ IDEA.
  User: arpit
  Date: 29/1/17
  Time: 5:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>

    <form action="Register.jsp" method="post" >
        <table>
            <tr>
                <td>First Name</td>
                <td>
                    <input type="text" name="firstName" required>
                </td>
            </tr>
            <tr>
                <td>Last Name</td>
                <td>
                    <input type="text" name="lastName" required>
                </td>
            </tr>

            <tr>
                <td>Voter-Id</td>
                <td>
                    <input type="text" name="uniqueId" required>
                </td>
            </tr>

            <tr>
                <td>Email</td>
                <td>
                    <input type="email" name="email" required>
                </td>
            </tr>
            <tr>
                <td>Mobile no.</td>
                <td>
                    <input type="number" maxlength="10" min="1000000000" name="mobile" required>
                </td>
            </tr>

            <tr>
                <td colspan="2">
                    <input type="submit" value="REGISTER ME FOR VOTING">
                </td>
            </tr>

        </table>

    </form>

</body>
</html>
