package com.datalook.service.sys.interfaces;

import java.util.List;

import com.datalook.dao.base.HqlFilter;
import com.datalook.model.sys.SysDict;
import com.datalook.service.base.IBaseService;

public interface ISysDictService extends IBaseService<SysDict>{

	public abstract SysDict getValue(String location, String code);

	public abstract List<SysDict> findValus(String location);

	public abstract List<SysDict> findValus(HqlFilter hqlFilter);

}