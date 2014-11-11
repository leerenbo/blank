package com.datalook.exception.base;

public class ToWebExceptionFactory {
	
	public static ToWebException createCodeRollbackInstance(String code){
		ToWebException twe=new ToWebException();
		twe.useCode(code);
		return twe;
	}
	
	public static ToWebException createCodeRollbackLogInstance(String code){
		ToWebException twe=new ToWebException();
		twe.useCode(code);
		twe.writeLog();
		return twe;
	}
	
	public static ToWebException createCodeCommitInstance(String code){
		ToWebException twe=new ToWebException();
		twe.useCode(code);
		twe.commitTransation();
		return twe;
	}
	
	public static ToWebException createCodeCommitLogInstance(String code){
		ToWebException twe=new ToWebException();
		twe.useCode(code);
		twe.commitTransation();
		twe.writeLog();
		return twe;
	}
	
	
	
	public static ToWebException createMessageRollbackInstance(String message){
		ToWebException twe=new ToWebException();
		twe.useMessage(message);
		return twe;
	}
	
	public static ToWebException createMessageRollbackLogInstance(String message){
		ToWebException twe=new ToWebException();
		twe.useMessage(message);
		twe.writeLog();
		return twe;
	}
	
	public static ToWebException createMessageCommitInstance(String message){
		ToWebException twe=new ToWebException();
		twe.useMessage(message);
		twe.commitTransation();
		return twe;
	}
	
	public static ToWebException createMessageCommitLogInstance(String message){
		ToWebException twe=new ToWebException();
		twe.useMessage(message);
		twe.commitTransation();
		twe.writeLog();
		return twe;
	}
	
}
