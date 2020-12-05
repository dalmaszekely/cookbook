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
        <title>Registration page</title>
    </head>
    <body>
        <p class="title">Welcome to CookBook!</p>
        <c:if test="${! empty param.errorMsg}" >
            <font color="red"> <b> ${param.errorMsg}</b></font>
        </c:if>
        <br> <br>
        <h4 class="text"> Create your own account! </h4>
        <form action="checkregistration.jsp" method="post">
            <table>
                <tr>
                    <td class="text">Username: </td> 
                    <td> <input type="text" name="name" value="" size="20" required class="textbox"> </td>
                </tr>
                <tr>
                    <td class="text">Email: </td> 
                    <td> <input type="email" name="email" value="" size="20" required class="textbox"> </td>
                </tr>
                <tr>
                    <td class="text"> Password: </td> 
                    <td> <input type="password" name="password" value="" size="20" required class="textbox"> </td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" name="registration" value="Registration" class="button"> </td>
                </tr>
            </table>
        </form>
            <h5 class="text">If you already have an account, please <a href="login.jsp">sign in</a></h5>
        <c:if test="${empty cookbook}">
            <p class="text">Check the database connection!</p>
        </c:if>
    </body>
</html>
