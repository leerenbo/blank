package com.datalook.interceptor.base;

import org.apache.struts2.ServletActionContext;

import com.datalook.model.sys.web.SessionInfo;
import com.datalook.util.base.ConfigUtil;
import com.datalook.util.base.LogUtil;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;

/**
 * 
 * 功能描述：session拦截器
 * 时间：2014年9月12日
 * @author ：lirenbo
 *
 */
public class SessionInterceptor extends MethodFilterInterceptor {

	private static final long serialVersionUID = 1L;

	protected String doIntercept(ActionInvocation actionInvocation) throws Exception {
		SessionInfo sessionInfo = (SessionInfo) ServletActionContext.getRequest().getSession().getAttribute(ConfigUtil.getSessionName());
		LogUtil.trace("[Interceptor] Session -> [" + ServletActionContext.getRequest().getServletPath() + "]");
		if (sessionInfo == null) {
			String errMsg = "您还没有登录或登录已超时，请重新登录，然后再刷新本功能！";
			LogUtil.trace(errMsg);
			ServletActionContext.getRequest().setAttribute("msg", errMsg);
			return "noSession";
		}
		return actionInvocation.invoke();
	}

}
