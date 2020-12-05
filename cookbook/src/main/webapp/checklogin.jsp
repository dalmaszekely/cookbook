<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@page session="true"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<sql:setDataSource var="cookbook" 
                   driver="org.apache.derby.jdbc.ClientDriver"
                   url="jdbc:derby://localhost:1527/semmi"
                   user="semmi"
                   password="semmi"
                   scope="session"/>

<c:choose>
    <c:when test="${!empty param.login}">
        <c:choose>
            <c:when test="${(param.email) == null || (param.password) == null}">
                <jsp:forward page="login.jsp">
                    <jsp:param name="errorMsg" value="The username and/or the password is empty."/>
                </jsp:forward>
            </c:when>
            <c:otherwise>  
                <sql:query var="result" dataSource="${cookbook}">
                    SELECT * FROM users WHERE email = '${param.email}' AND password = '${param.password}'
                </sql:query>
                <c:choose> 
                    <c:when test="${result.rowCount == 1}">
                        <c:forEach var = "row" items = "${result.rows}">
                            <c:set var="id" value="${row.id}"/>
                            <c:set var="authority" value="${row.authority}"/>
                            <%session.setAttribute("userid",pageContext.getAttribute("id"));%>
                            <%session.setAttribute("authority",pageContext.getAttribute("authority"));%>
                        </c:forEach> 
                        <jsp:forward page="recipes.jsp"/>
                    </c:when>
                    <c:otherwise>
                        <jsp:forward page="login.jsp">
                            <jsp:param name="errorMsg" value="The username and/or the password is not valid."/>
                        </jsp:forward>
                    </c:otherwise>
                </c:choose>
            </c:otherwise>
        </c:choose>
    </c:when>
</c:choose>