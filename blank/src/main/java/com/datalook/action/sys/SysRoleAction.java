package com.datalook.action.sys;

import java.lang.reflect.InvocationTargetException;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.reflect.FieldUtils;
import org.apache.commons.lang3.reflect.MethodUtils;
import org.apache.struts2.convention.annotation.Action;

import com.datalook.action.base.BaseAction;
import com.datalook.model.sys.SysFunction;
import com.datalook.model.sys.SysRole;
import com.datalook.model.sys.easyui.Json;
import com.datalook.service.base.BaseService;
import com.datalook.service.sys.SysRoleService;

@Action("sysRole")
public class SysRoleAction extends BaseAction<SysRole>{
	
	private static final long serialVersionUID = 1L;
	@Resource(name="sysFunctionService")
	BaseService<SysFunction> sysFunctionService;
	
	@Resource(name="sysRoleService")
	public void setService(BaseService<SysRole> service) {
		this.service = service;
	}
	
	/**
	 * 功能描述：角色授权
	 * 时间：2014年9月11日
	 * @author ：lirenbo
	 */
	public void grant(){
		Json re=new Json();
		List<SysFunction> nowUserFunctions=getSessionInfo().getAllFunction();
		String[] inSomeSysFunctionIds=new String[nowUserFunctions.size()];
		for(int i=0;i<nowUserFunctions.size();i++){
			inSomeSysFunctionIds[i]=nowUserFunctions.get(i).getId().toString();
		}

		String grantids[]=ids.split(",");
		out:for(String eachGrantid:grantids){
			in:for(SysFunction eachNowUserFunction:nowUserFunctions){
				if(StringUtils.equals(eachNowUserFunction.getId().toString(), eachGrantid)){
					continue out;
				}
			}
			re.setSuccess(false);
			re.setMsg(re.getMsg()+"没有权利授权"+sysFunctionService.getById(eachGrantid).getFunctionname());
			writeJson(re);
			return;
		}
		re.setSuccess(true);
		try {
			((SysRoleService)service).grant(id.toString(), grantids, inSomeSysFunctionIds);

		} catch (Exception e) {
			e.printStackTrace();
		}
		writeJson(re);
	}
	
	/**
	 * 功能描述：获取该用户的所有功能权限
	 * 时间：2014年9月11日
	 * @author ：lirenbo
	 */
	public void noSy_getRoleFunctions(){
		SysRole sysRole=service.getById(id);
		writeJson(sysRole.getSysFunctions());
	}
	
	/**
	 * 功能描述：获取当前用户的所有权限
	 * 时间：2014年9月11日
	 * @author ：lirenbo
	 */
	public void noSy_getgrantedFunctions(){
		writeJson(getSessionInfo().getAllFunction());
	}
	
	
	public void noSy_find(){
		find();
	}

}
