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
        <title>CookBook</title>
    </head>
    <body>
        <c:choose>
            <c:when test="${param.add_recipe != null}">  
                <sql:update var="result" dataSource="${cookbook}">
                    INSERT INTO recipes (name,preparation,ingredient,writer_id)
                    VALUES ('${param.name}', '${param.preparation}','${param.ingredient}',${sessionScope.userid })
                </sql:update>
                <%String redirectURL = "recipes.jsp";
                response.sendRedirect(redirectURL);%>    
            </c:when>
        </c:choose>
        <h1>Share your new recipe!</h1>
        <c:choose>
            <c:when test="${param.new_recipe != null}">
                <form action="newrecipe.jsp" id="recipe" method="POST">
                    <table>
                        <tr>
                            <td>Recipe name</td><tr><td><input type="text" size="53" name="name" required></td></tr><br>
                        </tr>
                        <tr>
                            <td>Ingredients</td><tr><td><textarea name="ingredient" rows="4" cols="50" form="recipe"></textarea></td></tr><br>
                        </tr>
                        <tr>
                            <td>Preparation</td><tr><td><textarea name="preparation" rows="10" cols="50" form="recipe"></textarea></td></tr><br>
                        </tr>
                        <tr>
                            <td><input type="submit" name="add_recipe" value="Add recipe"></td>
                        </tr>
                    </table>
                </form>
            </c:when>
        </c:choose>
    </body>
</html>
