package com.datalook.filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.dispatcher.ng.filter.StrutsPrepareAndExecuteFilter;

public class StrutsFilter  extends StrutsPrepareAndExecuteFilter{
	
	private List<String> list = new ArrayList<String>();

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		super.init(filterConfig);
		String exclude=filterConfig.getInitParameter("exclude");
		
		if (!StringUtils.isBlank(exclude)) {
			StringTokenizer st = new StringTokenizer(exclude, ",");
			list.clear();
			while (st.hasMoreTokens()) {
				list.add(st.nextToken());
			}
		}
		
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;

		String servletPath = request.getServletPath();
		for (String url : list) {
			if (servletPath.indexOf(url) > -1) {// 不需要过滤
				chain.doFilter(req, res);
				return ;
			}
		}
		super.doFilter(req, res, chain);
	}
	
}
