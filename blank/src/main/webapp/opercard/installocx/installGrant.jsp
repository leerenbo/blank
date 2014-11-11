<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String contextPath = request.getContextPath();
%>
<html>
	<head>
		<title>插件安装</title>
		<script type="text/javascript" src="<%=contextPath%>/js/jquery-easyui-1.4/jquery.min.js"></script>
		<script type="text/javascript">
		    /* ---------------------判断浏览器决定安装不同版本的插件start--------------------- */
			$(function (){ 
				var explorer = window.navigator.userAgent ;
				//ie 
				if (!!window.ActiveXObject || "ActiveXObject" in window) {
					$("#ieAndFirefox").css("display", "inline");
				}
				//firefox 
				else if (explorer.indexOf("Firefox") >= 0) {
					$("#ieAndFirefox").css("display", "inline");
				}
				//Chrome
				else if(explorer.indexOf("Chrome") >= 0){
					alert("Chrome暂时不支持");
				}
				//Opera
				else if(explorer.indexOf("Opera") >= 0){
					alert("Opera暂时不支持");
				}
				//Safari
				else if(explorer.indexOf("Safari") >= 0){
					alert("Safari暂时不支持");
				}
			});
			/* ---------------------判断浏览器决定安装不同版本的插件end--------------------- */
		</script>
	</head>		
	<body>
		<span>下载OCX插件:</span>
		<br/><br/>
		<span id="ieAndFirefox" style="display: none">点击
			<a href="<%=contextPath%>/opercard/installocx/OCX.zip">&quot;下载OCX插件（IE版&火狐版）&quot;</a>
			<br/><br/>
			<font color="red" size="2px;">下载结束后请解压文件。并参照文件中安装说明文档进行插件安装</font>
		</span>
	</body>
</html>
