package com.datalook.model.test;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import com.datalook.ezui.annotation.element.EzuiElement;
import com.datalook.ezui.annotation.page.EzuiDataGrid;

@Entity
@Table(name="TestSeat")
@EzuiDataGrid(moduleName="座位管理")
public class Seat {
	@EzuiElement(isHidden=true)
	private Integer id;
	@EzuiElement(formatString="{\"1\":\"桌1\",\"2\":\"桌2\",\"3\":\"桌3\"}",title="桌号")
	private String tableNum;
	
	@EzuiElement(title="座位名称")
	private String name;
	
	@EzuiElement(isHidden=true,defaultValue="1")
	private String status;
	
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
	
	@Column(name = "TABLENUM", length = 2)
	public String getTableNum() {
		return tableNum;
	}
	public void setTableNum(String tableNum) {
		this.tableNum = tableNum;
	}
	
	@Column(name = "STATUS", length = 2)
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
}
