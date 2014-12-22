#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="inc.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>测试</title>
<script type="text/javascript">
${symbol_dollar}(function () {
	${symbol_dollar}('${symbol_pound}ff').form({
		url : ez.contextPath + '/test!noSySn_upload.action',
	    onSubmit: function(){
	        // do some check
	        // return false to prevent submit;
	        return true;
	    },
	    success:function(data){
	    	console.info(data);
	    }
	});
})
function aa(){
	${symbol_dollar}('${symbol_pound}ff').submit();
}
</script>
</head>
<body>
<form id="ff"  method="post" enctype="multipart/form-data">
<input type="file" name="image" />
<input type="button" value="button" onclick="aa();">
</form>

<form id="dd" action="test!noSySn_upload.action"  method="post" enctype="multipart/form-data">
<input type="file" name="image" />
<input type="submit" value="submit">
</form>
</body>
</html>