<%--
  Created by IntelliJ IDEA.
  User: Tim
  Date: 2/2/13
  Time: 10:42 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ page import="java.util.List" %>
<%@ page import="tips.GetAllTipsServlet" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <link type="text/css" rel="stylesheet" href="/stylesheets/main.css"/>
</head>
<body>

<%
    //String tipsStoreName = request.getParameter(GetAllTipsServlet.TIPS_STORE_NAME_PARAMETER);
    //if (tipsStoreName == null) {
      String  tipsStoreName = GetAllTipsServlet.TIPS_STORE_NAME_DEFAULT;
    //}

    pageContext.setAttribute("tip_store_name", tipsStoreName);

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
    to include your name with greetings you post.</p>
<%
    }
%>
<%
    DatastoreService datastore = DatastoreServiceFactory    .getDatastoreService();
    Key key = KeyFactory.createKey(GetAllTipsServlet.TIPS_STORE_NAME_KEY,tipsStoreName);
// Run an ancestor query to ensure we see the most up-to-date
    // view of the Greetings belonging to the selected Guestbook.
    Query query = new Query(GetAllTipsServlet.TIPS_STORE_KIND, key);//.addSort("date", Query.SortDirection.DESCENDING);
    List<Entity> tips = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(50));
    if (tips.isEmpty()) {
%>
<p>TipStore '${fn:escapeXml(tip_store_name)}' has no messages.</p>
<%
} else {
%>

<p>Messages in TipStore '${fn:escapeXml(tip_store_name)}'.</p>
<%
    for (Entity greeting : tips) {
        pageContext.setAttribute("tip_id", greeting.getKey().getId());
        pageContext.setAttribute("tip_text", greeting.getProperty(GetAllTipsServlet.TIP_TIP_TEXT));
        pageContext.setAttribute("tip_ref", greeting.getProperty(GetAllTipsServlet.TIP_REF_URL));
        pageContext.setAttribute("tip_icon", greeting.getProperty(GetAllTipsServlet.TIP_ICON_URL));
        pageContext.setAttribute("tip_mod", greeting.getProperty(GetAllTipsServlet.TIP_MODIFIED));
        if (greeting.getProperty("user") == null) {
%>
<p>An anonymous person wrote:</p>
<%
} else {
    pageContext.setAttribute("greeting_user", greeting.getProperty("user"));
%>
<p><b>${fn:escapeXml(greeting_user.nickname)}</b> wrote:</p>
<%
    }
%>
<blockquote>${fn:escapeXml(tip_id)}: ${fn:escapeXml(tip_text)}<br/>
    ${fn:escapeXml(tip_ref)}<br/>
    ${fn:escapeXml(tip_icon)}<br/>
    ${fn:escapeXml(tip_mod)}<br/>
</blockquote>
<%
        }
    }
%>

<%
    pageContext.setAttribute("tip_text",GetAllTipsServlet.TIP_TIP_TEXT);
    pageContext.setAttribute("tip_icon",GetAllTipsServlet.TIP_ICON_URL);
    pageContext.setAttribute("tip_ref_url",GetAllTipsServlet.TIP_REF_URL);
    pageContext.setAttribute("tips_store_name_param",GetAllTipsServlet.TIPS_STORE_NAME_PARAMETER);
%>
<form action="/addTip" method="post">
    <div>Tip text:
        <textarea name="${tip_text}" rows="3" cols="60"></textarea></div>
    <div>Tip icon Url:
        <textarea name="${tip_icon}" rows="1" cols="60"></textarea></div>
    <div>Tip reference url:
        <textarea name="${tip_ref_url}" rows="1" cols="60"></textarea></div>
    <div><input type="submit" value="Post Tip"/></div>
    <input type="hidden" name="${tips_store_name_param}" value="${fn:escapeXml(tip_store_name)}"/>
</form>
<a href="./csv1">Download CSV file</a>
</body>
</html>