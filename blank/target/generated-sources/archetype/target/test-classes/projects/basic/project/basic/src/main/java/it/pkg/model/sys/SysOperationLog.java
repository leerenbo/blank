package it.pkg.model.sys;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * SysOperationLog entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "SYS_OPERATION_LOG")
public class SysOperationLog implements java.io.Serializable {

	// Fields
	private static final long serialVersionUID = -7246643902904260550L;
	private Integer id;
	private SysFunction sysFunction;
	private SysUser sysUser;
	private String operatedetail;
	private Timestamp operatetime;

	// Constructors

	/** default constructor */
	public SysOperationLog() {
	}

	/** minimal constructor */
	public SysOperationLog(Integer id) {
		this.id = id;
	}

	/** full constructor */
	public SysOperationLog(Integer id, SysFunction sysFunction, SysUser sysUser, String operatedetail, Timestamp operatetime) {
		this.id = id;
		this.sysFunction = sysFunction;
		this.sysUser = sysUser;
		this.operatedetail = operatedetail;
		this.operatetime = operatetime;
	}

	// Property accessors
	@Id
	@Column(name = "ID", unique = true, nullable = false)
	@GeneratedValue
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "SYSFUNCTIONID")
	public SysFunction getSysFunction() {
		return this.sysFunction;
	}

	public void setSysFunction(SysFunction sysFunction) {
		this.sysFunction = sysFunction;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "USERID")
	public SysUser getSysUser() {
		return this.sysUser;
	}

	public void setSysUser(SysUser sysUser) {
		this.sysUser = sysUser;
	}

	@Column(name = "OPERATEDETAIL", length = 50)
	public String getOperatedetail() {
		return this.operatedetail;
	}

	public void setOperatedetail(String operatedetail) {
		this.operatedetail = operatedetail;
	}

	@Column(name = "OPERATETIME", length = 23)
	public Timestamp getOperatetime() {
		return this.operatetime;
	}

	public void setOperatetime(Timestamp operatetime) {
		this.operatetime = operatetime;
	}

}