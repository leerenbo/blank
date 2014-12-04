package com.datalook.action.base;

import java.io.File;

import javax.annotation.Resource;

import org.apache.struts2.convention.annotation.Action;
import org.kie.api.runtime.KieSession;
import org.kie.api.runtime.manager.RuntimeEngine;
import org.kie.api.runtime.manager.RuntimeManager;
import org.kie.api.runtime.process.ProcessInstance;

@Action(value = "test")
public class TestAction extends BaseAction<Object> {

	private static final long serialVersionUID = -3802238894463370625L;
	private File image;
	private String imageFileName; // 文件名称
	private String imageContentType; // 文件类型
	private String content;

	@Resource(name = "runtimeManager")
	RuntimeManager runtimeManager;

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getImageFileName() {
		return imageFileName;
	}

	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}

	public String getImageContentType() {
		return imageContentType;
	}

	public void setImageContentType(String imageContentType) {
		this.imageContentType = imageContentType;
	}

	public File getImage() {
		return image;
	}

	public void setImage(File image) {
		this.image = image;
	}

	public void noSySn_upload() {
		System.out.println(image.toString());
	}

	public void noSySn_ueditor() {
		System.out.println(content);
	}

	@SuppressWarnings("unused")
	public void noSySn_noSe_jbpm() {
		RuntimeEngine engine = runtimeManager.getRuntimeEngine(null);
		KieSession ksession = engine.getKieSession();

		ProcessInstance processInstance = ksession.startProcess("com.sample.bpmn.hello");
	}
}
