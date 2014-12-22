#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.dao.base;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;

public interface IBaseDao<T> {

	//jpa2.0获得 hibernate session
	//Session session = entityManager.unwrap(org.hibernate.Session.class);
	public abstract void setEntityManager(EntityManager entityManager);

	/**
	 * 
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}save(java.lang.Object)
	 * 
	 * 功能描述：entityManager.persist
	 * 时间：2014年9月12日
	 * @author: lirenbo
	 * @param o
	 * @return
	 */
	public abstract Object save(T o);

	/**
	 * 
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}getById(java.lang.Class, java.lang.Object)
	 * 
	 * 功能描述：entityManager.find
	 * 时间：2014年9月12日
	 * @author: lirenbo
	 * @param clazz
	 * @param id
	 * @return
	 */
	public abstract <K> K getById(Class<K> clazz, Object id);

	/**
	 * 
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}getByHql(java.lang.String)
	 * 
	 * 功能描述：entityManager.createQuery
	 * 时间：2014年9月12日
	 * @author: lirenbo
	 * @param hql
	 * @return
	 */
	public abstract T getByHql(String hql);

	/**
	 * 
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}getByHql(java.lang.String, java.util.Map)
	 * 
	 * 功能描述：
	 * 时间：2014年9月12日
	 * @author: lirenbo
	 * @param hql
	 * @param params
	 * @return
	 */
	public abstract T getByHql(String hql, Map<String, Object> params);

	/**
	 * 
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}delete(java.lang.Object)
	 * 
	 * 功能描述：entityManager.remove
	 * 时间：2014年9月11日
	 * @author: lirenbo
	 * @param o
	 */
	public abstract void delete(T o);

	/**
	 * 
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}saveOrUpdate(java.lang.Object)
	 * 
	 * 功能描述：entityManager.merge
	 * 时间：2014年9月12日
	 * @author: lirenbo
	 * @param o
	 */
	public abstract Object saveOrUpdate(T o);

	/**
	 * 
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}find(java.lang.String)
	 * 
	 * 功能描述：entityManager.createQuery
	 * 时间：2014年9月12日
	 * @author: lirenbo
	 * @param hql
	 * @return
	 */
	public abstract List<T> find(String hql);

	/**
	 * 
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}find(java.lang.String, java.util.Map)
	 * 
	 * 功能描述：entityManager.createQuery
	 * 时间：2014年9月12日
	 * @author: lirenbo
	 * @param hql
	 * @param params
	 * @return
	 */
	public abstract List<T> find(String hql, Map<String, Object> params);

	/**
	 * 
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}find(java.lang.String, java.util.Map, int, int)
	 * 
	 * 功能描述：entityManager.createQuery
	 * 时间：2014年9月12日
	 * @author: lirenbo
	 * @param hql
	 * @param params
	 * @param page
	 * @param rows
	 * @return
	 */
	public abstract List<T> find(String hql, Map<String, Object> params, int page, int rows);

	/**
	 * 
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}find(java.lang.String, int, int)
	 * 
	 * 功能描述：entityManager.createQuery
	 * 时间：2014年9月12日
	 * @author: lirenbo
	 * @param hql
	 * @param page
	 * @param rows
	 * @return
	 */
	public abstract List<T> find(String hql, int page, int rows);

	/**
	 * 
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}getLong(java.lang.String)
	 * 
	 * 功能描述：entityManager.createQuery
	 * 时间：2014年9月12日
	 * @author: lirenbo
	 * @param hql
	 * @return
	 */
	public abstract Long getLong(String hql);

	/**
	 * 
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}getLong(java.lang.String, java.util.Map)
	 * 
	 * 功能描述：entityManager.createQuery
	 * 时间：2014年9月12日
	 * @author: lirenbo
	 * @param hql
	 * @param params
	 * @return
	 */
	public abstract Long getLong(String hql, Map<String, Object> params);

	/**
	 * 
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}getInteger(java.lang.String)
	 * 
	 * 功能描述：entityManager.createQuery
	 * 时间：2014年9月12日
	 * @author: lirenbo
	 * @param hql
	 * @return
	 */
	public abstract Integer getInteger(String hql);

