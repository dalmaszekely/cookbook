<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<sql:setDataSource var="cookbook" driver="org.apache.derby.jdbc.ClientDriver" url="jdbc:derby://localhost:1527/semmi"
    user="semmi" password="semmi" scope="session" />

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<link rel="shortcut icon" type="image/png" href="img/favicon.png">
<link rel="stylesheet" href="css/all.css">
<link rel="stylesheet" href="css/admin.css">

<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>CookBook</title>
</head>
<%if (session.getAttribute("authority").equals("admin")){%>

<body>
    <table>
        <tr>
            <td class="text_imp top">ID</td>
            <td class="text_imp top">Username</td>
            <td class="text_imp top">Email</td>
            <td class="text_imp top">User authority</td>
        </tr>
        <tr>
            <td colspan="5">
                <hr>
            </td>
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
            SELECT * FROM users ORDER BY id
        </sql:query>
        <c:forEach var="user" items="${result.rows}">
            <tr>
                <td>
                    <c:out value="${user.id}" />
                </td>
                <td>
                    <c:out value="${user.name}" />
                </td>
                <td>
                    <c:out value="${user.email}" />
                </td>
                <td>
                    <c:choose>
                        <c:when test="${user.authority=='admin'}">
                            Admin
                        </c:when>
                        <c:otherwise>
                            User
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <form action="admin.jsp" method="POST">
                        <input type="hidden" name="email" value="${user.email}">
                        <input type="submit" name="delete_user" value="Delete" class="button">
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
    <br><br>

    <c:choose>
        <c:when test="${param.new_user == null}">
            <form action="admin.jsp" method="POST">
                <input type="submit" name="new_user" value="New user" class="button">
            </form>
        </c:when>
    </c:choose>

    <c:choose>
        <c:when test="${param.new_user != null}">
            <form action="admin.jsp" method="POST">
                <table>
                    <tr>
                        <td class="text_imp">Username:</td>
                        <td><input type="text" name="name" required></td>
                    </tr>
                    <tr>
                        <td class="text_imp">Email:</td>
                        <td><input type="email" name="email" required></td>
                    </tr>
                    <tr>
                        <td class="text_imp">Password:</td>
                        <td><input type="password" name="password" required></td>
                    </tr <tr>
                    <td class="text_imp">User authority:</td>
                    <td><input type="radio" name="authority" value="user" checked="checked">User</td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><input type="radio" name="authority" value="admin">Admin</td>
                    </tr>

                </table>
                <input type="submit" name="add_user" value="Add user" class="button">
            </form>
        </c:when>
    </c:choose>
    <form action="recipes.jsp" method="POST"><input type="submit" name="recipes page" value="Back to recipes"
            class="button"></form>
</body>
<%}else{ %>
<jsp:forward page="recipes.jsp" />
<%}%>
</html>