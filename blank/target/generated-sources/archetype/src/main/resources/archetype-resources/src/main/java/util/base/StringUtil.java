#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.util.base;

import java.util.HashSet;
import java.util.Set;


/**
 * String工具类
 * 
 * 
 */
public class StringUtil {

	/**
	 * 格式化字符串
	 * 
	 * 例：formateString("xxx{0}b{1}bb",1,2) = xxx1b2bb
	 * 
	 * @param str
	 * @param params
	 * @return
	 */
	public static String formateString(String str, String... params) {
		for (int i = 0; i < params.length; i++) {
			str = str.replace("{" + i + "}", params[i] == null ? "" : params[i]);
		}
		return str;
	}
	
	/**
	 *	使用大括号()框住，用逗号,分割。
	 */
	public static String toNumbersSqlInString(Integer[] strs){
		StringBuffer re=new StringBuffer("(");
		for(Integer str:strs){
			re.append(str);
			re.append(",");
		}
		if(re.length()>1){
			re.replace(re.length()-1, re.length(), ")");
			return re.toString();
		}
		return "()";
	}
	/**
	 *	使用大括号()框住，用逗号,分割。
	 */
	public static String toNumbersSqlInString(String[] strs){
		StringBuffer re=new StringBuffer("(");
		for(String str:strs){
			re.append(str);
			re.append(",");
		}
		if(re.length()>1){
			re.replace(re.length()-1, re.length(), ")");
			return re.toString();
		}
		return "()";
	}
	/**
	 *	使用大括号()框住，用逗号,分割。
	 */
	public static String toVarcharsSqlInString(String[] strs){
		StringBuffer re=new StringBuffer("(");
		for(String str:strs){
			re.append("'");
			re.append(str);
			re.append("'");
			re.append(",");
		}
		if(re.length()>1){
			re.replace(re.length()-1, re.length(), ")");
			return re.toString();
		}
		return "()";
	}
	
	public static String[] getInStrs1DontInstrs2(String[] strs1,String[] strs2){
		Set<String> strs=new HashSet<String>();
		for (String string : strs1) {
			strs.add(string);
		}
		for (String string : strs2) {
			strs.remove(string);
		}
		return (String[])strs.toArray();
	}
	
	public static String addPrefix(String prefix,String field){
		String first = field.substring(0, 1).toUpperCase();
		String rest = field.substring(1);
		return new StringBuffer(prefix).append(first).append(rest).toString();
	}

//	public static String addDateLine(String date){
//		return date.substring(0, 4)+"-"+date.substring(4, 6)+"-"+date.substring(6,8);
//	}
	
}
