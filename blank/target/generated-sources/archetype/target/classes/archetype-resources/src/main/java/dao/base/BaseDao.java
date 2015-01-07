#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.dao.base;

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

import ${package}.util.base.BeanUtils;

@Repository
@SuppressWarnings("unchecked")
public class BaseDao<T> implements IBaseDao<T> {
	private EntityManager entityManager;

	// jpa2.0获得 hibernate session
	// Session session = entityManager.unwrap(org.hibernate.Session.class);
	/**
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}setEntityManager(javax.persistence.EntityManager)
	 * 
	 *      功能描述： 时间：2014年9月12日
	 * @author: lirenbo
	 * @param entityManager
	 */
	@Override
	@PersistenceContext(unitName = "${artifactId}Unit")
	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	/**
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}save(T)
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
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}getById(java.lang.Class,
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
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}getByHql(java.lang.String)
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
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}getByHql(java.lang.String,
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
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}delete(T)
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
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}saveOrUpdate(T)
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
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}find(java.lang.String)
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
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}find(java.lang.String, java.util.Map)
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
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}find(java.lang.String, java.util.Map,
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
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}find(java.lang.String, int, int)
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
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}getLong(java.lang.String)
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
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}getLong(java.lang.String,
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
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}getInteger(java.lang.String)
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
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}getInteger(java.lang.String,
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
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}executeHql(java.lang.String)
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
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}executeHql(java.lang.String,
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
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}findBySql(java.lang.String)
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
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}findBySql(java.lang.String, int, int)
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
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}findBySql(java.lang.String,
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
	Pattern kongge = Pattern.compile(".+${symbol_escape}${symbol_escape}s.+");
	Pattern dian = Pattern.compile(".+${symbol_escape}${symbol_escape}..+");
	for (int i = 0; i < columns.length; i++) {
	    Matcher konggem = kongge.matcher(columns[i]);
	    if (konggem.matches()) {
		columns[i] = columns[i].split(" +")[1];
	    }
	    Matcher dianm = dian.matcher(columns[i]);
	    if (dianm.matches()) {
		columns[i] = columns[i].split("${symbol_escape}${symbol_escape}.")[1].trim();
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
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}findBySql(java.lang.String,
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
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}executeSql(java.lang.String)
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
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}executeSql(java.lang.String,
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
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}getIntegerBySql(java.lang.String)
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
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}getIntegerBySql(java.lang.String,
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
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}findByProperties(T)
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
	 * @see ${package}.dao.base.IBaseDao${symbol_pound}getSeqValueSQLServer(java.lang.String)
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
