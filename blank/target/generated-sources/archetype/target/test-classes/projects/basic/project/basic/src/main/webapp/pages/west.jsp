<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="it.pkg.model.sys.web.SessionInfo"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<script type="text/javascript" charset="utf-8">
	function openTabInMain(title,src,iconCls){
		src=ez.contextPath+src;
 		var tabs = $('#mainTabs');

		var opts = {
			title : title,
			closable : true,
			iconCls: iconCls,
			content : ez.formatString('<iframe src="{0}" allowTransparency="true" style="border:0;width:100%;height:99%;" frameBorder="0"></iframe>', src),
			border : false,
			fit : true
		};
		if (tabs.tabs('exists', opts.title)) {
			tabs.tabs('select', opts.title);
		} else {
			tabs.tabs('add', opts);
		}
 	}
</script>
    <div class="easyui-accordion" data-options="multiple:true,border:false" >
		<s:iterator value="functions" id="func">
			<s:if test="#func.functiontype ==2">
				<div  title="<s:property value="#func.functionname"/>" data-options="selected:true" style="padding:10px;">
				<s:iterator value="functions" id="insidefunc">
					<s:if test="#insidefunc.functiontype ==3 && #insidefunc.pid==#func.id">
       					<a href="#" class="easyui-linkbutton" data-options="plain:true,width:170,iconCls:'<s:property value="#insidefunc.iconCls"/>'
       						"  onClick="openTabInMain('<s:property value="#insidefunc.functionname"/>','<s:property value="#insidefunc.url"/>','<s:property value="#insidefunc.iconCls"/>')"><s:property value="#insidefunc.functionname"/></a>
					</s:if>
				</s:iterator>
        		</div>
			</s:if>
		</s:iterator>    
    </div>
