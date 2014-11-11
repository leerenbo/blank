<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%@ page import="com.datalook.model.sys.web.SessionInfo"%>
<%
	String contextPath = request.getContextPath();
%>

<html>
  <head>
    <title>My JSP 'index.jsp' starting page</title>
  </head>
  
  <body>
 <jsp:include page="inc.jsp"></jsp:include>
<%
	SessionInfo sessionInfo = (SessionInfo) session.getAttribute("sessionInfo");
	if (sessionInfo != null) {
		request.getRequestDispatcher("/pages/main.jsp").forward(request, response);
	} else {
		request.getRequestDispatcher("/login.jsp").forward(request, response);
	}
%>
  </body>
</html>
