package it.pkg.dao.base;

import java.lang.reflect.Array;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.stereotype.Repository;

import it.pkg.util.base.BeanUtils;

@Repository
@SuppressWarnings("unchecked")
public class BaseDao<T> implements IBaseDao<T> {
	private EntityManager entityManager;

	// jpa2.0获得 hibernate session
	// Session session = entityManager.unwrap(org.hibernate.Session.class);
	/**
	 * @see it.pkg.dao.base.IBaseDao#setEntityManager(javax.persistence.EntityManager)
	 * 
	 *      功能描述： 时间：2014年9月12日
	 * @author: lirenbo
	 * @param entityManager
	 */
	@Override
	@PersistenceContext(unitName = "basicUnit")
	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	/**
	 * @see it.pkg.dao.base.IBaseDao#save(T)
	 * 
	 *      功能描述： 时间：2014年9月12日
	 * @author: lirenbo
	 * @param o
	 * @return
	 */

	@Override
	public Object save(T o) {
		if (o != null) {
			entityManager.persist(o);
			return o;
		}
		return null;
	}

	/**
	 * @see it.pkg.dao.base.IBaseDao#getById(java.lang.Class,
	 *      java.lang.Object)
	 * 
	 *      功能描述： 时间：2014年9月12日
	 * @author: lirenbo
	 * @param clazz
	 * @param id
	 * @return
	 */

	@Override
	public <K> K getById(Class<K> clazz, Object id) {
		return entityManager.find(clazz, id);
	}

	/**
	 * @see it.pkg.dao.base.IBaseDao#getByHql(java.lang.String)
	 * 
	 *      功能描述： 时间：2014年9月12日
	 * @author: lirenbo
	 * @param hql
	 * @return
	 */

	
	@Override
	public T getByHql(String hql) {
		Query q = entityManager.createQuery(hql);
		List<T> l = q.getResultList();
		if (l != null && l.size() > 0) {
			return l.get(0);
		}
		return null;
	}

	/**
	 * @see it.pkg.dao.base.IBaseDao#getByHql(java.lang.String,
	 *      java.util.Map)
	 * 
	 *      功能描述： 时间：2014年9月12日
	 * @author: lirenbo
	 * @param hql
	 * @param params
	 * @return
	 */

	@Override
	public T getByHql(String hql, Map<String, Object> params) {
		Query q = entityManager.createQuery(hql);
		if (params != null && !params.isEmpty()) {
			for (String key : params.keySet()) {
				q.setParameter(key, params.get(key));
			}
		}
		List<T> l = q.getResultList();
		if (l != null && l.size() > 0) {
			return l.get(0);
		}
		return null;
	}

	/**
	 * @see it.pkg.dao.base.IBaseDao#delete(T)
	 * 
	 *      功能描述： 时间：2014年9月12日
	 * @author: lirenbo
	 * @param o
	 */

	@Override
	public void delete(T o) {
		if (o != null) {
			entityManager.remove(o);
		}
	}

	/**
	 * @see it.pkg.dao.base.IBaseDao#saveOrUpdate(T)
	 * 
	 *      功能描述： 时间：2014年9月12日
	 * @author: lirenbo
	 * @param o
	 */

	@Override
	public Object saveOrUpdate(T o) {
		if (o != null) {
			return entityManager.merge(o);
		}
		return null;
	}

	/**
	 * @see it.pkg.dao.base.IBaseDao#find(java.lang.String)
	 * 
	 *      功能描述： 时间：2014年9月12日
	 * @author: lirenbo
	 * @param hql
	 * @return
	 */

	@Override
	public List<T> find(String hql) {
		Query q = entityManager.createQuery(hql);
		return q.getResultList();
	}

	/**
	 * @see it.pkg.dao.base.IBaseDao#find(java.lang.String, java.util.Map)
	 * 
	 *      功能描述： 时间：2014年9月12日
	 * @author: lirenbo
	 * @param hql
	 * @param params
	 * @return
	 */

	@Override
	public List<T> find(String hql, Map<String, Object> params) {
		Query q = entityManager.createQuery(hql);
		if (params != null && !params.isEmpty()) {
			for (String key : params.keySet()) {
				q.setParameter(key, params.get(key));
			}
		}
		return q.getResultList();
	}

