package it.pkg.model.sys;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.alibaba.fastjson.annotation.JSONField;

/**
 * SysFunction entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "SYS_FUNCTION")
public class SysFunction implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	// Fields
	private Integer id;
	@JSONField(serialize=false)
	private SysFunction sysFunction;
	private String functionname;
	private Short seq;
	private String functiontype;
	private String url;
	private String iconCls;
	private String img;
	private Integer pid;
	private Set<SysOperationLog> sysOperationLogs = new HashSet<SysOperationLog>(0);
	private Set<SysFunction> sysFunctions = new HashSet<SysFunction>(0);
	private Set<SysRole> sysRoles = new HashSet<SysRole>(0);

	// Constructors

	/** default constructor */
	public SysFunction() {
	}

	/** minimal constructor */
	public SysFunction(Integer id) {
		this.id = id;
	}

	/** full constructor */
	public SysFunction(Integer id, SysFunction sysFunction, String functionname, Short seq, String functiontype, String url, String iconCls, String img, Set<SysOperationLog> sysOperationLogs, Set<SysFunction> sysFunctions, Set<SysRole> sysRoles) {
		this.id = id;
		this.sysFunction = sysFunction;
		this.functionname = functionname;
		this.seq = seq;
		this.functiontype = functiontype;
		this.url = url;
		this.iconCls = iconCls;
		this.img = img;
		this.sysOperationLogs = sysOperationLogs;
		this.sysFunctions = sysFunctions;
		this.sysRoles = sysRoles;
	}
	
	
	@Column(name = "PID",insertable=false,updatable=false)
	public Integer getPid() {
		return pid;
	}

	public void setPid(Integer pid) {
		this.pid = pid;
	}

	// Property accessors
	@Id
	@Column(name = "ID", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "PID")
	public SysFunction getSysFunction() {
		return this.sysFunction;
	}

	public void setSysFunction(SysFunction sysFunction) {
		this.sysFunction = sysFunction;
	}

	@Column(name = "FUNCTIONNAME", length = 32)
	public String getFunctionname() {
		return this.functionname;
	}

	public void setFunctionname(String functionname) {
		this.functionname = functionname;
	}

	@Column(name = "SEQ")
	public Short getSeq() {
		return this.seq;
	}

	public void setSeq(Short seq) {
		this.seq = seq;
	}

	@Column(name = "FUNCTIONTYPE", length = 2)
	public String getFunctiontype() {
		return this.functiontype;
	}

	public void setFunctiontype(String functiontype) {
		this.functiontype = functiontype;
	}

	@Column(name = "URL", length = 100)
	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	@Column(name = "ICONCLS", length = 50)
	public String getIconCls() {
		return iconCls;
	}

	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
	}

	@Column(name = "IMG", length = 50)
	public String getImg() {
		return this.img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "sysFunction")
	public Set<SysOperationLog> getSysOperationLogs() {
		return this.sysOperationLogs;
	}

	public void setSysOperationLogs(Set<SysOperationLog> sysOperationLogs) {
		this.sysOperationLogs = sysOperationLogs;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "sysFunction")
	public Set<SysFunction> getSysFunctions() {
		return this.sysFunctions;
	}

	public void setSysFunctions(Set<SysFunction> sysFunctions) {
		this.sysFunctions = sysFunctions;
	}

	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "sysFunctions")
	public Set<SysRole> getSysRoles() {
		return this.sysRoles;
	}

	public void setSysRoles(Set<SysRole> sysRoles) {
		this.sysRoles = sysRoles;
	}

	@Override
	public String toString() {
		return "SysFunction [id=" + id + ", functionname=" + functionname + ", seq=" + seq + ", functiontype=" + functiontype + ", url=" + url + ", iconCls=" + iconCls + ", img=" + img + ", pid="+ pid  + "]";
	}
}