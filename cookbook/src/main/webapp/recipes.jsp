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
        <c:choose>
            <c:when test="${param.add_recipe != null}">  
                <sql:update var="result" dataSource="${cookbook}">
                    INSERT INTO recipes (name,preparation,ingredient)
                    VALUES ('${param.name}', '${param.preparation}','${param.ingredient}')
                </sql:update>

            </c:when>
        </c:choose>

        <sql:query var="result" dataSource="${cookbook}">
            SELECT * FROM recipes
        </sql:query>
        <c:forEach var="recipe" items="${result.rows}">
            <table>
                <form method="POST" action="recipes.jsp">
                <tr><td><h3><input type="submit" name="full_recipe" value="${recipe.name}"></h3></td></tr>
                </form>
                <c:choose>
                    <c:when test="${param.full_recipe == recipe.name}">  
                        <tr><td><c:out value="${recipe.ingredient}"/></td></tr>
                        <tr><td><c:out value="${recipe.preparation}"/></td></tr>
                    </c:when>
                </c:choose>
                                
            </table> 
        </c:forEach>
        <br><br>
        <c:choose>
            <c:when test="${param.new_recipe == null}">  
                <form action="newrecipe.jsp" method="POST">
                    <input type="submit" name="new_recipe" value="&#10010; Recipe">
                </form>        
            </c:when>
        </c:choose>        

    </body>
</html>