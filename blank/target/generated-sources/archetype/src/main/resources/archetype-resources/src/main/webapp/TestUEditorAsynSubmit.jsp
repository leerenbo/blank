#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>测试</title>
<script type="text/javascript">

	${symbol_dollar}(function() {
		${symbol_dollar}('${symbol_pound}ff').form({
			url : ez.contextPath + '/test!noSySn_ueditor.action',
			onSubmit : function() {
				// do some check
				// return false to prevent submit;
				return true;
			},
			success : function(data) {
				console.info(data);
			}
		});
	})
	function aa() {
	    //获取html内容，返回: <p>hello</p>
	    var html = ue.getContent();
	    //获取纯文本内容，返回: hello
	    var txt = ue.getContentTxt();
	    console.info(html);
	    console.info(txt);
		${symbol_dollar}('${symbol_pound}ff').submit();
	}
	

</script>
</head>
<body>
	<form id="ff" method="post">
		<!-- 加载编辑器的容器 -->
		<script id="container" name="content" type="text/plain"></script>
		<input type="button" value="button" onclick="aa();">
	</form>

	<!-- 实例化编辑器 -->
	<script type="text/javascript">
		
		/* ,{toolbars: [
		                                              ['fullscreen', 'source', 'undo', 'redo'],
		                                              ['bold', 'italic', 'underline', 'fontborder', 'strikethrough', 'superscript', 'subscript', 'removeformat', 'formatmatch', 'autotypeset', 'blockquote', 'pasteplain', '|', 'forecolor', 'backcolor', 'insertorderedlist', 'insertunorderedlist', 'selectall', 'cleardoc']
		                                          ]
} */
		var ue = UE.getEditor('container');
		//对编辑器的操作最好在编辑器ready之后再做
		ue.ready(function() {
		    //设置编辑器的内容
		    ue.setContent('hello');
		});

	</script>

</body>
</html>