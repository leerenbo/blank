var ez = ez || {};

/**
 * 去字符串空格
 * 
 * @author 孙宇
 */
ez.trim = function(str) {
	return str.replace(/(^\s*)|(\s*$)/g, '');
};
ez.ltrim = function(str) {
	return str.replace(/(^\s*)/g, '');
};
ez.rtrim = function(str) {
	return str.replace(/(\s*$)/g, '');
};

/**
 * 判断开始字符是否是XX
 * 
 * @author 孙宇
 */
ez.startWith = function(source, str) {
	var reg = new RegExp("^" + str);
	return reg.test(source);
};
/**
 * 判断结束字符是否是XX
 * 
 * @author 孙宇
 */
ez.endWith = function(source, str) {
	var reg = new RegExp(str + "$");
	return reg.test(source);
};

/**
 * iframe自适应高度
 * 
 * @author 孙宇
 * 
 * @param iframe
 */
ez.autoIframeHeight = function(iframe) {
	iframe.style.height = iframe.contentWindow.document.body.scrollHeight + "px";
};

/**
 * 设置iframe高度
 * 
 * @author 孙宇
 * 
 * @param iframe
 */
ez.setIframeHeight = function(iframe, height) {
	iframe.height = height;
};


/**
 * 模拟map对象
 * 李仁博
 */
function Map() {
	 var struct = function(key, value) {
	  this.key = key;
	  this.value = value;
	 }
	 
	 var put = function(key, value){
	  for (var i = 0; i < this.arr.length; i++) {
	   if ( this.arr[i].key === key ) {
	    this.arr[i].value = value;
	    return;
	   }
	  }
	   this.arr[this.arr.length] = new struct(key, value);
	 }
	 
	 var get = function(key) {
	  for (var i = 0; i < this.arr.length; i++) {
	   if ( this.arr[i].key === key ) {
	     return this.arr[i].value;
	   }
	  }
	  return null;
	 }
	 
	 var remove = function(key) {
	  var v;
	  for (var i = 0; i < this.arr.length; i++) {
	   v = this.arr.pop();
	   if ( v.key === key ) {
	    continue;
	   }
	   this.arr.unshift(v);
	  }
	 }
	 
	 var size = function() {
	  return this.arr.length;
	 }
	 
	 var isEmpty = function() {
	  return this.arr.length <= 0;
	 }
	 this.arr = new Array();
	 this.get = get;
	 this.put = put;
	 this.remove = remove;
	 this.size = size;
	 this.isEmpty = isEmpty;
	}
