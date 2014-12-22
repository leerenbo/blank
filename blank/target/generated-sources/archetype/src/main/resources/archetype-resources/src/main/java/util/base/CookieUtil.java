#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.util.base;

import javax.servlet.http.Cookie;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;


public class CookieUtil{
	public static boolean haveKeyValue(String key,String value){
		Cookie[] cookies=ServletActionContext.getRequest().getCookies();
		for (Cookie cookie : cookies) {
			if(StringUtils.equals(cookie.getName(), key)&&StringUtils.equals(cookie.getValue(),value)){
				return true;
			}
		}; 
		return false;
	}
}