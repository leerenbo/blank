package com.datalook.action.base;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.reflect.FieldUtils;
import org.apache.commons.lang3.reflect.MethodUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.datalook.dao.base.HqlFilter;
import com.datalook.filter.base.FastjsonFilter;
import com.datalook.model.sys.easyui.ComboTree;
import com.datalook.model.sys.easyui.Grid;
import com.datalook.model.sys.easyui.Json;
import com.datalook.model.sys.web.SessionInfo;
import com.datalook.service.base.BaseService;
import com.datalook.util.base.BeanUtils;
import com.datalook.util.base.GenericsUtils;
import com.datalook.util.base.LogUtil;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 功能描述：
 * 基础ACTION,其他ACTION继承此ACTION来获得writeJson和ActionSupport的功能
 * 基本的CRUD已实现，子类继承BaseAction的时候，提供setService方法即可
 * 注解@Action后，访问地址就是命名空间+类名(全小写，并且不包括Action后缀)，本action的访问地址就是/base.action
 * 时间：2014年9月11日
 * @author ：lirenbo
 */
@ParentPackage("basePackage")
@Namespace("/")
@Action
public class BaseAction<T> extends ActionSupport{
	private static final long serialVersionUID = -8744267073413050746L;

	private static final Logger logger = Logger.getLogger(BaseAction.class);

	protected int page = 1;// 当前页
	protected int rows = 10;// 每页显示记录数
	protected String sort;// 排序字段
	protected String order = "asc";// asc/desc
	protected String q;// easyui的combo和其子类过滤时使用

	protected Integer id;// 主键
	protected String ids;// 主键集合，逗号分割
	protected T data;// 数据模型(与前台表单name相同，name="data.xxx")
	protected T olddata;// 数据模型(与前台表单name相同，name="data.xxx")
	
	protected Boolean closed= false;//下拉列表树子节点折叠属性，设置true后，展开所有节点
	
	protected List<ComboTree> comboTrees = new ArrayList<ComboTree>();//通用下拉列表对象
	protected BaseService<T> service;// 业务逻辑

	/**
	 * @see com.datalook.action.base.IBaseAction#setService(com.datalook.service.base.BaseService)
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 * @param service
	 */

	public void setService(BaseService<T> service) {
		this.service = service;
	}

	/**
	 * @see com.datalook.action.base.IBaseAction#getId()
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 * @return
	 */

	public Integer getId() {
		return id;
	}

	/**
	 * @see com.datalook.action.base.IBaseAction#setId(java.lang.Integer)
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 * @param id
	 */

	public void setId(Integer id) {
		this.id = id;
	}

	/**
	 * @see com.datalook.action.base.IBaseAction#getIds()
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 * @return
	 */

	public String getIds() {
		return ids;
	}

	/**
	 * @see com.datalook.action.base.IBaseAction#setIds(java.lang.String)
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 * @param ids
	 */

	public void setIds(String ids) {
		this.ids = ids;
	}
	
	/**
	 * @see com.datalook.action.base.IBaseAction#getData()
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 * @return
	 */

	public T getData() {
		return data;
	}

	/**
	 * @see com.datalook.action.base.IBaseAction#setData(T)
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 * @param data
	 */

	public void setData(T data) {
		this.data = data;
	}

	/**
	 * @see com.datalook.action.base.IBaseAction#getOlddata()
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 * @return
	 */

	public T getOlddata() {
		return olddata;
	}

	/**
	 * @see com.datalook.action.base.IBaseAction#setOlddata(T)
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 * @param olddata
	 */

	public void setOlddata(T olddata) {
		this.olddata = olddata;
	}

	/**
	 * @see com.datalook.action.base.IBaseAction#getPage()
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 * @return
	 */

	public int getPage() {
		return page;
	}

	/**
	 * @see com.datalook.action.base.IBaseAction#setPage(int)
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 * @param page
	 */

