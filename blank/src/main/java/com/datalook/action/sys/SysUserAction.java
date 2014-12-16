package com.datalook.action.sys;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Action;
import org.hibernate.Hibernate;

import com.datalook.action.base.BaseAction;
import com.datalook.model.sys.SysRole;
import com.datalook.model.sys.SysUser;
import com.datalook.model.sys.easyui.Message;
import com.datalook.model.sys.web.SessionInfo;
import com.datalook.service.sys.SysUserService;
import com.datalook.util.base.ConfigUtil;
import com.datalook.util.base.MD5Util;

/**
 * 
 * 功能描述： 时间：2014年9月11日
 * 
 * @author ：lirenbo
 *
 */
@Action("sysUser")
public class SysUserAction extends BaseAction<SysUser> {

	private static final long serialVersionUID = 6254159754392240588L;

	@Resource(name = "sysUserService")
	public void setService(SysUserService service) {
		this.service = service;
	}

	/**
	 * @see com.datalook.action.sys.ISysUserAction#noSnSy_logout()
	 * 
	 *      功能描述： 时间：2014年9月29日
	 * @author: lirenbo
	 */
	public void noSnSy_logout() {
		if (getSession() != null) {
			getSession().invalidate();
		}
		Message j = new Message();
		j.setSuccess(true);
		writeJson(j);
	}

	/**
	 * @see com.datalook.action.sys.ISysUserAction#noSnSy_login()
	 * 
	 *      功能描述： 时间：2014年9月29日
	 * @author: lirenbo
	 */
	public void noSnSy_login() {
		data.setPassword(MD5Util.md5(data.getPassword()));
		SysUser sysUser = service.getByProperties(data);
		Message json = new Message();
		if (sysUser != null && "1".equals(sysUser.getStatus())) {
			json.setSuccess(true);
			SessionInfo sessionInfo = new SessionInfo();
			Hibernate.initialize(sysUser.getSysRoles());
			for (SysRole role : sysUser.getSysRoles()) {
				Hibernate.initialize(role.getSysFunctions());
			}
			sessionInfo.setSysUser(sysUser);
			getSession().setAttribute(ConfigUtil.getSessionName(), sessionInfo);
		} else {
			json.setMsg("用户名或密码错误！");
		}
		writeJson(json);
	}

	public void noSy_updateCurrentUserPassword() {
		SessionInfo sessionInfo = getSessionInfo();
		Message json = new Message();
		SysUser user = service.getById(sessionInfo.getSysUser().getId());
		user.setPassword(MD5Util.md5(data.getPassword()));
		service.saveOrUpdate(user);
		sessionInfo.getSysUser().setPassword(MD5Util.md5(data.getPassword()));
		getSession().setAttribute(ConfigUtil.getSessionName(), sessionInfo);
		json.setSuccess(true);
		json.setMsg("密码修改成功");
		writeJson(json);
	}

	public void noSy_checkCurrentUserPassword() {
		SessionInfo sessionInfo = getSessionInfo();
		SysUser user = sessionInfo.getSysUser();
		if (StringUtils.equals(MD5Util.md5(data.getPassword()), user.getPassword())) {
			writeJson(true);
		} else {
			writeJson(false);
		}
	}

	/**
	 * @see com.datalook.action.sys.ISysUserAction#grantSysRole()
	 * 
	 *      功能描述： 时间：2014年9月29日
	 * @author: lirenbo
	 * @throws IllegalAccessException 
	 */
	public void grantSysRole() throws IllegalAccessException {
		Message json = new Message();
		service.relate(data.getId(), ids, "sysRoles", SysRole.class);
		json.setSuccess(true);
		json.setMsg("授权成功");
		writeJson(json);
	}

	/**
	 * @see com.datalook.action.sys.ISysUserAction#noSy_getRolesByUserId()
	 * 
	 *      功能描述： 时间：2014年9月29日
	 * @author: lirenbo
	 * @throws IllegalAccessException
	 */
	public void noSy_getRolesByUserId() throws IllegalAccessException {
		writeJson(service.getById(data.getId()).getSysRoles());
	}

	@Override
	protected Message beforeSave() {
		Message json = new Message();
		SysUser s = new SysUser();
		s.setUsername(data.getUsername());
		List<SysUser> users = service.findByProperties(s);
		if (users.size() != 0) {
			json.setMsg("新建用户失败，用户已存在！");
		} else {
			data.setPassword(MD5Util.md5("123456"));
			json.setMsg("新建用户成功！默认密码：123456");
			json.setSuccess(true);
		}
		return json;
	}

	@Override
	protected Message beforeUpdate() {
		Message json = new Message();
		SysUser s = new SysUser();
		s.setUsername(data.getUsername());
		List<SysUser> users = service.findByProperties(s);
		if (users.size() != 0) {
			json.setMsg("修改用户失败，用户已存在！");
		} else {
			json.setSuccess(true);
			json.setMsg("修改用户成功！");
		}
		return json;
	}
}
