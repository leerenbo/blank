package com.datalook.action.sys;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.convention.annotation.Action;

import com.datalook.action.base.BaseAction;
import com.datalook.dao.base.HqlFilter;
import com.datalook.model.sys.SysDict;
import com.datalook.service.base.BaseService;
import com.datalook.service.sys.SysDictService;

@Action("sysDict")
public class SysDictAction extends BaseAction<SysDict>{
	
	@Resource(name="sysDictService")
	public void setService(BaseService<SysDict> service) {
		this.service = service;
	}
	
	public void noSy_find(){
		HqlFilter hqlFilter = new HqlFilter(getRequest());
		((SysDictService)service).findValus("com.datalook.model.sys.functiontype");
		if(!StringUtils.isBlank(hqlFilter.getSqltable())){
			writeJson(((SysDictService)service).findValus(hqlFilter));
		}else{
			writeJson(((SysDictService)service).findValus(hqlFilter));
		}
	}
	
}
