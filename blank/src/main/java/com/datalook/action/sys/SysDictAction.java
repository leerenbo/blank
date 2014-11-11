package com.datalook.action.sys;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Action;

import com.datalook.action.base.BaseAction;
import com.datalook.dao.base.HqlFilter;
import com.datalook.model.sys.SysDict;
import com.datalook.service.base.IBaseService;
import com.datalook.service.sys.interfaces.ISysDictService;

@Action("sysDict")
public class SysDictAction extends BaseAction<SysDict>{
	
	@Resource(name="sysDictService")
	public void setService(IBaseService<SysDict> service) {
		this.service = service;
	}
	
	public void noSy_find(){
		HqlFilter hqlFilter = new HqlFilter(getRequest());
		if(!StringUtils.isBlank(hqlFilter.getSqltable())){
			writeJson(((ISysDictService)service).findValus(hqlFilter));
		}else{
			writeJson(((ISysDictService)service).findValus(hqlFilter));
		}
	}
	
}
