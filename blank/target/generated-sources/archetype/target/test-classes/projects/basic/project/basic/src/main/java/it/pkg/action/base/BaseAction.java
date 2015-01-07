package it.pkg.action.base;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.reflect.FieldUtils;
import org.apache.commons.lang3.reflect.MethodUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import it.pkg.dao.base.HqlFilter;
import com.datalook.excel.core.OEM;
import it.pkg.filter.base.FastjsonFilter;
import it.pkg.model.sys.SysExcelUpload;
import it.pkg.model.sys.easyui.Grid;
import it.pkg.model.sys.easyui.Message;
import it.pkg.model.sys.web.SessionInfo;
import it.pkg.service.base.BaseService;
import it.pkg.util.base.BeanUtils;
import it.pkg.util.base.ConfigUtil;
import it.pkg.util.base.DateUtil;
import it.pkg.util.base.GenericsUtils;
import it.pkg.util.base.LogUtil;
import com.opensymphony.xwork2.ActionSupport;

/**
 * 功能描述： 基础ACTION,其他ACTION继承此ACTION来获得writeJson和ActionSupport的功能
 * 基本的CRUD已实现，子类继承BaseAction的时候，提供setService方法即可
 * 注解@Action后，访问地址就是命名空间+类名(全小写，并且不包括Action后缀)，本action的访问地址就是/base.action
 * 时间：2014年9月11日
 * 
 * @author ：lirenbo
 */
@ParentPackage("basePackage")
@Namespace("/")
@Action
@Result(name = "download", type = "stream", params = { "contentType", "application/octet-stream", "inputName", "inputStream", "contentDisposition", "attachment;filename=\"${fileName}\"", "bufferSize", "4096" })
public class BaseAction<T> extends ActionSupport {
	private static final long serialVersionUID = -8744267073413050746L;

	protected int page = 1;// 当前页
	protected int rows = 10;// 每页显示记录数
	protected String sort;// 排序字段
	protected String order = "asc";// asc/desc

	protected String ids;// 主键集合，逗号分割
	protected T data;// 数据模型(与前台表单name相同，name="data.xxx")
	protected T olddata;// 数据模型(与前台表单name相同，name="olddata.xxx")

	protected BaseService<T> service;// 业务逻辑
	protected String fileName;// 下载文件名称
	protected InputStream inputStream; // 下载提供的io流
	protected File uploadExcelFile;// 上传的文件
	protected String uploadExcelFileFileName;
	protected Date now;
	protected BaseService baseService;

	public void setService(BaseService<T> service) {
		this.service = service;
	}

