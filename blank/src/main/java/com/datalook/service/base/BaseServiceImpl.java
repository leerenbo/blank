package com.datalook.service.base;

import java.lang.reflect.ParameterizedType;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.datalook.dao.base.HqlFilter;
import com.datalook.dao.base.IBaseDao;
import com.datalook.dao.base.SqlBeanGenerater;
import com.datalook.util.base.GenericsUtils;

/**
 * 
 * 功能描述：基础业务逻辑 时间：2014年9月12日
 * 
 * @author ：lirenbo
 * 
 */
@SuppressWarnings("unchecked")
@Service("baseService")
public class BaseServiceImpl<T> implements BaseService<T> {

	@Autowired
	private IBaseDao<T> baseDao;

	/**
	 * 
	 * @see com.datalook.service.base.BaseService#countByHQLFilter(com.datalook.dao.base.HqlFilter)
	 * 
	 *      功能描述：根据过滤器查询，如果没有hqltable表则反射获取泛型为表 时间：2014年9月12日
	 * @author: lirenbo
	 * @param hqlFilter
	 * @return
	 */
	@Override
	public Long countByHQLFilter(HqlFilter hqlFilter) {
		if (!StringUtils.isBlank(hqlFilter.getHqltable())) {
			String hql = hqlFilter.getHql();
			hql = StringUtils.substringAfter(hql, "from");
			hql = StringUtils.substringBeforeLast(hql, "order");
			return baseDao.getLong("select count(*) from " + hql, hqlFilter.getParams());

		} else {
			String className = ((Class<T>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0]).getName();
			String hql = hqlFilter.getHql();

			hql = StringUtils.substringAfter(hql, "from").equals("") ? hql : StringUtils.substringAfter(hql, "from");
			hql = StringUtils.substringBeforeLast(hql, "order");

			hql = "select count(*) from " + className + " " + hql;
			return baseDao.getLong(hql, hqlFilter.getParams());
		}
	}

	public Long countBySQLFilter(HqlFilter hqlFilter) {
		if (!StringUtils.isBlank(hqlFilter.getSqltable())) {
			String sql = hqlFilter.getSql();
			sql = StringUtils.substringAfter(sql, "from").equals("") ? sql : StringUtils.substringAfter(sql, "from");
			sql = StringUtils.substringBeforeLast(sql, "order");
			sql = "select count(*) from " + sql;
			return Long.valueOf(baseDao.getIntegerBySql(sql, hqlFilter.getParams()).toString());
		}
		return null;
	}

	@Override
	public void delete(T o) {
		baseDao.delete(o);
	}

	@Override
	public int executeHql(String hql) {
		return baseDao.executeHql(hql);
	}

	@Override
	public int executeHql(String hql, Map<String, Object> params) {
		return baseDao.executeHql(hql, params);
	}

	@Override
	public int executeSql(String sql) {
		return baseDao.executeSql(sql);
	}

	@Override
	public int executeSql(String sql, Map<String, Object> params) {
		return baseDao.executeSql(sql, params);
	}

	@Override
	public List<T> find(String hql) {
		return baseDao.find(hql);
	}

	@Override
	public List<T> find(String hql, int page, int rows) {
		return baseDao.find(hql, page, rows);
	}

	@Override
	public List<T> find(String hql, Map<String, Object> params) {
		return baseDao.find(hql, params);
	}

	@Override
	public List<T> find(String hql, Map<String, Object> params, int page, int rows) {
		return baseDao.find(hql, params, page, rows);
	}

	@Override
	public List<T> findAll() {
		return findByHQLFilter(new HqlFilter());
	}

	@Override
	public List<T> findByHQLFilter(HqlFilter hqlFilter) {
		if (!StringUtils.isBlank(hqlFilter.getHqltable())) {
			return baseDao.find(hqlFilter.getHqlwithOrder(), hqlFilter.getParams());
		} else {
			String className = ((Class<T>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0]).getName();
			String hql = "from " + className + " " + hqlFilter.getHqlwithOrder();
			return baseDao.find(hql, hqlFilter.getParams());
		}
	}

	/**
	 * 
	 * @see com.datalook.service.base.BaseService#findByHQLFilter(com.datalook.dao.base.HqlFilter, int, int)
	 * 
	 *      功能描述：根据分页信息，与过滤器查询，如果没有hqltable表则反射获取泛型为表 时间：2014年9月12日
	 * @author: lirenbo
	 * @param hqlFilter
	 * @param page
	 * @param rows
	 * @return
	 */
	@Override
	public List<T> findByHQLFilter(HqlFilter hqlFilter, int page, int rows) {
		if (!StringUtils.isBlank(hqlFilter.getHqltable())) {
			return baseDao.find(hqlFilter.getHqlwithOrder(), hqlFilter.getParams(), page, rows);
		} else {
			String className = ((Class<T>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0]).getName();
			String hql = "from " + className + " " + hqlFilter.getHqlwithOrder();
			return baseDao.find(hql, hqlFilter.getParams(), page, rows);
		}
	}

