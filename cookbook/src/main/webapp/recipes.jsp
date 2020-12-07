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

<link rel="shortcut icon" type="image/png" href="img/favicon.png">
<link rel="stylesheet" href="css/all.css">
<link rel="stylesheet" href="css/recipes.css">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>CookBook</title>
    </head>

    <body>
        <form action="logout.jsp" method="POST"><input type="submit" name="logout" value="Log out" class="button"></form>
        <div class="back-black">
            <%if(session.getAttribute("userid")!= null){%>
            <c:choose>
                <c:when test="${param.delete_recipe != null}">  
                    <sql:update var="result" dataSource="${cookbook}">
                        DELETE FROM recipes WHERE id = <%= Integer.parseInt(request.getParameter("recipe_id"))%>
                    </sql:update>
                </c:when>
            </c:choose>
            <h1 class="white op">Find and share everyday cooking inspiration!</h1>
            <h3 class="white op">Search here for recipes</h3>

            <form method="POST" action="recipes.jsp" class="white">
                <input type="text" name="searched" value='${param.searched}' class="textbox_rec">
                <input type="submit" name="search_recipe" value="Search" class="button">
            </form>
            <%if (session.getAttribute("authority").equals("admin")){%>
            <br><form action="admin.jsp" method="POST"><input type="submit" name="admin page" value="Admin features" class="button"></form><br>
                <%}%>
                <sql:query var="result" dataSource="${cookbook}">
                SELECT * FROM recipes where upper(name)LIKE'%${fn:toUpperCase(param.searched)}%'
            </sql:query>

            <form action="newrecipe.jsp" method="POST">
                <input type="submit" name="new_recipe" value="&#10010; Recipe" class="button">
            </form>
            <c:forEach var="recipe" items="${result.rows}">
                <table class="recipe">
                    <tr><td><h3 class="white"><c:out value="${recipe.name}"/></h3></td>

                        <c:set var="writer_id" value="${recipe.writer_id}"/>

                        <%if (session.getAttribute("authority").equals("admin")){%>
                        <td><form action="recipes.jsp" method='POST'>
                                <input type="hidden" name="recipe_id" value="${recipe.id}">
                                <input type="submit" name="delete_recipe" value="Delete" class="button"></form>
                        </td>

                        <%}else{%>
                        <% if (session.getAttribute("userid")== pageContext.getAttribute("writer_id")){%>
                        <td><form action="recipes.jsp" method='POST'>
                                <input type="hidden" name="recipe_id" value="${recipe.id}">
                                <input type="submit" name="delete_recipe" value="Delete" class="button"></form>
                        </td>
                        <%}}%>
                    </tr>
                    <tr><td class="white space"><c:out value="${recipe.ingredient}"/></td></tr>
                    <tr><td class="white"><c:out value="${recipe.preparation}"/></td></tr>
                </table>
                <hr>
            </c:forEach>
            <br><br>
        </div>
    </body>
    <%}else{%>
    <jsp:forward page="login.jsp"/>
    <%}%>
</html>