	public void setPage(int page) {
		this.page = page;
	}

	/**
	 * @see com.datalook.action.base.IBaseAction#getRows()
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 * @return
	 */

	public int getRows() {
		return rows;
	}

	/**
	 * @see com.datalook.action.base.IBaseAction#setRows(int)
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 * @param rows
	 */

	public void setRows(int rows) {
		this.rows = rows;
	}

	/**
	 * @see com.datalook.action.base.IBaseAction#getSort()
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 * @return
	 */

	public String getSort() {
		return sort;
	}

	/**
	 * @see com.datalook.action.base.IBaseAction#setSort(java.lang.String)
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 * @param sort
	 */

	public void setSort(String sort) {
		this.sort = sort;
	}

	/**
	 * @see com.datalook.action.base.IBaseAction#getOrder()
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 * @return
	 */

	public String getOrder() {
		return order;
	}

	/**
	 * @see com.datalook.action.base.IBaseAction#setOrder(java.lang.String)
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 * @param order
	 */

	public void setOrder(String order) {
		this.order = order;
	}

	/**
	 * @see com.datalook.action.base.IBaseAction#getQ()
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 * @return
	 */

	public String getQ() {
		return q;
	}

	/**
	 * @see com.datalook.action.base.IBaseAction#setQ(java.lang.String)
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 * @param q
	 */

	public void setQ(String q) {
		this.q = q;
	}
	
	/**
	 * @see com.datalook.action.base.IBaseAction#writeJsonByFilter(java.lang.Object, java.lang.String[], java.lang.String[])
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 * @param object
	 * @param includesProperties
	 * @param excludesProperties
	 */

