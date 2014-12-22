#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.typeConverter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;

import com.opensymphony.xwork2.conversion.impl.DefaultTypeConverter;

public class DateConverter extends DefaultTypeConverter {

	private static final String DATETIME_PATTERN = "yyyy-MM-dd HH:mm:ss";

	private static final String DATE_PATTERN = "yyyy-MM-dd";

	private static final String TIME_PATTERN = "HH:mm";

	private static final String TIMEWITHSECONDE_PATTERN = "HH:mm:ss";

	/**
	 * Convert value between types
	 */
	@SuppressWarnings("unchecked")
	public Object convertValue(Map ognlContext, Object value, Class toType) {
		Object result = null;
		if(value==null){
			return null;
		}
		if (value instanceof Object[]){
			Object[] values=((Object[])value);
			for (Object object : values) {
				if(StringUtils.isBlank((CharSequence) object)){
					return null;
				}
			}
		}
		if (toType == Date.class) {
			result = doConvertToDate(value);
		} else if (toType == String.class) {
			result = doConvertToString(value);
		}
		return result;
	}

	/**
	 * Convert String to Date
	 *
	 * @param value
	 * @return
	 */
	private Date doConvertToDate(Object value) {
		Date result = null;

		if (value instanceof String) {
			try {
				result = DateUtils.parseDate((String) value, new String[] { DATE_PATTERN, DATETIME_PATTERN, TIME_PATTERN, TIMEWITHSECONDE_PATTERN });
			} catch (ParseException e1) {
				e1.printStackTrace();
			}

			// all patterns failed, try a milliseconds constructor
			// if (result == null && StringUtils.isNotEmpty((String) value)) {
			//
			// try {
			// result = new Date(new Long((String) value).longValue());
			// } catch (Exception e) {
			// e.printStackTrace();
			// }
			//
			// }

		} else if (value instanceof Object[]) {
			// let's try to convert the first element only
			Object[] array = (Object[]) value;

			if ((array != null) && (array.length >= 1)) {
				value = array[0];
				result = doConvertToDate(value);
			}

		} else if (Date.class.isAssignableFrom(value.getClass())) {
			result = (Date) value;
		}
		return result;
	}

	/**
	 * Convert Date to String
	 *
	 * @param value
	 * @return
	 */
	private String doConvertToString(Object value) {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(DATETIME_PATTERN);
		String result = null;
		if (value instanceof Date) {
			result = simpleDateFormat.format(value);
		}
		return result;
	}
}
