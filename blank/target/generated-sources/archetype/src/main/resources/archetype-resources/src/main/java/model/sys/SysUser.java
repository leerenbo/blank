#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.model.sys;

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
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * SysUser entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "SYS_USER")
public class SysUser implements java.io.Serializable {

	// Fields
	private static final long serialVersionUID = -6537888910944690228L;
	private Integer id;
	private String realname;
	private String username;
	private String password;
	private String status;
	private Set<SysRole> sysRoles = new HashSet<SysRole>(0);
	private Set<SysOperationLog> sysOperationLogs = new HashSet<SysOperationLog>(0);

	// Constructors

	/** default constructor */
	public SysUser() {
	}

	/** minimal constructor */
	public SysUser(Integer id) {
		this.id = id;
	}

	/** full constructor */
	public SysUser(Integer id, String realname, String username, String password, String status, Set<SysRole> sysRoles, Set<SysOperationLog> sysOperationLogs) {
		this.id = id;
		this.realname = realname;
		this.username = username;
		this.password = password;
		this.status = status;
		this.sysRoles = sysRoles;
		this.sysOperationLogs = sysOperationLogs;
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

	@Column(name = "REALNAME", length = 32)
	public String getRealname() {
		return this.realname;
	}

	public void setRealname(String realname) {
		this.realname = realname;
	}

	@Column(name = "USERNAME", length = 32)
	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	@Column(name = "PASSWORD", length = 32)
	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Column(name = "STATUS", length = 2)
	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinTable(name = "SYS_USER_ROLE_RELATION", joinColumns = { @JoinColumn(name = "USERID", updatable = false) }, inverseJoinColumns = { @JoinColumn(name = "ROLEID", updatable = false) })
	public Set<SysRole> getSysRoles() {
		return this.sysRoles;
	}

	public void setSysRoles(Set<SysRole> sysRoles) {
		this.sysRoles = sysRoles;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "sysUser")
	public Set<SysOperationLog> getSysOperationLogs() {
		return this.sysOperationLogs;
	}

	public void setSysOperationLogs(Set<SysOperationLog> sysOperationLogs) {
		this.sysOperationLogs = sysOperationLogs;
	}

}