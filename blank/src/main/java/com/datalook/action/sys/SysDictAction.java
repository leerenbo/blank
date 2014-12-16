package com.datalook.action.sys;

import javax.annotation.Resource;

import org.apache.struts2.convention.annotation.Action;

import com.datalook.action.base.BaseAction;
import com.datalook.model.sys.SysDict;
import com.datalook.service.sys.SysDictService;
import com.datalook.service.base.BaseService;
@Action("sysDict")
public class SysDictAction extends BaseAction<SysDict> {
	
	@Resource(name = "sysDictService")
	public void setService(BaseService<SysDict> service) {
		this.service = service;
	}
	
	public void noSy_find(){
		find();
	}
}
