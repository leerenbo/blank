package it.pkg.action.sys;

import java.util.List;

import javax.annotation.Resource;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import it.pkg.action.base.BaseAction;
import it.pkg.model.sys.SysFunction;
import it.pkg.model.sys.easyui.Message;
import it.pkg.model.sys.web.SessionInfo;
import it.pkg.service.base.BaseService;

/**
 * 
 * 功能描述：系统功能 时间：2014年9月11日
 * 
 * @author ：lirenbo
 *
 */
@Action("sysFunction")
@Results({ @Result(name = "makeMenu", location = "/pages/west.jsp") })
public class SysFunctionAction extends BaseAction<SysFunction> {

	private static final long serialVersionUID = -1212028577583528732L;
	List<SysFunction> functions;

	@Resource(name = "sysFunctionService")
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
	 * 功能描述：获取个人功能 时间：2014年9月11日
	 * 
	 * @author ：lirenbo
	 * @return
	 */
	public String noSy_makeMenu() {
		SessionInfo sessionInfo = getSessionInfo();
		functions = sessionInfo.getAllFunction();
		return "makeMenu";
	}

	/**
	 * 功能描述：查询所有功能 时间：2014年9月11日
	 * 
	 * @author ：lirenbo
	 */
	public void noSy_getAllMenuWithRoot() {
		functions = service.find("from SysFunction where functiontype!='0'");
		writeJson(functions);
	}

	@Override
	protected Message beforeSave() {
		dataTypeAutoSet();
		return super.beforeSave();
	}

	@Override
	protected Message beforeUpdate() {
		dataTypeAutoSet();
		return super.beforeUpdate();
	}

	private void dataTypeAutoSet() {
		String type = service.getById(data.getSysFunction().getId()).getFunctiontype();
		if ("2".equals(type)) {
			data.setFunctiontype("3");
		} else if ("3".equals(type)) {
			data.setFunctiontype("0");
		} else if ("-1".equals(type)) {
			data.setFunctiontype("2");
		}
	}
}