	/**
	 * 
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}getInteger(java.lang.String, java.util.Map)
	 * 
	 * 功能描述：
	 * 时间：2014年9月12日
	 * @author: lirenbo
	 * @param hql
	 * @param params
	 * @return
	 */
	public abstract Integer getInteger(String hql, Map<String, Object> params);

	/**
	 * 
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}executeHql(java.lang.String)
	 * 
	 * 功能描述：entityManager.createQuery
	 * 时间：2014年9月12日
	 * @author: lirenbo
	 * @param hql
	 * @return
	 */
	public abstract int executeHql(String hql);

	/**
	 * 
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}executeHql(java.lang.String, java.util.Map)
	 * 
	 * 功能描述：entityManager.createQuery
	 * 时间：2014年9月12日
	 * @author: lirenbo
	 * @param hql
	 * @param params
	 * @return
	 */
	public abstract int executeHql(String hql, Map<String, Object> params);

	/**
	 * 
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}findBySql(java.lang.String)
	 * 
	 * 功能描述：entityManager.createNativeQuery
	 * 时间：2014年9月12日
	 * @author: lirenbo
	 * @param sql
	 * @return
	 */
	public abstract List<Object[]> findBySql(String sql);

	/**
	 * 
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}findBySql(java.lang.String, int, int)
	 * 
	 * 功能描述：entityManager.createNativeQuery
	 * 时间：2014年9月12日
	 * @author: lirenbo
	 * @param sql
	 * @param page
	 * @param rows
	 * @return
	 */
	public abstract List<Object[]> findBySql(String sql, int page, int rows);

	/**
	 * 
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}findBySql(java.lang.String, java.util.Map)
	 * 
	 * 功能描述：entityManager.createNativeQuery
	 * 时间：2014年9月12日
	 * @author: lirenbo
	 * @param sql
	 * @param params
	 * @return
	 */
	public abstract List<Object[]> findBySql(String sql, Map<String, Object> params);

	/**
	 * 
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}findBySql(java.lang.String, java.util.Map, int, int)
	 * 
	 * 功能描述：entityManager.createNativeQuery
	 * 时间：2014年9月12日
	 * @author: lirenbo
	 * @param sql
	 * @param params
	 * @param page
	 * @param rows
	 * @return
	 */
	public abstract List<Object[]> findBySql(String sql, Map<String, Object> params, int page, int rows);

	/**
	 * 
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}executeSql(java.lang.String)
	 * 
	 * 功能描述：entityManager.createNativeQuery
	 * 时间：2014年9月12日
	 * @author: lirenbo
	 * @param sql
	 * @return
	 */
	public abstract int executeSql(String sql);

	/**
	 * 
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}executeSql(java.lang.String, java.util.Map)
	 * 
	 * 功能描述：entityManager.createNativeQuery
	 * 时间：2014年9月12日
	 * @author: lirenbo
	 * @param sql
	 * @param params
	 * @return
	 */
	public abstract int executeSql(String sql, Map<String, Object> params);

	/**
	 * 
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}getIntegerBySql(java.lang.String)
	 * 
	 * 功能描述：entityManager.createNativeQuery
	 * 时间：2014年9月12日
	 * @author: lirenbo
	 * @param sql
	 * @return
	 */
	public abstract Integer getIntegerBySql(String sql);

	/**
	 * 
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}getIntegerBySql(java.lang.String, java.util.Map)
	 * 
	 * 功能描述：
	 * 时间：2014年9月11日
	 * @author: lirenbo
	 * @param sql
	 * @param params
	 * @return
	 */
	public abstract Integer getIntegerBySql(String sql, Map<String, Object> params);

	/**
	 * 
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}findByProperties(java.lang.Object)
	 * 
	 * 功能描述：根据有的属性查询一个满足该属性的List集合（集合类不能使用）
	 * 时间：2014年9月11日
	 * @author: lirenbo
	 * @param properties
	 * @return
	 */
	public abstract List<T> findByProperties(T properties);

	/**
	 * 
	 * 功能描述：调用存储过程获得对应表序列
	 * 时间：2014年9月4日 下午4:13:08
	 * @author ：songxia
	 * @param callName
	 * @return
	 */
	public abstract Integer getSeqValueSQLServer(String callName);

	public abstract String getString(String hql);

	BigDecimal getBigDecimalBySql(String sql);

}