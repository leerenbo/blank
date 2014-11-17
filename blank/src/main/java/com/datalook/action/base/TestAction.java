package com.datalook.action.base;


import java.io.File;

import org.apache.struts2.convention.annotation.Action;

@Action(value="test")
public class TestAction extends BaseAction<Object>{

	private File image;
    private String imageFileName; //文件名称
    private String imageContentType; //文件类型
    private String content;
    
    
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

	public void noSySn_upload(){
		System.out.println(image.toString());
	}
	public void noSySn_ueditor(){
		System.out.println(content);
	}
}
