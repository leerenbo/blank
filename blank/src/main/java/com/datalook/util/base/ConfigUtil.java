package com.datalook.util.base;

import java.util.ResourceBundle;

public class ConfigUtil {

	private static final ResourceBundle bundle = ResourceBundle.getBundle("config");

	public static final String get(String key) {
		return bundle.getString(key);
	}

	public static void main(String[] args) {
		System.out.println(get("jdbc_driverClassName"));
	}
}
