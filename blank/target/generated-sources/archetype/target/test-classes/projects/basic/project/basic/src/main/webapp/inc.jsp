<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="org.apache.commons.lang3.StringUtils"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();%>
<%String contextPath = request.getContextPath();%>

<%
String easyuiTheme = "metro-blue";//指定如果用户未选择样式，那么初始化一个默认样式
/* Map<String, Cookie> cookieMap = new HashMap<String, Cookie>();
Cookie[] cookies = request.getCookies();
if (null != cookies) {
	for (Cookie cookie : cookies) {
		cookieMap.put(cookie.getName(), cookie);
	}
}
if (cookieMap.containsKey("easyuiTheme")) {
	Cookie cookie = (Cookie) cookieMap.get("easyuiTheme");
	easyuiTheme = cookie.getValue();
}
 */%>

<script type="text/javascript">
var ez = ez || {};
ez.contextPath = '<%=contextPath%>';
ez.basePath = '<%=basePath%>';
ez.pixel_0 = '<%=contextPath%>/style/images/pixel_0.gif';//0像素的背景，一般用于占位
</script>

<script type="text/javascript" src="<%=contextPath%>/js/jquery-easyui-1.4/jquery.min.js"></script>

<%-- 引入自定义样式 --%>
<link rel="stylesheet" href="<%=contextPath%>/style/EzuiCss.css" type="text/css">
<%-- 引入javascript扩展 --%>
<script src="<%=contextPath%>/js/EzuiJavascript.js" type="text/javascript" charset="utf-8"></script>
<%-- 引入jquery扩展 --%>
<script src="<%=contextPath%>/js/EzuiJquery.js" type="text/javascript" charset="utf-8"></script>

<%-- 引入EasyUI --%>
<link id="easyuiTheme" rel="stylesheet" href="<%=contextPath%>/js/jquery-easyui-1.4/themes/<%=easyuiTheme%>/easyui.css" type="text/css">
<link rel="stylesheet" href="<%=contextPath%>/js/jquery-easyui-1.4/themes/icon.css" type="text/css">
<%-- 引入扩展图标 --%>
<link rel="stylesheet" href="<%=contextPath%>/style/EzuiIcon.css" type="text/css">
<script type="text/javascript" src="<%=contextPath%>/js/jquery-easyui-1.4/jquery.easyui.min.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=contextPath%>/js/jquery-easyui-1.4/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>

<%-- 引入easyui扩展 --%>
<script src="<%=contextPath%>/js/EzuiEasyUI.js" type="text/javascript" charset="utf-8"></script>


<!-- 引入UEditor -->
<!-- 配置文件 -->
<script type="text/javascript" src="<%=contextPath%>/ueditor/ueditor.config.js"></script>
<!-- 编辑器源码文件 -->
<script type="text/javascript" src="<%=contextPath%>/ueditor/ueditor.all.js"></script>
<script type="text/javascript" src="<%=contextPath%>/ueditor/lang/zh-cn/zh-cn.js"></script>
