package com.datalook.model.sys;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import com.datalook.ezui.annotation.declare.EzuiShow;
import com.datalook.ezui.annotation.declare.EzuiTransparent;
import com.datalook.ezui.annotation.element.EzuiElement;
import com.datalook.ezui.annotation.element.EzuiElement.EzuiElementType;
import com.datalook.ezui.annotation.page.EzuiDataGrid;

/**
 * SysDict entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "SYS_DICT")
//@EzuiDataGrid(moduleName="数据字典")
public class SysDict implements java.io.Serializable {

	@EzuiTransparent
	private static final long serialVersionUID = -2246244085151786686L;
	// Fields
	@EzuiElement(isHidden=true)
	private Integer id;
	@EzuiElement(elementType=EzuiElementType.textbox,title="字典组")
	private String location;
	@EzuiElement(elementType=EzuiElementType.textbox,title="字典键")
	private String value;
	@EzuiElement(elementType=EzuiElementType.textbox,title="字典值")
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