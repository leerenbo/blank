package com.datalook.service.sys;

import java.util.List;

import org.springframework.cache.annotation.Cacheable;

import com.datalook.dao.base.HqlFilter;
import com.datalook.model.sys.SysDict;
import com.datalook.service.base.BaseService;

public interface SysDictService extends BaseService<SysDict>{
	@Cacheable({"SysDictValue"})
	public abstract SysDict getValue(String location, String code);
	
	@Cacheable({"SysDictValues"})
	public abstract List<SysDict> findValus(String location);
	
	@Cacheable({"SysDictValuesHqlFilter"})
	public abstract List<SysDict> findValus(HqlFilter hqlFilter);

}