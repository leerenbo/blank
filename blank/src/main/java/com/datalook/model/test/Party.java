package com.datalook.model.test;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
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
@Table(name="TestParty")
@EzuiDataGrid(moduleName="晚会管理")
public class Party {
	@EzuiElement(isHidden=true)
	private Integer id;
	@EzuiElement(title="晚会名称",dataOptions=@EzuiDataOptions(validTypes={@EzuiValid(type=ValidType.CharAndChineseAndNumber)}))
	private String name;
	@JSONField(format="yyyy-MM-dd")
	@EzuiElement(elementType=EzuiElementType.datebox,title="开始日期")
	private Date openDay;
	@JSONField(format="hh:mm:ss")
	@EzuiElement(elementType=EzuiElementType.timespinner,title="开始时间")
	private Date openTime;
	@JSONField(format="yyyy-MM-dd hh:mm:ss")
	@EzuiElement(elementType=EzuiElementType.datetimebox,title="结束时间点")
	private Date endTimestap;
	@JSONField(serialize=false)
	@EzuiElement(title="节目列表",buttonText="安排节目")
	private List<Program> programs=new ArrayList<Program>();
	@Id
	@GeneratedValue
	@Column(name = "ID", unique = true, nullable = false)
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
	
	@OneToMany(mappedBy="party")
	public List<Program> getPrograms() {
		return programs;
	}

	public void setPrograms(List<Program> programs) {
		this.programs = programs;
	}
	@Column(name="OPENDAY")
	@Temporal(TemporalType.DATE)
	public Date getOpenDay() {
		return openDay;
	}
	public void setOpenDay(Date openDay) {
		this.openDay = openDay;
	}

	@Column(name="OPENTIME")
	@Temporal(TemporalType.TIME)
	public Date getOpenTime() {
		return openTime;
	}

	public void setOpenTime(Date openTime) {
		this.openTime = openTime;
	}

	@Column(name="ENDTIMESTAP")
	@Temporal(TemporalType.TIMESTAMP)
	public Date getEndTimestap() {
		return endTimestap;
	}

	public void setEndTimestap(Date endTimestap) {
		this.endTimestap = endTimestap;
	}
	
	
}
