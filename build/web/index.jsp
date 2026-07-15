<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    // Si ya hay sesión activa, ir al dashboard
    if (session.getAttribute("usuario") != null) {
        response.sendRedirect(request.getContextPath() + "/dashboard");
        return;
    }
    // Si no hay sesión, ir al login
    response.sendRedirect(request.getContextPath() + "/login.jsp");
%>