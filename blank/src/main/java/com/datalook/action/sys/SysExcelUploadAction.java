package com.datalook.action.sys;

import javax.annotation.Resource;

import org.apache.struts2.convention.annotation.Action;

import com.datalook.action.base.BaseAction;
import com.datalook.model.sys.SysExcelUpload;
import com.datalook.service.sys.SysExcelUploadService;
import com.datalook.service.base.BaseService;
@Action("sysExcelUpload")
public class SysExcelUploadAction extends BaseAction<SysExcelUpload> {
	
	@Resource(name = "sysExcelUploadService")
	public void setService(BaseService<SysExcelUpload> service) {
		this.service = service;
	}
	
	
	
}
