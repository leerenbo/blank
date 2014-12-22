#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.dao.base;

import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;

/**
 * HQL过滤器，用于添加where条件和排序，过滤结果集
 * 
 * 
 * key：
 * 支持前缀：
 * 		hqland_
 * 		hqltable_
 * 		hqlother_
 * 		sqltable_
 * 其中hqland_的格式为：
 * 
 * 		hqland_属性.*.*_操作_类型		例：hqland_id_dengyu_Integer
 * 
 *		 第一个属性，为Action<T> 泛型T内的属性
 * 
 * 支持操作：
 * dengyu 等于 // budeng 不等 // xiaoyu 小于 // dayu 大于 // xiaoyudengyu 小于等于 // dayudengyu 大于等于 // mohu 模糊 // youmohu 右模糊 // zuomohu 左模糊// in 在范围内，用|分割多个value值
 *	
 * 支持类型：
 * String Long Integer Short BigDecimal Float Date（"yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd HH:mm", "yyyy-MM-dd", "yyyy/MM/dd"）4种形式
 * 
 * 
 * 支持中缀：
 * 		_or_   连接条件与参数		例：request.name=hqland_t.id_dengyu_Integer_or_t.name_mohu_String
 * 		
 * 
 * 
 * value：
 * 支持中缀：
 * 		_or_	:用于连接参数带_or_的多个值
 * 		|		:用力连接参数方法为in的多个值
 */
public class HqlFilter {

	private HttpServletRequest request;// 为了获取request里面传过来的动态参数
	private Map<String, Object> params = new HashMap<String, Object>();// 条件参数
	private String sort;// 排序字段
	private String order = "asc";// asc/desc
	private StringBuffer whereStr = new StringBuffer("where 1=1");
	private String otherStr;
	private String orderAndSortStr;
	private String hqltable;
	private String sqltable;
	private StringBuilder hashStr=new StringBuilder();
	public HqlFilter() {

	}

	public String getHqltable() {
		return hqltable;
	}

	public String getSqltable() {
		return sqltable;
	}

	public HqlFilter(HttpServletRequest request) {
		this.request = request;
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		addCondition(request);
		makesortorder();
	}
	
	public void addSort(String sort) {
		this.sort = sort;
	}

	public void addOrder(String order) {
		this.order = order;
	}

	public String getHql() {
		String re="";
		if(!StringUtils.isBlank(hqltable)){
			re=re+hqltable+" ";
		}
		re=re+whereStr.toString();
		if(!StringUtils.isBlank(otherStr)){
			re=re+otherStr+" ";
		}
		return re;
	}
	public String getSql() {
		String re="";
		if(!StringUtils.isBlank(sqltable)){
			re=re+sqltable+" ";
		}
		re=re+whereStr.toString();
		if(!StringUtils.isBlank(otherStr)){
			re=re+otherStr+" ";
		}
		return re;
	}
	
	public String getHqlwithOrder() {
		makesortorder();
		String re="";
		if(!StringUtils.isBlank(hqltable)){
			re=re+hqltable+" ";
		}
		re=re+whereStr.toString();
		if(!StringUtils.isBlank(otherStr)){
			re=re+otherStr+" ";
		}
		if(!StringUtils.isBlank(orderAndSortStr)){
			re=re+orderAndSortStr;
		}
		return re;
	}
	
	public String getSqlwithOrder() {
		makesortorder();
		String re="";
		if(!StringUtils.isBlank(sqltable)){
			re=re+sqltable+" ";
		}
		re=re+whereStr.toString();
		if(!StringUtils.isBlank(otherStr)){
			re=re+otherStr+" ";
		}
		if(!StringUtils.isBlank(orderAndSortStr)){
			re=re+orderAndSortStr;
		}
		return re;
	}

