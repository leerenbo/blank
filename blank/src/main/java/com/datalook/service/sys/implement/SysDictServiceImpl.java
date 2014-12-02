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
	
	@Override
	@Cacheable({"SysDictValue"})
	public SysDict getValue(String location,String value){
		List<SysDict> sysDicts=sysDictDao.find("from SysDict where location ='"+location+"' and value ='"+value+"'");
		if(sysDicts.size()==0){
			return null;
		}else{
			return sysDicts.get(0);
		}
	}
	
	@Override
	@Cacheable({"SysDictValues"})
	public List<SysDict> findValus(String location){
		List<SysDict> sysDicts=sysDictDao.find("from SysDict where location ='"+location+"'");
		return sysDicts;
	}
	
	@Override
	@Cacheable({"SysDictValuesHqlFilter"})
	public List<SysDict> findValus(HqlFilter hqlFilter){
		List<SysDict> sysDicts=findByHQLFilter(hqlFilter);
		return sysDicts;
	}
}
