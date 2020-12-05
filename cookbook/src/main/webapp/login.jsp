<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : login
    Created on : 2020.12.04., 16:39:34
    Author     : Virág
--%>
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
        <title>Login page</title>
    </head>
    <body>
        <h1 align=center>Welcome on CookBook!</h1>
       <c:if test="${! empty param.errorMsg}" >
        <font color="red"> <b> ${param.errorMsg}     </b></font>
      </c:if>
    <br> <br>
    <h4> Sign in with username and password! </h4>
    <form action="check.jsp" method="post">
      <table>
      <tr>
      <td>Username: </td> 
      <td> <input name="userName" value="" size="20" > </td>
      </tr>
      <tr>
      <td> Password: </td> 
      <td> <input type="password" name="password" value="" size="20"> </td>
      </tr>
      <tr>
      <td></td>
      <td><input type="submit" value="Elküld"> </td>
      </tr>
      </table>
    </form>

        <c:if test="${empty felhasznalok}">
            <p>Check the database connection!</p>
        </c:if>
    </body>
</html>
