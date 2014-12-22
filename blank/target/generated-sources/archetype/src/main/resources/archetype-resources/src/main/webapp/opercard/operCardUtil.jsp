#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc.jsp"%>
<div style="display:none;">
	<!-- IE版本 -->
	<object id="RfCard" classid="clsid:b4ca7207-acff-4cca-bd45-4518a4d80d13"></object>
</div>
<div>
	<!-- 火狐版本 -->
	<object id="Splugin" type="application/scriptable" width=0 height=0></object>
</div>
<script type="text/javascript">
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
	
	/* ---------------获得卡参数start--------------- */
	var _userCode = "";//用户代码
	var _cardKey = "";//卡密钥
	var _initKey = "";//初始密钥
	${symbol_dollar}.ajax({
		type : "post", 
		async : false,//同步
		url : "<%=contextPath%>/sysCardParam!noSnSy_findAll.action",
		success : function(data){
			var res = eval(data);
			_userCode = res[0].usercode;
			_cardKey = res[0].cardkey;
			_initKey = res[0].providerkey;
		}
	});
	/* ---------------获得卡参数end--------------- */
	
	/* ------------------------------外部调用读卡start------------------------------ */
	
	/* ---------------读卡并返回卡中信息start--------------- */
	function readCardInfo(operate){
		try {
			if (openSerial()) {//打开串口号
				if (hasCard()) {//是否有卡
					var cardid = getCardId();//卡序列号
					
					//判断是否为本系统卡
					var encrycardid = cardIdEncrypt(cdidencryption, cardid);//加密后的卡序列号
					var result = checkCardId(encrycardid);
					if (result == "0") {//0 否     1 是
						//如果不是本系统卡，则验证卡密钥，验证通过则允许开户
						var encrycarkey = cardIdEncrypt(cdidencryption, _cardKey);//加密后的卡密钥
						var res = checkCardId(encrycarkey);
					    if (res == "0") {//验证卡密钥
					    	parent.${symbol_dollar}.messager.alert('','此卡非本系统卡!','error');
							return false;
					    }
					}
					
					if (operate == "open") {
						//卡序列号是否已被使用
						var reExist = checkCardidExist(cardid);
						if (reExist == "0") {//0 否     1 是
							parent.${symbol_dollar}.messager.alert('','卡序列号已被使用!','error');
							return false;
						}
					}
					
					//蜂鸣
					beep();
					
					//卡信息
					var usercode = "";//用户代码(2扇区第0块前8位数据)
					var cardno = "";//卡号(2扇区第0块第二个8位数据)
					var employeenumber = "";//员工号(2扇区第1块数据)
					var cardpwd = "";//密码(2扇区第2块前6位数据)
					var employeename = "";//员工姓名(3扇区第2块数据)
					
					//加载卡密钥
					loadCardPwd();
					
					var str = readCard(8);
					if (str != null && str != "") {
						cardno = str.substring(8, 16);
					}
					
					str = readCard(9);
					if (str != null && str != "") {
						employeenumber = str;
					}
					
					str = readCard(14);
					if (str != null && str != "") {
						var len = str.indexOf("0");
						if (len < 0) {
							employeename = str;
						} else {
							employeename = str.substring(0, len);
						}
					}
					
					var cardinfo = {
						"cardid" : cardid,
						"cardno" : cardno,
						"employeenumber" : employeenumber,
						"employeename" : employeename
					};
					
					return cardinfo;
					
				} else {
					parent.${symbol_dollar}.messager.alert('','没有卡片!','error');
					return ;
				}
			} else {
				parent.${symbol_dollar}.messager.alert('','请设置串口!','error');
			}
    	} catch(e) {
    		parent.${symbol_dollar}.messager.alert('','页面异常，请重新打开该页面!','error');
    	} finally {
    		closeSerial();//关闭串口
    	}
	};
	/* ---------------读卡并返回卡中信息end--------------- */
	
	/* ---------------判断是否为本系统卡start--------------- */
	function checkCardId(encrycardid){
		var result = "1";
		${symbol_dollar}.ajax({
			type : "post",
			async : false,//同步
			url : "<%=contextPath%>/cardChkCardid!noSnSy_findAll.action?hqland_cardid_dengyu_String=" + encrycardid,
		    success : function(data){
		    	var res = eval(data);
		    	if (res.length > 0) {
		    		return result;
		    	} else {
		    		return result = "0";
		    	}
		    }
		});
		return result;
	}
	/* ---------------判断是否为本系统卡end--------------- */
	
	/* ---------------卡序列号是否已被使用start--------------- */
	function checkCardidExist(cardid){
		var result = "1";
		${symbol_dollar}.ajax({
			type : "post",
			dataType : "json",
			async : false,//同步
			url : "<%=contextPath%>/card!noSnSy_checkCardidExist.action",
			data : {cardid : cardid},
		    success : function(data){
		    	if (data.success == false) {
		    		return result = "0";
		    	} else {
		    		return result;
		    	}
		    }
		});
		return result; 
	}
	/* ---------------卡序列号是否已被使用end--------------- */
	
	/* ------------------------------外部调用读卡end------------------------------ */
	
	/* ------------------------------外部调用写卡start------------------------------ */
	
	/* ---------------------------写卡start--------------------------- */
	function writeCardInfo(cardno, cardid, cardInfo){
		var flag = callWriteCard(true,cardno,cardid,cardInfo);
		if (flag == "2") {
			flag = callWriteCard(false,cardno,cardid,cardInfo);//不加密直接写卡
		}
		return flag;
	}
	/* ---------------------------写卡end--------------------------- */
	
	function callWriteCard(isRepwd, cardNo, cardId, cardInfo){
		var isSuccess = false;
		var blackNum;
		var msg;
		var posIndex;
		var msgArray = cardInfo.split("|");
		try {
			if (openSerial()) {//打开串口号
				if (hasCard()) {//有卡
					var _cardId = getCardId();//得到卡序列号
					if (_cardId == "") {
						return "1";//卡序列号为空
					} else if (cardId != _cardId) {
						return "1";//交易前后卡号不一致
					}
					if (isRepwd) { //加密卡片
						loadDefaultCardPwd();
						if (!cardEncrypt(cardNo)) {
							return "2";//卡片初始化错误，请重新初始化
						}
					}
					loadCardPwd(); //加载卡密钥
					for (var i = 0; i < msgArray.length; i++) {
						posIndex = msgArray[i].indexOf(":");
						if (posIndex > 0) {
							blackNum = msgArray[i].substring(0, posIndex);
							msg = msgArray[i].substring(posIndex + 1);
							if (blackNum == "" || msg == "") {//非法的写卡组织信息						
								return "4";//非法的写卡组织信息
								break;
							} else {
								isSuccess = writeCardData(blackNum, msg);//调用写卡方法
								if (!isSuccess) { //写卡失败
									return "4";//非法的写卡组织信息
								}
							}
						} else { //非法的写卡组织信息
							return "4";//非法的写卡组织信息
							break;
						}
					}		
				} else {//没有卡片
					return "3";//没有卡片
				}		
			} else {
				return "-1";
			}
			if (isSuccess) {//写卡成功
				beep();//蜂鸣
				return "0";
			}
		} catch(e) {
			return "-2";
		} finally {
			closeSerial();//关闭串口
		}
	}	
	/* ------------------------------外部调用写卡end------------------------------ */
	
	/* ------------------------------dll------------------------------ */
	//打开串口   0:成功，其他则为失败
	function openSerial(){
		var comvalue = getComValue();
		var restr = rfCard.rf_link_com(comvalue);//打开串口
		var strs = restr.split("|");//解析返回结果
		if (strs[0] == 0) {
			return true;
		} else {
			return false;
		}
	}
	
	//获取读卡器串口号
	function getComValue(){
		var comvalue = "-1";
		var restr = rfCard.readCommIni();//获取读卡器串口
		var strs = restr.split("|");
		if (strs[0] == 0) {
		   var comvalue = strs[1]; 
		}
		return comvalue;
	}
	
	//判断是否有卡
	function hasCard(){
		var restr = rfCard.rf_card();//判断是否有卡
		var strs = restr.split("|");//解析返回结果
		if (strs[0] == 0) {
		  return true;
		} else {
		  return false;
		}			
	}	
	
	//读取卡片序列号（十进制）
	function getCardId(){
		var restr = rfCard.rf_rd_cardnum();//读取卡片序列号
		var strs = restr.split("|");
		if (strs[0] == 0) {
			return hex2dec(strs[1]);
		} else {
			return "-1";
		}
	}
	
	//卡序列号加密
	function cardIdEncrypt(cdidencryption, cardid){
		restr = rfCard.Encry_Id(cdidencryption, cardid);
	  	var strs = restr.split("|");
	  	if (strs[0] == 0) {
	    	return strs[1];
	  	} else {
	    	return "";
	  	}
	}
	
	//关闭串口
	function closeSerial(){
		try {
		  var restr = rfCard.rf_unlink_com();//关闭串口
		} catch(e) {			
			restr = "";
		}
	}
   
	//蜂鸣
	function beep(){
		try {
			var restr = rfCard.rf_beep(1);//蜂鸣
		} catch(e) {
			restr = "";
		}
	}
	
	//装载卡片密钥
	function loadCardPwd(){
		var cardid = getCardIdHex();//十六进制卡ID
		var restr = rfCard.rf_load_key_look(_userCode + cardid, _cardKey);
		var strs = restr.split("|");
		if (strs[0] == 0) {
			return true;
		} else {
			return false;
		}
	}
	
	//读卡
	function readCard(block){
		var str = "";
		if (block == 12) {	 
		   str = readCardMoney("1");//读卡金额（按存款读取）
		} else {
		   str = readCardother(block);
		}
		return str;
	}
	
	/**
	 * 获取卡金额:由于CPU卡中的用卡次数为内部维护，存款和取款个维护一个，所以，要根据存款和取款区分将其用卡次数读出来
	 *            为了让其能够具有通用性，所以按标志进行区分
	 * flag 0:取款 1：存款 
	 */
	function readCardMoney(flag){
	    var tmpstr = "";
		if (flag == "0") {
			var restr = rfCard.rf_rd_bala_mf2_look();
		    //restr=0:读卡成功，否则读卡失败
		    var strs = restr.split("|");
		    if (strs[0] == 0) {
				//解析读出来的串：   0~8：卡余额，   8~14：累计消费日期，  14~22：累计消费金额，  22~26：用卡次数，26~30：卡控制序列号
				return strs[1];
		    } else {
				return "";
		    }
		} else {
			var restr = rfCard.rf_rd_bala_mf1_look();
		    var strs = restr.split("|");
		    if (strs[0] == 0) {
				//解析读出来的串：   0~8：卡余额，   8~14：累计消费日期，  14~22：累计消费金额，  22~26：用卡次数，26~30：卡控制序列号
				return strs[1];
		    } else {
				return "";
		    }
		}
	}
	
	/*
	*读非金额区的卡数据函数
	*k=8  读卡编号串：   0~8：用户代码，   8~16：卡编号，  16~18：卡状态，  18~24：有效日期，24~26：卡类型，26~28：身份，
	*k=9  读证件号串：
	*k=10读个人密码和消费限额串：0~6：卡密码，6~14：消费限额，14~22：累计消费限额
	*k=14读姓名串  
	*/
	function readCardother(block){
		var tmpstr = "";
		var restr = "";
		if (block == 14) {//读姓名
		  	restr = rfCard.rf_rd_cardc(18, 0, block, 16);
		  	var strs = restr.split("|");
		  	if (strs[0] == 0) {
		    	return strs[1];
		  	} else {
		    	return "";
		  	}
		} else if (block == 9) {//读证件号
			restr = rfCard.rf_rd_card(18, 0, block, 16);
          	var strs = restr.split("|");
		  	if (strs[0] == 0) {
		    	return idserialConvert(strs[1], 0);
		  	} else {
		    	return "";
		  	}
		} else {
			restr = rfCard.rf_rd_card(18, 0, block, 16);
			var strs = restr.split("|");		  
			if (strs[0] == 0) {
				return strs[1];
			} else {
				return "";
			}
		}
	}
	
	//证件号的解析方法，用来进行读和写证件号时，处理证件号
	function idserialConvert(certno, flag){
		var tmpss,s1,sss,len1,len2,tmplen,news1,news2,news3,news4,news;
	  	if (flag == "0") {//读转换
		  	/*例如卡内存储证件号值：41530821612161045751
		     	 解析拆分：41：A，  53：S，  
						06：长度，
						21612161：中间证件号真实值
						04:后面字符长度，
						57：W，51：Q
			  	转换后真实证件号：AS21612161WQ
			  */
			tmpss = certno.substring(0, 2);//证件号第一位，ascii码16进制
			s1 = parseInt(tmpss, 16);//将16进制转10进制
			news1 = String.fromCharCode(s1);//要显示的证件号第一位字符
			tmpss = certno.substring(2, 4);//证件号第二位，ascii码16进制
			s1 = parseInt(tmpss, 16);//将16进制转10进制
			news2 = String.fromCharCode(s1);//要显示的证件号第二位字符
			tmplen = certno.substring(4, 6);//紧接着第三位和第四位存储的是中间证件号长度
			if (tmplen == "00") {
		 		news = "";
		 		len1 = 0;
	    	} else {
		 		tmplen = removeZero(tmplen);
		 		len1 = parseInt(tmplen);
		 		news = certno.substring(6, len1 + 6);//把中间的证件号取出来
			}
			tmplen = removeZero(certno.substring(6 + len1, 6 + len1 + 2));//后面的长度值
	    	len2 = parseInt(tmplen);
			if (len2 == 4) {
		  		tmpss = certno.substring(6 + len1 + 2, 6 + len1 + 2 + 2);
		  		s1 = parseInt(tmpss, 16);//将16进制转10进制
		  		news3 = String.fromCharCode(s1);//要显示的证件号倒数第二位字符
		  		tmpss = certno.substring(6 + len1 + 2 + 2, 6 + len1 + 2 + 2 + 2);
		  		s1 = parseInt(tmpss, 16);//将16进制转10进制
		  		news4 = String.fromCharCode(s1);//要显示的证件号倒数第一位字符
			} else {
	      		news3 = "";
		  		news4 = "";
			}
			return news1 + news2 + news + news3 + news4;
	  	}
	  	
	  	if (flag == "1") {//写转换
	  		var sb = new StringBuffer();
	  		sb.append(str2Hex(certno.substring(0, 2)));
	  		var msglen = certno.length;
			var len = msglen-4;
			if (len <= 0) {
				sb.append("00");
			} else if (len < 10) {
				sb.append("0");
				sb.append(len);
				sb.append(certno.substring(2, len+2));
			} else {
				sb.append(len);
				sb.append(certno.substring(2, len+2));
			}
			sb.append("04");
			sb.append(str2Hex(certno.substring(msglen-2)));
			return sb.toString();
		}
	}
	
	//去除首部‘0’字符
	function removeZero(str){
		if (str == 0) return '0';
	   	var ch;  
	   	if (str == "") {				
			return "";
		}	
	   	
		try {			
			for (var i = 0; i < str.length; i = i + 1) {
				ch = str.charAt(i);
				if (ch == '0') {					
					continue;
				} else {
				   return str.substr(i);
				}
			}
		} catch (e) {
			return "";
		}		
	}
	
	//写卡函数
    function writeCardData(block, cardInfo){
       var restr = "";
       var strs;
       var ret = false;
       var newcardid = getCardIdHex();//十六进制卡ID
       //装载用户代码和卡密钥
       rfCard.rf_load_key_look(_userCode + newcardid, _cardKey);
       if (block == 12) {//写金额区
			restr = rfCard.rf_wr_bala_mf1_look(cardInfo);
			strs = restr.split("|");
			if (strs[0] == 0) {
				ret = true;//写卡成功
			} else {
				ret=false; //写卡失败
			}
       } else {//写非金额块数据
            if (block == 9) {//写证件号块
				var idserial = idserialConvert(cardInfo, 1);//证件号写转换
				idserial = fillStr(idserial, 30, "0", 1);//补齐30位
				restr = rfCard.rf_wr_card_mac(18, 0, block, 16, idserial);
				strs = restr.split("|");
				if (strs[0] == 0) {
					ret = true;//写卡成功
				} else {
					ret = false; //写卡失败
				}				
            } else if (block == 14) {//写姓名
				restr = rfCard.rf_wr_cardc(18, 0, block, 15, cardInfo);
				strs = restr.split("|");
				if (strs[0] == 0) {
					ret = true;//写卡成功
				} else {
					ret = false; //写卡失败
				}
            } else {
            	restr = rfCard.rf_wr_card_mac(18, 0, block, 16, cardInfo);
				strs = restr.split("|");
				if (strs[0] == 0) {
					ret = true;//写卡成功
				} else {
					ret=false; //写卡失败
				}           	
            }
		}
		return ret;
	}
	
  	//装载初始卡密钥
	function loadDefaultCardPwd(){
		var restr = rfCard.rf_load_key(18, _initKey);
		var strs = restr.split("|");
		if (strs[0] == 0) {
			return true;
		} else {
			return false;
		}		
	}
	
	//卡片2、3加密
	function cardEncrypt(cardNo){
		var cardid = getCardIdHex();//十六进制卡ID
		cardNo = fillStr(cardNo, 8, "0", 0);
		var restr = rfCard.rf_modi_key_look(_userCode + cardid + cardNo, _cardKey);
		var strs = restr.split("|");
		if (strs[0] == 0) {
			return true;
		} else {
			return false;
		}
	}
	
	/**
	 * 根据条件和给定的长度获取填充后的字符串
	 * @param src 源字符串
	 * @param len 所需长度
	 * @param fillStr 填充串  为空时默认填充0
	 * @param flag 填充标志 0：前填充 1：后填充
	 * @return
	 */
	function fillStr(src, len, fillStr, flag){
		var sb;
		try{
			if (src.length > 0) {
				sb = new StringBuffer();
				var _len = src.length;
				switch (flag) {
					case 0:
						if (len > _len) {
							for (var i = 0; i < len-_len; i++) {
								sb.append(fillStr);
							}
						}
						sb.append(src);						
						break;	
					case 1:
						sb.append(src);
						if (len > _len) {
							for (var i = 0; i < len-_len; i++) {
								sb.append(fillStr);
							}
						}
					default:
						break;
				}
			} else {
				sb = new StringBuffer();
				switch (flag) {
					case 0:						
						for (var i = 0; i < len; i++) {
							sb.append(fillStr);
						}						
						sb.append(src);						
						break;	
					case 1:
						sb.append(src);						
						for (var i = 0; i < len; i++) {
							sb.append(fillStr);
						}						
					default:
						break;
				}
			}
		} catch(e) {
			alert(e);
		}
		return sb.toString(); 
	}
	
	//将字符串转换为十六制
	function str2Hex(str){
	    var val="";
		for (var i = 0; i < str.length; i++) {
			if (val == "") 
				val = str.charCodeAt(i).toString(16);
			else
	     		val += str.charCodeAt(i).toString(16);
		}
		return val;
  	}
	
	//读取卡片序列号（十六进制）
	function getCardIdHex(){
		var restr = rfCard.rf_rd_cardnum();//读取卡片序列号
		var strs = restr.split("|");
		if (strs[0] == 0) {
			return strs[1];
		} else {
			return "-1";
		}
	}
	
	//十六进制转十进制
	function hex2dec(str){
		var result;
		try {
			result = parseInt(str, 16); // converts hex to int, eg. "FF" => 255 
		} catch (err) {
			result = "";  
		}
		return result;
	}	
	
	//封装StringBuffer方法
	function StringBuffer(){
		var buffer = [] ;		// 存放字符串数组
		var size = 0 ;			// 存放数组大小
		// 追加字符串
		this.append = function(s){
			if (s != null ) {
				buffer.push(s);
				size++ ;
			} 
		}
		// 返回字符串
		this.toString = function(){
			return buffer.join("");
		}
		// 清空
		this.clear = function(key){
			size = 0 ;
			buffer = [] ;
		}
		// 返回数组大小
		this.size = function(){
			return size ;
		}
		// 返回数组
		this.toArray = function(){
			return buffer ;
		}
		// 倒序返回字符串
		this.doReverse = function(){
			var str = buffer.join('') ; 
			str = str.split('');  
			return str.reverse().join('');
		}
	}
	/* ------------------------------dll------------------------------ */
	
	//卡片加密
	function cardEncryptOther(cardNo, sno){
		var cardid = getCardIdHex();//十六进制卡ID
		var restr = rfCard.rf_modi_key_look_other(_userCode + cardid, _cardKey, sno);
		var strs = restr.split("|");
		if (strs[0] == 0) {
			return true;
		} else {
			return false;
		}
	}	

	//cpu卡分析
	function anlyCpuCard(cardidHex){
		restr = rfCard.Anly_CpuCard(_userCode, _cardKey, cardidHex);
		var strs = restr.split("|");
		return strs[0];
	}
	
	//cpu卡解锁
	function unLockCpuCard(cardidHex){
		restr = rfCard.Un_LockCpuCard(_userCode, _cardKey, cardidHex);
		var strs = restr.split("|");
		return strs[0];
	}
	
	//得到卡片类型 00 M1卡  01 CPU卡
	function getCardType(){
		var cardtype = "";
		restr = rfCard.rf_rd_serial();
		var strs = restr.split("|");
		if (strs[0] == 0) {
			cardtype = strs[1].substring(8);
		}	
		return cardtype;
	}		

</script>