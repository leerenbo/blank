package com.datalook.action.sys;


import java.io.File;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.convention.annotation.Action;
import org.hibernate.Hibernate;

import com.datalook.action.base.BaseAction;
import com.datalook.model.sys.SysRole;
import com.datalook.model.sys.SysUser;
import com.datalook.model.sys.easyui.Json;
import com.datalook.model.sys.web.SessionInfo;
import com.datalook.service.sys.SysUserService;
import com.datalook.util.base.CookieUtil;
import com.datalook.util.base.MD5Util;

/**
 * 
 * 功能描述：
 * 时间：2014年9月11日
 * @author ：lirenbo
 *
 */
@Action("sysUser")
public class SysUserAction extends BaseAction<SysUser> {
	
	private static final long serialVersionUID = 1L;
	
	private File image;
	private String imageFileName;
	private String imageContentType;
	
	public File getImage() {
		return image;
	}


	public void setImage(File image) {
		this.image = image;
	}


	public String getImageFileName() {
		return imageFileName;
	}


	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}


	public String getImageContentType() {
		return imageContentType;
	}


	public void setImageContentType(String imageContentType) {
		this.imageContentType = imageContentType;
	}


	@Resource(name="sysUserService")
	public void setService(SysUserService service) {
		this.service = service;
	}


	/**
	 * @see com.datalook.action.sys.ISysUserAction#noSnSy_logout()
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 */
	public void noSnSy_logout() {
		if (getSession() != null) {
			getSession().invalidate();
		}
		Json j = new Json();
		j.setSuccess(true);
		writeJson(j);
	}

	/**
	 * @see com.datalook.action.sys.ISysUserAction#noSnSy_login()
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 */
	public void noSnSy_login() {
		data.setPassword(MD5Util.md5(data.getPassword()));
		SysUser sysUser = service.getByProperties(data);
		Json json = new Json();
		if (sysUser != null&&"1".equals(sysUser.getStatus())) {
			json.setSuccess(true);
			SessionInfo sessionInfo = new SessionInfo();
			Hibernate.initialize(sysUser.getSysRoles());
			for (SysRole role : sysUser.getSysRoles()) {
				Hibernate.initialize(role.getSysFunctions());
			}
			sessionInfo.setSysUser(sysUser);
			getSession().setAttribute("sessionInfo", sessionInfo);
		} else {
			json.setMsg("用户名或密码错误！");
		}
		if(CookieUtil.haveKeyValue("easyuiStyle", "check")||CookieUtil.haveKeyValue("easyuiStyle", "icon")){
			
		}else{
			getResponse().addCookie(new Cookie("easyuiStyle", "check"));
		}
		
		writeJson(json);
	}
	
	/**
	 * @see com.datalook.action.sys.ISysUserAction#noSy_updateCurrentUserPassword()
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 */
	public void noSy_updateCurrentUserPassword() {
		SessionInfo sessionInfo = (SessionInfo) getSession().getAttribute("sessionInfo");
		Json json = new Json();
		SysUser user = service.getById(sessionInfo.getSysUser().getId());
		user.setPassword(MD5Util.md5(data.getPassword()));
		sessionInfo.getSysUser().setPassword(MD5Util.md5(data.getPassword()));
//		getSession().removeAttribute("sessionInfo");
		getSession().setAttribute("sessionInfo", sessionInfo);
		service.saveOrUpdate(user);
		json.setSuccess(true);
		writeJson(json);
	}
	
	public void noSy_checkCurrentUserPassword() {
		SessionInfo sessionInfo = (SessionInfo) getSession().getAttribute("sessionInfo");
		SysUser user = sessionInfo.getSysUser();
		if(StringUtils.equals(MD5Util.md5(data.getPassword()),user.getPassword())){
			writeJson(true);
		}else{
			writeJson(false);
		}
	}

	/**
	 * @see com.datalook.action.sys.ISysUserAction#grantSysRole()
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 */
	public void grantSysRole() {
		Json json = new Json();
		((SysUserService) service).grantSysRole(id, ids);
		json.setSuccess(true);
		writeJson(json);
	}
	
	/**
	 * @see com.datalook.action.sys.ISysUserAction#noSy_getRolesByUserId()
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 */
	public void noSy_getRolesByUserId() {
		SysUser sysUser=service.getById(id);
		writeJson(sysUser.getSysRoles());
	}

	/**
	 * 
	 * @see com.datalook.action.base.BaseAction#save()
	 * 
	 * 功能描述：新建用户
	 * 时间：2014年9月11日
	 * @author: lirenbo
	 */
	synchronized public void save() {
		System.out.println(imageFileName);
		Json json = new Json();
		if (data != null) {
			List<SysUser> users =  service.findByProperties(data);
			if (users.size() !=0 ) {
				json.setMsg("新建用户失败，用户名已存在！");
			} else {
				data.setPassword(MD5Util.md5("123456"));
				service.save(data);
				json.setMsg("新建用户成功！默认密码：123456");
				json.setSuccess(true);
			}
		}
		writeJson(json);
	}
}
