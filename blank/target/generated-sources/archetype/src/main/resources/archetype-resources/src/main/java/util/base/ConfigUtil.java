#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.util.base;

import java.util.ResourceBundle;

import org.apache.commons.lang3.StringUtils;

public class ConfigUtil {

	private static final ResourceBundle bundle = ResourceBundle.getBundle("config");

	private static String sessionName;

	public static final String getSessionName() {
		if (StringUtils.isEmpty(sessionName))
			sessionName = get("sessionName");
		return sessionName;
	}

	public static final String get(String key) {
		return bundle.getString(key);
	}

	public static void main(String[] args) {
		System.out.println(get("jdbc_driverClassName"));
	}
}