	@Override
	public List<T> findByProperties(T properties) {
		return baseDao.findByProperties(properties);
	}

	@Override
	public List<Object[]> findBySql(String sql) {
		return baseDao.findBySql(sql);
	}

	@Override
	public List<Object[]> findBySql(String sql, int page, int rows) {
		return baseDao.findBySql(sql, page, rows);
	}

	@Override
	public List<Object[]> findBySql(String sql, Map<String, Object> params) {
		return baseDao.findBySql(sql, params);
	}

	@Override
	public List<Object[]> findBySql(String sql, Map<String, Object> params, int page, int rows) {
		return baseDao.findBySql(sql, params, page, rows);
	}

	public List<Object> findBySQLFilter(HqlFilter hqlFilter) {
		if (!StringUtils.isBlank(hqlFilter.getSqltable())) {
			List<Object[]> los = baseDao.findBySql(hqlFilter.getSqlwithOrder(), hqlFilter.getParams());
			return SqlBeanGenerater.generateBySqlList(hqlFilter.getSqlwithOrder(), los);
		}
		return new ArrayList<Object>();
	}

	public List<Object> findBySQLFilter(HqlFilter hqlFilter, int page, int rows) {
		if (!StringUtils.isBlank(hqlFilter.getSqltable())) {
			List<Object[]> los = baseDao.findBySql(hqlFilter.getSqlwithOrder(), hqlFilter.getParams(), page, rows);
			return SqlBeanGenerater.generateBySqlList(hqlFilter.getSqlwithOrder(), los);
		}
		return new ArrayList<Object>();
	}

	public IBaseDao<T> getBaseDao() {
		return baseDao;
	}

	@Override
	public T getByHql(String hql) {
		return baseDao.getByHql(hql);
	}

	@Override
	public T getByHql(String hql, Map<String, Object> params) {
		return baseDao.getByHql(hql, params);
	}

	@Override
	public T getById(Class<?> c, Object id) {
		return (T) baseDao.getById(c, id);
	}

	/**
	 * 
	 * @see com.datalook.service.base.BaseService#getById(java.lang.Object)
	 * 
	 *      功能描述：获取确定泛型class，根据主键直接查找对象 时间：2014年9月12日
	 * @author: lirenbo
	 * @param id
	 * @return
	 */
	@Override
	public T getById(Object id) {
		Class<?> c = GenericsUtils.getSuperClassGenricType(getClass());
		return (T) baseDao.getById(c, id);
	}

	/**
	 * 
	 * @see com.datalook.service.base.BaseService#getByProperties(java.lang.Object)
	 * 
	 *      功能描述：根据对象含有的属性查找对象，集合无效 时间：2014年9月12日
	 * @author: lirenbo
	 * @param properties
	 * @return
	 */
	@Override
	public T getByProperties(T properties) {
		List<T> list = findByProperties(properties);
		if (list.size() == 1) {
			return list.get(0);
		}
		return null;
	}

	/**
	 * 
	 * 功能描述：调用存储过程获得对应表序列 时间：2014年9月4日 下午4:13:08
	 * 
	 * @author ：songxia
	 * @param callName
	 * @return
	 */
	@Override
	public Integer getSeqValueSQLServer(T o) {
		if (o != null) {
			String callName = o.getClass().getSimpleName() + "_GetSeqvalue";
			return baseDao.getSeqValueSQLServer(callName);
		}
		return null;
	}

	@Override
	public String getString(String hql) {
		return baseDao.getString(hql);
	}

	@Override
	public Object save(T o) {
		return baseDao.save(o);
	}

	/**
	 * 
	 * @see com.datalook.service.base.BaseService#saveoDeleteOld(java.lang.Object, java.lang.Object)
	 * 
	 *      功能描述：删除oldo，保存o 时间：2014年9月12日
	 * @author: lirenbo
	 * @param o
	 * @param oldo
	 */
	@Override
	public void saveoDeleteOld(T o, T oldo) {
		oldo = getByProperties(oldo);
		delete(oldo);
		save(o);
	}

	@Override
	public void saveOrUpdate(T o) {
		baseDao.saveOrUpdate(o);
	}
}
