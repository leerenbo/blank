package com.datalook.service.sys;

import com.datalook.model.sys.SysRole;
import com.datalook.service.base.BaseService;

public interface SysRoleService extends BaseService<SysRole> {

	public abstract void grant(String sysRoleId, String grantSysFunctionIds[], String inSomeSysFunctionIds[]);

}