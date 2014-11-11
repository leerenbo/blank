package com.datalook.service.sys;

import javax.transaction.Transactional;

import com.datalook.exception.base.ToWebException;

public interface ISysFunctionService {

	public abstract void test(String test) throws ToWebException;

}