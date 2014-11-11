package com.datalook.service.sys;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.datalook.dao.base.IBaseDao;
import com.datalook.model.sys.SysRole;
import com.datalook.model.sys.SysUser;
import com.datalook.service.base.BaseService;
import com.datalook.service.sys.interfaces.ISysUserService;

/**
 * 用户业务逻辑
 * 
 * 
 */
@Service
public class SysUserService extends BaseService<SysUser> implements ISysUserService {

	@Autowired
	private IBaseDao<SysRole> roleDao;

	/* (non-Javadoc)
	 * @see com.datalook.service.sys.ISysUserService#grantSysRole(java.lang.String, java.lang.String)
	 */
	@Override
	public void grantSysRole(Integer id, String roleIds) {
		SysUser user = getById(id);
		if (user != null) {
			user.setSysRoles(new HashSet<SysRole>());
			for (String roleId : roleIds.split(",")) {
				if (!StringUtils.isBlank(roleId)) {
					SysRole role = roleDao.getById(SysRole.class, Integer.valueOf(roleId));
					if (role != null) {
						user.getSysRoles().add(role);
					}
				}
			}
		}
	}
}
