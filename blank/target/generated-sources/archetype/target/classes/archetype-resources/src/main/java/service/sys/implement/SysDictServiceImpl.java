#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.service.sys.implement;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import ${package}.dao.base.HqlFilter;
import ${package}.dao.base.IBaseDao;
import ${package}.model.sys.SysDict;
import ${package}.service.base.BaseServiceImpl;
import ${package}.service.sys.SysDictService;
@Service("sysDictService")
public class SysDictServiceImpl extends BaseServiceImpl<SysDict> implements SysDictService{
	@Autowired
	IBaseDao<SysDict> sysDictDao;
	
	/**
	 * @see ${package}.service.sys.SysDictService${symbol_pound}getValue(java.lang.String, java.lang.String)
	 * 
	 * 功能描述：
	 * 时间：2014年10月16日
	 * @author: lirenbo
	 * @param location
	 * @param code
	 * @return
	 */
	@Override
//	@Cacheable({"SysDictValue"})
	public SysDict getValue(String location,String code){
		List<SysDict> sysDicts=sysDictDao.find("from SysDict where location ='"+location+"' and code ='"+code+"'");
		if(sysDicts.size()==0){
			return null;
		}else{
			return sysDicts.get(0);
		}
	}
	
	
	/**
	 * @see ${package}.service.sys.SysDictService${symbol_pound}findValus(java.lang.String)
	 * 
	 * 功能描述：
	 * 时间：2014年10月16日
	 * @author: lirenbo
	 * @param location
	 * @return
	 */
	@Override
//	@Cacheable({"SysDictValues"})
	public List<SysDict> findValus(String location){
		List<SysDict> sysDicts=sysDictDao.find("from SysDict where location ='"+location+"'");
		return sysDicts;
	}
	
	
	/**
	 * @see ${package}.service.sys.SysDictService${symbol_pound}findValus(${package}.dao.base.HqlFilter)
	 * 
	 * 功能描述：
	 * 时间：2014年10月16日
	 * @author: lirenbo
	 * @param hqlFilter
	 * @return
	 */
	@Override
//	@Cacheable({"SysDictValuesHqlFilter"})
	public List<SysDict> findValus(HqlFilter hqlFilter){
		List<SysDict> sysDicts=findByHQLFilter(hqlFilter);
		return sysDicts;
	}
}
