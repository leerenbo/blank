package com.datalook.action.sys;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.datalook.action.base.BaseAction;
import com.datalook.exception.base.ToWebException;
import com.datalook.model.sys.SysFunction;
import com.datalook.model.sys.web.SessionInfo;
import com.datalook.service.base.BaseService;
import com.datalook.service.sys.SysFunctionService;

/**
 * 
 * 功能描述：系统功能
 * 时间：2014年9月11日
 * @author ：lirenbo
 *
 */
@Action("sysFunction")
@Results({
	@Result(name="makeMenu",location="/pages/west.jsp")	
})
public class SysFunctionAction extends BaseAction<SysFunction>{
	private static final long serialVersionUID = 1L;

	private static final Logger logger = Logger.getLogger(SysFunctionAction.class);

	List<SysFunction> functions=new ArrayList<SysFunction>();
	
	@Resource(name="sysFunctionService")
	public void setService(BaseService<SysFunction> service) {
		this.service = service;
	}

	public List<SysFunction> getFunctions() {
		return functions;
	}
	public void setFunctions(List<SysFunction> functions) {
		this.functions = functions;
	}

	/**
	 * 功能描述：获取个人功能
	 * 时间：2014年9月11日
	 * @author ：lirenbo
	 * @return
	 */
	public String noSy_makeMenu(){
		SessionInfo sessionInfo = (SessionInfo) getSession().getAttribute("sessionInfo");
		functions=sessionInfo.getAllFunction();
		logger.info(functions);
		return "makeMenu";
	}
	
	/**
	 * 功能描述：查询所有功能
	 * 时间：2014年9月11日
	 * @author ：lirenbo
	 */
	public void noSy_getAllMenuWithRoot(){
		functions=service.find("from SysFunction where functiontype!='0'");
		writeJson(functions);
	}
	
	public void noSySn_test() throws ToWebException{
		((SysFunctionService)service).test("params");
	}
}
