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
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registration page</title>
    </head>
    <body>
        <h1 align=center>Welcome to CookBook!</h1>
        <c:if test="${! empty param.errorMsg}" >
            <font color="red"> <b> ${param.errorMsg}</b></font>
        </c:if>
        <br> <br>
        <h4> Create your own account! </h4>
        <form action="checkregistration.jsp" method="post">
            <table>
                <tr>
                    <td>Username: </td> 
                    <td> <input type="text" name="username" value="" size="20" required> </td>
                </tr>
                <tr>
                    <td>Email: </td> 
                    <td> <input type="email" name="email" value="" size="20" required> </td>
                </tr>
                <tr>
                    <td> Password: </td> 
                    <td> <input type="password" name="password" value="" size="20" required> </td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" name="registration" value="Registration"> </td>
                </tr>
            </table>
        </form>
            <h5>If you already have an account, please <a href="login.jsp">sign in</a></h5>
        <c:if test="${empty cookbook}">
            <p>Check the database connection!</p>
        </c:if>
    </body>
</html>
