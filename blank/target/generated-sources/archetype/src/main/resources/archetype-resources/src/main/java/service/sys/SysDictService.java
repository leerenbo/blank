#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.service.sys;

import java.util.List;

import ${package}.dao.base.HqlFilter;
import ${package}.model.sys.SysDict;
import ${package}.service.base.BaseService;

public interface SysDictService extends BaseService<SysDict>{

	public abstract SysDict getValue(String location, String code);

	public abstract List<SysDict> findValus(String location);

	public abstract List<SysDict> findValus(HqlFilter hqlFilter);

}