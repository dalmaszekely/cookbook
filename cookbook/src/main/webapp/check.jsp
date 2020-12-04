<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- 
    Document   : check
    Created on : 2020.12.04., 17:17:30
    Author     : Virág
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Check login</title>
    </head>
    <body>
        <% session.removeAttribute("validUser"); %>

   if (request.getParameter("userName").length() == 0 ||
      request.getParameter("password").length() == 0) { 
%>
<c:choose>
    <c:when test="${(empty param.userName) || (empty param.password)}">
     <jsp:forward page="login.jsp" >
       <jsp:param name="errorMsg" value="The username and/or the password is not valid."/>
     </jsp:forward>    
    </c:when>
    <c:otherwise>
        <c:choose>
            <c:when test="${param.password eq \"jsp\"}">
                <% session.setAttribute("validUser", request.getParameter("userName"));%>
                <jsp:forward page="main.jsp" />
            </c:when>
            <c:otherwise>
                <jsp:forward page="login.jsp" >
                    <jsp:param name="errorMsg" value="The password is incorrect."/>
                </jsp:forward>
            </c:otherwise>
        </c:choose>
    </c:otherwise>
</c:choose>
  
    </body>
</html>
