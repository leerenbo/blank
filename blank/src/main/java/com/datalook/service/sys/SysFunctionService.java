package com.datalook.service.sys;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Service;

import com.datalook.exception.base.ToWebException;
import com.datalook.exception.base.ToWebExceptionFactory;
import com.datalook.model.sys.SysFunction;
import com.datalook.service.base.BaseService;
import com.datalook.service.base.IBaseService;


@Service("sysFunctionService")
public class SysFunctionService extends BaseService<SysFunction> implements IBaseService<SysFunction>, ISysFunctionService {

	public SysFunctionService() {
		super();
	}

	@Override
	public synchronized Object save(SysFunction o) {
		Integer i=getBaseDao().getInteger("select max(sf.id) from SysFunction sf");
		o.setSysFunction(getById(o.getPid()));
		o.setId(i+1);
		getBaseDao().save(o);
		return o;
	}

	@Override
	public void saveOrUpdate(SysFunction o) {
		o.setSysFunction(getById(o.getPid()));
		getBaseDao().saveOrUpdate(o);
		return ;
	}
	
	
	/**
	 * @see com.datalook.service.sys.ISysFunctionService#test(java.lang.String)
	 * 
	 * 功能描述：
	 * 时间：2014年10月15日
	 * @author: lirenbo
	 * @param test
	 * @throws ToWebException 
	 */
	@Override
	@org.springframework.transaction.annotation.Transactional
	public void test(String test) throws ToWebException{
		getBaseDao().save(new SysFunction(99868, null, test, null, null, null, null, null, null, null, null));
		throw ToWebExceptionFactory.createCodeRollbackInstance("1");
	}
}
