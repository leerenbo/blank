package it.pkg.action.sys;

import javax.annotation.Resource;

import org.apache.struts2.convention.annotation.Action;

import it.pkg.action.base.BaseAction;
import it.pkg.model.sys.SysDict;
import it.pkg.service.sys.SysDictService;
import it.pkg.service.base.BaseService;
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
