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
                <td>Username</td>
                <td>Email</td>
                <td>User authority</td>
            </tr>
            <c:choose>
                <c:when test="${param.add_user != null}">  
                    <sql:query var="result" dataSource="${cookbook}">
                        SELECT * FROM users where email='${param.email}'
                    </sql:query>
                    <c:choose>
                        <c:when test="${result.rowCount ne 0}">
                            <p style="color:red;">This email address is already taken :(</p>
                        </c:when>
                        <c:otherwise>
                            <sql:update var="result" dataSource="${cookbook}">
                                INSERT INTO users (name,email,password,authority)
                                VALUES ('${param.name}', '${param.email}','${param.password}','${param.authority}')
                        </sql:update>
                        </c:otherwise>
                    </c:choose>
                </c:when>
            </c:choose>
            <c:choose>
                <c:when test="${param.delete_user != null}">  
                    <sql:update var="result" dataSource="${cookbook}">
                        
                        <%-- Delete  based on email, because email is a unique value--%>
                        DELETE FROM users WHERE email = '${param.email}'
                    </sql:update>        
                </c:when>
            </c:choose>


            <sql:query var="result" dataSource="${cookbook}">
                SELECT * FROM users
            </sql:query>
            <c:forEach var="user" items="${result.rows}">
                <tr>
                    <td><c:out value="${user.id}"/></td>
                    <td><c:out value="${user.name}"/></td>
                    <td><c:out value="${user.email}"/></td>
                    <td><c:choose>
                            <c:when test="${user.authority=='admin'}">
                                Admin 
                            </c:when>    
                            <c:otherwise>
                                User 
                            </c:otherwise>
                        </c:choose></td>
                    <td>
                        <form action="admin.jsp" method="POST">
                            <input type="hidden" name="email" value="${user.email}">
                            <input type="submit" name="delete_user" value="Delete">
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </table>
        <br><br>
        <c:choose>
                <c:when test="${param.new_user == null}">  
                    <form action="admin.jsp" method="POST">
                        <input type="submit" name="new_user" value="New user">
                    </form>        
                </c:when>
            </c:choose>        
        
        <c:choose>
            <c:when test="${param.new_user != null}">
                <form action="admin.jsp" method="POST">
                    <table>
                        <tr>
                            <td>Username:</td><td><input type="text" name="name" required></td>
                        </tr>
                        <tr>
                            <td>Email:</td><td><input type="email" name="email" required></td>
                        </tr>
                        <tr>
                            <td>Password:</td><td><input type="password" name="password" required></td>
                        </tr
                        <tr>
                            <td>User authority:</td><td><input type="radio" name="authority" value="user" checked="checked">User</td>
                        </tr>
                        <tr>
                            <td></td><td><input type="radio" name="authority" value="admin">Admin</td>
                        </tr>
                        
                    </table> 
                    <input type="submit" name="add_user" value="Add user">
                </form>
            </c:when>
        </c:choose>
    </body>
</html>

