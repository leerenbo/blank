package com.datalook.model.sys;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.Table;

/**
 * SysDict entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "SYS_DICT")
public class SysDict implements java.io.Serializable {

	// Fields

	private String location;
	private String code;
	private String value;
	private String text;

	// Constructors

	/** default constructor */
	public SysDict() {
	}
	
	public SysDict(String location, String code) {
		super();
		this.location = location;
		this.code = code;
	}

	public SysDict(String location, String code, String value, String text) {
		super();
		this.location = location;
		this.code = code;
		this.value = value;
		this.text = text;
	}

	@Id
	@Column(name = "location", nullable = false, length = 50)
	public String getLocation() {
		return this.location;
	}

	public void setLocation(String location) {
		this.location = location;
	}
	@Id
	@Column(name = "code", nullable = false, length = 10)
	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	@Column(name = "value")
	public String getValue() {
		return this.value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	@Lob
	@Column(name = "text")
	public String getText() {
		return this.text;
	}

	public void setText(String text) {
		this.text = text;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((code == null) ? 0 : code.hashCode());
		result = prime * result + ((location == null) ? 0 : location.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		SysDict other = (SysDict) obj;
		if (code == null) {
			if (other.code != null)
				return false;
		} else if (!code.equals(other.code))
			return false;
		if (location == null) {
			if (other.location != null)
				return false;
		} else if (!location.equals(other.location))
			return false;
		return true;
	}

	
}