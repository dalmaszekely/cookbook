<%-- 
    Document   : admin
    Created on : 2020.12.03., 17:18:45
    Author     : Danubius
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:setDataSource var="cookbook" 
                   driver="org.apache.derby.jdbc.ClientDriver"
                   url="jdbc:derby://localhost:1527/semmi"
                   user="semmi"
                   password="semmi"
                   scope="session"/>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Beadando3</title>
    </head>
    <body>
        <table>
            <tr>
                <td>ID</td>
                <td>Felhasználónév</td>
                <td>Email</td>
                <td>Jogosultság</td>
            </tr>
            <c:choose>
            <c:when test="${param.delete_user != null}">  
                <sql:update var="eredmeny" dataSource="${cookbook}">
                    DELETE FROM users WHERE email = '${param.email}'
                </sql:update>
         
            </c:when>
            <c:otherwise>
                ss
            </c:otherwise>
            </c:choose>


            <sql:query var="eredmeny" dataSource="${cookbook}">
                SELECT * FROM users
            </sql:query>
            <c:forEach var="user" items="${eredmeny.rows}">
                <tr>
                    <td><c:out value="${user.id}"/></td>
                    <td><c:out value="${user.name}"/></td>
                    <td><c:out value="${user.email}"/></td>
                    <td><c:choose>
                            <c:when test="${user.is_admin=='1'}">
                                Admin 
                            </c:when>    
                            <c:otherwise>
                                Felhasználó 
                            </c:otherwise>
                        </c:choose></td>
                    <td>
                        <form action="admin.jsp" method="POST">
                            <input type="hidden" name="email" value="${user.email}">
                            <input type="submit" name="delete_user" value="Törlés">
                        </form>
                    </td>
                </tr>
            </c:forEach>

        </table>

    </body>
</html>

