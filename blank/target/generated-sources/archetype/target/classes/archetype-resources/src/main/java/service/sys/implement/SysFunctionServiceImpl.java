#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.service.sys.implement;

import org.springframework.stereotype.Service;

import ${package}.model.sys.SysFunction;
import ${package}.service.base.BaseServiceImpl;
import ${package}.service.sys.SysFunctionService;


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