	/**
	 * @see it.pkg.dao.base.IBaseDao#find(java.lang.String, java.util.Map,
	 *      int, int)
	 * 
	 *      功能描述： 时间：2014年9月12日
	 * @author: lirenbo
	 * @param hql
	 * @param params
	 * @param page
	 * @param rows
	 * @return
	 */

	@Override
	public List<T> find(String hql, Map<String, Object> params, int page, int rows) {
		Query q = entityManager.createQuery(hql);
		if (params != null && !params.isEmpty()) {
			for (String key : params.keySet()) {
				q.setParameter(key, params.get(key));
			}
		}
		return q.setFirstResult((page - 1) * rows).setMaxResults(rows).getResultList();
	}

	/**
	 * @see it.pkg.dao.base.IBaseDao#find(java.lang.String, int, int)
	 * 
	 *      功能描述： 时间：2014年9月12日
	 * @author: lirenbo
	 * @param hql
	 * @param page
	 * @param rows
	 * @return
	 */

	@Override
	public List<T> find(String hql, int page, int rows) {
		Query q = entityManager.createQuery(hql);
		return q.setFirstResult((page - 1) * rows).setMaxResults(rows).getResultList();
	}

	/**
	 * @see it.pkg.dao.base.IBaseDao#getLong(java.lang.String)
	 * 
	 *      功能描述： 时间：2014年9月12日
	 * @author: lirenbo
	 * @param hql
	 * @return
	 */

	@Override
	public Long getLong(String hql) {
		Query q = entityManager.createQuery(hql);
		return (Long) q.getSingleResult();
	}

	@Override
	public String getString(String hql) {
		Query q = entityManager.createQuery(hql);
		return (String) q.getSingleResult();
	}

	/**
	 * @see it.pkg.dao.base.IBaseDao#getLong(java.lang.String,
	 *      java.util.Map)
	 * 
	 *      功能描述： 时间：2014年9月12日
	 * @author: lirenbo
	 * @param hql
	 * @param params
	 * @return
	 */

	@Override
	public Long getLong(String hql, Map<String, Object> params) {
		Query q = entityManager.createQuery(hql);
		if (params != null && !params.isEmpty()) {
			for (String key : params.keySet()) {
				q.setParameter(key, params.get(key));
			}
		}
		return (Long) q.getSingleResult();
	}

	/**
	 * @see it.pkg.dao.base.IBaseDao#getInteger(java.lang.String)
	 * 
	 *      功能描述： 时间：2014年9月12日
	 * @author: lirenbo
	 * @param hql
	 * @return
	 */

	@Override
	public Integer getInteger(String hql) {
		Query q = entityManager.createQuery(hql);
		return (Integer) q.getSingleResult();
	}

	/**
	 * @see it.pkg.dao.base.IBaseDao#getInteger(java.lang.String,
	 *      java.util.Map)
	 * 
	 *      功能描述： 时间：2014年9月12日
	 * @author: lirenbo
	 * @param hql
	 * @param params
	 * @return
	 */

	@Override
	public Integer getInteger(String hql, Map<String, Object> params) {
		Query q = entityManager.createQuery(hql);
		if (params != null && !params.isEmpty()) {
			for (String key : params.keySet()) {
				q.setParameter(key, params.get(key));
			}
		}
		return (Integer) q.getSingleResult();
	}

	/**
	 * @see it.pkg.dao.base.IBaseDao#executeHql(java.lang.String)
	 * 
	 *      功能描述： 时间：2014年9月12日
	 * @author: lirenbo
	 * @param hql
	 * @return
	 */

	@Override
	public int executeHql(String hql) {
		Query q = entityManager.createQuery(hql);
		return q.executeUpdate();
	}

	/**
	 * @see it.pkg.dao.base.IBaseDao#executeHql(java.lang.String,
	 *      java.util.Map)
	 * 
	 *      功能描述： 时间：2014年9月12日
	 * @author: lirenbo
	 * @param hql
	 * @param params
	 * @return
	 */

	@Override
	public int executeHql(String hql, Map<String, Object> params) {
		Query q = entityManager.createQuery(hql);
		if (params != null && !params.isEmpty()) {
			for (String key : params.keySet()) {
				q.setParameter(key, params.get(key));
			}
		}
		return q.executeUpdate();
	}

