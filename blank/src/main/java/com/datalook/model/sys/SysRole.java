package com.datalook.model.sys;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

/**
 * SysRole entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "SYS_ROLE")
public class SysRole implements java.io.Serializable {

	// Fields
	private static final long serialVersionUID = 5793710045580501552L;
	private Integer id;
	private String rolename;
	private Short seq;
	private String status;
	private Set<SysUser> sysUsers = new HashSet<SysUser>(0);
	private Set<SysFunction> sysFunctions = new HashSet<SysFunction>(0);

	// Constructors

	/** default constructor */
	public SysRole() {
	}

	/** minimal constructor */
	public SysRole(Integer id) {
		this.id = id;
	}

	/** full constructor */
	public SysRole(Integer id, String rolename, Short seq, String status, Set<SysUser> sysUsers, Set<SysFunction> sysFunctions) {
		this.id = id;
		this.rolename = rolename;
		this.seq = seq;
		this.status = status;
		this.sysUsers = sysUsers;
		this.sysFunctions = sysFunctions;
	}

	// Property accessors
	@Id
	@Column(name = "ID", unique = true)
	@GeneratedValue
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "ROLENAME", length = 32)
	public String getRolename() {
		return this.rolename;
	}

	public void setRolename(String rolename) {
		this.rolename = rolename;
	}

	@Column(name = "SEQ")
	public Short getSeq() {
		return this.seq;
	}

	public void setSeq(Short seq) {
		this.seq = seq;
	}

	@Column(name = "STATUS", length = 2)
	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "sysRoles")
	public Set<SysUser> getSysUsers() {
		return this.sysUsers;
	}

	public void setSysUsers(Set<SysUser> sysUsers) {
		this.sysUsers = sysUsers;
	}

	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinTable(name = "SYS_ROLE_FUNCTION_RELATION", joinColumns = { @JoinColumn(name = "ROLEID", updatable = false) }, inverseJoinColumns = { @JoinColumn(name = "SYSFUNCTIONID", updatable = false) })
	public Set<SysFunction> getSysFunctions() {
		return this.sysFunctions;
	}

	public void setSysFunctions(Set<SysFunction> sysFunctions) {
		this.sysFunctions = sysFunctions;
	}
}