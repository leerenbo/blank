package it.pkg.util.base;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;

import it.pkg.model.sys.SysFunction;
import it.pkg.model.sys.web.SessionInfo;

public class SecurityUtil {
	public static boolean havePermission(String url) {
		SessionInfo sessionInfo = (SessionInfo) ServletActionContext.getRequest().getSession().getAttribute(ConfigUtil.getSessionName());
		List<SysFunction> functions = sessionInfo.getAllFunction();// 去重(这里包含了当前用户可访问的所有资源)
		for (SysFunction function : functions) {
			if (StringUtils.equals(function.getUrl(), url)) {// 如果有相同的，则代表当前用户可以访问这个资源
				return true;
			}
		}
		return false;
	}
}
