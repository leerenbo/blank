package it.pkg.service.sys.implement;

import org.springframework.stereotype.Service;

import it.pkg.model.sys.SysFunction;
import it.pkg.service.base.BaseServiceImpl;
import it.pkg.service.sys.SysFunctionService;


@Service("sysFunctionService")
public class SysFunctionServiceImpl extends BaseServiceImpl<SysFunction> implements  SysFunctionService {

	public SysFunctionServiceImpl() {
		super();
	}

	@Override
	public synchronized Object save(SysFunction o) {
		Integer i=getBaseDao().getInteger("select max(sf.id) from SysFunction sf");
		o.setId(i+1);
		getBaseDao().save(o);
		return o;
	}

	@Override
	public void saveOrUpdate(SysFunction o) {
		getBaseDao().saveOrUpdate(o);
		return ;
	}
	
}
