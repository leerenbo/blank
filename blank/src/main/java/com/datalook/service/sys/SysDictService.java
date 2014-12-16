package com.datalook.service.sys;

import java.util.List;

import com.datalook.dao.base.HqlFilter;
import com.datalook.model.sys.SysDict;
import com.datalook.service.base.BaseService;

public interface SysDictService extends BaseService<SysDict>{

	public abstract SysDict getValue(String location, String code);

	public abstract List<SysDict> findValus(String location);

	public abstract List<SysDict> findValus(HqlFilter hqlFilter);

}