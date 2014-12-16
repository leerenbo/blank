package com.datalook.model.test;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.alibaba.fastjson.annotation.JSONField;
import com.datalook.ezui.annotation.element.EzuiDataOptions;
import com.datalook.ezui.annotation.element.EzuiElement;
import com.datalook.ezui.annotation.element.EzuiElement.EzuiElementType;
import com.datalook.ezui.annotation.page.EzuiDataGrid;

@Entity
@Table(name="TestProgram")
@EzuiDataGrid(moduleName="节目管理")
public class Program {
	@EzuiElement(isHidden=true)
	private Integer id;
	@EzuiElement(title="节目名",dataOptions=@EzuiDataOptions(prompt="输入节日名称",required=true))
	private String name;
	@EzuiElement(elementType=EzuiElementType.treegrid,title="演员",buttonText="安排演员",textField="name")
	@JSONField(serialize=false)
	private List<Person> persons;
	
	@EzuiElement(title="晚会",idField="id",textField="name")
	private Party party;
	@Id
	@GeneratedValue
	@Column(name = "ID", unique = true, nullable = false)
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	
	@Column(name = "NAME", length = 255)
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "TEST_PERSON_PROGRAM", joinColumns = { @JoinColumn(name = "PROGRAMID") }, inverseJoinColumns = { @JoinColumn(name = "PERSONID") })
	public List<Person> getPersons() {
		return persons;
	}
	public void setPersons(List<Person> persons) {
		this.persons = persons;
	}
	
//	@JoinTable(name = "TEST_PARTY_PROGRAM", joinColumns = { @JoinColumn(name = "PARTYID", updatable = false) }, inverseJoinColumns = { @JoinColumn(name = "PERSONID", updatable = false) })
	@JoinColumn(name = "PARTYID")
	@ManyToOne(fetch = FetchType.LAZY)
	public Party getParty() {
		return party;
	}
	public void setParty(Party party) {
		this.party = party;
	}
}
