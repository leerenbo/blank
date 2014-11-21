package com.datalook.service.sys;

import com.datalook.model.sys.SysUser;
import com.datalook.service.base.BaseService;

/**
 * 用户业务
 * 
 * 
 */
public interface SysUserService extends BaseService<SysUser> {

	/**
	 * 修改用户角色
	 * @param id
	 *            用户ID
	 * @param roleIds
	 *            角色IDS
	 */
	public void grantSysRole(Integer id, String roleIds);

}