	/**
	 * @see it.pkg.dao.base.IBaseDao#findBySql(java.lang.String)
	 * 
	 *      功能描述： 时间：2014年9月12日
	 * @author: lirenbo
	 * @param sql
	 * @return
	 */

	@Override
	public List<Object[]> findBySql(String sql) {
		Query q = entityManager.createNativeQuery(sql);
		return q.getResultList();
	}

	/**
	 * @see it.pkg.dao.base.IBaseDao#findBySql(java.lang.String, int, int)
	 * 
	 *      功能描述： 时间：2014年9月12日
	 * @author: lirenbo
	 * @param sql
	 * @param page
	 * @param rows
	 * @return
	 */

	@Override
	public List<Object[]> findBySql(String sql, int page, int rows) {
		Query q = entityManager.createNativeQuery(sql);
		List los = q.setFirstResult((page - 1) * rows).setMaxResults(rows).getResultList();
		if (los.size() != 0) {
			if (los.get(0).getClass().isArray()) {
				return los;
			} else {
				List<Object[]> newlos = new ArrayList<Object[]>();
				for (int i = 0; i < los.size(); i++) {
					Object[] os = new Object[1];
					os[0] = los.get(i);
					newlos.add(os);
				}
				return newlos;
			}
		}
		return new ArrayList<Object[]>();
	}

	/**
	 * @see it.pkg.dao.base.IBaseDao#findBySql(java.lang.String,
	 *      java.util.Map)
	 * 
	 *      功能描述： 时间：2014年9月12日
	 * @author: lirenbo
	 * @param sql
	 * @param params
	 * @return
	 */

	@Override
	public List<Object[]> findBySql(String sql, Map<String, Object> params) {
		Query q = entityManager.createNativeQuery(sql);
		if (params != null && !params.isEmpty()) {
			for (String key : params.keySet()) {
				q.setParameter(key, params.get(key));
			}
		}
		List los = q.getResultList();
		if (los.size() != 0) {
			if (los.get(0).getClass().isArray()) {
				return los;
			} else {
				List<Object[]> newlos = new ArrayList<Object[]>();
				for (int i = 0; i < los.size(); i++) {
					Object[] os = new Object[1];
					os[0] = los.get(i);
					newlos.add(os);
				}
				return newlos;
			}
		}
		return new ArrayList<Object[]>();
	}
    public <C> List<C> findBySql(String sql, Map<String, Object> params,Class<C> clazz) {
	List<C> re = new ArrayList<C>();
	String[] strs = sql.split("(select +)|( +from)");
	String[] columns = strs[1].split(",");
	Pattern kongge = Pattern.compile(".+\\s.+");
	Pattern dian = Pattern.compile(".+\\..+");
	for (int i = 0; i < columns.length; i++) {
	    Matcher konggem = kongge.matcher(columns[i]);
	    if (konggem.matches()) {
		columns[i] = columns[i].split(" +")[1];
	    }
	    Matcher dianm = dian.matcher(columns[i]);
	    if (dianm.matches()) {
		columns[i] = columns[i].split("\\.")[1].trim();
	    }
	}
	Query q = entityManager.createNativeQuery(sql);
	if (params != null && !params.isEmpty()) {
	    for (String key : params.keySet()) {
		q.setParameter(key, params.get(key));
	    }
	}
	List los = q.getResultList();
	for (Object object : los) {
	    try {
		C c = clazz.newInstance();
		for (int j = 0; j < columns.length; j++) {
		    clazz.getDeclaredField(columns[j]).setAccessible(true);
		    if (columns.length > 1) {
			clazz.getDeclaredField(columns[j]).set(c,
				((Array[]) object)[j]);
		    } else if (columns.length == 1) {

			clazz.getDeclaredField(columns[j]).set(c, object);
		    }
		}
		re.add(c);
	    } catch (IllegalArgumentException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	    } catch (SecurityException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	    } catch (IllegalAccessException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	    } catch (NoSuchFieldException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	    } catch (InstantiationException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	    }
	}
	return re;
    }
	/**
	 * @see it.pkg.dao.base.IBaseDao#findBySql(java.lang.String,
	 *      java.util.Map, int, int)
	 * 
	 *      功能描述： 时间：2014年9月12日
	 * @author: lirenbo
	 * @param sql
	 * @param params
	 * @param page
	 * @param rows
	 * @return
	 */