	public void writeJsonByFilter(Object object, String[] includesProperties, String[] excludesProperties) {
		try {
			FastjsonFilter filter = new FastjsonFilter();// excludes优先于includes
			if (excludesProperties != null && excludesProperties.length > 0) {
				filter.getExcludes().addAll(Arrays.<String> asList(excludesProperties));
			}
			if (includesProperties != null && includesProperties.length > 0) {
				filter.getIncludes().addAll(Arrays.<String> asList(includesProperties));
			}
			LogUtil.trace("[JSON准备]：(+)[" + excludesProperties + "]  (-)[" + includesProperties + "]");
			String json;
			String User_Agent = getRequest().getHeader("User-Agent");
			if (StringUtils.indexOfIgnoreCase(User_Agent, "MSIE 6") > -1) {
				// 使用SerializerFeature.BrowserCompatible特性会把所有的中文都会序列化为\\uXXXX这种格式，字节数会多一些，但是能兼容IE6
				json = JSON.toJSONString(object, filter);//, SerializerFeature.WriteDateUseDateFormat, SerializerFeature.DisableCircularReferenceDetect, SerializerFeature.BrowserCompatible
			} else {
				// 使用SerializerFeature.WriteDateUseDateFormat特性来序列化日期格式的类型为yyyy-MM-dd hh24:mi:ss
				// 使用SerializerFeature.DisableCircularReferenceDetect特性关闭引用检测和生成
				json = JSON.toJSONString(object, filter,SerializerFeature.WriteDateUseDateFormat, SerializerFeature.DisableCircularReferenceDetect);// 
			}
			LogUtil.trace("[JSON数据]：" + json);
			getResponse().setContentType("text/html;charset=utf-8");
			getResponse().getWriter().write(json);
			getResponse().getWriter().flush();
			getResponse().getWriter().close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * @see com.datalook.action.base.IBaseAction#writeJson(java.lang.Object)
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 * @param object
	 */

	public void writeJson(Object object) {
		writeJsonByFilter(object, null, null);
	}

	/**
	 * @see com.datalook.action.base.IBaseAction#writeJsonByIncludesProperties(java.lang.Object, java.lang.String[])
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 * @param object
	 * @param includesProperties
	 */

	public void writeJsonByIncludesProperties(Object object, String[] includesProperties) {
		writeJsonByFilter(object, includesProperties, null);
	}

	/**
	 * @see com.datalook.action.base.IBaseAction#writeJsonByExcludesProperties(java.lang.Object, java.lang.String[])
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 * @param object
	 * @param excludesProperties
	 */

	public void writeJsonByExcludesProperties(Object object, String[] excludesProperties) {
		writeJsonByFilter(object, null, excludesProperties);
	}
	
	/**
	 * @see com.datalook.action.base.IBaseAction#getRequest()
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 * @return
	 */

	public HttpServletRequest getRequest() {
		return ServletActionContext.getRequest();
	}

	/**
	 * @see com.datalook.action.base.IBaseAction#getResponse()
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 * @return
	 */

	public HttpServletResponse getResponse() {
		return ServletActionContext.getResponse();
	}

	/**
	 * @see com.datalook.action.base.IBaseAction#getSession()
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 * @return
	 */

	public HttpSession getSession() {
		return ServletActionContext.getRequest().getSession();
	}

	/**
	 * @see com.datalook.action.base.IBaseAction#getById()
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 */

	@SuppressWarnings("rawtypes")
	public void getById() {
		if (id!=null) {
			Class c=GenericsUtils.getSuperClassGenricType(getClass());
			writeJson(service.getById(c,Integer.valueOf(id)));
		} else {
			Json j = new Json();
			j.setMsg("主键不可为空！");
			writeJson(j);
		}
	}

	/**
	 * @see com.datalook.action.base.IBaseAction#find()
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 */

	public void find() {
		HqlFilter hqlFilter = new HqlFilter(getRequest());
		if(!StringUtils.isBlank(hqlFilter.getSqltable())){
			writeJson(service.findBySQLFilter(hqlFilter));
		}else{
			writeJson(service.findByHQLFilter(hqlFilter));
		}
	}
	
	/**
	 * @see com.datalook.action.base.IBaseAction#grid()
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 */

	public void grid() {
		if(page==0){
			Grid grid = new Grid();
			writeJson(grid);
			return;
		}
		Grid grid = new Grid();
		HqlFilter hqlFilter = new HqlFilter(getRequest());
		if(!StringUtils.isBlank(hqlFilter.getSqltable())){
			grid.setTotal(service.countBySQLFilter(hqlFilter));
			grid.setRows(service.findBySQLFilter(hqlFilter, page, rows));
		}else{
			grid.setTotal(service.countByHQLFilter(hqlFilter));
			grid.setRows(service.findByHQLFilter(hqlFilter, page, rows));
		}
		writeJson(grid);
	}
	
	
	/**
	 * @see com.datalook.action.base.IBaseAction#gridAll()
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 */

	public void gridAll() {
		Grid grid = new Grid();
		HqlFilter hqlFilter = new HqlFilter(getRequest());
		if(!StringUtils.isBlank(hqlFilter.getSqltable())){
			List<Object> l = service.findBySQLFilter(hqlFilter);
			grid.setTotal((long)l.size());
			grid.setRows(l);
		}else{
			List<T> l = service.findByHQLFilter(hqlFilter);
			grid.setTotal((long) l.size());
			grid.setRows(l);
		}
		writeJson(grid);
	}

	/**
	 * @see com.datalook.action.base.IBaseAction#treeGrid()
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 */

	public void treeGrid() {
		HqlFilter hqlFilter = new HqlFilter(getRequest());
		if(!StringUtils.isBlank(hqlFilter.getSqltable())){
			writeJson(service.findBySQLFilter(hqlFilter));
		}else{
			writeJson(service.findByHQLFilter(hqlFilter));
		}
	}
	
	
	/**
	 * @see com.datalook.action.base.IBaseAction#save()
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 */

	public void save() {
		Json json = new Json();
		if (data != null) {
			service.save(data);
			json.setSuccess(true);
			json.setMsg("新建成功！");
		}
		writeJson(json);
	}

	
	/**
	 * @see com.datalook.action.base.IBaseAction#update()
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 */

	public void update() {
		Json json = new Json();
		Integer reflectId = null;
		try {
			if (data != null) {
				reflectId = (Integer) FieldUtils.readField(data, "id", true);
			}
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		}
		if (null!=reflectId) {
			T t = service.getById(reflectId);
			BeanUtils.copyNotNullProperties(data, t, new String[] { "password" });
			service.saveOrUpdate(t);
			json.setSuccess(true);
			json.setMsg("更新成功！");
		}
		writeJson(json);
	}
	
	
	/**
	 * @see com.datalook.action.base.IBaseAction#deleteByStatus()
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 */

	public void  deleteByStatus() {
		Json json = new Json();
		Integer reflectId = null;
		Long reflectIdLong = null;
		Object obj=null;

		try {
			if (data != null) {
				obj=FieldUtils.readField(data, "id", true);
				
				if(obj instanceof Integer){
					reflectId = (Integer) obj;
				}else if(obj instanceof Long){
					reflectIdLong = (Long) obj;
				}
	
				if (null!=reflectId) {
					T t = service.getById(reflectId);
					MethodUtils.invokeExactMethod(t, "setStatus", "0");
					service.saveOrUpdate(t);
					json.setSuccess(true);
					json.setMsg("删除成功！");
				}
				if (null!=reflectIdLong) {
					T t = service.getById(reflectIdLong);
					MethodUtils.invokeExactMethod(t, "setStatus", "0");
					service.saveOrUpdate(t);
					json.setSuccess(true);
					json.setMsg("删除成功！");
				}
				writeJson(json);
			}
			
			if(ids!=null){
				String[] idstrs=ids.split(",");
				for (String eachidstr : idstrs) {
					T t = null;
					if (GenericsUtils.getSuperClassGenricType(getClass()).getDeclaredField("id").getType().equals(Integer.class)) {
						reflectId = Integer.valueOf(eachidstr);
					}else if (GenericsUtils.getSuperClassGenricType(getClass()).getDeclaredField("id").getType().equals(Long.class)) {
						reflectIdLong = Long.valueOf(eachidstr);
					}
					
					if (null!=reflectId) {
						t = service.getById(reflectId);
						MethodUtils.invokeExactMethod(t, "setStatus", "0");
						service.saveOrUpdate(t);
						json.setSuccess(true);
						json.setMsg("删除成功！");
					}
					if (null!=reflectIdLong) {
						t = service.getById(reflectIdLong);
						MethodUtils.invokeExactMethod(t, "setStatus", "0");
						service.saveOrUpdate(t);
						json.setSuccess(true);
						json.setMsg("删除成功！");
					}
					writeJson(json);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			json.setMsg("删除失败！");
			writeJson(json);
		}
	}
	
	/**
	 * @see com.datalook.action.base.IBaseAction#delete()
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 */

	public void delete() {
		Json json = new Json();
		Integer reflectId = null;
		Long reflectIdLong = null;
		Object obj=null;
		try {
			if (data != null) {
				if(obj instanceof Integer){
					reflectId = (Integer) obj;
				}else if(obj instanceof Long){
					reflectIdLong = (Long) obj;
				}
				obj=FieldUtils.readField(data, "id", true);
				if (null!=reflectId) {
					T t = service.getById(reflectId);
					service.delete(t);
					json.setSuccess(true);
					json.setMsg("删除成功！");
				}
				if (null!=reflectIdLong) {
					T t = service.getById(reflectIdLong);
					service.delete(t);
					json.setSuccess(true);
					json.setMsg("删除成功！");
				}
			}
			
			if(ids!=null){
				String[] idstrs=ids.split(",");
				for (String eachidstr : idstrs) {
					T t = null;
					if (GenericsUtils.getSuperClassGenricType(getClass()).getDeclaredField("id").getType().equals(Integer.class)) {
						reflectId = Integer.valueOf(eachidstr);
					}else if (GenericsUtils.getSuperClassGenricType(getClass()).getDeclaredField("id").getType().equals(Long.class)) {
						reflectIdLong = Long.valueOf(eachidstr);
					}
					if (null!=reflectId) {
						t = service.getById(reflectId);
						service.delete(t);
						json.setSuccess(true);
						json.setMsg("删除成功！");
					}
					if (null!=reflectIdLong) {
						t = service.getById(reflectIdLong);
						service.delete(t);
						json.setSuccess(true);
						json.setMsg("删除成功！");
					}
				}
			}
			writeJson(json);
		} catch (Exception e) {
			e.printStackTrace();
			json.setMsg("删除失败");
			writeJson(json);
		}
	}
	
	/**
	 * @see com.datalook.action.base.IBaseAction#getSessionInfo()
	 * 
	 * 功能描述：
	 * 时间：2014年9月29日
	 * @author: lirenbo
	 * @return
	 */

	public SessionInfo getSessionInfo(){
		return (SessionInfo) getSession().getAttribute("sessionInfo");
	}
	
	/**
	 * 
	 * 功能描述：获得下拉列表json
	 * 时间：2014年9月10日 上午9:41:25
	 * @author ：songxia
	 * @param comboTreeList
	 */
	protected void noSnSy_getComboTreeData(List<ComboTree> comboTreeList) {
		try {
			String sign = getRequest().getParameter("closed");
			
			if (sign != null &&  (sign.equals("true") || sign.equals("false"))) {
				closed = Boolean.parseBoolean(sign);
			}
			
			//构建json数据
			StringBuffer json = new StringBuffer();
			buildJSON(comboTreeList, json);
			
			getResponse().getWriter().print(json.toString());
		} catch (Exception e) {
			logger.error(e);
			e.printStackTrace();
		}

	}
	
	/**
	 * 
	 * 功能描述：从已经查询到的所有节点lists中查询父节点
	 * 时间：2014年9月9日 下午5:12:21
	 * @author ：songxia
	 * @param pid
	 * @return
	 */
	protected List<ComboTree> findByPid(int pid){
		List<ComboTree> result = new ArrayList<ComboTree>();
		
		for (ComboTree vo : comboTrees) {
			if (pid == vo.getPid()) {
				result.add(vo);
			}
		}		
		return result;
	}

	/**
	 * 
	 * 功能描述：构建树json对象
	 * 时间：2014年9月9日 下午5:15:51
	 * @author ：songxia
	 * @param comboTrees
	 * @param json
	 */
	protected void buildJSON(List<ComboTree> comboTrees, StringBuffer json){
		
		json.append("[");		
		
		if (comboTrees != null && comboTrees.size() > 0) {
			
			for (int i = 0; i < comboTrees.size(); i++ ) {
				
				ComboTree ct = comboTrees.get(i);
				
				json.append("{");
				
				json.append("\"id\"");
				json.append(":");
				json.append("\"");
				json.append(ct.getId());
				json.append("\"");
				
				json.append(",");
				
				json.append("\"text\"");
				json.append(":");
				json.append("\"");
				json.append(ct.getText());
				json.append("\"");
				
				if (ct.getId() == -2) {
					json.append(",");
					json.append("\"checked\"");
					json.append(":");
					json.append("\"true\"");
				}
				
				List<ComboTree> children = findByPid(ct.getId());
				
				if (children != null && children.size() > 0) {
					if (!closed) {
						json.append(",");
						json.append("\"state\"");
						json.append(":");
						json.append("\"closed\"");
					}
					
					json.append(",");
					
					json.append("\"children\"");
					json.append(":");
					
					buildJSON(children, json);
					
				}
				
				json.append("}");
				
				if (i != comboTrees.size() - 1) {
					json.append(",");
				}
			}
		}
		json.append("]");
	}
	
}
