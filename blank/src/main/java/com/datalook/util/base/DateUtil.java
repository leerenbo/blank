package com.datalook.util.base;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 日期工具类
 * 
 * 
 */
public class DateUtil {

	private static Map<String, SimpleDateFormat> sdfMap = new HashMap<String, SimpleDateFormat>();

	public static Date stringToDate(String str, String pattern) {
		if (str != null) {
			SimpleDateFormat sdf;
			if (sdfMap.containsKey(pattern)) {
				sdf = sdfMap.get(pattern);
			} else {
				sdf = new SimpleDateFormat(pattern);
				sdfMap.put(pattern, sdf);
			}
			try {
				return sdf.parse(str);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	/**
	 * 日期转字符串
	 * 
	 * @param date
	 *            日期
	 * @param pattern
	 *            格式
	 * @return
	 */
	public static String dateToString(Date date, String pattern) {
		if (date != null) {
			SimpleDateFormat sdf;
			if (sdfMap.containsKey(pattern)) {
				sdf = sdfMap.get(pattern);
			} else {
				sdf = new SimpleDateFormat(pattern);
				sdfMap.put(pattern, sdf);
			}
			return sdf.format(date);
		}
		return "";
	}

	/**
	 * 日期转字符串
	 * 
	 * @param date
	 * @return
	 */
	public static String dateToString(Date date) {
		return dateToString(date, "yyyy-MM-dd hh:mm:ss");
	}

}
