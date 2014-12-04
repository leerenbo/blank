package com.datalook.model.sys;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * SysDict entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "SYS_DICT")
public class SysDict implements java.io.Serializable {

	private static final long serialVersionUID = -2246244085151786686L;
	// Fields
	private Integer id;
	private String location;
	private String value;
	private String text;

	// Constructors
	/** default constructor */
	public SysDict() {
	}
	
	public SysDict(Integer id, String location, String value, String text) {
		super();
		this.id = id;
		this.location = location;
		this.value = value;
		this.text = text;
	}

	@Id
	@Column(name = "ID", unique = true, nullable = false)
	@GeneratedValue
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	@Column(name = "location", nullable = false, length = 255)
	public String getLocation() {
		return this.location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	@Column(name = "value",length=50)
	public String getValue() {
		return this.value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	@Column(name = "text", length=255)
	public String getText() {
		return this.text;
	}

	public void setText(String text) {
		this.text = text;
	}
}