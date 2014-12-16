package com.datalook.action.sys;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Action;

import com.datalook.action.base.BaseAction;
import com.datalook.model.sys.SysFunction;
import com.datalook.model.sys.SysRole;
import com.datalook.model.sys.easyui.Message;
import com.datalook.service.base.BaseService;
import com.datalook.service.sys.SysRoleService;

@Action("sysRole")
public class SysRoleAction extends BaseAction<SysRole> {

	private static final long serialVersionUID = -8187753885200063063L;
	@Resource(name = "sysFunctionService")
	BaseService<SysFunction> sysFunctionService;

	@Resource(name = "sysRoleService")
	public void setService(BaseService<SysRole> service) {
		this.service = service;
	}

	/**
	 * 功能描述：角色授权 时间：2014年9月11日
	 * 
	 * @author ：lirenbo
	 * @throws IllegalAccessException 
	 */
	@SuppressWarnings("unused")
	public void grantSysFunction() throws IllegalAccessException {
		Message re = new Message();
		List<SysFunction> nowUserFunctions = getSessionInfo().getAllFunction();
		String[] inSomeSysFunctionIds = new String[nowUserFunctions.size()];
		for (int i = 0; i < nowUserFunctions.size(); i++) {
			inSomeSysFunctionIds[i] = nowUserFunctions.get(i).getId().toString();
		}

		String grantids[] = ids.split(",");
		out: for (String eachGrantid : grantids) {
			in: for (SysFunction eachNowUserFunction : nowUserFunctions) {
				if (StringUtils.equals(eachNowUserFunction.getId().toString(), eachGrantid)) {
					continue out;
				}
			}
			re.setSuccess(false);
			re.setMsg(re.getMsg() + "没有权利授权" + sysFunctionService.getById(eachGrantid).getFunctionname());
			writeJson(re);
			return;
		}
		re.setSuccess(true);
		service.relate(data.getId(), ids, "sysFunctions", SysFunction.class);
		writeJson(re);
	}

	/**
	 * 功能描述：获取该用户的所有功能权限 时间：2014年9月11日
	 * 
	 * @author ：lirenbo
	 */
	public void noSy_getRoleFunctions() {
		writeJson(service.getById(data.getId()).getSysFunctions());
	}

	/**
	 * 功能描述：获取当前用户的所有权限 时间：2014年9月11日
	 * 
	 * @author ：lirenbo
	 */
	public void noSy_getgrantedFunctions() {
		writeJson(getSessionInfo().getAllFunction());
	}

	public void noSy_find() {
		find();
	}

}
