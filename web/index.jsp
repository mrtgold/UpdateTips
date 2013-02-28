<%--
  Created by IntelliJ IDEA.
  User: Tim
  Date: 2/2/13
  Time: 9:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
  <head>
    <title></title>
      <link type="text/css" rel="stylesheet" href="stylesheets/main.css"/>
  </head>
  <body>
  <%
      UserService userService = UserServiceFactory.getUserService();
      User user = userService.getCurrentUser();
      if (user != null) {
          pageContext.setAttribute("user", user);
  %>
  <p>Hello, ${fn:escapeXml(user.nickname)}! (You can
      <a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)</p>
  <%
  } else {
  %>
  <p>Hello!
      <a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>
      please!</p>
  <%
      }
  %>
  </body>
</html>