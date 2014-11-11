package com.datalook.service.sys.interfaces;

import com.datalook.model.sys.SysRole;
import com.datalook.service.base.IBaseService;

public interface ISysRoleService extends IBaseService<SysRole>{

	public abstract void grant(String sysRoleId, String grantSysFunctionIds[],
			String inSomeSysFunctionIds[]);

}