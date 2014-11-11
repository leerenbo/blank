package com.datalook.service.sys.interfaces;

import java.util.List;

import com.datalook.model.sys.SysUser;
import com.datalook.service.base.IBaseService;

/**
 * 用户业务
 * 
 * 
 */
public interface ISysUserService extends IBaseService<SysUser> {

	/**
	 * 修改用户角色
	 * @param id
	 *            用户ID
	 * @param roleIds
	 *            角色IDS
	 */
	public void grantSysRole(Integer id, String roleIds);

}