	@Resource(name = "baseService")
	public void setBaseService(BaseService baseService) {
		this.baseService = baseService;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public T getData() {
		return data;
	}

	public void setData(T data) {
		this.data = data;
	}

	public T getOlddata() {
		return olddata;
	}

	public void setOlddata(T olddata) {
		this.olddata = olddata;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public InputStream getInputStream() {
		return inputStream;
	}

	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}

	public File getUploadExcelFile() {
		return uploadExcelFile;
	}

	public void setUploadExcelFile(File uploadExcelFile) {
		this.uploadExcelFile = uploadExcelFile;
	}

	public String getUploadExcelFileFileName() {
		return uploadExcelFileFileName;
	}

	public void setUploadExcelFileFileName(String uploadExcelFileFileName) {
		this.uploadExcelFileFileName = uploadExcelFileFileName;
	}

	/**
	 * @see it.pkg.wanhui.action.base.IBaseAction#writeJsonByFilter(java.lang.Object,
	 *      java.lang.String[], java.lang.String[])
	 * 
	 *      功能描述： 时间：2014年9月29日
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
				json = JSON.toJSONString(object, filter);// ,
															// SerializerFeature.WriteDateUseDateFormat,
															// SerializerFeature.DisableCircularReferenceDetect,
															// SerializerFeature.BrowserCompatible
			} else {
				// 使用SerializerFeature.WriteDateUseDateFormat特性来序列化日期格式的类型为yyyy-MM-dd
				// hh24:mi:ss
				// 使用SerializerFeature.DisableCircularReferenceDetect特性关闭引用检测和生成
				json = JSON.toJSONString(object, filter, SerializerFeature.WriteDateUseDateFormat, SerializerFeature.DisableCircularReferenceDetect);//
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

	public void writeJson(Object object) {
		writeJsonByFilter(object, null, null);
	}

	public void writeJsonByIncludesProperties(Object object, String[] includesProperties) {
		writeJsonByFilter(object, includesProperties, null);
	}

	public void writeJsonByExcludesProperties(Object object, String[] excludesProperties) {
		writeJsonByFilter(object, null, excludesProperties);
	}

	public HttpServletRequest getRequest() {
		return ServletActionContext.getRequest();
	}

	public HttpServletResponse getResponse() {
		return ServletActionContext.getResponse();
	}

	public HttpSession getSession() {
		return ServletActionContext.getRequest().getSession();
	}

	public void getById() throws IllegalAccessException {
		Object id;
		id = FieldUtils.readDeclaredField(data, "id", true);
		if (id != null) {
			Class<?> c = GenericsUtils.getSuperClassGenricType(getClass());
			writeJson(service.getById(c, id));
		} else {
			Message j = new Message();
			j.setMsg("主键不可为空！");
			writeJson(j);
		}
	}

	public void datagridByPage() {
		if (page == 0) {
			Grid grid = new Grid();
			writeJson(grid);
			return;
		}
		Grid grid = new Grid();
		HqlFilter hqlFilter = new HqlFilter(getRequest());
		if (!StringUtils.isBlank(hqlFilter.getSqltable())) {
			grid.setTotal(service.countBySQLFilter(hqlFilter));
			grid.setRows(service.findBySQLFilter(hqlFilter, page, rows));
		} else {
			grid.setTotal(service.countByHQLFilter(hqlFilter));
			grid.setRows(service.findByHQLFilter(hqlFilter, page, rows));
		}
		writeJson(grid);
	}

	public void datagridNoPage() {
		Grid grid = new Grid();
		HqlFilter hqlFilter = new HqlFilter(getRequest());
		if (!StringUtils.isBlank(hqlFilter.getSqltable())) {
			List<Object> l = service.findBySQLFilter(hqlFilter);
			grid.setTotal((long) l.size());
			grid.setRows(l);
		} else {
			List<T> l = service.findByHQLFilter(hqlFilter);
			grid.setTotal((long) l.size());
			grid.setRows(l);
		}
		writeJson(grid);
	}

	public void treegridNoPage() {
		find();
	}

	public void find() {
		HqlFilter hqlFilter = new HqlFilter(getRequest());
		if (!StringUtils.isBlank(hqlFilter.getSqltable())) {
			writeJson(service.findBySQLFilter(hqlFilter));
		} else {
			writeJson(service.findByHQLFilter(hqlFilter));
		}
	}

	protected Message beforeSave() {
		Message json = new Message();
		json.setSuccess(true);
		json.setMsg("添加成功！");
		return json;
	}

	public void save() {
		Message json = beforeSave();
		if (json == null) {
			LogUtil.error("不可以返回null的Message对象");
		} else {
			if (json.isSuccess()) {
				service.save(data);
			} else {
			}
		}
		writeJson(json);
	}

	protected Message beforeUpdate() {
		Message json = new Message();
		json.setSuccess(true);
		json.setMsg("修改成功！");
		return json;
	}

	public void update() throws IllegalAccessException {
		Message json = beforeUpdate();
		if (json == null) {
			LogUtil.error("不可以返回null的Message对象");
		} else {
			if (json.isSuccess()) {
				Object reflectId = null;
				if (data != null) {
					reflectId = FieldUtils.readField(data, "id", true);
				}
				if (null != reflectId) {
					T t = service.getById(reflectId);
					BeanUtils.copyNotNullProperties(data, t);
					service.saveOrUpdate(t);
				}
			} else {
			}
		}
		writeJson(json);
	}

	protected Message beforeDeleteByStatus() {
		Message json = new Message();
		json.setSuccess(true);
		json.setMsg("删除成功！");
		return json;
	}

	public void deleteByStatus() throws NoSuchMethodException, IllegalAccessException, InvocationTargetException, NoSuchFieldException, SecurityException {
		Message json = beforeDeleteByStatus();
		if (json == null) {
			LogUtil.error("不可以返回null的Message对象");
		} else {
			if (json.isSuccess()) {
				if (ids != null) {
					String[] idstrs = ids.split(",");
					for (String eachidstr : idstrs) {
						T t = null;
						Object id = MethodUtils.invokeStaticMethod(GenericsUtils.getSuperClassGenricType(getClass()).getDeclaredField("id").getType(), "valueOf", eachidstr);
						if (null != id) {
							t = service.getById(id);
							FieldUtils.writeDeclaredField(t, "status", "0", true);
							service.saveOrUpdate(t);
						}
					}
				} else {
					json.setSuccess(false);
					json.setMsg("请选择要删除的数据");
				}
			} else {

			}
		}
		writeJson(json);
	}

	protected Message beforeDeletePhysical() {
		Message json = new Message();
		json.setSuccess(true);
		json.setMsg("删除成功！");
		return json;
	}

	public void deletePhysical() throws NoSuchMethodException, IllegalAccessException, InvocationTargetException, NoSuchFieldException, SecurityException {
		Message json = beforeDeletePhysical();
		if (json == null) {
			LogUtil.error("不可以返回null的Message对象");
		} else {
			if (json.isSuccess()) {
				if (ids != null) {
					String[] idstrs = ids.split(",");
					for (String eachidstr : idstrs) {
						T t = null;
						Object id = MethodUtils.invokeStaticMethod(GenericsUtils.getSuperClassGenricType(getClass()).getDeclaredField("id").getType(), "valueOf", eachidstr);
						if (null != id) {
							t = service.getById(id);
							service.delete(t);
						}
					}
				} else {
					json.setSuccess(false);
					json.setMsg("请选择要删除的数据");
				}
			} else {

			}
		}
		writeJson(json);
	}

	public SessionInfo getSessionInfo() {
		return (SessionInfo) getSession().getAttribute(ConfigUtil.getSessionName());
	}

	public String downloadExcel() throws UnsupportedEncodingException {
		HqlFilter hqlFilter = new HqlFilter(getRequest());
		List<T> lse = service.findByHQLFilter(hqlFilter);
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		try {
			if (lse.size() > 0) {
				OEM.generateExecl(lse, baos, OEM.OFFICE03);
			} else {
				OEM.generateExeclTitle(GenericsUtils.getSuperClassGenricType(this.getClass()), baos, OEM.OFFICE03);
			}
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		inputStream = new ByteArrayInputStream(baos.toByteArray());
		if (StringUtils.isNotBlank(fileName)) {
			fileName = new String((fileName + DateUtil.dateToString(new Date(), "yyyy-MM-dd-hhmmss") + ".xls").getBytes(), "iso8859-1");
		} else {
			fileName = new String(("报表" + DateUtil.dateToString(new Date(), "yyyy-MM-dd-hhmmss") + ".xls").getBytes(), "iso8859-1");
		}
		return "download";
	}

	public void uploadExcel() throws IOException {
		now = new Date();
		String destFilePath = getRequest().getServletContext().getRealPath("/") + File.separator + "upload" + File.separator + "excel" + File.separator + now.getTime() + uploadExcelFileFileName;
		File destFile = new File(destFilePath);
		FileUtils.copyFile(uploadExcelFile, destFile);
		FileInputStream fis = FileUtils.openInputStream(destFile);
		List<T> l = OEM.readExecl(GenericsUtils.getSuperClassGenricType(this.getClass()), fis, OEM.OFFICE03);
		SysExcelUpload seu = afterUploadExcel(l);
		baseService.save(seu);
		Message msg = new Message();
		msg.setMsg("导入成功<br/>" + seu.toString());
		msg.setSuccess(true);
		writeJson(msg);
	}

	protected SysExcelUpload afterUploadExcel(List<T> infoInExcel) throws IOException {
		SysExcelUpload seu = new SysExcelUpload();
		seu.setUploadTime(new Date());
		List<T> errorList = new ArrayList<T>();
		for (T info : infoInExcel) {
			if (checkUploadExcel(info)) {
				service.save(info);
				seu.setSuccessCount(seu.getSuccessCount() + 1);
			} else {
				errorList.add(info);
				seu.setErrorCount(seu.getErrorCount() + 1);
			}
		}

		if (errorList.size() > 0) {
			String errorFilePath = getRequest().getServletContext().getRealPath("/") + File.separator + "upload" + File.separator + "errorInfo" + File.separator + now.getTime() + uploadExcelFileFileName;
			File errorFile = new File(errorFilePath);
			OEM.generateExecl(errorList, FileUtils.openOutputStream(errorFile), OEM.OFFICE03);
			seu.setErrorDocPath(getRequest().getContextPath() + "/upload/errorInfo/" + now.getTime() + uploadExcelFileFileName);
		} else {

		}
		return seu;
	}

	protected boolean checkUploadExcel(T info) {
		return true;
	}

	public String noSy_downloadExcelTemplate() throws InstantiationException, IllegalAccessException, UnsupportedEncodingException {
		List<T> lse = new ArrayList<T>();
		if (data != null) {
			lse.add(data);
		} else {
		}
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		try {
			if (lse.size() > 0) {
				OEM.generateExecl(lse, baos, OEM.OFFICE03);
			} else {
				OEM.generateExeclTitle(GenericsUtils.getSuperClassGenricType(this.getClass()), baos, OEM.OFFICE03);
			}
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		inputStream = new ByteArrayInputStream(baos.toByteArray());
		if (StringUtils.isNotBlank(fileName)) {
			fileName = new String((fileName + "导入模板.xls").getBytes(), "iso8859-1");
		} else {
			fileName = new String("导入模板.xls".getBytes(), "iso8859-1");
		}
		return "download";
	}
}
