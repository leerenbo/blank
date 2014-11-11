package com.datalook.interceptor.base;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.datalook.model.sys.SysFunction;
import com.datalook.model.sys.web.SessionInfo;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;

/**
 * 
 * 功能描述：权限拦截器
 * 时间：2014年8月14日
 * @author ：lirenbo
 */
public class SecurityInterceptor extends MethodFilterInterceptor {

	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger.getLogger(SecurityInterceptor.class);

	protected String doIntercept(ActionInvocation actionInvocation) throws Exception {
		SessionInfo sessionInfo = (SessionInfo) ServletActionContext.getRequest().getSession().getAttribute("sessionInfo");
		String servletPath = ServletActionContext.getRequest().getServletPath();
		logger.info("进入权限拦截器->访问的资源为：[" + servletPath + "]");

		servletPath = StringUtils.substringBeforeLast(servletPath, ".");// 去掉后面的后缀*.action之类的

		List<SysFunction> functions = sessionInfo.getAllFunction();// 去重(这里包含了当前用户可访问的所有资源)
		for (SysFunction function : functions) {
			if (function != null && StringUtils.equals(function.getUrl(), servletPath)) {
				return actionInvocation.invoke();
			}
		}

		String errMsg = "您没有访问此功能的权限！功能路径为[" + servletPath + "]请联系管理员给你赋予相应权限。";
		logger.info(errMsg);
		ServletActionContext.getRequest().setAttribute("msg", errMsg);
		return "noSecurity";
	}
}