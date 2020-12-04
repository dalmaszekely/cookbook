<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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

        <c:choose>
            <c:when test="${param.delete_recipe != null}">  
                <sql:update var="result" dataSource="${cookbook}">
                    DELETE FROM recipes WHERE id = <%= Integer.parseInt(request.getParameter("delete_id"))%>
                </sql:update>
            </c:when>
        </c:choose>

        <h1>Find and share everyday cooking inspiration!</h1>
        <h3>Search here for recipes</h3>
        <form method="POST" action="recipes.jsp">
            <input type="text" name="searched" value='${param.searched}'>
            <input type="submit" name="search_recipe" value="Search">
        </form>

        <sql:query var="result" dataSource="${cookbook}">
            SELECT * FROM recipes where upper(name)LIKE'%${fn:toUpperCase(param.searched)}%'
        </sql:query>

        <c:forEach var="recipe" items="${result.rows}">
            <table>
                <tr><td><h4><c:out value="${recipe.name}"/></h4></td></tr>
                <tr><td><c:out value="${recipe.ingredient}"/></td></tr>
                <tr><td><c:out value="${recipe.preparation}"/></td></tr>
            </table> 
        </c:forEach>
        <br><br>

        <form action="newrecipe.jsp" method="POST">
            <input type="submit" name="new_recipe" value="&#10010; Recipe">
        </form>           
    </body>
</html>