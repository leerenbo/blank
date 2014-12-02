package com.datalook.service.sys.implement;

import org.springframework.stereotype.Service;

import com.datalook.model.sys.SysRole;
import com.datalook.service.base.BaseServiceImpl;
import com.datalook.service.sys.SysRoleService;
import com.datalook.util.base.StringUtil;

@Service("sysRoleService")
public class SysRoleServiceImpl extends BaseServiceImpl<SysRole> implements SysRoleService{

	@Override
	public synchronized void grant(String sysRoleId,String grantSysFunctionIds[],String inSomeSysFunctionIds[]){
		getBaseDao().executeSql(StringUtil.formateString("delete SYS_ROLE_FUNCTION_RELATION where ROLEID = {0} and SYSFUNCTIONID in {1} ",sysRoleId,StringUtil.toVarcharsSqlInString(inSomeSysFunctionIds)));
		for (String eachgrantSysFunctionId : grantSysFunctionIds) {
			getBaseDao().executeSql(StringUtil.formateString("insert into SYS_ROLE_FUNCTION_RELATION values({0},{1})", sysRoleId,eachgrantSysFunctionId));
		}
	}
}
