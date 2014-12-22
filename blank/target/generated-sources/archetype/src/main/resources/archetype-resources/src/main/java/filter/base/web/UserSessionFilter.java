#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.filter.base.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import ${package}.util.base.ConfigUtil;
import ${package}.util.base.LogUtil;

/**
 * 
 * 功能描述：用于过滤需要拦截的JSP文件 时间：2014年9月12日
 * 
 * @author ：lirenbo
 *
 */
public class UserSessionFilter implements Filter {

	private List<String> list = new ArrayList<String>();

	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) res;
		String servletPath = request.getServletPath();
		for (String url : list) {
			if (servletPath.indexOf(url) > -1) {// 需要过滤
				LogUtil.trace("[Filter] UserSession -> [" + servletPath + "]");
				if (request.getSession().getAttribute(ConfigUtil.getSessionName()) == null) {// session不存在需要拦截
					request.setAttribute("msg", "您还没有登录或登录已超时，请重新登录，然后再刷新本功能！");
					request.getRequestDispatcher("/error/noSession.jsp").forward(request, response);
					return;
				}
				break;
			}
		}
		chain.doFilter(request, response);

	}

	public void init(FilterConfig filterConfig) throws ServletException {
		// 初始化需要拦截的文件夹
		String include = filterConfig.getInitParameter("include");
		if (!StringUtils.isBlank(include)) {
			StringTokenizer st = new StringTokenizer(include, ",");
			list.clear();
			while (st.hasMoreTokens()) {
				list.add(st.nextToken());
			}
		}
	}

	public void destroy() {
	}
}
