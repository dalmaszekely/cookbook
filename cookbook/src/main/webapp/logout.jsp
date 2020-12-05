<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<%
    session.invalidate();
    String redirectURL = "login.jsp";
    response.sendRedirect(redirectURL);
%>