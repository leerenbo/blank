#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="${package}.model.sys.web.SessionInfo"%>
<html>
  <head>
    <title>My JSP 'index.jsp' starting page</title>
  </head>
  
  <body>
 <jsp:include page="inc.jsp"></jsp:include>
<%
	SessionInfo sessionInfo = (SessionInfo) session.getAttribute(${package}.util.base.ConfigUtil.getSessionName());
	if (sessionInfo != null) {
		request.getRequestDispatcher("/pages/main.jsp").forward(request, response);
	} else {
		request.getRequestDispatcher("/login.jsp").forward(request, response);
	}
%>
  </body>
</html>
