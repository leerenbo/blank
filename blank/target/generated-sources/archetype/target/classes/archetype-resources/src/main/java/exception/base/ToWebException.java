#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.exception.base;


public class ToWebException extends Exception{

	private static final long serialVersionUID = -4641419729467488075L;
	private String code;
	private String message;
	
	private boolean useCode=false;
	private boolean useMessage=false;
	private boolean commitTransation=false;
	private boolean writeLog=false;
	
	public void useCode(String code) {
		this.code=code;
		useCode=true;
		useMessage=false;
	}
	public void useMessage(String message){
		this.message=message;
		useCode=false;
		useMessage=true;
	}
	public boolean isUseCode() {
		return useCode;
	}
	public boolean isUseMessage() {
		return useMessage;
	}
	
	public boolean isCommitTransation() {
		return commitTransation;
	}
	public void commitTransation() {
		this.commitTransation = true;
	}
	
	public boolean isWriteLog() {
		return writeLog;
	}
	public void writeLog() {
		this.writeLog = true;
	}
	public String getCode() {
		return code;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	
}