	@Override
	public List<Object[]> findBySql(String sql, Map<String, Object> params, int page, int rows) {
		Query q = entityManager.createNativeQuery(sql);
		if (params != null && !params.isEmpty()) {
			for (String key : params.keySet()) {
				q.setParameter(key, params.get(key));
			}
		}
		List los = q.setFirstResult((page - 1) * rows).setMaxResults(rows).getResultList();
		if (los.size() != 0) {
			if (los.get(0).getClass().isArray()) {
				return los;
			} else {
				List<Object[]> newlos = new ArrayList<Object[]>();
				for (int i = 0; i < los.size(); i++) {
					Object[] os = new Object[1];
					os[0] = los.get(i);
					newlos.add(os);
				}
				return newlos;
			}
		}
		return new ArrayList<Object[]>();
	}

	/**
	 * @see it.pkg.dao.base.IBaseDao#executeSql(java.lang.String)
	 * 
	 *      功能描述： 时间：2014年9月12日
	 * @author: lirenbo
	 * @param sql
	 * @return
	 */

	@Override
	public int executeSql(String sql) {
		Query q = entityManager.createNativeQuery(sql);
		return q.executeUpdate();
	}

	/**
	 * @see it.pkg.dao.base.IBaseDao#executeSql(java.lang.String,
	 *      java.util.Map)
	 * 
	 *      功能描述： 时间：2014年9月12日
	 * @author: lirenbo
	 * @param sql
	 * @param params
	 * @return
	 */

	@Override
	public int executeSql(String sql, Map<String, Object> params) {
		Query q = entityManager.createNativeQuery(sql);
		if (params != null && !params.isEmpty()) {
			for (String key : params.keySet()) {
				q.setParameter(key, params.get(key));
			}
		}
		return q.executeUpdate();
	}

	/**
	 * @see it.pkg.dao.base.IBaseDao#getIntegerBySql(java.lang.String)
	 * 
	 *      功能描述： 时间：2014年9月12日
	 * @author: lirenbo
	 * @param sql
	 * @return
	 */

	@Override
	public Integer getIntegerBySql(String sql) {
		Query q = entityManager.createNativeQuery(sql);
		return (Integer) q.getSingleResult();
	}

	/**
	 * @see it.pkg.dao.base.IBaseDao#getIntegerBySql(java.lang.String,
	 *      java.util.Map)
	 * 
	 *      功能描述： 时间：2014年9月12日
	 * @author: lirenbo
	 * @param sql
	 * @param params
	 * @return
	 */

	@Override
	public Integer getIntegerBySql(String sql, Map<String, Object> params) {
		Query q = entityManager.createNativeQuery(sql);
		if (params != null && !params.isEmpty()) {
			for (String key : params.keySet()) {
				q.setParameter(key, params.get(key));
			}
		}
		return (Integer) q.getSingleResult();
	}

	/**
	 * @see it.pkg.dao.base.IBaseDao#findByProperties(T)
	 * 
	 *      功能描述： 时间：2014年9月12日
	 * @author: lirenbo
	 * @param properties
	 * @return
	 */

	@Override
	public List<T> findByProperties(T properties) {
		if (properties != null) {
			Map<String, Object> m = BeanUtils.toMapWithoutCollection(properties);
			String hql = "from ";
			hql = hql + properties.getClass().getSimpleName() + " pros ";
			if (m.size() > 0) {
				hql = hql + "where ";
				for (String key : m.keySet()) {
					hql = hql + "pros." + key + "=:" + key + " and ";
				}
			}
			hql = hql.substring(0, hql.length() - 5);
			Query q = entityManager.createQuery(hql);
			for (String key : m.keySet()) {
				q.setParameter(key, m.get(key));
			}
			return (List<T>) q.getResultList();
		}
		return null;
	}

	/**
	 * @see it.pkg.dao.base.IBaseDao#getSeqValueSQLServer(java.lang.String)
	 * 
	 *      功能描述： 时间：2014年9月12日
	 * @author: lirenbo
	 * @param callName
	 * @return
	 */

	@Override
	public Integer getSeqValueSQLServer(String callName) {
		Query query = entityManager.createNativeQuery(callName);
		return (Integer) query.getSingleResult();
	}

	@Override
	public BigDecimal getBigDecimalBySql(String sql) {
		Query q = entityManager.createNativeQuery(sql);
		return (BigDecimal) q.getSingleResult();
	}

}
