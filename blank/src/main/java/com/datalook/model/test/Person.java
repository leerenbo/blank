package com.datalook.model.test;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.alibaba.fastjson.annotation.JSONField;
import com.datalook.ezui.annotation.element.EzuiDataOptions;
import com.datalook.ezui.annotation.element.EzuiDataOptions.EzuiValid;
import com.datalook.ezui.annotation.element.EzuiDataOptions.EzuiValid.ValidType;
import com.datalook.ezui.annotation.element.EzuiElement;
import com.datalook.ezui.annotation.element.EzuiElement.EzuiElementType;
import com.datalook.ezui.annotation.page.EzuiDataGrid;

@Entity
@Table(name = "TestPerson")
@EzuiDataGrid(moduleName = "人员管理")
public class Person {
	@EzuiElement(isHidden = true)
	private Integer id;

	@EzuiElement(title = "姓名", dataOptions = @EzuiDataOptions(missingMessage = "姓名不能为空", validTypes = { @EzuiValid(type = ValidType.Chinese), @EzuiValid(type = ValidType.length, params = { "2", "5" }) }))
	private String name;

	@EzuiElement(elementType = EzuiElementType.datebox, title = "出生日期", dataOptions = @EzuiDataOptions(editable = false))
	@JSONField(format = "yyyy-MM-dd")
	private Date born;

	@EzuiElement(title = "节目列表", buttonText = "安排节目")
	@JSONField(serialize = false)
	private List<Program> programs;

	@EzuiElement(title = "座位", textField = "name", idField = "id")
	private Seat seat;

	@Id
	@GeneratedValue
	@Column(name = "ID")
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "NAME", nullable = false, length = 50)
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "OPERATETIME")
	@Temporal(TemporalType.DATE)
	public Date getBorn() {
		return born;
	}

	public void setBorn(Date born) {
		this.born = born;
	}

	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "persons")
	public List<Program> getPrograms() {
		return programs;
	}

	public void setPrograms(List<Program> programs) {
		this.programs = programs;
	}

	@OneToOne
	@JoinColumn(name = "SEATID")
	public Seat getSeat() {
		return seat;
	}

	public void setSeat(Seat seat) {
		this.seat = seat;
	}
}
