#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.interceptor.base;

import org.apache.struts2.ServletActionContext;

import ${package}.model.sys.web.SessionInfo;
import ${package}.util.base.ConfigUtil;
import ${package}.util.base.LogUtil;
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
