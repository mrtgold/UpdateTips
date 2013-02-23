<%--
  Created by IntelliJ IDEA.
  User: Tim
  Date: 2/2/13
  Time: 10:42 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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

<%!
%><%
    String tipsStoreName = request.getParameter(GetAllTipsServlet.TIPS_STORE_NAME_PARAMETER);
    if (tipsStoreName == null) {
        tipsStoreName = GetAllTipsServlet.TIPS_STORE_NAME_DEFAULT;
    }

    pageContext.setAttribute(GetAllTipsServlet.TIPS_STORE_NAME_PARAMETER, tipsStoreName);

    DatastoreService datastore = DatastoreServiceFactory    .getDatastoreService();
    Key tipStoreKey = KeyFactory.createKey(GetAllTipsServlet.TIPS_STORE_NAME_KEY, tipsStoreName);
// Run an ancestor query to ensure we see the most up-to-date
    // view of the Greetings belonging to the selected Guestbook.
    Query query = new Query(GetAllTipsServlet.TIPS_STORE_KIND, tipStoreKey);//.addSort("date", Query.SortDirection.DESCENDING);
    List<Entity> tips = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(50));
    if (tips.isEmpty()) {
%>
<p>TipStore '${fn:escapeXml(tipsStoreName)}' has no messages.</p>
<%
} else {
%>
<p>Tips in TipStore '${fn:escapeXml(tipsStoreName)}'.</p>
<%
    for (Entity tip : tips) {
        pageContext.setAttribute("tip_text",
                tip.getProperty(GetAllTipsServlet.TIP_TIP_TEXT));
%>
<blockquote>${fn:escapeXml(tip_text)}</blockquote>
<%
        }
    }
%>
</body>
</html>