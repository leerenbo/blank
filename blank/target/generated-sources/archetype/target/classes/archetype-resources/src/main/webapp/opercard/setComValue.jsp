#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.HashMap"%>
<%String contextPath = request.getContextPath();%>
<%
	Map<String, Cookie> cookieMap = new HashMap<String, Cookie>();
	Cookie[] cookies = request.getCookies();
	if (null != cookies) {
		for (Cookie cookie : cookies) {
			cookieMap.put(cookie.getName(), cookie);
		}
	}
	String easyuiTheme = "bootstrap";//指定如果用户未选择样式，那么初始化一个默认样式
	if (cookieMap.containsKey("easyuiTheme")) {
		Cookie cookie = (Cookie) cookieMap.get("easyuiTheme");
		easyuiTheme = cookie.getValue();
	}
%>
<html>
	<head>
		<title>串口设置</title>
		<script type="text/javascript" src="<%=contextPath%>/js/jquery-easyui-1.4/jquery.min.js"></script>
		<link id="easyuiTheme" rel="stylesheet" href="<%=contextPath%>/js/jquery-easyui-1.4/themes/<%=easyuiTheme%>/easyui.css" type="text/css">
		<link rel="stylesheet" href="<%=contextPath%>/js/jquery-easyui-1.4/themes/icon.css" type="text/css">
		<script type="text/javascript" src="<%=contextPath%>/js/jquery-easyui-1.4/jquery.easyui.min.js" charset="utf-8"></script>
		<script type="text/javascript" src="<%=contextPath%>/js/jquery-easyui-1.4/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
		<link rel="stylesheet" href="<%=contextPath%>/style/EzuiIcon.css" type="text/css">
		<link rel="stylesheet" href="<%=contextPath%>/style/EzuiCss.css" type="text/css">
	    <script type="text/javascript">
	    	//显示、隐藏psam卡槽
			function setCardType(obj){
			    var cardtype = obj.value;
				if ( cardtype == "1" || cardtype == "2"  || cardtype == "3") {
					${symbol_dollar}("${symbol_pound}PasmCardIndex").parent().css('display','block');
					${symbol_dollar}("${symbol_pound}CpuCardType").parent().css('display','block');
				} else {
					${symbol_dollar}("${symbol_pound}PasmCardIndex").parent().css('display','none');
					${symbol_dollar}("${symbol_pound}CpuCardType").parent().css('display','none');
				}
			}
			
	    	${symbol_dollar}(function (){
		    	/* -----------------初始化信息start----------------- */
	    		/* ---------------------判断浏览器决定调用不同版本控件start--------------------- */
	    		var rfCard;//操作卡控件
	    		var explorer = window.navigator.userAgent ;
	    		//ie 
	    		if (!!window.ActiveXObject || "ActiveXObject" in window) {
	    			rfCard = document.getElementById('RfCard');
	    		}
	    		//firefox 
	    		else if (explorer.indexOf("Firefox") >= 0) {
	    			rfCard = document.getElementById('Splugin');
	    		}
	    		//Chrome
	    		else if (explorer.indexOf("Chrome") >= 0) {
	    			alert("Chrome暂时不支持操作卡控件");
	    		}
	    		//Opera
	    		else if (explorer.indexOf("Opera") >= 0) {
	    			alert("Opera暂时不支持操作卡控件");
	    		}
	    		//Safari
	    		else if (explorer.indexOf("Safari") >= 0) {
	    			alert("Safari暂时不支持操作卡控件");
	    		}
	    		/* ---------------------判断浏览器决定调用不同版本控件end--------------------- */
	            
	            //初始化串口号
	            var message = new Array(); //定义一数组
				var loadComResult = rfCard.readCommIni();//读取串口号
				message = loadComResult.split("|"); //解析返回结果
				var readCardComValue = message[1];//读卡器串口号
				var comSize = ${symbol_dollar}("${symbol_pound}com option").length;
				for (var i = 0; i < comSize; i++) {
					if (${symbol_dollar}("${symbol_pound}com").get(0).options[i].value == readCardComValue) {
						${symbol_dollar}("${symbol_pound}com").combobox('select',readCardComValue);
						break;
					}
				}
				
				//初始化卡类型
				var loadCardTypeResult = rfCard.readCard_TypeIni();//读取卡类型
				message = loadCardTypeResult.split("|"); //解析返回结果
				var cardTypeValue = message[1];//卡类型
				var cardTypeSize = ${symbol_dollar}("${symbol_pound}cardtype option").length;
				for (var i = 0; i < cardTypeSize; i++) {
					if (${symbol_dollar}("${symbol_pound}cardtype").get(0).options[i].value == cardTypeValue) {
						${symbol_dollar}("${symbol_pound}cardtype").combobox('select',cardTypeValue);
						break;
					}
				}
				
				//初始化卡槽和CPU卡类型
				if (cardTypeValue == "1" || cardTypeValue == "2" || cardTypeValue == "3") {
					//初始化卡槽
					var loadPsamResult = rfCard.readPsamIndexIni();//读取PSAM卡槽
					message = loadPsamResult.split("|"); //解析返回结果
					var pasmCardIndexValue = message[1];//PSAM卡槽				
					var pasmSize = ${symbol_dollar}("${symbol_pound}PasmCardIndex option").length;
					for (var i = 0; i < pasmSize; i++) {
						if (${symbol_dollar}("${symbol_pound}PasmCardIndex").get(0).options[i].value == pasmCardIndexValue) {
							${symbol_dollar}("${symbol_pound}PasmCardIndex").combobox('select',pasmCardIndexValue);
							break;  
						}
					}
					
					//初始化CPU卡类型
					var loadCpuCardTypeResult = rfCard.readCpuCardTypeIni();//读取CPU卡类型
					message = loadCpuCardTypeResult.split("|"); //解析返回结果
					var cpuCardTypeValue = message[1];//CPU卡类型
					var cpuSize = ${symbol_dollar}("${symbol_pound}CpuCardType option").length;
					for (var i = 0; i < cpuSize; i++) {
						if (${symbol_dollar}("${symbol_pound}CpuCardType").get(0).options[i].value == cpuCardTypeValue) {
							${symbol_dollar}("${symbol_pound}CpuCardType").combobox('select',cpuCardTypeValue);
							break;  
						}
					}
				} else {
					${symbol_dollar}("${symbol_pound}PasmCardIndex").parent().css('display','none');
					${symbol_dollar}("${symbol_pound}CpuCardType").parent().css('display','none');	
				}
				
				//初始化加密方式
				var loadM1EnModeResult = rfCard.readM1EnModeIni();//读取加密方式
				message = loadM1EnModeResult.split("|"); //解析返回结果
				var m1EnModeValue = message[1];//加密方式
				var cyptModeSize = ${symbol_dollar}("${symbol_pound}cyptMode option").length;
				for (var i = 0; i < cyptModeSize; i++) {
					if (${symbol_dollar}("${symbol_pound}cyptMode").get(0).options[i].value == m1EnModeValue) {
						${symbol_dollar}("${symbol_pound}cyptMode").combobox('select',m1EnModeValue);
						break;  
					}
				}		
				/* -----------------初始化信息end----------------- */
				
				//保存设置
				${symbol_dollar}("${symbol_pound}saveConfig").click(function(){
					var message = new Array(); //定义一数组
					var cardTypeValue = ${symbol_dollar}("${symbol_pound}cardtype").combobox('getValue');//卡类型
					var readCardComValue = ${symbol_dollar}("${symbol_pound}com").combobox('getValue');//读卡器串口号
					var cyptModeValue = ${symbol_dollar}("${symbol_pound}cyptMode").combobox('getValue');//加密方式
					var setComResult = rfCard.writeCommIni(readCardComValue);//保存读卡器串口
					message = setComResult.split("|");//解析返回结果
					if (message[0] == 0) {
						var setCardTypeResult = rfCard.writeCard_TypeIni(cardTypeValue);//保存卡类型
						message = setCardTypeResult.split("|");//解析返回结果
						if (message[0] == 0) {
							rfCard.writeCard_TypeIni(cardTypeValue);//写配置文件（卡类型）
							rfCard.writeM1EnModeIni(cyptModeValue);//保存加密方式
							if ( cardTypeValue == "1" || cardTypeValue == "2" || cardTypeValue == "3" || cardTypeValue == "4") {//CPU卡
								var pasmCardIndexValue = ${symbol_dollar}("${symbol_pound}PasmCardIndex").combobox('getValue');//PSAM卡槽
								var setPsamResult = rfCard.writePsamIndexIni(pasmCardIndexValue);//保存PSAM卡槽
								message = setPsamResult.split("|");//解析返回结果
								if (message[0] == 0) {
									var cpuCardTypeValue = ${symbol_dollar}("${symbol_pound}CpuCardType").combobox('getValue');//CPU卡类型
									var setCpuCardTypeResult = rfCard.writeCpuCardTypeIni(cpuCardTypeValue);//保存CPU卡类型
									message = setCpuCardTypeResult.split("|");//解析返回结果
									if (message[0] == 0) {
										${symbol_dollar}.messager.confirm('','保存成功，请关闭浏览器，重新进入系统!',function(r){
											if (r) {
												var userAgent = navigator.userAgent;
												if (userAgent.indexOf("Firefox") != -1 || userAgent.indexOf("Presto") != -1) {
												    window.parent.location.replace("about:${artifactId}");
												} else {
												    window.opener = null;
												    window.open("", "_self");
												    window.parent.close();
												}
											}
										});
									} else {
										${symbol_dollar}.messager.alert('','保存CPU卡类型失败!','error');
									}
								} else {
									${symbol_dollar}.messager.alert('','保存PSAM卡槽失败!','error');
								}
							} else {
								${symbol_dollar}.messager.confirm('','保存成功，请关闭浏览器，重新进入系统!',function(r){
									if (r) {
										var userAgent = navigator.userAgent;
										if (userAgent.indexOf("Firefox") != -1 || userAgent.indexOf("Presto") != -1) {
										    window.parent.location.replace("about:${artifactId}");
										} else {
										    window.opener = null;
										    window.open("", "_self");
										    window.parent.close();
										}
									}
								});
							}
						} else {
							${symbol_dollar}.messager.alert('','保存卡类型失败!','error');
						}
					} else {
						${symbol_dollar}.messager.alert('','保存串口配置失败!','error');
					}
				});
	        });
        </script>		
	</head>
	<body>
		<div style="display: none;">
			<!-- IE版本 -->
			<object id="RfCard" classid="clsid:b4ca7207-acff-4cca-bd45-4518a4d80d13"></object>
			
		</div>
		<div>
			<!-- 火狐版本 -->
			<object id="Splugin" type="application/scriptable" width=0 height=0></object>
		</div>
		<table class="table" style="margin-left: 5%;">
			<tr>
				<th>串口号：</th>
				<td>
					<select class="easyui-combobox" name="com" id="com" data-options="width:'200',panelHeight:'210'">
						<option value="0">COM1</option>
						<option value="1">COM2</option>
						<option value="2">COM3</option>
						<option value="3">COM4</option>
						<option value="4">COM5</option>
						<option value="5">COM6</option>
						<option value="6">COM7</option>
						<option value="7">COM8</option>
						<option value="8">COM9</option>
						<option value="9">COM10</option>
						<option value="10">COM11</option>
						<option value="11">COM12</option>
						<option value="12">COM13</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>卡类型：</th>
				<td>
					<select class="easyui-combobox" name="cardtype" id="cardtype" data-options="onSelect:setCardType,width:'200',panelHeight:'120'">
						<option value="0">M1卡</option>
						<option value="1">M1卡、CPU卡</option>
						<option value="2">M1卡CPU卡、联通手机卡</option>						
						<option value="3">M1卡CPU卡、移动手机卡</option>
						<option value="4">2.4G手机卡</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>PSAM卡槽：</th>
				<td>
					<select class="easyui-combobox" name="PasmCardIndex" id="PasmCardIndex" data-options="width:'200',panelHeight:'70'">
						<option value="1">大卡槽</option>
						<option value="0">小卡槽I(U6)</option>
						<option value="2">小卡槽II(U7)</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>CPU卡类型：</th>
				<td>
					<select class="easyui-combobox" name="CpuCardType" id="CpuCardType" data-options="width:'200',panelHeight:'40'">
						<option value="1">华虹卡</option>
						<option value="0">其他卡</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>加密方式：</th>
				<td>
					<select class="easyui-combobox" name="cyptMode" id="cyptMode" data-options="width:'200',panelHeight:'40'">
						<option value="0">keyA</option>
						<option value="1">keyB</option>
					</select>
					<font style="color: red; font-size: 12px;">					
						<strong>默认为keyA</strong>
					</font>
				</td>
			</tr>
		</table>
		<div style="margin-top: 10px;">
            <a class="easyui-linkbutton" style="margin-left: 87%; width: 50px;" id="saveConfig">保存</a>
        </div>
	</body>
</html>