package it.pkg.service.sys.implement;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import it.pkg.dao.base.HqlFilter;
import it.pkg.dao.base.IBaseDao;
import it.pkg.model.sys.SysDict;
import it.pkg.service.base.BaseServiceImpl;
import it.pkg.service.sys.SysDictService;
@Service("sysDictService")
public class SysDictServiceImpl extends BaseServiceImpl<SysDict> implements SysDictService{
	@Autowired
	IBaseDao<SysDict> sysDictDao;
	
	/**
	 * @see it.pkg.service.sys.SysDictService#getValue(java.lang.String, java.lang.String)
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
	 * @see it.pkg.service.sys.SysDictService#findValus(java.lang.String)
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
	 * @see it.pkg.service.sys.SysDictService#findValus(it.pkg.dao.base.HqlFilter)
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
