package com.datalook.model.sys;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.alibaba.fastjson.annotation.JSONField;

@Entity
@Table(name = "SYS_EXCEL_UPLOAD")
public class SysExcelUpload {
	private Integer id;
	@JSONField(format="yyyy-MM-dd hh:mm:ss")
	private Date uploadTime;
	
	private Integer successCount=0;
	private Integer errorCount=0;
	private String errorDocPath;

	@Id
	@Column(name = "ID",  nullable = false)
	@GeneratedValue
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "UPLOADTIME", nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	public Date getUploadTime() {
		return uploadTime;
	}

	public void setUploadTime(Date uploadTime) {
		this.uploadTime = uploadTime;
	}

	@Column(name = "SUCCESSCOUNT")
	public Integer getSuccessCount() {
		return successCount;
	}

	public void setSuccessCount(Integer successCount) {
		this.successCount = successCount;
	}

	@Column(name = "ERRORCOUNT")
	public Integer getErrorCount() {
		return errorCount;
	}

	public void setErrorCount(Integer errorCount) {
		this.errorCount = errorCount;
	}

	@Column(name = "ERRORDOCPATH")
	public String getErrorDocPath() {
		return errorDocPath;
	}

	public void setErrorDocPath(String errorDocPath) {
		this.errorDocPath = errorDocPath;
	}

	@Override
	public String toString() {
		return "成功导入 " + successCount + " 条, 信息错误 " + errorCount + " 条";
	}

}