	private void makesortorder() {
		if (!StringUtils.isBlank(sort) && !StringUtils.isBlank(order)) {
//			if (sort.indexOf(".") < 1) {
//				sort = sort;
//			}
			orderAndSortStr=" order by " + sort + " " + order + " ";// 添加排序信息
		} else {
			if (request != null) {
				String s = request.getParameter("sort");
				String o = request.getParameter("order");
				if (!StringUtils.isBlank(s)) {
					sort = s;
				}
				if (!StringUtils.isBlank(o)) {
					order = o;
				}
				if (!StringUtils.isBlank(sort) && !StringUtils.isBlank(order)) {
//					if (sort.indexOf(".") < 1) {
//						sort = sort;
//					}
					orderAndSortStr=" order by " + sort + " " + order + " ";// 添加排序信息
				}
			}
		}
	}

	public Map<String, Object> getParams() {
		return params;
	}

	/**
	 * 功能描述：根据request过滤条件，详细见类注释
	 * 时间：2014年9月12日
	 * @author ：lirenbo
	 * @param condition
	 * @param value
	 */
	public void addCondition(HttpServletRequest request) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Enumeration<String> names = request.getParameterNames();
		while (names.hasMoreElements()) {
			String name = names.nextElement();
			String value = request.getParameter(name);
			if(name.equals("hqltable_")||name.equals("sqltable_")){
				if(StringUtils.containsIgnoreCase(value, "insert")||StringUtils.containsIgnoreCase(value, "update")||StringUtils.containsIgnoreCase(value, "delete")){
					continue;
				}
			}
			addCondition(name, value);
		}
	}

	/**
	 * 功能描述：添加过滤条件，详细见类注释
	 * 时间：2014年9月12日
	 * @author ：lirenbo
	 * @param condition
	 * @param value
	 */
	public void addCondition(String condition, String value) {
		hashStr.append(condition).append(":").append(value).append(",");
		if (condition != null && value != null&&value!="") {
			if (condition.startsWith("hqland_")) {// 如果有需要过滤的字段
				condition=condition.substring(7);
				
				if(condition.contains("_or_")){
					String[] conditons=condition.split("_or_");
					String[] values=value.split("_or_");
					boolean flag=true;
					for (int i=0;i<values.length;i++) {
						String eachconditon=conditons[i];
						if(values[i]==null){
							continue;
						}
						String[] filterParams = StringUtils.split(eachconditon, "_");
						if (filterParams.length >= 3) {
							String columnName = filterParams[0];//.replaceAll("`", "."); 要过滤的字段名称
							String operator = filterParams[1];// SQL操作符
							String columnType = filterParams[2];// 字段类型
							String placeholder = UUID.randomUUID().toString().replace("-", "");// 生成一个随机的参数名称
							if(flag){
								whereStr.append(" and ("+columnName + " " + getSqlOperator(operator) + " :param" + placeholder + " ");// 拼HQL
								flag=false;
							}else{
								whereStr.append(" or " + columnName + " " + getSqlOperator(operator) + " :param" + placeholder + " ");// 拼HQL
							}
							params.put("param" + placeholder, castParam(columnType, operator, values[i]));// 添加参数
						}
					}
					if(!flag){
						whereStr.append(" ) ");
					}
					return;
				}else{
					String[] filterParams = StringUtils.split(condition, "_");
					if (filterParams.length >= 3) {
						String columnName = filterParams[0];//.replaceAll("`", ".");// 要过滤的字段名称
						String operator = filterParams[1];// SQL操作符
						String columnType = filterParams[2];// 字段类型
						String placeholder = UUID.randomUUID().toString().replace("-", "");// 生成一个随机的参数名称

						whereStr.append(" and " + columnName + " " + getSqlOperator(operator) + " :param" + placeholder + " ");// 拼HQL
						params.put("param" + placeholder, castParam(columnType, operator, value));// 添加参数
						return;
					}
				}
			}
			if (condition.startsWith("hqltable_")) {// 如果有需要过滤的字段 value='select * from User'
				hqltable=value;
				return;
			}
			if (condition.startsWith("sqltable_")) {// 如果有需要过滤的字段 value='select * from User'
				sqltable=value;
				return;
			}
			if (condition.startsWith("hqlother_")) {// 如果有需要过滤的字段在where之后，orderby之前。
				otherStr=value;
				return;
			}
		}
	}
	
	private String getSqlOperator(String operator) {
		if (StringUtils.equalsIgnoreCase(operator, "dengyu")) {
			return " = ";
		}
		if (StringUtils.equalsIgnoreCase(operator, "in")) {
			return " in ";
		}
		if (StringUtils.equalsIgnoreCase(operator, "budeng")) {
			return " != ";
		}
		if (StringUtils.equalsIgnoreCase(operator, "xiaoyu")) {
			return " < ";
		}
		if (StringUtils.equalsIgnoreCase(operator, "dayu")) {
			return " > ";
		}
		if (StringUtils.equalsIgnoreCase(operator, "xiaoyudengyu")) {
			return " <= ";
		}
		if (StringUtils.equalsIgnoreCase(operator, "dayudengyu")) {
			return " >= ";
		}
		if (StringUtils.equalsIgnoreCase(operator, "mohu") || StringUtils.equalsIgnoreCase(operator, "youmohu") || StringUtils.equalsIgnoreCase(operator, "zuomohu")) {
			return " like ";
		}
		return "";
	}

	private Object castParam(String columnType, String operator, String value) {
		if (StringUtils.equalsIgnoreCase(columnType, "String")) {
			if (StringUtils.equalsIgnoreCase(operator, "mohu")) {
				value = "%" + value + "%";
			} else if (StringUtils.equalsIgnoreCase(operator, "youmohu")) {
				value = value + "%";
			} else if (StringUtils.equalsIgnoreCase(operator, "zuomohu")) {
				value = "%" + value;
			}
			if(StringUtils.equalsIgnoreCase(operator, "in")){
				 String[] strs = value.split("${symbol_escape}${symbol_escape}|");
				 return Arrays.asList(strs);
			}
			return value;
		}
		if (StringUtils.equalsIgnoreCase(columnType, "Long")) {
			return Long.parseLong(value);
		}
		if (StringUtils.equalsIgnoreCase(columnType, "Integer")) {
			if(StringUtils.equalsIgnoreCase(operator, "in")){
				 String[] strs = value.split("${symbol_escape}${symbol_escape}|");
				 ArrayList<Integer> al=new ArrayList<Integer>();
				 for (String string : strs) {
					al.add(Integer.valueOf(string));
				}
				 return al;
			}
			return Integer.parseInt(value);
		}
		if (StringUtils.equalsIgnoreCase(columnType, "Date")) {
			try {
				return DateUtils.parseDate(value, new String[] { "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd HH:mm", "yyyy-MM-dd", "yyyy/MM/dd","HH:mm" });
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		if (StringUtils.equalsIgnoreCase(columnType, "Short")) {
			return Short.parseShort(value);
		}
		if (StringUtils.equalsIgnoreCase(columnType, "BigDecimal")) {
			return BigDecimal.valueOf(Long.parseLong(value));
		}
		if (StringUtils.equalsIgnoreCase(columnType, "Float")) {
			return Float.parseFloat(value);
		}
		if (StringUtils.equalsIgnoreCase(columnType, "Double")) {
			return Double.parseDouble(value);
		}
		if (StringUtils.equalsIgnoreCase(columnType, "Boolean")) {
			return Boolean.parseBoolean(value);
		}
		return null;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((hashStr == null) ? 0 : hashStr.toString().hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		HqlFilter other = (HqlFilter) obj;
		if (hashStr.toString() == null) {
			if (other.hashStr.toString() != null)
				return false;
		} else if (!hashStr.toString().equals(other.hashStr.toString()))
			return false;
		return true;
	}
}
