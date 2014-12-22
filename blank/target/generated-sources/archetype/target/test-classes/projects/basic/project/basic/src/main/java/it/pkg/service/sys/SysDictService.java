package it.pkg.service.sys;

import java.util.List;

import it.pkg.dao.base.HqlFilter;
import it.pkg.model.sys.SysDict;
import it.pkg.service.base.BaseService;

public interface SysDictService extends BaseService<SysDict>{

	public abstract SysDict getValue(String location, String code);

	public abstract List<SysDict> findValus(String location);

	public abstract List<SysDict> findValus(HqlFilter hqlFilter);

}