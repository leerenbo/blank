package com.datalook.service.sys.implement;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.datalook.dao.base.HqlFilter;
import com.datalook.dao.base.IBaseDao;
import com.datalook.model.sys.SysDict;
import com.datalook.service.base.BaseServiceImpl;
import com.datalook.service.sys.SysDictService;
@Service("sysDictService")
public class SysDictServiceImpl extends BaseServiceImpl<SysDict> implements SysDictService{
	@Autowired
	IBaseDao<SysDict> sysDictDao;
	
	/**
	 * @see com.datalook.service.sys.SysDictService#getValue(java.lang.String, java.lang.String)
	 * 
	 * 功能描述：
	 * 时间：2014年10月16日
	 * @author: lirenbo
	 * @param location
	 * @param code
	 * @return
	 */
	@Override
	@Cacheable({"SysDictValue"})
	public SysDict getValue(String location,String code){
		List<SysDict> sysDicts=sysDictDao.find("from SysDict where location ='"+location+"' and code ='"+code+"'");
		if(sysDicts.size()==0){
			return null;
		}else{
			return sysDicts.get(0);
		}
	}
	
	
	/**
	 * @see com.datalook.service.sys.SysDictService#findValus(java.lang.String)
	 * 
	 * 功能描述：
	 * 时间：2014年10月16日
	 * @author: lirenbo
	 * @param location
	 * @return
	 */
	@Override
	@Cacheable({"SysDictValues"})
	public List<SysDict> findValus(String location){
		List<SysDict> sysDicts=sysDictDao.find("from SysDict where location ='"+location+"'");
		return sysDicts;
	}
	
	
	/**
	 * @see com.datalook.service.sys.SysDictService#findValus(com.datalook.dao.base.HqlFilter)
	 * 
	 * 功能描述：
	 * 时间：2014年10月16日
	 * @author: lirenbo
	 * @param hqlFilter
	 * @return
	 */
	@Override
	@Cacheable({"SysDictValuesHqlFilter"})
	public List<SysDict> findValus(HqlFilter hqlFilter){
		List<SysDict> sysDicts=findByHQLFilter(hqlFilter);
		return sysDicts;
	}
}
