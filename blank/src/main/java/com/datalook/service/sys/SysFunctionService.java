package com.datalook.service.sys;

import com.datalook.exception.base.ToWebException;
import com.datalook.model.sys.SysFunction;
import com.datalook.service.base.BaseService;

public interface SysFunctionService extends BaseService<SysFunction>{

	public abstract void test(String test) throws ToWebException;

}