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
        <title>CookBook</title>
    </head>

    <body>
        <%if(session.getAttribute("userid")!= null){%>
        <c:choose>
            <c:when test="${param.delete_recipe != null}">  
                <sql:update var="result" dataSource="${cookbook}">
                    DELETE FROM recipes WHERE id = <%= Integer.parseInt(request.getParameter("recipe_id"))%>
                </sql:update>
            </c:when>
        </c:choose>
                    <form action="logout.jsp" method="POST"><input type="submit" name="logout" value="Log out"></form>
        <h1>Find and share everyday cooking inspiration!</h1>
        <h3>Search here for recipes</h3>

        <form method="POST" action="recipes.jsp">
            <input type="text" name="searched" value='${param.searched}'>
            <input type="submit" name="search_recipe" value="Search">
        </form>
        <%if (session.getAttribute("authority").equals("admin")){%>
        <br><form action="admin.jsp" method="POST"><input type="submit" name="admin page" value="Admin features"></form><br>
            <%}%>
            <sql:query var="result" dataSource="${cookbook}">
            SELECT * FROM recipes where upper(name)LIKE'%${fn:toUpperCase(param.searched)}%'
        </sql:query>

        <c:forEach var="recipe" items="${result.rows}">
            <table>
                <tr><td><h4><c:out value="${recipe.name}"/></h4></td>

                    <c:set var="writer_id" value="${recipe.writer_id}"/>

                    <%if (session.getAttribute("authority").equals("admin")){%>
                    <td><form action="recipes.jsp" method='POST'>
                            <input type="hidden" name="recipe_id" value="${recipe.id}">
                            <input type="submit" name="delete_recipe" value="Delete"></form>
                    </td>

                    <%}else{%>
                    <% if (session.getAttribute("userid")== pageContext.getAttribute("writer_id")){%>
                    <td><form action="recipes.jsp" method='POST'>
                            <input type="hidden" name="recipe_id" value="${recipe.id}">
                            <input type="submit" name="delete_recipe" value="Delete"></form>
                    </td>
                    <%}}%>
                </tr>
                <tr><td><c:out value="${recipe.ingredient}"/></td></tr>
                <tr><td><c:out value="${recipe.preparation}"/></td></tr>
            </table> 
        </c:forEach>
        <br><br>

        <form action="newrecipe.jsp" method="POST">
            <input type="submit" name="new_recipe" value="&#10010; Recipe">
        </form>           
    </body>
    <%}else{%>
    <jsp:forward page="login.jsp"/>
    <%}%>
</html>