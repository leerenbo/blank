#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.action.sys;

import javax.annotation.Resource;

import org.apache.struts2.convention.annotation.Action;

import ${package}.action.base.BaseAction;
import ${package}.model.sys.SysDict;
import ${package}.service.sys.SysDictService;
import ${package}.service.base.BaseService;
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
