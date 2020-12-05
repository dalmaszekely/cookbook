<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:setDataSource var="cookbook" 
                   driver="org.apache.derby.jdbc.ClientDriver"
                   url="jdbc:derby://localhost:1527/semmi"
                   user="semmi"
                   password="semmi"
                   scope="session"/>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>

<link rel="shortcut icon" type="image/png" href="img/favicon.png">
<link rel="stylesheet" href="css/all.css">
<link rel="stylesheet" href="css/login.css">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login page</title>
    </head>
    <body>
        <p class="title">Welcome to CookBook!</p>
        <c:if test="${! empty param.errorMsg}" >
            <font color="red"> <b> ${param.errorMsg}</b></font>
        </c:if>
        <br> <br>
        <h4 class="text"> Sign in with email and password! </h4>
        <form action="checklogin.jsp" method="post">
            <table>
                <tr>
                    <td class="text">Email: </td> 
                    <td> <input type="email" name="email" value="" size="20" required class="textbox"> </td>
                </tr>
                <tr>
                    <td class="text"> Password: </td> 
                    <td> <input type="password" name="password" value="" size="20" required class="textbox"> </td>
                </tr>
                <tr>
                    <td><input type="submit" name="login" value="Sign in" class="button"> </td>
                    <td></td>
                </tr>
            </table>
        </form>
        <form action="registration.jsp" method="POST">
            <input type="submit" name="registration" value="Create a new account" class="button">
        </form>
        <c:if test="${empty cookbook}">
            <p>Check the database connection!</p>
        </c:if>
    </body>
</html>
